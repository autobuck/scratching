Sprite cat;
Sprite alsoCat;
int numberOfSprites=0;

static int rotationStyle_AllAround=0;
static int rotationStyle_LeftRight=1;
static int rotationStyle_DontRotate=2;

void setup() {
  size(600, 600);
  cat = new Sprite(this);
  numberOfSprites++;
  cat.size = 50;
  cat.pos.set(0, 0);
  alsoCat = new Sprite(this);
  numberOfSprites++;
   cat.size=50;
   cat.goToXY(0,0);
   alsoCat.size=25;
   alsoCat.pos.set(200,200);
   alsoCat.direction=00;
}
  
void wrapAtEdges() {
  if (cat.pos.x>330) cat.pos.x=-330;
  if (cat.pos.y>330) cat.pos.y=-330;
  if (cat.pos.x<-330) cat.pos.x=330;
  if (cat.pos.y<-330) cat.pos.y=330;
}  

void draw() {
  background(0);

  //cat.pointTowards(alsoCat);
  cat.update();
  if (cat.distanceToXY(mouseX,mouseY) > 11) {
    cat.pointTowardsMouse();
    cat.move(10);
    cat.nextCostume();
  }
  println(cat.distanceToXY(mouseX-300,mouseY-300));
  wrapAtEdges();
   
  alsoCat.nextCostume();
  if (alsoCat.touchingSprite(cat)) { alsoCat.hide(); cat.goToXY(0,0); } 
  else alsoCat.show();
  alsoCat.update();
   
  delay(100);
}

void mouseClicked() {    
  if (cat.rotationStyle==rotationStyle_AllAround) cat.rotationStyle=rotationStyle_LeftRight;
  else if (cat.rotationStyle==rotationStyle_LeftRight) cat.rotationStyle=rotationStyle_DontRotate;
  else if (cat.rotationStyle==rotationStyle_DontRotate) cat.rotationStyle=rotationStyle_AllAround;
  cat.ghostEffect=cat.ghostEffect-50; if (cat.ghostEffect<0) cat.ghostEffect = 255;
}

