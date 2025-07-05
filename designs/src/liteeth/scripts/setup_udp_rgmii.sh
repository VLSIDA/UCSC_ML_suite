# liteeth_udp_stream_rgmii
echo "Setting up liteeth_udp_stream_rgmii..."
rm -rf build
python ../repo/liteeth/gen.py ../repo/examples/udp_s7phyrgmii.yml
cp build/gateware/liteeth_core.v ../liteeth_udp_stream_rgmii.v
sed -i 's/^module liteeth_core (/module liteeth_udp_stream_rgmii (/' ../liteeth_udp_stream_rgmii.v
