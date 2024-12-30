mogrify -resize 1200x500 ./*.jpg
ffmpeg \
  -i t_train.mp4 \
  -r 15 \
  -vf scale=500:-1 \
  -ss 00:00:02.5 -to 00:00:04 \
  t_train.gif
rm t_train.mp4
ffmpeg \
  -i birthday_eclipse.mp4 \
  -r 15 \
  -vf scale=500:-1 \
  -ss 00:00:07.25 -to 00:00:09.25 \
  birthday_eclipse.gif
rm birthday_eclipse.mp4
ffmpeg \
  -i bt_sail_video.mp4 \
  -r 15 \
  -vf scale=500:-1 \
  -ss 00:00:32 -to 00:00:33.5 \
  bt_sail_video.gif
rm bt_sail_video.mp4
ffmpeg \
  -i c_pizza.mp4 \
  -r 15 \
  -vf scale=500:-1 \
  -ss 00:00:01 -to 00:00:02.5 \
  c_pizza.gif
rm c_pizza.mp4
ffmpeg \
  -i i_fall.mp4 \
  -r 15 \
  -vf scale=500:-1 \
  -ss 00:00:00 -to 00:00:01.5 \
  i_fall.gif
rm i_fall.mp4
ffmpeg \
  -i vito_kick.mp4 \
  -r 15 \
  -vf scale=500:-1 \
  -ss 00:00:00 -to 00:00:01.25 \
  vito_kick.gif
rm vito_kick.mp4