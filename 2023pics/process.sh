python3 process.py
mogrify -resize 600x ./*.jpg
ffmpeg \
  -i parade.mp4 \
  -r 15 \
  -vf scale=500:-1 \
  -ss 00:00:00.25 -to 00:00:02.25 \
  parade.gif
rm parade.mp4