include $(TOPDIR)/rules.mk

PKG_NAME:=phonebook
PKG_VERSION:=1.9.1
PKG_RELEASE:=$(AUTORELEASE)

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Martin Suess

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/arednch/phonebook.git
PKG_SOURCE_DATE:=2024-07-08
PKG_SOURCE_VERSION:=519cc75286e389f41627a9cf24073668c176b251
PKG_MIRROR_HASH:=7a039f794ed6e41ac6a61ae7314161d7ffe95cce8877588859c79e442d49f766

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
