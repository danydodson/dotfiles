# FFMPEG Cheatsheet

---

## Installation

Install the latest FFMpeg static binaries to `/opt/ffmpeg_sources` (no libx265):

```bash
sudo mkdir -p /opt/ffmpeg_sources
sudo chown "$USER":"$USER" /opt/ffmpeg_sources
cd /opt/ffmpeg_sources

wget -O ffmpeg-snapshot.tar.bz2 https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
tar xjvf ffmpeg-snapshot.tar.bz2
cd ffmpeg

PATH="$PWD/bin:$PATH" PKG_CONFIG_PATH="$PWD/ffmpeg_build/lib/pkgconfig" ./configure \
  --prefix="$PWD/ffmpeg_build" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I$PWD/ffmpeg_build/include" \
  --extra-ldflags="-L$PWD/ffmpeg_build/lib" \
  --extra-libs="-lpthread -lm" \
  --ld="g++" \
  --bindir="$PWD/bin" \
  --enable-gpl \
  --enable-gnutls \
  --enable-libaom \
  --enable-libass \
  --enable-libfdk-aac \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libsvtav1 \
  --enable-libdav1d \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
  --enable-nvdec \
  --enable-vaapi \
  --enable-nonfree

PATH="$PWD/bin:$PATH" make
make install
hash -r
````

---

## HQ Encoding

* **CRF** (Constant Rate Factor): Lower = higher quality (range 0-51, default 23, visually lossless at 18).
* **Preset** controls encoding speed.

```bash
ffmpeg -i in.mp4 -preset slower -crf 18 out.mp4
```

More: [FFmpeg H.264 Encoding](https://trac.ffmpeg.org/wiki/Encode/H.264)

---

## HQ Deinterlace

```bash
ffmpeg -i in.mp4 -vf yadif out.mp4
```

---

## Convert to WebM

**VP8**
[FFmpeg VP8 Guide](https://trac.ffmpeg.org/wiki/Encode/VP8)

```bash
ffmpeg -i input.mov -vcodec libvpx -qmin 0 -qmax 50 -crf 10 -b:v 1M -acodec libvorbis output.webm
```

**VP9**
[FFmpeg VP9 Guide](https://trac.ffmpeg.org/wiki/Encode/VP9)
[Google VP9 Guide](https://sites.google.com/a/webmproject.org/wiki/ffmpeg/vp9-encoding-guide)

Basic:

```bash
ffmpeg -i input.mov -vcodec libvpx-vp9 -b:v 1M -acodec libvorbis output.webm
```

Two-pass (Google "Best Quality (Slowest)"):

```bash
# Pass 1
ffmpeg -i <source> -c:v libvpx-vp9 -pass 1 -b:v 1000K -threads 1 -speed 4 \
-tile-columns 0 -frame-parallel 0 -auto-alt-ref 1 -lag-in-frames 25 \
-g 9999 -aq-mode 0 -an -f webm /dev/null

# Pass 2
ffmpeg -i <source> -c:v libvpx-vp9 -pass 2 -b:v 1000K -threads 1 -speed 0 \
-tile-columns 0 -frame-parallel 0 -auto-alt-ref 1 -lag-in-frames 25 \
-g 9999 -aq-mode 0 -c:a libopus -b:a 64k -f webm out.webm
```

---

## HQ Deshake

Pass 1 (detect):

```bash
ffmpeg -i input.mkv -vf 'select=not(mod(n\,20))',setpts=0.05*PTS,mestimate=hexbs,vidstabdetect=shakiness=10:result=transforms.trf
```

Pass 2 (transform):

```bash
ffmpeg -i input.mkv -vf 'select=not(mod(n\,20))',setpts=0.05*PTS,vidstabtransform=crop=black:smoothing=0:optzoom=0
```

Example (pass 2 with smoothing):

```bash
ffmpeg -i MOV_3147.mp4 -vf 'select=not(mod(n\,20))',setpts=0.05*PTS,vidstabtransform=crop=black:smoothing=180:optzoom=0:interpol=bicubic -an -vcodec libx265 -crf 16 -tune grain wolken-2-deshake.mkv
```

---

## Tonemap HDR (BT.2020) to SDR (BT.709)

```bash
ffmpeg -i file.mkv -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable,zscale=t=bt709:m=bt709:r=tv,format=yuv420p -crf 20 -acodec copy output.mkv
```

[Guide](https://stevens.li/guides/video/converting-hdr-to-sdr-with-ffmpeg/)

---

## High Frame Rate Slow-Motion (No Sound)

```bash
ffmpeg -i input.mp4 -filter:v "minterpolate=fps=240:mi_mode=mci:mc_mode=aobmc:me_mode=bidir:vsbmc=1, setpts=4.0*PTS",scale=1920:1080:flags=lanczos -an -c:v libx264 -preset faster -crf 18 output.mp4
```

Experimental:

```bash
ffmpeg -loglevel info -i vid-speedup.mp4 -preset veryslow -crf 17 -subq 10 -me_range 64 \
-partitions p8x8,p4x4,b8x8,i8x8,i4x4 \
-vf "minterpolate=fps=90:mi_mode=mci,scale=h=1844:w=1036:flags=experimental,setpts=PTS*4" output.mp4
```

---

## Stabilize Video

**Requires `libvidstab` filter.**

Detect:

```bash
ffmpeg -i vid.mp4 -vf vidstabdetect -f null -
```

Transform:

```bash
ffmpeg -i vid.mp4 -vf vidstabtransform=smoothing=5:input="transforms.trf" vidstab.mp4
```

---

## Adjust Video Speed (PTS)

**Slow Down:**

```bash
ffmpeg -i vid.mp4 -filter:v "setpts=4.0*PTS" vid.mp4
```

**Speed Up:**

```bash
ffmpeg -i vid.mp4 -filter:v "setpts=0.5*PTS" vid.mp4
```

**Quadruple Speed (with new framerate):**

```bash
ffmpeg -i vid.mkv -r 16 -filter:v "setpts=0.25*PTS" vid.mkv
```

---

## Cut

**Without Re-encoding:**

```bash
ffmpeg -ss [start] -i vid.mp4 -t [duration] -c copy vid.mp4
```

**With Re-encoding:**

```bash
ffmpeg -ss [start] -i vid.mp4 -t [duration] -c:v libx264 -c:a aac -strict experimental -b:a 128k vid.mp4
```

---

## Merge Videos

1. Create a `.txt` file:

   ```
   file 'vid.mp4'
   file 'vid2.mp4'
   file 'vid3.mp4'
   file 'vid4.mp4'
   ```
2. Concatenate:

   ```bash
   ffmpeg -f concat -i list.txt -c copy vid.mp4
   ```

---

## Create Thumbnails

```bash
ffmpeg -ss 00:08:20 -to 00:08:33 -i vid.mp4 -vf "fps=1" \
-qscale:v 2 -strftime 1 "thumb-%Y%m%d%H%M%S.png" -hide_banner
```

Add `2> error.log` for error handling.

---

## Rotate a Video

Rotate 90 degrees clockwise:

```bash
ffmpeg -i vid.mov -vf "transpose=1" vid.mov
```

* `0 = 90° CCW + vertical flip`
* `1 = 90° CW`
* `2 = 90° CCW`
* `3 = 90° CW + vertical flip`
* 180°: `-vf "transpose=2,transpose=2"`

---

## Create a Video Slideshow from Images

**Variation 1:**

```bash
ffmpeg -r 1/5 -i img%03d.png -c:v libx264 -vf fps=25 -pix_fmt yuv420p vid.mp4
```

**Variation 2 (truncates images):**

```bash
ffmpeg -framerate 1/3 -i frame_%d.jpg -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -c:v libx264 -r 30 -pix_fmt yuv420p slideshow.mp4
```

**Variation 3 (Adds interpolation):**

```bash
ffmpeg -framerate 1/3 -i frame_%d.jpg -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2,minterpolate='mi_mode=mci:mc_mode=aobmc:vsbmc=1:fps=60'" -c:v libx264 -r 60 -pix_fmt yuv420p slideshow.mp4
```

**Variation 4:**

```bash
ffmpeg -f image2 -framerate 12 -i foo-%03d.jpeg -s WxH foo.avi
```

**Variation 5 (40x speed):**

```bash
ffmpeg -framerate 1/3 -i frame_%d.jpg -vf "scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2,format=yuv420p" -c:v libx264 -r 120 -pix_fmt yuv420p -s 1280x720 slideshow.mp4
```

---

## Extract Images from a Video

**All frames:**

```bash
ffmpeg -i vid.mp4 thumb%04d.jpg -hide_banner
```

**Frame every second:**

```bash
ffmpeg -i vid.mp4 -vf fps=1 thumb%04d.jpg -hide_banner
```

**One frame at specific time:**

```bash
ffmpeg -i vid.mp4 -ss 00:00:10.000 -vframes 1 thumb.jpg
```

**Lossless PNG:**

```bash
ffmpeg -i vid.mp4 -ss 00:00:10.000 -vframes 1 -f image2 -vcodec png thumb.png
```

---

## Ripping Streaming Media

1. **Get m3u8 url:**
   Use `youtube-dl -g` to print the m3u8 url.

2. **Download & concatenate:**

   ```bash
   ffmpeg -i "path_to_playlist.m3u8" -c copy -bsf:a aac_adtstoasc vid.mp4
   ```

   If you get protocol errors:

   ```bash
   ffmpeg -protocol_whitelist "file,http,https,tcp,tls" -i "path_to_playlist.m3u8" -c copy -bsf:a aac_adtstoasc vid.mp4
   ```

3. **Helper script:**

   ```bash
   echo "Enter m3u8 link:"; read link; echo "Enter output filename:"; read filename; ffmpeg -i "$link" -c copy $filename.mp4
   ```

---

# Advanced

## Encode Multiple Files

```bash
for f in *.m4a; do ffmpeg -i "$f" -codec:v copy -codec:a libmp3lame -q:a 2 newfiles/"${f%.m4a}.mp3"; done
```

---

## Extract Single Image at Frame (custom function)

Custom script (`vf`):

```bash
ffmpeg -ss $1 -i $2 -qmin 1 -q:v 1 -qscale:v 2 -frames:v 1 -huffman optimal $3.jpg
```

Where `ss` offset = frame\_number / FPS.

---

## Duplicate Video N Times

```bash
ffmpeg -stream_loop 3 -i input.mp4 -c copy output.mp4
```

---

## Rotate by Metadata (No Re-encode)

```bash
ffmpeg -i input.m4v -map_metadata 0 -metadata:s:v rotate="90" -codec copy output.m4v
```

---

## Reduce Filesize

Reduce size with good quality:

```bash
ffmpeg -i input.mov -vcodec libx264 -crf 24 output.mp4
```

Grayscale, scale, and compress:

```bash
ffmpeg -i video.mov -vf eq=saturation=0 -s 640x480 -c:v libx264 -crf 24 output.mp4
```

---

## Convert MP4 to WEBM

```bash
ffmpeg -i input.mp4 -c:v libvpx-vp9 -crf 31 -b:v 1M output.webm
```

[More info](http://trac.ffmpeg.org/wiki/Encode/VP9)

---

## Reverse a Video

```bash
ffmpeg -i vid.mp4 -vf reverse reversed.mp4
```

---

## Looperang (Ping-Pong Video)

Concat a video with a reversed copy:

```bash
ffmpeg -i input.mov \
-filter_complex "[0:v]reverse[r];[0:v][r]concat=n=2:v=1[v]" \
-map "[v]" output.mp4
```

---

## Mosaic from Every n-th Frame

```bash
ffmpeg -ss 13 -i test.mov -frames 1 -vf "select=not(mod(n\,400)),scale=854:480,tile=8x4" tile.png
```

---

## Mosaic by Scene Change

Mosaic:

```bash
ffmpeg -i YosemiteHDII.webm -vf "select=gt(scene\,0.4),scale=854:480,tile" -frames:v 1 preview.png
```

Export frames:

```bash
ffmpeg -i YosemiteHDII.webm -vf "select=gt(scene\,0.4),scale=854:480" -vsync vfr frame_%04d.png
```

---

## Convert H.264 to H.265 (iOS Airdrop Fix)

```bash
ffmpeg -i input.mp4 -c:v libx265 -vtag hvc1 -c:a copy output.mp4
```

---

## Natural Color Presentation

```bash
ffmpeg -i input.mp4 -vf "eq=brightness=0.15:contrast=1.3:saturation=0.9,colorbalance=rs=-0.1:gs=0.05:bs=0.05" -c:v libx264 -crf 18 -preset slow output.mp4
```

---

## Loop Video Infinitely

```bash
ffmpeg -threads 2 -re -fflags +genpts -stream_loop -1 -i ./test.mp4 -c copy ./test.m3u8
```

---

# Basics

## Quick Convert

```bash
ffmpeg -i vid.mp4 vid.avi
ffmpeg -i vid.mp4 vid.mov
ffmpeg -i vid.mp4 vid.webm
ffmpeg -i vid.mp4 vid.mkv
```

---

## Remux MKV to MP4

```bash
ffmpeg -i vid.mkv -c:v copy -c:a copy vid.mp4
```

---

## Kill Audio

```bash
ffmpeg -i vid.mp4 -an vid.mp4
```

---

## Trim Audio

```bash
ffmpeg -i audio_file.mp3 -ss [start_time] -to [end_time] -c copy trimmed_audio_file.mp3
```

---

## Deblock and Denoise

```bash
ffmpeg -i vid.mp4 -vf "hqdn3d,deblock" vid.mp4
```

---

## Metadata: Change the title

```bash
ffmpeg -i in.mp4 -map_metadata -1 -metadata title="My Title" -c:v copy -c:a copy out.mp4
```

---

## Tools

* [ffmpeg.lav.io](https://ffmpeg.lav.io/) — Interactive resource to compose FFmpeg actions.

```
