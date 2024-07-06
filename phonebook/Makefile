include $(TOPDIR)/rules.mk

PKG_NAME:=phonebook
PKG_VERSION:=1.8.3
PKG_RELEASE:=$(AUTORELEASE)

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Martin Suess

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/arednch/phonebook.git
PKG_SOURCE_DATE:=2024-07-06
PKG_SOURCE_VERSION:=af5540b0c45c7e9d7a72ef7be3c231b90b9fdb86
PKG_MIRROR_HASH:=623bf2c89cb7d51956d72703b217b6bf834f6cb4c5d5d7574172e8285734a971

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
	$(STAGING_DIR_HOST)/bin/upx --lzma --best $(GO_PKG_BUILD_BIN_DIR)/phonebook
endef

define Build/Install
	#
endef

define Package/preinst
#!/bin/sh
if [ ! -f '/etc/httpd.conf' ] || [ "$(grep -c phonebook.sh /etc/httpd.conf)" = "0" ]; then
	echo '/cgi-bin/phonebook.sh:root:$p$root' >>/etc/httpd.conf
fi
if [ ! -f '/etc/httpd.conf' ] || [ "$(grep -c update_urls.sh /etc/httpd.conf)" = "0" ]; then
	echo '/cgi-bin/update_urls.sh:root:$p$root' >>/etc/httpd.conf
fi
/etc/init.d/uhttpd reload
exit 0
endef

define Package/phonebook/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(GO_PKG_BUILD_BIN_DIR)/phonebook $(1)/usr/bin/phonebook
 
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) ./files/phonebook.config $(1)/etc/phonebook.conf
	$(INSTALL_CONF) ./files/phonebook_urls $(1)/etc/phonebook_urls
 
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/phonebook.init $(1)/etc/init.d/phonebook

	$(INSTALL_DIR) $(1)/etc/cron.hourly
	$(INSTALL_BIN) ./files/fetch_phonebook.cron $(1)/etc/cron.hourly/fetch_phonebook
	$(INSTALL_BIN) ./files/update_phonebook.cron $(1)/etc/cron.hourly/update_phonebook

	$(INSTALL_DIR) $(1)/www/cgi-bin
	$(INSTALL_BIN) ./files/phonebook.sh $(1)/www/cgi-bin/phonebook.sh
	$(INSTALL_BIN) ./files/update_urls.sh $(1)/www/cgi-bin/update_urls.sh
endef

define Package/postinst
#!/bin/sh
mkdir -p /www/arednstack

chmod 755 /etc/init.d/phonebook
/etc/init.d/phonebook enable
/etc/init.d/phonebook start

/etc/cron.hourly/fetch_phonebook
exit 0
endef

$(eval $(call GoBinPackage,phonebook))
$(eval $(call BuildPackage,phonebook))
