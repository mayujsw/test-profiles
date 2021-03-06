#!/bin/sh
# BSD version is using gmake rather than make to avoid build problems on at least FreeBSD 12 current over "need an operator" warnings
tar -xjf ffmpeg-3.4.1.tar.bz2
mkdir ffmpeg_/

cd ffmpeg-3.4.1/
./configure --disable-zlib --disable-doc --prefix=$HOME/ffmpeg_/
gmake -j $NUM_CPU_JOBS
echo $? > ~/install-exit-status
gmake install
cd ~/
rm -rf ffmpeg-3.4.1/
rm -rf ffmpeg_/lib/

echo "#!/bin/sh

./ffmpeg_/bin/ffmpeg -i HD2-h264.ts -f rawvideo -threads \$NUM_CPU_CORES -y -target ntsc-dv /dev/null 2>&1
echo \$? > ~/test-exit-status" > ffmpeg
chmod +x ffmpeg
