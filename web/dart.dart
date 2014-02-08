import 'dart:html';
import 'dart:math';

CanvasElement canvasElement;
var ctx;
bool gameFirstStarted = true;
bool heroLoaded = false;

int oldMonsterX, oldMonsterY;
int heroX = 550, heroY = 200;
int pappuX , pappuY ;

ImageElement backgroundImage;
ImageElement heroImage;
ImageElement pappuImage;

int score = 0;

bool left = false, up= false, right = false, down = false;

void main() {
  canvasElement = querySelector('#canvas');
  ctx = canvasElement.getContext("2d");
  
  
  pappuX = new Random().nextInt(1300 - 147);
  pappuY = new Random().nextInt(600 - 247);
  backgroundImage = new ImageElement(src : "images/background.png");
  backgroundImage.onLoad.listen((_) {
    // Draw once the image is loaded
    heroImage = new ImageElement(src: "images/hero.png");
    heroImage.onLoad.listen((_) {
      heroLoaded = true;
      ctx.drawImage(backgroundImage, 0, 0);
      ctx.drawImage(heroImage, heroX, heroY);
      print(pappuX);
      
    });
    
    pappuImage = new ImageElement(src : 'images/pappu.png');
    pappuImage.onLoad.listen((_) {
      ctx.drawImage(pappuImage, pappuX, pappuY);
    });
  });
  
  
  
  /*
  if(gameFirstStarted) {
    //if(heroLoaded) {
      //ctx.drawImage(heroImage, 0, 0);
      mHero.setX = 230;
      mHero.setY = 450;
    //}
  } else {
    mHero.setX = new Random().nextInt(1) * ((canvasElement.style.width as int) - 137);
    mHero.setY = new Random().nextInt(1) * ((canvasElement.style.height as int) - 247);
  }
  */
// Adds event handler for key press
  document.body.onKeyDown.listen((e) {
    
    onKeyDown(e);
  });
  document.body.onKeyUp.listen((e) {
    
    onKeyUp(e);
  });
  
  window.requestAnimationFrame(render);
  
}

bool render(double time) {
  
  isColloided();
  if(left == true) {
    ctx.drawImage(backgroundImage, 0, 0);
    ctx.drawImage(pappuImage, pappuX, pappuY);
    heroX -= 8;
    ctx.drawImage(heroImage, heroX, heroY);
  } else if(up == true) {
    ctx.drawImage(backgroundImage, 0, 0);
    ctx.drawImage(pappuImage, pappuX, pappuY);
    heroY -= 8;
    ctx.drawImage(heroImage, heroX, heroY);
  } else if(right == true) {
    ctx.drawImage(backgroundImage, 0, 0);
    ctx.drawImage(pappuImage, pappuX, pappuY);
    heroX += 8;
    ctx.drawImage(heroImage, heroX, heroY);
  } else if(down == true) {
    ctx.drawImage(backgroundImage, 0, 0);
    ctx.drawImage(pappuImage, pappuX, pappuY);
    heroY += 8;
    ctx.drawImage(heroImage, heroX, heroY);
  }
  window.requestAnimationFrame(render);
}

bool isColloided() {
  if((pappuX-heroX)<=105&&(heroX-pappuX)<=97&&(pappuY-heroY)<=247&&(heroY-pappuY)<=203) {
    score++;
    reset();
  }
}

void reset() {
  querySelector('#score').innerHtml= 'Pappu caught ' + score.toString() + ' times';
  ctx.drawImage(backgroundImage, 0, 0);
  pappuX = new Random().nextInt(1300 - 147);
  pappuY = new Random().nextInt(600 - 247);
  ctx.drawImage(pappuImage, pappuX, pappuY);
  ctx.drawImage(heroImage, heroX, heroY);
}
void onKeyDown(e){
  
  switch(e.keyCode){
    
    case 37 :
      left = true;
    break;
    case 38:
      up = true;
    break;
    case 39:
      right = true;
    break;
    case 40:
      down = true;
    break;
  }
}

void onKeyUp(e){
  
  switch(e.keyCode){
    
    case 37 :
      left = false;
    break;
    case 38:
      up = false;
    break;
    case 39:
      right = false;
    break;
    case 40:
      down = false;
    break;
  }  
}