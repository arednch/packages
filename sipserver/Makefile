#
# Copyright (C) 2014-2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sipserver
PKG_VERSION:=1.0.0
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/arednch/sipserver.git
PKG_SOURCE_DATE:=2023-09-10
PKG_SOURCE_VERSION:=144b7e414926d1ed1ec5156795cef51cedd6f200
PKG_MIRROR_HASH:=adcff06834d6f98f5e9842ebbcc60a9f714dd733d03c3e48b5893b5dc6fe45f0

PKG_BUILD_PARALLEL:=1

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/sipserver
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Telephony
  TITLE:=SIP Server
  URL:=https://github.com/arednch/sipserver
  DEPENDS:=+libstdcpp +libpthread
endef

define Package/sipserver/description
  A simple SIP server for handling VoIP calls based on SIP protocol.
endef

define Build/Install
	#
endef

define Package/sipserver/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/SipServer $(1)/usr/sbin/sipserver
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/sipserver.init $(1)/etc/init.d/sipserver
endef

define Package/postinst
#!/bin/sh
chmod 755 /etc/init.d/sipserver
/etc/init.d/sipserver enable
/etc/init.d/sipserver start
endef

$(eval $(call BuildPackage,sipserver))

