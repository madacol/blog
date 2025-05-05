---
tags: english, tutorial, til, ubuntu, nautilus, ffmpeg, video, mp4
date: 2023-08-15
---

# Script to convert videos to mp4 with Nautilus (Ubuntu's file explorer)

In Ubuntu, nautilus has a folder where it stores scripts that can be executed from the context menu of the file explorer. This is the path to that folder:

```bash
~/.local/share/nautilus/scripts
```

To create a script that converts videos to mp4, create a file in that folder with the following content:

```bash
#!/bin/bash

for file in "$@"
do
	outputpath="/dev/shm"
	filename=$(basename "$file")
	basefilename="${filename%.*}"
	output="$outputpath/${basefilename}.mp4"

	ffmpeg -i "$file" -y \
		-vf "scale='bitand(oh*dar,65534)':'min(720,ih)'" \
		-vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" \
		-c:v libx264 -pix_fmt yuv420p \
		-profile:v baseline -level 3.0 \
		"$output"\
		2> /dev/shm/convertToMP4.log

		# -acodec aac -ar 44100 -ac 2\
		# -movflags +faststart \
		# -minrate 1024k -maxrate 1024k -bufsize 1024k \
done
```

The name of the file will be the name of the script in the context menu. In this case, I named it `Convert to MP4`.

![Context menu showing the "Convert to MP4" option](image.png)
