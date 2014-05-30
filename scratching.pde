Sprite cat;
Sprite alsoCat;
Stage stage;

static int rotationStyle_AllAround=0;
static int rotationStyle_LeftRight=1;
static int rotationStyle_DontRotate=2;

void setup() {
  // never change these first X lines
  size(480, 360);
  stage = new Stage(this);

  // add your own initialization code here
  cat = new Sprite(this);
  alsoCat = new Sprite(this);
  cat.size=50;
  cat.goToXY(0,0);
  alsoCat.size=25;
  alsoCat.goToXY(150,150);
  stage.switchToBackdrop(0);
}
  
void draw() {
  // these functions move the Sprites
  moveTheCat();
  moveAlsoCat();
  wrapAtEdges(cat);
  wrapAtEdges(alsoCat);
  
  stage.update();
  cat.update();
  alsoCat.update();

  delay(100);
}

// this function moves the cat towards the mouse
void moveTheCat() {
  // this "if" makes sure the cat doesn't move if it's already standing on the mouse cursor
  if (cat.distanceToXY(mouseX,mouseY) > 11) {
    cat.pointTowardsMouse();
    cat.nextCostume();
    cat.move(10);
  }
}

// this moves the alsoCat Sprite a little bit randomly
void moveAlsoCat() {
  if (random(0,100)>90) alsoCat.direction=pickRandomDirection();
  alsoCat.nextCostume();
  alsoCat.move(10);
  if (alsoCat.touchingSprite(cat)) { alsoCat.hide(); cat.goToXY(0,0); alsoCat.goToXY(150,150); } 
  else alsoCat.show();
}

// this is a useful function which you may want again, so try adding this as a "built-in feature" of your Sprite class.
void wrapAtEdges(Sprite whomever) {
  if (whomever.pos.x>230) whomever.pos.x=-230;
  if (whomever.pos.x<-230) whomever.pos.x=230;
  if (whomever.pos.y>170) whomever.pos.y=-170;
  if (whomever.pos.y<-170) whomever.pos.y=170;
}  

// return a random cardinal direction
int pickRandomDirection() {
  int newDirection = (int)random(0,4);
  switch (newDirection) {
    case 0: return 90;
    case 1: return 270;
    case 2: return 180;
    case 3: return 0;
  }
  // -99 is our "error code"; this should always return a useful direction
  return -99;
}
