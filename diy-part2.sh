#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate
#!/bin/bash
# 修改 IP (可选，默认 192.168.1.1)
# sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# --- 核心操作：释放 Reserved 内存 ---
# 定位小米 AX1800 的设备树文件路径 (注意：不同源码路径可能略有差异)
DTS_PATH="target/linux/ipq60xx/files/arch/arm64/boot/dts/qcom/ipq6018-xiaomi-ax1800.dts"

# 1. 禁用 Wi-Fi 固件预留内存 (释放约 50MB)
sed -i '/wlan_fw_mem: wlan_fw_mem@4ab00000/a \ \ \ \ \ \ \ \ status = "disabled";' $DTS_PATH

# 2. 禁用 NSS 核心预留内存 (释放约 30MB)
sed -i '/nss_core0_mem: nss_core0_mem@40000000/a \ \ \ \ \ \ \ \ status = "disabled";' $DTS_PATH
sed -i '/nss_core1_mem: nss_core1_mem@40800000/a \ \ \ \ \ \ \ \ status = "disabled";' $DTS_PATH

# 3. 禁用调试日志预留 (释放约 3MB)
sed -i '/m3_dump: m3_dump@50c00000/a \ \ \ \ \ \ \ \ status = "disabled";' $DTS_PATH
sed -i '/q6_etr_dump: q6_etr_dump@50b00000/a \ \ \ \ \ \ \ \ status = "disabled";' $DTS_PATH
