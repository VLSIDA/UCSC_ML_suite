# liteeth_udp_raw_rgmii
echo "Setting up liteeth_udp_raw_rgmii..."
rm -rf build
python ../repo/liteeth/gen.py ../repo/examples/udp_raw_ecp5rgmii.yml
cp build/gateware/liteeth_core.v ../liteeth_udp_raw_rgmii.v
sed -i 's/^module liteeth_core (/module liteeth_udp_raw_rgmii (/' ../liteeth_udp_raw_rgmii.v

