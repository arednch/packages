include $(TOPDIR)/rules.mk

PKG_NAME:=phonebook
PKG_VERSION:=1.11.2
PKG_RELEASE:=0

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Martin Suess

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/arednch/phonebook.git
PKG_SOURCE_DATE:=2025-02-22
PKG_SOURCE_VERSION:=be638f8793e667e17c94b71407385f263eb14cfa
PKG_MIRROR_HASH:=c6db58baeca60803643bcec8b3f7f066a440529d4ddd12394015d8028f9bbca7

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

define Package/phonebook
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Telephony
  TITLE:=Phonebook
  URL:=https://github.com/arednch/phonebook
  DEPENDS:=$(GO_ARCH_DEPENDS) +ca-bundle
endef

define Package/phonebook/description
  A phonebook fetching and conversion tool intended for AREDN.
endef

define Build/Compile
	$(call GoPackage/Build/Compile)
	$(STAGING_DIR_HOST)/bin/upx --lzma -6 $(GO_PKG_BUILD_BIN_DIR)/phonebook
endef

define Package/phonebook/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(GO_PKG_BUILD_BIN_DIR)/phonebook $(1)/usr/bin/phonebook

	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) ./files/phonebook.config $(1)/etc/phonebook.conf

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/phonebook.init $(1)/etc/init.d/phonebook

	$(INSTALL_DIR) $(1)/www/
	$(INSTALL_DATA) ./files/bootstrap.min.css $(1)/www/bootstrap.min.css
endef

define Package/phonebook/preinst
#!/bin/sh
exit 0
endef

define Package/phonebook/postinst
#!/bin/sh
mkdir -p /www/arednstack
chmod 755 /etc/init.d/phonebook
exit 0
endef

define Package/phonebook/prerm
#!/bin/sh
exit 0
endef

define Package/phonebook/postrm
#!/bin/sh
rm -rf /www/arednstack
exit 0
endef

$(eval $(call GoBinPackage,phonebook))
$(eval $(call BuildPackage,phonebook))
