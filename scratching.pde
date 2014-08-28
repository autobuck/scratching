Stage stage;
Sprite cat;

static int rotationStyle_allAround=0;
static int rotationStyle_leftRight=1;
static int rotationStyle_dontRotate=2;
static int upArrow=0;
static int downArrow=1;
static int leftArrow=2;
static int rightArrow=3;
boolean[] keyIsDown = new boolean[256];
boolean[] arrowDown = new boolean[4];


void setup() {
  size(500, 500);
  stage = new Stage(this);
  
  stage.addDefaultBackdrop();
  stage.setBackdrop(0);
  
  cat = new Sprite(this);
  cat.addDefaultCostumes();
  cat.setCostume(0);
  cat.goToXY(0,height/2);
  cat.penDown = true;
  //cat.drawOnStage(stage);
  cat.drawOwnPen();
  cat.penWidth(3);
  cat.penColor(255,0,0);
}
  
void draw() {
  stage.draw();
  cat.draw();    
  cat.move(2);
  //if (frameCount % 50 == 0) cat.penClear();
  cat.wrapAtEdges();
}

void keyPressed() {
 if (key<256) {
   keyIsDown[key] = true; 
 }
 if (key==CODED) {
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
     case DOWN: arrowDown[downArrow]=false; break;
     case LEFT: arrowDown[leftArrow]=false;  break;
     case RIGHT: arrowDown[rightArrow]=false; break;
   }
 }
}
