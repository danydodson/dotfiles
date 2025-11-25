'use strict';

function getFavicon(){
  let nodeList = document.getElementsByTagName("link");
  for (let i = nodeList.length - 1; i >= 0; i--){
    let rel = nodeList[i].getAttribute("rel");
    if(/((\sicon)|(^icon))\b/i.test(rel) || (rel === "apple-touch-icon-precomposed")){
      try{
        let img = new Image();
        img.src = nodeList[i].href;
        return img
      }catch(e){
        
      }
    }
  }
  let img = new Image();
  img.src = "https://"+document.location.host+"/favicon.ico";
  return img
}

async function createFaviconCanvas(){
  let icon = getFavicon();
  if(!icon.src){
    return
  }
  try{
    await icon.decode();
    return getColorForImage(icon);
  }catch(e){
    
  }
  return null
}
class Color{
  constructor(r,g,b){
    this.r = Math.floor((r+32)/63);
    this.g = Math.floor((g+32)/63);
    this.b = Math.floor((b+32)/63);
  }
  toString(){
    //const arr = ["","\u200b","\u200c","\u200d","\ufeff"];
    const arr = ["","\u2062","\u2063","\u2064","\ufeff"];
    let r = arr[this.r];
    let g = (arr[this.g]).repeat(2);
    let b = (arr[this.b]).repeat(3);
    return `\u2060 ${r} ${g} ${b} `;
  }
  static from(str){
    if(typeof str !== "string"){
      return null
    }
    if(/#[0-9a-f]{6}/i.test(str.slice(0,7))){
      let red = Number.parseInt(str.slice(1,3),16);
      let green = Number.parseInt(str.slice(3,5),16);
      let blue = Number.parseInt(str.slice(5,7),16);
      return new Color(red,green,blue);
    }
    if(str.startsWith("rgb(")){
      let things = str.match(/\d+/g);
      if(things.length === 3){
        return new Color(...things.map(a => (Number(a) & 0xff)))
      }
    }
  }
}
function createCanvas(x,y){
  
  let canvas = document.createElement("canvas");
  canvas.width = x;
  canvas.height = y;
  let ctx = canvas.getContext("2d");
  return ctx;
}
// Create a 2x2 canvas to draw downsampled favicon image to
// Then get the color values from the bottom-right pixel
function getColorForImage(image){
  let canvas = createCanvas(2,2);
  canvas.drawImage(image,0,0,2,2);
  let pixels = canvas.getImageData(1,1,1,1).data;
  // if difference of every r,g,b value and the inverted ones is less than 40 then draw the progress as red 
  return new Color(pixels[0],pixels[1],pixels[2])
}
function getColorFromAttrs(){
  let attrs = ["theme-color","msapplication-TileColor"];
  for(let name of attrs){
    let og = document.querySelector(`meta[name="${name}"]`)?.getAttribute("content");
    if(og){
      return Color.from(og)
    }
  }
  return null
}
async function computePrefix(){
  let theme_color = getColorFromAttrs();
  if(theme_color){
    return theme_color.toString();
  }
  let icon_color = await createFaviconCanvas();
  
  return icon_color?.toString() || "   ";
}

async function addTitle(){
  let prefix = await computePrefix();
  window.document.title = prefix + document.title;
  
  const titleDescriptor = Object.getOwnPropertyDescriptor(document.__proto__.__proto__,"title");
  let origSet = titleDescriptor.set;
  let origGet = titleDescriptor.get;
  Object.defineProperty(window.wrappedJSObject.document,"title",{
    set: exportFunction((some) => {
      Reflect.apply(origSet,window.document,[prefix + some]);
    },window.document),
    get: exportFunction(() => {
      let real = Reflect.apply(origGet,window.document,[]);
      return real.replace(/^[\s\u{feff}\u{2062}-\u{2064}]+/u,"")
    },window.document)
  });

}

addTitle();
