## Normalize Video Files

#### Re-Encode

```bash
ffmpeg -i input.mp4 -c:v libx264 -preset faster -crf 24 -c:a copy -movflags +faststart output.mp4
```

#### High Quality

```bash
ffmpeg -i input.mp4 -c:v libx264 -preset slower -crf 18 -c:a copy output.mp4
```

#### Lossless

```bash
ffmpeg -i input.mov -c:v libx264 -crf 0 output-lossless.mp4
```

#### Deinterlace

```bash
ffmpeg -i input.mp4 -vf yadif output-deinterlace.mp4
```

#### Output to 60fps

```bash
ffmpeg -i input.mp4 -vf "setpts=0.5*PTS" -r 60 output-60fps.mp4
```

#### High Frame Rate Slow Motion

```bash
ffmpeg -i input.mp4 -filter:v "minterpolate=fps=240:mi_mode=mci:mc_mode=aobmc:me_mode=bidir:vsbmc=1, setpts=4.0*PTS",scale=1920:1080:flags=lanczos -an -c:v libx264 -preset faster -crf 18 output_slowmotion.mp4
```

#### Thumbnails (Extract 1 per sec in 10-20s range)

```bash
ffmpeg -ss 00:00:10 -to 00:00:20 -i input.mp4 -vf "fps=1" -qscale:v 2 "thumb%04d.jpg"
```

#### Extract all frames

```bash
ffmpeg -i input.mp4 frame%04d.png
```

#### Create Single Frame

```bash
ffmpeg -ss 00:00:10 -i input.mp4 -vframes 1 frame.png
```

#### Create lossless PNG frame

```bash
ffmpeg -ss 00:00:10 -i input.mp4 -vframes 1 -f image2 -vcodec png frame_lossless.png
```

#### Download M3U8 Stream

```bash
ffmpeg -i "http://example.com/stream.m3u8" -c copy -bsf:a aac_adtstoasc output.mp4
```

#### Record Screencast

```bash
ffmpeg -f x11grab -r 25 -s 1280x720 -i :0.0 output_screencast.mkv
```

#### Live Stream

```bash
ffmpeg -f alsa \
  -ac 2 \
  -i hw:0,0 \
  -f x11grab \
  -framerate 30 \
  -video_size 1280x720 \
  -i :0.0+0,0 \
  -c:v libx264 \
  -preset veryfast \
  -b:v 1984k \
  -maxrate 1984k \
  -bufsize 3968k \
  -vf "format=yuv420p" \
  -g 60 \
  -c:a aac \
  -b:a 128k \
  -bashar 44100 \
  -f flv rtmp://live.twitch.tv/app/stream_key
```

#### Natural Color Correction

```bash
ffmpeg -i input.mp4 -vf "eq=brightness=0.15:contrast=1.3:saturation=0.9,colorbalance=rs=-0.1:gs=0.05:bs=0.05" -c:v libx264 -crf 18 -preset slow output_color_corrected.mp4
```

#### Tonemap HDR (BT.2020) to SDR (BT.709)

```bash
ffmpeg -i file.mkv -vf "zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable,zscale=t=bt709:m=bt709:r=tv,format=yuv420p" -crf 20 -acodec copy output_sdr.mkv
```

#### Change Video Metadata Title

```bash
ffmpeg -i input.mp4 -metadata title="My New Video Title" -c copy output_with_title.mp4
```

#### High-Quality Encoding (H.264 / H.265)

```bash
Utilize the Constant Rate Factor (CRF) for H.264/H.265 encoding, balancing quality and file size. Lower CRF values mean higher quality (0 is lossless, 23 is default, 18-20 is visually lossless). preset controls encoding speed vs. compression efficiency.
```

#### H.264 (libx264) with CRF 18 (visually lossless) and slower preset

```bash
ffmpeg -i input.mp4 -c:v libx264 -preset slower -crf 18 -c:a copy output.mp4
```

#### H.265 (libx265) for better compression (iOS Airdrop compatible tag `hvc1`)

```bash
ffmpeg -i input.mp4 -c:v libx265 -vtag hvc1 -preset medium -crf 24 -c:a copy output.mp4
```

#### Lossless H.264 encoding (very large files)

```bash
ffmpeg -i input.mov -c:v libx264 -crf 0 output.mp4
```
