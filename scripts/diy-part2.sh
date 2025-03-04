#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.3.1/g' package/base-files/files/bin/config_generate

# 修改主机名字，把CM520-PROMO修改你喜欢的就行（不能纯数字或者使用中文）
sed -i '/uci commit system/i\uci set system.@system[0].hostname='CM520-PROMO'' package/lean/default-settings/files/zzz-default-settings

# 版本号里显示一个自己的名字（ababwnq build $(TZ=UTC-8 date "+%Y.%m.%d") @ 这些都是后增加的）
sed -i "s/OpenWrt /MrAvengers build $(TZ=UTC+8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# 修改 argon 为默认主题,可根据你喜欢的修改成其他的（不选择那些会自动改变为默认主题的主题才有效果）
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings

# Add luci-app-ssr-plus
#pushd package/lean
#git clone --depth=1 https://github.com/fw876/helloworld
#popd

# Clone community packages to package/community
#mkdir package/community
#pushd package/community

# Add Lienol's Packages
#git clone --depth=1 https://github.com/Lienol/openwrt-package
#rm -rf ../lean/luci-app-kodexplorer

# Add immortalwrt's Packages
#git clone --depth=1 -b openwrt-18.06 https://github.com/immortalwrt/packages
#git clone --depth=1 -b openwrt-18.06-k5.4 https://github.com/immortalwrt/luci
#cp -r ../luci/applications/luci-app-adguardhome ../package/lean//luci-app-adguardhome

# Add luci-app-passwall
#git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall

# Add luci-app-vssr <M>
#git clone --depth=1 https://github.com/jerrykuku/lua-maxminddb.git
#git clone --depth=1 https://github.com/jerrykuku/luci-app-vssr

# Add luci-proto-minieap
#git clone --depth=1 https://github.com/ysc3839/luci-proto-minieap

# Add ServerChan
#git clone --depth=1 https://github.com/tty228/luci-app-serverchan

# Add OpenClash
#git clone --depth=1 -b master https://github.com/vernesong/OpenClash

# Add luci-app-onliner
#git clone --depth=1 https://github.com/rufengsuixing/luci-app-onliner

# Add luci-app-diskman
#git clone --depth=1 https://github.com/SuLingGG/luci-app-diskman
#mkdir parted
#cp luci-app-diskman/Parted.Makefile parted/Makefile

# Add luci-app-dockerman
#rm -rf ../lean/luci-app-docker
#git clone --depth=1 https://github.com/lisaac/luci-app-dockerman
#git clone --depth=1 https://github.com/lisaac/luci-lib-docker

# Add luci-theme-argon
#git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
#git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config
#rm -rf ../lean/luci-theme-argon

# Add subconverter
#git clone --depth=1 https://github.com/tindy2013/openwrt-subconverter

# Add luci-udptools
#svn co https://github.com/zcy85611/Openwrt-Package/trunk/luci-udptools
#svn co https://github.com/zcy85611/Openwrt-Package/trunk/udp2raw
#svn co https://github.com/zcy85611/Openwrt-Package/trunk/udpspeeder-tunnel

# Add OpenAppFilter
#git clone --depth 1 -b oaf-3.0.1 https://github.com/destan19/OpenAppFilter.git

# Add luci-app-oled (R2S Only)
#git clone --depth=1 https://github.com/NateLol/luci-app-oled

# Add extra wireless drivers
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/rtl8812au-ac
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/rtl8821cu
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/rtl8188eu
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/rtl8192du
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-18.06-k5.4/package/kernel/rtl88x2bu

# Add apk (Apk Packages Manager)
#svn co https://github.com/openwrt/packages/trunk/utils/apk
#popd

# Mod zzz-default-settings
#pushd package/lean/default-settings/files
#sed -i '/http/d' zzz-default-settings
#export orig_version="$(cat "zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')"
#sed -i "s/${orig_version}/${orig_version} ($(date +"%Y-%m-%d"))/g" zzz-default-settings
#popd

# Use Lienol's https-dns-proxy package
#pushd feeds/packages/net
#rm -rf https-dns-proxy
#svn co https://github.com/Lienol/openwrt-packages/trunk/net/https-dns-proxy
#popd

# Use snapshots' syncthing package
#pushd feeds/packages/utils
#rm -rf syncthing
#svn co https://github.com/openwrt/packages/trunk/utils/syncthing
#popd

# Fix mt76 wireless driver
#pushd package/kernel/mt76
#sed -i '/mt7662u_rom_patch.bin/a\\techo mt76-usb disable_usb_sg=1 > $\(1\)\/etc\/modules.d\/mt76-usb' Makefile
#popd

# Change default shell to zsh
#sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

