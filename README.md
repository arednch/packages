# AREDN-Packages

This is a repo to hold AREDN packages (OpenWrt) as a separate package feed. These include primarily Makefiles for custom packages.

## Packages

The following packages are currently supported:

- [phonebook](https://github.com/arednch/packages/tree/main/phonebook): A phonebook service running on the AREDN Node fetching
  a CSV from an upstream server and converting into XML phonebooks which can be fetched by phones.
  
    * See the [package folder](https://github.com/arednch/packages/tree/main/phonebook) for AREDN package specific options (i.e. where the configuration file resides).
    * See the [repository](https://github.com/arednch/phonebook) for more details including supported flags / configuration options.

- [sipserver](https://github.com/arednch/packages/tree/main/sipserver): A (very) simple SIP server allowing local registration.
  Note that the [code](https://github.com/arednch/sipserver) is mostly a copy of
  [SipServer](https://github.com/BarGabriel/SipServer) apart from a fix to make it run as a daemon.

Each package is defined in a separate folder and aligned with OpenWrt's build system and file locations. See the [OpenWrt documentation](https://openwrt.org/docs/start) for more details, but on a high level, this includes:

- A `Makefile` which contains all the instructions to fetch the source code, build the binary and install it on the target system including (optionally) copying cron files and configuration if needed.

- (Optional) A `files` directory with default files such as configurations and cron templates which are copied to the target system upon installation (based on instructions in the `Makefile`).

  * `cron` jobs are typically defined as files in `/etc/cron.hourly` and `/etc/cron.daily` (there are other options but they tend to be more convoluted).
  * config files are set up in `/etc/config/` for the packages in this repository.

## Building

### Automated Builds

While the [Local Builds](#local-builds) section should provide enough guidance and pointers to allow building the packages locally for debugging purposes, the release builds should mostly be built by [GitHub Actions](https://github.com/features/actions) going forward.

Automated builds are currently configured as follows:

- The creation of a new [release](https://github.com/arednch/packages/releases) acts as the trigger (this may be adjusted as we see fit).
- Additionally, new builds can be [manually triggered](https://github.com/arednch/packages/actions/workflows/build.yml).
- The actual build runs against one or more architectures (currently `x86_64`, `mips_24kc` and `arm_cortex-a7_neon-vfpv4` but may be subject to change) in order to support the platforms we need (see [Compatibility](#compatibility)).

  * The build runs using the [OpenWRT GitHub Action](https://github.com/openwrt/gh-action-sdk) which builds packages using official OpenWrt SDK Docker containers.
  * The created packages are then uploaded as artifacts to the build (primarily for debugging purposes at this point).
  * More importantly, if the build was triggered by a release, the packages are also wrapped into a ZIP archive and added to the release.

See the build definitions in [`build.yml`](https://github.com/arednch/packages/blob/main/.github/workflows/build.yml) for more details.

### Local Builds

In order to be able to compile/use these definitions, familiarize yourself with the OpenWrt build environment. Roughly in order:

- [Build system essentials](https://openwrt.org/docs/guide-developer/toolchain/buildsystem_essentials)

  * Note: The `phonebook` package will also require `golang` which is not part of the suggested build system essentials. Hence, also run `sudo install golang` to add it.

- [Build system setup](https://openwrt.org/docs/guide-developer/toolchain/install-buildsystem)
- [Build system usage](https://openwrt.org/docs/guide-developer/toolchain/use-buildsystem)
- [Building a single package](https://openwrt.org/docs/guide-developer/toolchain/single.package)

More specifically, an end-to-end path for Ubuntu 22.04:

**Disclaimer**: _This will quickly be outdated, so no guarantee that this still works when you run it._

- Install the required [build system essentials](https://openwrt.org/docs/guide-developer/toolchain/install-buildsystem#debianubuntu)

- Install golang as another build system requirement (for the `phonebook` in particular). Also include `vim` and `screen` (optional).

  ```
  sudo apt install golang vim screen
  ```

- [Get the OpenWRT source](https://openwrt.org/docs/guide-developer/toolchain/use-buildsystem#build_system_usage)

  ```
  git clone https://git.openwrt.org/openwrt/openwrt.git
  cd openwrt
  git tag
  git checkout v22.03.5
  ```

  Note: After running `git tag`, pick the version which AREDN is currently compiled against. This can be found in the [AREDN source code](https://github.com/aredn/aredn/blob/main/openwrt.mk).

- [Add the AREDNCH feed](#prepare-feeds)

  Add the git source for our AREDN packages feed:

  ```
  cp feeds.conf.default feeds.conf
  echo 'src-git aredn https://github.com/arednch/packages.git' >> feeds.conf
  ```

  Alternatively to the above: In case you want to make local changes to the AREDN CH package definitions, clone them locally and point to them in the feed config:

  ```
  cd ..
  git clone https://github.com/arednch/packages.git arednch
  cd openwrt
  cp feeds.conf.default feeds.conf
  echo 'src-link aredn <insert the absolute path to the arednch cloned repo above>' >> feeds.conf
  ```

- [Prepare and install feeds](https://openwrt.org/docs/guide-developer/toolchain/use-buildsystem#build_system_usage)

  ```
  ./scripts/feeds update -a
  ./scripts/feeds install -a
  ```

- [Prepare configuration](https://github.com/arednch/packages#prepare-config)

  Run `make menuconfig` and follow the [instructions linked to](https://github.com/arednch/packages#prepare-config).

- [Compile the toolchain](https://openwrt.org/docs/guide-developer/toolchain/single.package) (required at least once per architecture)

  Note: Both the following steps will likely take a while to complete.

  ```
  make tools/install
  make toolchain/install
  ```

- [Compile a package](https://openwrt.org/docs/guide-developer/toolchain/single.package)

  This is the example for `phonebook` but other packages like `sipserver` as well as standard OpenWRT packages can be compiled this way.

  ```
  ​make package/phonebook/compile
  ```

  Run it with the `V=Sc` option to get much more detailed debugging output:

  ```
  ​make package/phonebook/compile V=Sc
  ```

- Find the compiled packages

  * The AREDN CH packages can be found here: `find ./bin/packages -name *.ipk`

  * Standard packages like `libstdcpp` which is a required dependency for `sipserver` can be found here: `find ./bin/targets -name *.ipk`

#### Prepare config

This repository also contains suggested starting points for configs to compile the package with. See the `configs` folder. In order to use them, copy the `<architecture>.config` file into your build root directory as `.config`.

Important manual changes to the configs (via `make menuconfig` or directly in the `.config` file):

- `Target System`: Pick the platform you want to compile for. If you're unsure, see [Supported Devices](http://downloads.arednmesh.org/firmware/html/SUPPORTED_DEVICES.md) for more info.
- `Subtarget`: Pick the platform you want to compile for. If you're unsure, see [Supported Devices](http://downloads.arednmesh.org/firmware/html/SUPPORTED_DEVICES.md) for more info.
- `Target Profile`: Pick the platform you want to compile for. If you're unsure, see [Supported Devices](http://downloads.arednmesh.org/firmware/html/SUPPORTED_DEVICES.md) for more info.
- `Global build settings` > `Cryptographically signed package lists`: `off`
- `Languages` > `Go` > `Configuration` > `External bootstrap Go root directory`: `/usr/bin` (set to whatever your `go` binary is in)
- `Base system` > `libstdcpp`: `M`
- `Network` > `Telephony` > `phonebook`: `M`
- `Network` > `Telephony` > `sipserver`: `M`

#### Prepare feeds

Once you have a working build setup, you can include the AREDN packages as a feed:

Note: If feeds.conf already exists, you can ignore this step.

```
cd <your openwrt build/src root>
cp feeds.conf.default feeds.conf
```

Add the following in `feeds.conf`:
```
src-git aredn https://github.com/arednch/packages.git
# If you prefer a local copy instead:
# src-link aredn <folder where you have the aredn package definitions (this repo)>
```

Announce the new feed to the build system:
```
cd <your openwrt build/src root>
./scripts/feeds update aredn
./scripts/feeds install -a -p aredn
```

Note: When a new package is added, remember to rerun `./scripts/feeds update aredn` in order to make the build system aware of it.

Once this is set up, you should start to see packages from this feed show up in the available package list when running `make menuconfig`.

Specifically to set up a custom feed, find some more guidance here:
https://openwrt.org/docs/guide-developer/helloworld/chapter4

## Releases

Releases are created for the packages defined / built in this repo: https://github.com/arednch/packages/releases

The following always points to the latest release: https://github.com/arednch/packages/releases/latest

The stable download links for the latest release for each architecture:

- [ARM Cortex A7, ipq40xx (e.g. hAP AC3)](https://github.com/arednch/packages/releases/latest/download/arm_cortex-a7_neon-vfpv4.zip)
- [MIPS 24kc, ath79 (e.g. hAP AC Lite)](https://github.com/arednch/packages/releases/latest/download/mips_24kc.zip)
- [x86_64](https://github.com/arednch/packages/releases/latest/download/x86_64.zip)

Note: Also read the [Automated Builds](#automated-builds) section as it provides the artifacts for these releases.

### Compatibility

The releases are usually tested with the latest (stable) version of [AREDN firmware](https://www.arednmesh.org/content/current-software). Notably, the software packages are currently built and tested in particular for the following:

- MikroTik hAP AC3 (`ipq40xx`, `arm_cortex-a7_neon-vfpv4`)
- MikroTik hAP AC Lite (`ath79`, `mips_24kc`)

Note: While we believe these packages _should_ run on most other AREDN firmware versions and likely for many other platforms using the same chipset, we are _not_ testing these explicitly.
