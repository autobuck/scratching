Sprite cat;
Sprite alsoCat;
Stage stage;
int numberOfSprites=0;

static int rotationStyle_AllAround=0;
static int rotationStyle_LeftRight=1;
static int rotationStyle_DontRotate=2;

void setup() {
  size(480, 360);
  stage = new Stage(this);
  cat = new Sprite(this);
  alsoCat = new Sprite(this);
  numberOfSprites++;
  cat.size = 50;
  cat.pos.set(0, 0);
  numberOfSprites++;
   cat.size=50;
   cat.goToXY(0,0);
   alsoCat.size=25;
   alsoCat.pos.set(150,150);
   alsoCat.direction=00;
}
  
void wrapAtEdges() {
  if (cat.pos.x>230) cat.pos.x=-230;
  if (cat.pos.x<-230) cat.pos.x=230;
  if (cat.pos.y>170) cat.pos.y=-170;
  if (cat.pos.y<-170) cat.pos.y=170;
}  


void draw() {
  stage.switchToBackdrop(0);

  //cat.pointTowards(alsoCat);
  if (cat.distanceToXY(mouseX,mouseY) > 11) {
    cat.pointTowardsMouse();
    cat.move(10);
    cat.nextCostume();
  }
  cat.update();
  wrapAtEdges();
   
  alsoCat.nextCostume();
  if (alsoCat.touchingSprite(cat)) { alsoCat.hide(); cat.goToXY(0,0); } 
  else alsoCat.show();
  alsoCat.update();
   
  delay(100);
}

void mouseClicked() {    
  stage.ask("What is your quest?");
/*
  if (cat.rotationStyle==rotationStyle_AllAround) cat.rotationStyle=rotationStyle_LeftRight;
  else if (cat.rotationStyle==rotationStyle_LeftRight) cat.rotationStyle=rotationStyle_DontRotate;
  else if (cat.rotationStyle==rotationStyle_DontRotate) cat.rotationStyle=rotationStyle_AllAround;
  cat.ghostEffect=cat.ghostEffect-50; if (cat.ghostEffect<0) cat.ghostEffect = 255;
  */
}

