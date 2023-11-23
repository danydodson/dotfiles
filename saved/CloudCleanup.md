# Cloud Cleanup

- Clear CloudDocs of folders referring to deleted Apps

```sh
cd ~/'Library/Application Support/CloudDocs/session/containers'

rm -rf iCloud.com.publisher.appname
rm -rf iCloud.com.publisher.appname.plist

```

- Delete iCloud App Library

```sh
cd ~/'Library/Mobile Documents/com~apple~CloudDocs'
cd ../

rm -R \
'/Users/Dany/Library/Mobile Documents/F3LWYJ7GM7~com~apple~mobilegarageband/Documents' \
'/Users/Dany/Library/Mobile Documents/F3LWYJ7GM7~com~apple~garageband10/Documents' \
'/Users/Dany/Library/Mobile Documents/F6266T9T75~com~apple~iMovie/Documents' \
'/Users/Dany/Library/Mobile Documents/W6L39UYL6Z~com~mindnode~MindNode/Documents' \
'/Users/Dany/Library/Mobile Documents/4R6749AYRE~com~pixelmatorteam~pixelmator/Documents' \
'/Users/Dany/Library/Mobile Documents/NK37SPV8GQ~cn~winat~EasyVoice/Documents' \
'/Users/Dany/Library/Mobile Documents/WUGMZZ5K46~com~bohemiancoding~sketch/Documents' \
'/Users/Dany/Library/Mobile Documents/com~apple~Numbers/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~com~agiletortoise~Drafts5/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~net~tejat~Fonts/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~co~fluder~fsnotes/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~com~globalid~globaliD/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~nl~Qwertasy~Gw2InSession/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~com~runloop~heavyset/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~space~Kodex~App/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~com~hasankassem~mockup/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~porizm~nodelab/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~co~noteplan~NotePlan/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~com~viettran~NotePlus/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~md~obsidian/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~de~cooperrs~Authenticator/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~com~pixelmatorteam~photo/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~com~apple~Playgrounds/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~com~reddit~reddit/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~dk~simonbs~Scriptable/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~com~twolivesleft~Shade/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~com~teologov~Snipper/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~com~moontechnolabs~ssh2/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~com~mathieurouthier~Suggester/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~com~nssurge~inc/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~app~cyan~taio/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~com~iconfactory~Blackbird/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~com~ubnt~unifiac/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~com~TapMediaLtd~VoiceRecorderFREE/Documents' \
'/Users/Dany/Library/Mobile Documents/iCloud~net~shinyfrog~bear/Documents'
```

---

- Remove the Artifact

```sh

rm -R \
F3LWYJ7GM7~com~apple~mobilegarageband \
F3LWYJ7GM7~com~apple~garageband10 \
F6266T9T75~com~apple~iMovie \
W6L39UYL6Z~com~mindnode~MindNode \
4R6749AYRE~com~pixelmatorteam~pixelmator \
NK37SPV8GQ~cn~winat~EasyVoice \
WUGMZZ5K46~com~bohemiancoding~sketch \
com~apple~Numbers \
iCloud~com~agiletortoise~Drafts5 \
iCloud~net~tejat~Fonts \
iCloud~co~fluder~fsnotes \
iCloud~com~globalid~globaliD \
iCloud~nl~Qwertasy~Gw2InSession \
iCloud~com~runloop~heavyset \
iCloud~space~Kodex~App \
iCloud~com~hasankassem~mockup \
iCloud~porizm~nodelab \
iCloud~co~noteplan~NotePlan \
iCloud~com~viettran~NotePlus \
iCloud~md~obsidian \
iCloud~de~cooperrs~Authenticator \
iCloud~com~pixelmatorteam~photo \
iCloud~com~apple~Playgrounds \
iCloud~com~reddit~reddit \
iCloud~dk~simonbs~Scriptable \
iCloud~com~twolivesleft~Shade \
iCloud~com~teologov~Snipper \
iCloud~com~moontechnolabs~ssh2 \
iCloud~com~mathieurouthier~Suggester \
iCloud~com~nssurge~inc \
iCloud~app~cyan~taio \
iCloud~com~iconfactory~Blackbird \
iCloud~com~ubnt~unifiac \
iCloud~com~TapMediaLtd~VoiceRecorderFREE \
iCloud~net~shinyfrog~bear \
356QY8883U~com~melodis~soundhound~free \
3L68KQB4HG~com~readdle~CommonDocuments \
3UMKW67674~at~mah~finances \
3UMKW67674~at~mah~finances~beta \
3UMKW67674~at~mah~finances~debug \
4R6749AYRE~com~pixelmatorteam~pixelmator \
4SDFS58KAG~me~walz~ruler \
57T9237FN3~net~whatsapp~WhatsApp \
5U8NS4GX82~com~dayoneapp~dayone \
6LVTQB9699~com~seriflabs~affinitydesigner \
777W53UFB2~iCloud~com~burbn~instagram \
7BUA9G6CLB~com~imangi~templerun2 \
7L2665GDL2~com~pannacooking~panna~ipad \
82J93X7T25~com~apple~mobileiphoto \
8375YL3V7A~me~npkn~wallyapp \
9B2QQPGL2V~be~netwalk~movielicious \
A9L2BYN4P3~com~norfello~docscanner \
AWD93N88MB~com~turborilla~MadSkillsBMXBlitz \
BQRKDTXN23~com~apptwee~ritv \
EHUV85D7V8~im~roboto~CardWallet \
F3LWYJ7GM7~com~apple~garageband10 \
F3LWYJ7GM7~com~apple~mobilegarageband \
F6266T9T75~com~apple~iMovie \
FXLPHZS84D~com~clickspace~tapforms \
KDF36UJ89S~com~velestar~vssh \
NK37SPV8GQ~cn~winat~EasyVoice \
P3ZB44H9AT~com~cameronchow~Strong \
QLA2ZR8DLM~com~thirstlabs~topics \
RXB6MSKG28~com~maddyhome~iphone~Palettes \
SGM366JANM~com~mediafire~iphone \
VDZ8PCF9YD~com~Halfbrick~FruitNinjaHD \
W6L39UYL6Z~com~mindnode~MindNode \
WUGMZZ5K46~com~bohemiancoding~sketch \
X6UDPZTLVR~Q5CS529KB3~com~velyoo~iDashboard \
XXKJ396S2Y~com~autodesk~SketchBookPro \
com~apple~Automator \
com~apple~CloudDocs \
com~apple~Keynote \
com~apple~Notes \
com~apple~Numbers \
com~apple~Pages \
com~apple~Preview \
com~apple~QuickTimePlayerX \
com~apple~SafariShared~History \
com~apple~ScriptEditor2 \
com~apple~TextEdit \
com~apple~TextInput \
com~apple~iBooks~cloudData \
com~apple~mail \
com~apple~mobilemail \
com~apple~shoebox \
com~apple~system~spotlight \
iCloud~Ff2lqVpcZ2~ComicZeal4 \
iCloud~Uniswap \
iCloud~app~funfocus~DetailsPro \
iCloud~com~8bit~bitwarden \
iCloud~com~JustZht~GitHubContributions \
iCloud~com~TapMediaLtd~Pro \
iCloud~com~TapMediaLtd~VoiceRecorderFREE \
iCloud~com~TapMedia~filebox \
iCloud~com~agiletortoise~Drafts5 \
iCloud~com~amazon~Drive \
iCloud~com~appersian~color \
iCloud~com~apple~DocumentsApp \
iCloud~com~apple~MobileSMS \
iCloud~com~apple~Playgrounds \
iCloud~com~apple~RealityComposer \
iCloud~com~apple~iBooks \
iCloud~com~apple~iBooks~iTunesU \
iCloud~com~apple~itunesu \
iCloud~com~apple~mobilesafari \
iCloud~com~apple~passd \
iCloud~com~apple~shortcuts~runtime \
iCloud~com~appliedphasor~working-copy \
iCloud~com~appliedphasor~working-copy-enterprise \
iCloud~com~axos~udb \
iCloud~com~behindtechlines~HTTPBot \
iCloud~com~click2mobile~collagegrameFree~ok \
iCloud~com~coinbase~wallet \
iCloud~com~comcsoft~iTransferPro \
iCloud~com~comquas~Athena \
iCloud~com~eprintit~FlexPrint \
iCloud~com~eprintit~ppl \
iCloud~com~evernote~Scannable \
iCloud~com~evernote~iPhone~Evernote \
iCloud~com~facebook~Messenger \
iCloud~com~facebook~Messenger~encryptedBackups \
iCloud~com~firecore~infuse~6 \
iCloud~com~freelancer~messenger \
iCloud~com~getdropbox~Dropbox \
iCloud~com~glassdoor~glassdoor \
iCloud~com~globalid~globaliD \
iCloud~com~google~b612 \
iCloud~com~google~container \
iCloud~com~hammockdistrict~clone \
iCloud~com~hankinsoft~sqlpro \
iCloud~com~hasankassem~mockup \
iCloud~com~hegenberg~BetterTouchTool \
iCloud~com~highcaffeinecontent~pastel \
iCloud~com~iconfactory~Blackbird \
iCloud~com~ideasoncanvas~MindNode \
iCloud~com~intuit~qbse \
iCloud~com~iuuapp~audiomaker \
iCloud~com~iversecomics~comicreader \
iCloud~com~izotope~Spire \
iCloud~com~jadedpixel~shopify \
iCloud~com~jordankoch~igloo \
iCloud~com~linkedin~LinkedIn \
iCloud~com~mathieurouthier~Suggester \
iCloud~com~mewe \
iCloud~com~michaelmatics~chordprogressiongenerator \
iCloud~com~microsoft~Office~Excel \
iCloud~com~microsoft~Office~PowerPoint \
iCloud~com~microsoft~Office~Word \
iCloud~com~microsoft~skydrive \
iCloud~com~mkApps~MarkdownEditor \
iCloud~com~moontechnolabs~ssh2 \
iCloud~com~nssurge~inc \
iCloud~com~onmyway133~PastePal \
iCloud~com~pixelmatorteam~photo \
iCloud~com~polygitapp~polygit \
iCloud~com~reddit~reddit \
iCloud~com~renfei~SnippetsLab \
iCloud~com~resonantcavity~Voloco \
iCloud~com~runloop~heavyset \
iCloud~com~seriflabs~affinityshared \
iCloud~com~skyjos~fileexplorerfree~icloud \
iCloud~com~skyjos~fileexplorer~icloud \
iCloud~com~soundbrenner~metronome~development \
iCloud~com~teologov~Snipper \
iCloud~com~twolivesleft~Shade \
iCloud~com~ubnt~unifiac \
iCloud~com~viettran~NotePlus \
iCloud~com~wizeyes~colorcapture \
iCloud~co~bergen~Darkroom \
iCloud~co~fluder~fsnotes \
iCloud~co~noteplan~NotePlan \
iCloud~de~cooperrs~Authenticator \
iCloud~dk~simonbs~Scriptable \
iCloud~es~produkt~app~panels \
iCloud~fm~overcast~overcast \
iCloud~host~exp~Exponent \
iCloud~is~workflow~my~workflows \
iCloud~it~bloop~airmail2 \
iCloud~it~twsweb~Nextcloud \
iCloud~md~obsidian \
iCloud~mega~ios \
iCloud~meshtech~no \
iCloud~me~rainbow \
iCloud~me~walz~ruler \
iCloud~net~shinyfrog~bear \
iCloud~net~tejat~Fonts \
iCloud~nl~Qwertasy~Gw2InSession \
iCloud~org~coursera~coursera \
iCloud~org~videolan~vlc-ios \
iCloud~org~wordpress \
iCloud~ph~telegra~Telegraph \
iCloud~pl~ewas~Crax \
iCloud~porizm~nodelab \
iCloud~ru~macflash~bf \
iCloud~space~Kodex~App \
iCloud~spoticamenu \
iCloud~tech~spotapp~spot \
iCloud~uk~co~codingcorner~iFont \
iCloud~us~afterlight~Afterlight \

```
