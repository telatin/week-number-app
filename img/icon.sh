mkdir WeekNumber.iconset

convert icon.png -resize 16x16    WeekNumber.iconset/icon_16x16.png
convert icon.png -resize 32x32    WeekNumber.iconset/icon_16x16@2x.png
convert icon.png -resize 32x32    WeekNumber.iconset/icon_32x32.png
convert icon.png -resize 64x64    WeekNumber.iconset/icon_32x32@2x.png
convert icon.png -resize 128x128  WeekNumber.iconset/icon_128x128.png
convert icon.png -resize 256x256  WeekNumber.iconset/icon_128x128@2x.png
convert icon.png -resize 256x256  WeekNumber.iconset/icon_256x256.png
convert icon.png -resize 512x512  WeekNumber.iconset/icon_256x256@2x.png
convert icon.png -resize 512x512  WeekNumber.iconset/icon_512x512.png
cp icon.png                       WeekNumber.iconset/icon_512x512@2x.png

