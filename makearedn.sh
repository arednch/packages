#!/bin/sh

rm bin/phonebook_*

# Build AC3
cp arm_cortex-a7_neon-vfpv4.config .config
make tools/compile
make toolchain/compile
make package/phonebook/compile V=99
# make package/sipserver/compile V=99
# Package AC3
rm -rf /tmp/arm_cortex-a7_neon-vfpv4
mkdir /tmp/arm_cortex-a7_neon-vfpv4
cp bin/packages/arm_cortex-a7_neon-vfpv4/aredn/phonebook_* bin/
# cp bin/packages/arm_cortex-a7_neon-vfpv4/aredn/phonebook_* /tmp/arm_cortex-a7_neon-vfpv4
# cp bin/packages/arm_cortex-a7_neon-vfpv4/aredn/sipserver_* /tmp/arm_cortex-a7_neon-vfpv4
# cp bin/targets/ipq40xx/mikrotik/packages/libstdcpp6_* /tmp/arm_cortex-a7_neon-vfpv4
# rm bin/arm_cortex-a7_neon-vfpv4.zip
# zip -jr bin/arm_cortex-a7_neon-vfpv4.zip /tmp/arm_cortex-a7_neon-vfpv4/*
# rm -rf /tmp/arm_cortex-a7_neon-vfpv4

# Build x86
cp x86_64.config .config
make tools/compile
make toolchain/compile
make package/phonebook/compile V=99
# make package/sipserver/compile V=99
# Package x86
rm -rf /tmp/x86_64
mkdir /tmp/x86_64
cp bin/packages/x86_64/aredn/phonebook_* bin/
# cp bin/packages/x86_64/aredn/phonebook_* /tmp/x86_64
# cp bin/packages/x86_64/aredn/sipserver_* /tmp/x86_64
# cp bin/targets/x86/64/packages/libstdcpp6_* /tmp/x86_64
# rm bin/x86_64.zip
# zip -jr bin/x86_64.zip /tmp/x86_64/*
# rm -rf /tmp/x86_64

# Build AC Lite
cp mips_24kc.config .config
make tools/compile
make toolchain/compile
make package/phonebook-min/compile V=99
# make package/sipserver/compile V=99
# Build AC Lite
rm -rf /tmp/mips_24kc
mkdir /tmp/mips_24kc
cp bin/packages/mips_24kc/aredn/phonebook-min_* bin/
# cp bin/packages/mips_24kc/aredn/phonebook_* /tmp/mips_24kc
# cp bin/packages/mips_24kc/aredn/sipserver_* /tmp/mips_24kc
# cp bin/targets/ath79/mikrotik/packages/libstdcpp6_* /tmp/mips_24kc
# rm bin/mips_24kc.zip
# zip -jr bin/mips_24kc.zip /tmp/mips_24kc/*
# rm -rf /tmp/mips_24kc
