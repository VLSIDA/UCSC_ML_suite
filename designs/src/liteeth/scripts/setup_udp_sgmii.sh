# liteeth_udp_stream_sgmii
echo "Setting up liteeth_udp_stream_sgmii..."
rm -rf build
python ../repo/liteeth/gen.py ../repo/examples/udp_a7_gtp_sgmii.yml
cp build/gateware/liteeth_core.v ../liteeth_udp_stream_sgmii.v
sed -i 's/^module liteeth_core (/module liteeth_udp_stream_sgmii (/' ../liteeth_udp_stream_sgmii.v
