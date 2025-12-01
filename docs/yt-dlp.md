# ytdlp.conf

### BEST VIDEO + BEST AUDIO MERGE

Download and merge the best video-only format and the best audio-only format, or download the best combined format if video-only format is not available

```bash
yt-dlp -f "bv+ba/b"
```

### BEST VIDEO + IF NO AUDIO + BEST AUDIO MERGE

Download best format that contains video, and if it doesn't already have an audio stream, merge it with best audio-only format

```bash
yt-dlp -f "bv*+ba/b"` or `yt-dlp`
```

### BEST MP4 OR BEST VIDEO

Download the best mp4 video available, or the best video if no mp4 available

```bash
yt-dlp -f "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4] / bv*+ba/b"`
```

### BEST VIDEO + BEST EXTENSION

(For video, mp4 > mov > webm > flv. For audio, m4a > aac > mp3 ...)

```bash
yt-dlp -S "ext"`
```

### BEST VIDEO + < 480P

Download the best video available but no better than 480p or the worst video if there is no video under 480p

```bash
yt-dlp -f "bv*[height<=480]+ba/b[height<=480] / wv*+ba/w"`
```

### BEST VIDEO + LARGEST HEIGHT + < 480P

Download the best video available with the largest height but no better than 480p, or the best video with the smallest resolution if there is no video under 480p

```bash
yt-dlp -S "height:480"`
```

### BEST VIDEO + LARGEST RESOLUTION + < 480P

Download the best video available with the largest resolution but no better than 480p, or the best video with the smallest resolution if there is no video under 480p Resolution is determined by using the smallest dimension. So this works correctly for vertical videos as well

```bash
yt-dlp -S "res:480"`
```

### BEST VIDEO + DIRECT-LINK HTTP/HTTPS PROTOCOL

Download best video available via direct link over HTTP/HTTPS protocol, or the best video available via any protocol if there is no such video

```bash
yt-dlp -f "(bv*+ba/b)[protocol^=http][protocol!*=dash] / (bv*+ba/b)"`
```

### BEST VIDEO + BEST PROTOCOL

Download best video available via the best protocol(https/ftps > http/ftp > m3u8_native > m3u8 > http_dash_segments ...)

```bash
yt-dlp -S "proto"`
```

### BEST VIDEO WITH H264 OR H265

Download the best video with either h264 or h265 codec, or the best video if there is no such video

```bash
yt-dlp -f "(bv*[vcodec~='^((he|a)vc|h26[45])']+ba) / (bv*+ba/b)"`
```

## More Complex Examples

### BEST VIDEO < 720P + FPS 30+ OR WORST VIDEO + FPS 30+

Download the best video no better than 720p preferring framerate greater than 30, or the worst video (still preferring framerate greater than 30) if there is no such video

```bash
yt-dlp -f "((bv*[fps>30]/bv*)[height<=720]/(wv*[fps>30]/wv*)) + ba / (b[fps>30]/b)[height<=720]/(w[fps>30]/w)"`
```

### BEST VIDEO + LARGEST RESOLUTION < 720P

Download the video with the largest resolution no better than 720p, or the video with the smallest resolution available if there is no such video, preferring larger framerate for formats with the same resolution

```bash
yt-dlp -S "res:720,fps"`
```

### BEST VIDEO + SMALLEST RESOLUTION + > 480P

Download the video with smallest resolution no worse than 480p, or the video with the largest resolution available if there is no such video, preferring better codec and then larger total bitrate for the same resolution

```bash
yt-dlp -S "+res:480,codec,br"`
```
