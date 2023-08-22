include $(TOPDIR)/rules.mk

PKG_NAME:=phonebook
PKG_RELEASE:=$(AUTORELEASE)

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Martin Suess

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/finfinack/phonebook.git
PKG_SOURCE_DATE:=2023-08-22
PKG_SOURCE_VERSION:=7ed638a9cd9ef369deafc88d0e60d5385ed5f9fe
PKG_MIRROR_HASH:=skip

PKG_HASH:=skip
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

GO_PKG:=github.com/finfinack/phonebook

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/phonebook
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Telephony
  TITLE:=Phonebook
  URL:=https://github.com/finfinack/phonebook
  DEPENDS:=$(GO_ARCH_DEPENDS) +ca-bundle
endef

define Package/phonebook/description
  A phonebook fetching and conversion tool intended for AREDN.
endef

define Build/Install
	#
endef

define Package/phonebook/install
	$(INSTALL_DIR) \
		$(1)/usr/bin/ \
		$(1)/etc/cron.daily/ \
		$(1)/etc/config/

	$(INSTALL_BIN) $(GO_PKG_BUILD_BIN_DIR)/phonebook $(1)/usr/bin/phonebook
  
	$(INSTALL_CONF) ./files/phonebook.config $(1)/etc/config/phonebook
  
	$(INSTALL_BIN) ./files/update_phonebook.cron $(1)/etc/cron.daily/update_phonebook
endef

define Package/postinst
#!/bin/sh
/etc/cron.daily/update_phonebook
endef

$(eval $(call GoBinPackage,phonebook))
$(eval $(call BuildPackage,phonebook))
