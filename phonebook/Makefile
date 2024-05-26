include $(TOPDIR)/rules.mk

PKG_NAME:=phonebook
PKG_VERSION:=1.4
PKG_RELEASE:=$(AUTORELEASE)

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Martin Suess

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/arednch/phonebook.git
PKG_SOURCE_DATE:=2024-05-26
PKG_SOURCE_VERSION:=17fbccf4f182f6aaa57934ed48afcaa7793f81ff
PKG_MIRROR_HASH:=ebabee3e160ad96d70f281c0c2d79918a77674c2939d77217e340a1df3d9b29c

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_BUILD_FLAGS:=no-mips16
PKG_USE_MIPS16:=0

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

define Build/Install
	#
endef

define Package/preinst
#!/bin/sh
if [ ! -f '/etc/httpd.conf' ] || [ "$(grep -c phonebook.sh /etc/httpd.conf)" = "0" ]; then
	echo '/cgi-bin/phonebook.sh:root:$p$root' >>/etc/httpd.conf
fi
/etc/init.d/uhttpd reload
exit 0
endef

define Package/phonebook/install
	$(INSTALL_DIR) \
		$(1)/usr/bin/ \
		$(1)/etc/init.d/ \
		$(1)/etc/cron.hourly/ \
		$(1)/etc/config/ \
		$(1)/www/cgi-bin/

	$(INSTALL_BIN) $(GO_PKG_BUILD_BIN_DIR)/phonebook $(1)/usr/bin/phonebook
  
	$(INSTALL_CONF) ./files/phonebook_cron.config $(1)/etc/config/phonebook_cron
	$(INSTALL_CONF) ./files/phonebook_svc.config $(1)/etc/config/phonebook_svc
  
	$(INSTALL_BIN) ./files/phonebook.init $(1)/etc/init.d/phonebook
	$(INSTALL_BIN) ./files/fetch_phonebook.cron $(1)/etc/cron.hourly/fetch_phonebook
	$(INSTALL_BIN) ./files/update_phonebook.cron $(1)/etc/cron.hourly/update_phonebook

	$(INSTALL_BIN) ./files/phonebook.sh $(1)/www/cgi-bin/phonebook.sh
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
