# mogrify -resize 1200x500 ./*.jpg


for f in *.gif; do
  ffmpeg -i "$f" -vf "fps=15,scale=500:-1:flags=lanczos,palettegen" -y /tmp/palette.png
  ffmpeg -i "$f" -i /tmp/palette.png -filter_complex "fps=15,scale=500:-1:flags=lanczos[x];[x][1:v]paletteuse" -y "${f%.gif}_small.gif"
done