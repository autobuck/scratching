Stage stage;
Sprite cat;

static int rotationStyle_AllAround=0;
static int rotationStyle_LeftRight=1;
static int rotationStyle_DontRotate=2;
boolean[] keyIsDown = new boolean[256];
boolean[] arrowDown = new boolean[4];
static int upArrow=0;
static int downArrow=1;
static int leftArrow=2;
static int rightArrow=3;

void setup() {
  // never change these first 2 lines
  size(480, 360);
  stage = new Stage(this);
  
  stage.loadDefaultBackdrop();
  stage.setBackdrop(0);
  //stage.update();
  
  cat = new Sprite(this);
  cat.loadDefaultCostumes();
  cat.setCostume(0);
  cat.goToXY(0,0);
}
  
void draw() {
  stage.update();
  cat.update();
  cat.move(2);
  cat.ghostEffect = 0;
}

void keyPressed() {
 if (key<256) {
   keyIsDown[key] = true; 
 }
 if (key==CODED) {
   //cat.nextCostume();
   switch (keyCode) {
     case UP: arrowDown[upArrow]=true; break;
     case DOWN: arrowDown[downArrow]=true; break;
     case LEFT: arrowDown[leftArrow]=true;  break;
     case RIGHT: arrowDown[rightArrow]=true; break;
   }
 }
}

void keyReleased() {
 if (key<256) {
   keyIsDown[key] = false;  
 }
  if (key==CODED) {
   switch (keyCode) {
     case UP: arrowDown[upArrow]=false; break;
     case DOWN: arrowDown[downArrow]=false;break;
     case LEFT: arrowDown[leftArrow]=false;  break;
     case RIGHT: arrowDown[rightArrow]=false; break;
   }
 }
}
