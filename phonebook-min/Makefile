include $(TOPDIR)/rules.mk

PKG_NAME:=phonebook-min
PKG_VERSION:=1.0.1
PKG_RELEASE:=0

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Martin Suess

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/arednch/phonebook.git
PKG_SOURCE_DATE:=2025-02-22
PKG_SOURCE_VERSION:=be638f8793e667e17c94b71407385f263eb14cfa
PKG_MIRROR_HASH:=409e94407cdd384874d1dd4e25c95ae39db2ecd4b7bdabfe2d7d2c3a8f0539ff

PKG_BUILD_DEPENDS:=golang/host upx/host
PKG_BUILD_PARALLEL:=1
PKG_BUILD_FLAGS:=no-mips16
PKG_USE_MIPS16:=0

GO_PKG_GCFLAGS:=-B
GO_PKG_LDFLAGS:=-s -w
GO_PKG_LDFLAGS_X:= \
	main.CommitSHA=$(PKG_SOURCE_VERSION) \
	main.Version=$(PKG_VERSION)-$(PKG_RELEASE)

GO_PKG:=github.com/arednch/phonebook

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/phonebook-min
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Telephony
  TITLE:=Phonebook-Mininmal
  URL:=https://github.com/arednch/phonebook
  DEPENDS:=$(GO_ARCH_DEPENDS) +ca-bundle
endef

define Package/phonebook-min/description
  A phonebook fetching and conversion tool intended for AREDN.
endef

define Build/Compile
	$(call GoPackage/Build/Compile)
	$(STAGING_DIR_HOST)/bin/upx --lzma -6 $(GO_PKG_BUILD_BIN_DIR)/phonebook
endef

define Package/phonebook-min/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(GO_PKG_BUILD_BIN_DIR)/phonebook $(1)/usr/bin/phonebook

	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) ./files/phonebook.config $(1)/etc/phonebook.conf

	$(INSTALL_DIR) $(1)/etc/cron.hourly
	$(INSTALL_BIN) ./files/phonebook.cron $(1)/etc/cron.hourly/phonebook
endef

define Package/phonebook/preinst
#!/bin/sh
exit 0
endef

define Package/phonebook-min/postinst
#!/bin/sh
mkdir -p /www/arednstack
chmod 755 /etc/cron.hourly/phonebook
exit 0
endef

define Package/phonebook-min/prerm
#!/bin/sh
exit 0
endef

define Package/phonebook-min/postrm
#!/bin/sh
rm -rf /www/arednstack
exit 0
endef

$(eval $(call GoBinPackage,phonebook-min))
$(eval $(call BuildPackage,phonebook-min))
