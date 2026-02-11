Sample use cases How to upload

# Uploading is easy using curl

```
$ curl --upload-file ./hello.txt https://transfer.archivete.am/hello.txt
```

https://transfer.archivete.am/66nb8/hello.txt

```
$ curl -H "Max-Downloads: 1" -H "Max-Days: 5" --upload-file ./hello.txt https://transfer.archivete.am/hello.txt
```

https://transfer.archivete.am/66nb8/hello.txt

# Download the file

```
$ curl https://transfer.archivete.am/66nb8/hello.txt -o hello.txt
```

Add shell function to .bashrc or .zshrc

# Add this to .bashrc or .zshrc or its equivalent

```
transfer(){ if [ $# -eq 0 ];then echo "No arguments specified.\nUsage:\n transfer <file|directory>\n ... | transfer <file_name>">&2;return 1;fi;if tty -s;then file="$1";file_name=$(basename "$file");if [ ! -e "$file" ];then echo "$file: No such file or directory">&2;return 1;fi;if [ -d "$file" ];then file_name="$file_name.zip" ,;(cd "$file"&&zip -r -q - .)|curl --progress-bar --upload-file "-" "https://transfer.archivete.am/$file_name"|tee /dev/null,;else cat "$file"|curl --progress-bar --upload-file "-" "https://transfer.archivete.am/$file_name"|tee /dev/null;fi;else file_name=$1;curl --progress-bar --upload-file "-" "https://transfer.archivete.am/$file_name"|tee /dev/null;fi;}
```

# Now you can use transfer function

```
$ transfer hello.txt
```

More examples Upload multiple files at once

```
$ curl -i -F filedata=@/tmp/hello.txt -F filedata=@/tmp/hello2.txt https://transfer.archivete.am/
```

# Combining downloads as zip or tar archive

```
$ curl https://transfer.archivete.am/(15HKz/hello.txt,15HKz/hello.txt).tar.gz
$ curl https://transfer.archivete.am/(15HKz/hello.txt,15HKz/hello.txt).zip
```

Encrypt your files with gpg before the transfer

# Encrypt files with password using gpg

```
$ cat /tmp/hello.txt|gpg -ac -o-|curl -X PUT --upload-file "-" https://transfer.archivete.am/test.txt
```

# Download and decrypt

```
$ curl https://transfer.archivete.am/1lDau/test.txt|gpg -o- > /tmp/hello.txt
```

Scan for malware

# Scan for malware or viruses using Clamav

```
$ wget http://www.eicar.org/download/eicar.com
$ curl -X PUT --upload-file ./eicar.com https://transfer.archivete.am/eicar.com/scan
```

# Upload malware to VirusTotal, get a permalink in return

```

```

$ curl -X PUT --upload-file nhgbhhj https://transfer.archivete.am/test.txt/virustotal

```
Backup mysql database, encrypt and transfer
# Backup, encrypt and transfer
```

$ mysqldump --all-databases|gzip|gpg -ac -o-|curl -X PUT --upload-file "-" https://transfer.archivete.am/test.txt

```
Send email with transfer link (uses shell function)
# Transfer and send email with link (uses shell function)
```

$ transfer /tmp/hello.txt | mail -s "Hello World" user@yourmaildomain.com

```
Using Keybase.io
# Import keys from keybase
```

$ keybase track [them]

```
# Encrypt for recipient(s)
```

$ cat somebackupfile.tar.gz | keybase encrypt [them] | curl --upload-file '-' https://transfer.archivete.am/test.txt

```
# Decrypt
```

$ curl https://transfer.archivete.am/sqUFi/test.md |keybase decrypt

```
wget uploads also supported
# wget
```

$ wget --method PUT --body-file=/tmp/file.tar https://transfer.archivete.am/file.tar -O - -nv

```
Transfer pound logs
# grep syslog for pound and transfer
```

$ cat /var/log/syslog|grep pound|curl --upload-file - https://transfer.archivete.am/pound.log

```
Upload a file using Powershell
# Upload using Powershell
```

PS H:\> invoke-webrequest -method put -infile .\file.txt https://transfer.archivete.am/file.txt

```
Upload a file using HTTPie
# HTTPie
$ http https://transfer.archivete.am/ -vv < /tmp/test.log
Upload a file using Unofficially client in Python

# transfersh-cli (https://github.com/tanrax/transfersh-cli)
$ trasnfersh photos.zip
# Uploading file
# Download from here: https://transfer.archivete.am/xxxxxx/photos.zip
# It has also been copied to the clipboard!
Encrypt your files with openssl before the transfer
# Encrypt files with password using openssl
$ cat /tmp/hello.txt|openssl aes-256-cbc -pbkdf2 -e|curl -X PUT --upload-file "-" https://transfer.archivete.am/test.txt

# Download and decrypt
$ curl https://transfer.archivete.am/1lDau/test.txt|openssl aes-256-cbc -pbkdf2 -d > /tmp/hello.txt
Upload a file or directory in Windows
#Save this as transfer.cmd in Windows 10 (which has curl.exe)
@echo off
setlocal EnableDelayedExpansion EnableExtensions
goto main
:usage
echo No arguments specified. >&2
echo Usage: >&2
echo transfer ^<file^|directory^> >&2
echo ... ^| transfer ^<file_name^> >&2
exit /b 1
:main
if "%~1" == "" goto usage
timeout.exe /t 0 >nul 2>nul || goto not_tty
set "file=%~1"
for %%A in ("%file%") do set "file_name=%%~nxA"
if exist "%file_name%" goto file_exists
echo %file%: No such file or directory >&2
exit /b 1
:file_exists
if not exist "%file%\" goto not_a_directory
set "file_name=%file_name%.zip"
pushd "%file%" || exit /b 1
set "full_name=%temp%\%file_name%"
powershell.exe -Command "Get-ChildItem -Path . -Recurse | Compress-Archive -DestinationPath ""%full_name%"""
curl.exe --progress-bar --upload-file "%full_name%" "https://transfer.archivete.am/%file_name%"
popd
goto :eof
:not_a_directory
curl.exe --progress-bar --upload-file "%file%" "https://transfer.archivete.am/%file_name%"
goto :eof
:not_tty
set "file_name=%~1"
curl.exe --progress-bar --upload-file - "https://transfer.archivete.am/%file_name%"
goto :eof
```
