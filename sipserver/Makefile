#
# Copyright (C) 2014-2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sipserver
PKG_VERSION:=1.0.1
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/arednch/sipserver.git
PKG_SOURCE_DATE:=2024-04-30
PKG_SOURCE_VERSION:=0ecd68309a13e24b965762b37006d859b1b619cc
PKG_MIRROR_HASH:=535c9930d643e2ed6e1a70e87eece180e6a6d1b91b0c9b9dc88e6fb7fb21e3fa

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

