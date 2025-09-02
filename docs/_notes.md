# JavaScripts
JavaScript files (edited by me &amp; originals from greasy/sleazyfork.com)


- [jQuery min v3.6.0](https://github.com/Snakejuice87/JavaScripts/raw/main/jquery.min.js)


      // JQuery Link
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

      // CSS anf JS local file linking
<link rel="stylesheet" href="style.css" type="text/css">
<script src="script.js"></script>
  
  
//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-
//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-

data:text/html,


                                            //     converting SUBTITLE 
                                      // using REGEX wìth RUNESTONE app

 ///   converting SRT to ASS

          // Gemma
      search:        \n?\d?(\d:\d\d:\d\d).(\d\d)\d( --> |\,)\d?(\d:\d\d:\d\d).(\d\d)\d\n?\D?(<font color=#......>)?(.+)?(</font>)?$
      replace:      Dialogue: 0,$1.$2,$4.$5,Gemma Best,,0,0,0,,$7
          // Wayne
      search:        \n?\d?(\d:\d\d:\d\d).(\d\d)\d( --> |\,)\d?(\d:\d\d:\d\d).(\d\d)\d\n?\D?(<font color=#......>)?(.+)?(</font>)?$
      replace:      Dialogue: 0,$1.$2,$4.$5,Wayne best,,0,0,0,,$7


///   convrring ASS to SRT

          // Gemma
      search:        Dialogue: \d,(\d:\d\d:\d\d.\d\d),(\d:\d\d:\d\d.\d\d),Gemma Best,,0,0,0,,(.*)
      replace:       0$10 --> 0$20\n<font color=#E99CFD>$3</font>)\n
          // Wayne
      search:        Dialogue: \d,(\d:\d\d:\d\d.\d\d),(\d:\d\d:\d\d.\d\d),Wayne best,,0,0,0,,(.*)
      replace:       0$10 --> 0$20\n<font color=#67B3FF>$3</font>)\n


//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-
//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-
                                  //  {     IMPORTANT HTML AND DOM JS     }
//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-

      // Get details of Window.location

const logLines = ["Property (Typeof): Value", `location (${typeof location}): ${location}`, ];
for (const prop in location) {
    logLines.push(`${prop} (${typeof location[prop]}): ${location[prop] || "n/a"}`, );
}
console.log(logLines.join("\n"));


//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-

      // Prevent site from redirect (unload)

  let warn = false;
window.addEventListener(’beforeunload’, e => {
  if (!warn) return;

      // Cancel the event
  e.preventDefault();

      // Chrome requires returnValue to be set
  e.returnValue = ’’;
});
warn = true;  // during runtime you change warn to true


//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-

      // Changes all elements with example class name font size to 18px

      // v.1 
            // (changes for all selected)
const list = document.querySelectorAll("example");
      for (let i = 0; i < list.length; i++) {
          list[i].style.textSize = "18px";
}
    
    // v.2
            // adds css JQuery
$(document).ready(function() {
     $(’#example’).css({ ’width’:’1080px’, ’right’:’0px’, ’left’: ’0px’ });
  });


//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-

      // open url in new tab !!

  var win = window.open(’http://url.com/’, ’_blank’);
if (win) {

      //Browser has allowed it to be opened
    win.focus();
} else {

      //Browser has blocked it
    alert(’Please allow popups for this website’);
}
  
  
//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-

      // !! - Multiple element src grab

  var imgs = document.getElementsByTagName("img");
var imgSrcs = [];
for (var i = 0; i < imgs.length; i++) {
  imgSrcs.push(imgs[i].src);
}
imgs = document.getElementsByTagName("video");
for (var i = 0; i < imgs.length; i++) {
  imgSrcs.push(imgs[i].src);
}
document.getElementsByTagName("audio");
for (var i = 0; i < imgs.length; i++) {
  imgSrcs.push(imgs[i].src);
}
 completion(imgSrcs);

    // v.2
var imgs1 = document.getElementsByTagName("img");
var imgs2 = document.getElementsByTagName("video");
var imgs3 = document.getElementsByTagName("source");
var imgs4 = document.querySelectorAll("video>source");
var imgSrcs = [];
for (var i = 0; i < imgs1.length; i++) {
  imgSrcs.push(imgs1[i].src);
}
for (var i = 0; i < imgs2.length; i++) {
  imgSrcs.push(imgs2[i].src);
}
for (var i = 0; i < imgs3.length; i++) {
  imgSrcs.push(imgs3[i].src);
}
for (var i = 0; i < imgs4.length; i++) {
  imgSrcs.push(imgs4[i].src);
}
 console.log(imgSrcs);


//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-
//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-

      // Reversing fb messages

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
 
<div class="message"><div class="message_header"><span class="user">Paigee Lewiis</span><span class="meta">Saturday, May 4, 2013 at 6:14pm UTC+08</span></div></div><p>Umm</p><div class="message"><div class="message_header"><span class="user">Chelsea Walker</span><span class="meta">Saturday, May 4, 2013 at 6:14pm UTC+08</span></div></div><p>remember me :)</p>
 
<script>
function display( divs ) {
  var a = [];
  for ( var i = 0; i < divs.length; i++ ) {
    a.push( divs[ i ].innerHTML );
  }
  $( "span" ).text( a.join(" ") );
}
display( $( "div" ).get().reverse() );
</script>


<//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-
//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-
      // DOM or HTML scripts
//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-

            // Creates button over video

.video-view {
  position: relative;
  width: 300px;
  height: 100px;
}

.video-view .video {
  position: absolute;
  width: 100%;
  height: 100%;
  object-fit: cover;
  background-color: #ccc;
}

.video-view .video-content {
  position: absolute;
  bottom: 0px;
}
<div class="video-view">
  <video class="video"></video>
  <div class="video-content">
    <button onclick="myFunction()">Sample</button>
  </div>
</div>


<//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-

      //Swap img src with another using a button 

<div>
    <img id="demo" src="4paiges&gemma.png"></img>
       <button id="txt" type="button" onclick="myFunction()" style="margin-top: 80px; zoom: 2; position: absolute; border: 1px solid grey; z-index: 99;">swap</button>
</div>
                  
<script>
    let colorImage = document.getElementById("demo");
    let button2 = document.getElementById("txt");

function swap() {
    if (colorImage.getAttribute(’src’) === "./img/4paiges&gemma.png") {
        colorImage.setAttribute(’src’, "./img/Corrina&us.png"),

      // colorImage.setAttribue(’background’, "url(’./img/4paiges&gemma.png’)");
    }
    else {
        colorImage.setAttribute(’src’, "./img/4paiges&gemma.png"),

      // colorImage.setAttribue(’background’, "url(’./img/Corrina&us.png’)");
    }
}
button2.addEventListener("click", swap);
</script>


>//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-

      // CREATE A BUTTON OVER VIDEO to Swap src 

        // SCRIPT
const video = document.querySelector(’video’);
const source = document.querySelector(’source’)

video.appendChild(source)
video.play()

const changeVideoButton = document.querySelector(’#changeVideo’)
changeVideo.addEventListener(’click’, e => {
  video.pause()
  
  source.setAttribute(’src’, "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")
  
  video.load()
  video.play()
})

<        // CSS
<style>
#container {
  position: relative;
}
video {
  width: 300px;
}
#changeVideo {
  position: absolute;
  top: 10px;
  left: 10px;
  width: 25px;
  height: 25px;
  opacity: 0;
  transition: opacity .3s ease;
  cursor: pointer;
  /* Additional styles just to increase visual appeal */
  border-radius: 50%;
  background: #FFFFFFDD;
  color: red;
  font-weight: bold;
  line-height: 25px;
  text-align: center;
  /* End */
}
/* On hovering the video, show the button */
video:hover~#changeVideo {
  opacity: 1;
}
#changeVideo:hover {
  opacity: 1;
}
</style>

<          // HTML
<div id="container">
  <video controls autoplay loop>
    <source src="http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4" type="video/mp4">
  </video>
  <div id="changeVideo">Swap</div>
</div>


>//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-

      // Gets current Webpage URL

// v.1
    var currentURL = document.URL;
    alert(currentURL);

// v.2
		let url = location.href;
		// document.getElementById("demo").innerHTML = url;
 console.log(url)


>//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-

      // Href on page scroll to reference

		<button onclick="myFunction()">Go to top</button>

		<script>
			function myFunction() {
				location.href = "#top";
			}
		</script>


>          //HTML version // ––––––––––––
      
  <element1 id="j1">
	
	<element2 href="#j1">
  
  
>//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-

      // Create Href Attribute to Element

		<button onclick="myFunction()">Add</button>

		<script>
			function myFunction() {
      // Create a href attribute:
				const attr = document.createAttribute("href");
      // Set the value of the href attribute:
				attr.value = "https://www.w3schools.com";
      // Add the href attribute to an element:
				document.getElementById("myAnchor").setAttributeNode(attr);
			}
		</script>
    

>//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-

          // Creat button with src link

$('video').prop('src')
// $('video').attr('src')

function showImgUrl(){
  console.log( $('video').prop('src') );
  // console.log($('#video').attr('src'));
}
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<img id='imageId' src='images/image1.jpg' height='50px' width='50px'/>

<input type='button' onclick='showImgUrl()' value='Src' />


<//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-

                // CSS inject
$(document).ready(function() {
     $(’#example’).css({ ’width’:’1080px’, ’right’:’0px’, ’left’: ’0px’ });
  });
  
    var imgs = document.getElementsByTagName("video");
var imgSrcs = [];
for (var i = 0; i < imgs.length; i++) {
  imgSrcs.push(imgs[i].src);
        // Creates & appends a new button Element
		const btn = document.createElement("button");
      btn.innerHTML = "Src";
      btn.style.width = "55px";
      btn.style.width = "55px";
      btn.style.height = "20px";
      btn.style.opacity = "1";
      btn.style.zindex = "999";
      btn.style.position = "absolute";
      btn.style.float = "right";
      btn.style.top = "99";
      btn.location.Href = ("href", imgs[i].src);
			document.body.appendChild(btn);
}


  // Open url

    window.open('https://google.com', '_blank');

in HTML

 		const btn = document.createElement("button");
    <button class="btn btn-success" onclick=" window.open('http://google.com','_blank')"> Google</button>


>//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-
//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-
    // General video stuff - loop script, leg only video playing script.. ect
//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-

      // Get src JQuery
$('.img1 img').attr('src');
// OR
$('video').attr('src');


//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-

      // Add/Remove Video controls
    
    function toggleControls() {
      ’use strict’;
  	var videos = document.querySelectorAll("video");
  
  	for (var video of videos) {
  
    
    if (videos.hasAttribute("controls")) {  
    } else {
       video.setAttribute("controls","controls")   
    }
  }


<//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-

      // Video ATTRIBUTES - play on mouseover & controls & loop	

		$(function(){
    $(’.video’).on(’mouseenter’, function(){
        if( this.paused) this.play();
    }).on(’mouseleave’, function(){
        if( !this.playing) this.pause();
    });
},

(function() {
	’use strict’;
	var videos = document.querySelectorAll("video");
	for (var video of videos) {
		video.setAttribute("controls", true);
		video.setAttribute("loop", true);
		video.setAttribute("muted", false);
		video.setAttribute("autoplay", true);
		video.loop = true;
		video.muted = false;
		video.autoplay = false;
		video.controls = true;
	},
	if (typeof video.loop == ’boolean’) { // loop supported
		video.loop = true;
	} else { // loop property not supported
		video.addEventListener(’ended’, function() {
			this.currentTime = 0;
			this.play();
		}, false);
	},

      //...
	video.play();
	})
	}
    
<//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-

      // Pause playing video if another video is played
    
		function onlyPlayOneIn(container) {
      container.addEventListener("play", function(event) {
      video_elements = container.getElementsByTagName("video")
        for(i=0; i < video_elements.length; i++) {
          video_element = video_elements[i];
          if (video_element !== event.target) {
            video_element.pause();
          }
        }
      }, true),
    }
    document.addEventListener("DOMContentLoaded", function() {
      onlyPlayOneIn(document.body);
    });
    function() {
      console.log("");
    });
    function(){
        document.getElementsByTagName("video").onPlay("play", function() {
            document.getElementsByTagName("video").not(this).each(function(index, video) {
                video.pause();
            });
        });
    });


>//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-

      // ! Shows a PLAY & PAUSE button on Video’s

      // HTML
      //HEAD
        		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
            
      //BODY
<div class="video-container">
      <div class="video-controls"><i class="fas fa-pause-circle play"></i></div>
      <video autoplay muted loop id="myVideo">
      <source src="img/video.mp4" />
  </video>
</div>
>      // END HTML

>    // Show video Play/Pause icons
<script>
    $("#myVideo").mouseenter(function() {
        $(’.video-controls’).show();
    }).mouseleave(function() {
        $(’.video-controls’).hide();
    });
    
>    // Pause/Play video on hover
  $("#myVideo").bind("click", function () {
      var vid = $(this).get(0);
          if (vid.paused) {
            vid.play();
            $(’.video-controls’).html(’<i class="fas fa-pause-circle pause"></i>’);
          } else {
            vid.pause();
            $(’.video-controls’).html(’<i class="fas fa-play-circle play"></i>’);
          }
      });
</script>
      
      
>//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-

      // PLAY VIDEO ON MOUSE OVER - 2 versions

// version 1
       // HTML version (inner video attribute)

     <video src="" onmouseover="this.play()" onmouseout="this.pause()" unmuted></video>

>// version 2
       // JS VERSION - script at end of body

		<script>
  $(function(){
    $(’.video’).on(’mouseenter’, function(){
        if( this.paused) this.play();
    }).on(’mouseleave’, function(){
        if( !this.playing) this.pause();
    });
});
</script>


>//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-
//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-
  
    
//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-		
        //––––––––––––––––––––-JAVASCIPT CODE - URL ENCODED––––––––––––––––––––-
//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-
    

      >// !! Gets CURRENT URL as parameter and opens Keepv.id in a New TAB
    
javascript:(function()%7B%20window.open(’https://keepv.id/?url=’+encodeURIComponent(location.href));%20%7D)();
    
<//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-

      // Eruda (Devtools) JavaScript code
        
javascript:(function () { var script = document.createElement(’script’); script.src="https://cdn.jsdelivr.net/npm/eruda"; document.body.append(script); script.onload = function () { eruda.init(); } })();

      // Runs Eruda (Devtools) via web browsers address bar
        
javascript:(function%20()%20%7B%20var%20script%20=%20document.createElement(’script’);%20script.src=%22https://cdn.jsdelivr.net/npm/eruda%22;%20document.body.append(script);%20script.onload%20=%20function%20()%20%7B%20eruda.init();%20%7D%20%7D)();

      // Gets the Page URL as input for site "keepv.id" that opens in a newtab
        
javascript:(function()%7B%20window.open(’https://keepv.id/?url=’+encodeURIComponent(location.href));%20%7D)();

      //  View Webpage HTML Source
      
javascript:(function()%7Bvar%20a=window.open(’about:blank’).document;a.write(’%3C!DOCTYPE%20html%3E%3Chtml%3E%3Chead%3E%3Ctitle%3ESource:%20’+location.href+’%3C/title%3E%3Cmeta%20name=%22viewport%22%20content=%22width=device-width%22%20/%3E%3C/head%3E%3Cbody%3E%3C/body%3E%3C/html%3E’);a.close();var%20b=a.body.appendChild(a.createElement(’pre’));b.style.overflow=’auto’;b.style.whiteSpace=’pre-wrap’;b.appendChild(a.createTextNode(document.documentElement.innerHTML))%7D)();


//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-

//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-
//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––-


