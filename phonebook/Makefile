include $(TOPDIR)/rules.mk

PKG_NAME:=phonebook
PKG_VERSION:=1.9.2
PKG_RELEASE:=$(AUTORELEASE)

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Martin Suess

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/arednch/phonebook.git
PKG_SOURCE_DATE:=2024-07-09
PKG_SOURCE_VERSION:=693831aa312e2288acc4dcfbe3cee17aeb1abcff
PKG_MIRROR_HASH:=d39c635a045a8c7b718967dc9153b57d8c1677e39a1b0805222bb9d973117c6e

PKG_BUILD_DEPENDS:=golang/host upx/host
PKG_BUILD_PARALLEL:=1
PKG_BUILD_FLAGS:=no-mips16
PKG_USE_MIPS16:=0

GO_PKG_GCFLAGS:=-l -B
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

define Build/Install
	#
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

define Package/postinst
#!/bin/sh
chmod 755 /etc/init.d/phonebook
/etc/init.d/phonebook enable
/etc/init.d/phonebook start
exit 0
endef

$(eval $(call GoBinPackage,phonebook))
$(eval $(call BuildPackage,phonebook))
