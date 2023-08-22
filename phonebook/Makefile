include $(TOPDIR)/rules.mk

PKG_NAME:=phonebook
PKG_RELEASE:=$(AUTORELEASE)

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Martin Suess

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/finfinack/phonebook.git
PKG_SOURCE_DATE:=2023-08-22
PKG_SOURCE_VERSION:=50fc17140615582a9299078cd1c1f901e7dc19ba
PKG_MIRROR_HASH:=skip

PKG_HASH:=skip
PKG_BUILD_PARALLEL:=1

GO_PKG:=github.com/finfinack/phonebook

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/phonebook
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Telephony
  TITLE:=A phonebook fetching and conversion tool intended for AREDN.
  URL:=https://github.com/finfinack/phonebook
  DEPENDS:=$(GO_ARCH_DEPENDS) +ca-bundle
endef

$(eval $(call GoBinPackage,phonebook))
$(eval $(call BuildPackage,phonebook))
