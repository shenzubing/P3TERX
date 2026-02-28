# 自动寻找小米 AX1800 的 DTS 文件路径
DTS_PATH=$(find target/linux/ipq60xx/ -name "*ipq6018-xiaomi-ax1800.dts*" | head -n 1)

if [ -n "$DTS_PATH" ]; then
    echo "定位到 DTS 文件: $DTS_PATH"
    # 执行内存手术
    sed -i '/wlan_fw_mem: wlan_fw_mem@4ab00000/a \ \ \ \ \ \ \ \ status = "disabled";' "$DTS_PATH"
    sed -i '/nss_core0_mem: nss_core0_mem@40000000/a \ \ \ \ \ \ \ \ status = "disabled";' "$DTS_PATH"
    sed -i '/nss_core1_mem: nss_core1_mem@40800000/a \ \ \ \ \ \ \ \ status = "disabled";' "$DTS_PATH"
    sed -i '/m3_dump: m3_dump@50c00000/a \ \ \ \ \ \ \ \ status = "disabled";' "$DTS_PATH"
    sed -i '/q6_etr_dump: q6_etr_dump@50b00000/a \ \ \ \ \ \ \ \ status = "disabled";' "$DTS_PATH"
else
    echo "错误: 找不到 AX1800 的 DTS 文件，请检查源码是否支持该机型"
    exit 1
fi
