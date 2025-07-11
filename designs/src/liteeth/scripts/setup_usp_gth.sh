# liteeth_udp_gth_sgmii
echo "Setting up liteeth_udp_gth_sgmii..."
rm -rf build
python ../repo/liteeth/gen.py ../repo/examples/udp_usp_gth_sgmii.yml
cp build/gateware/liteeth_core.v ../liteeth_udp_gth_sgmii.v
sed -i 's/^module liteeth_core (/module liteeth_udp_gth_sgmii (/' ../liteeth_udp_gth_sgmii.v
