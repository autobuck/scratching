Stage stage;
Sprite cat;

static int rotationStyle_360degrees=0;
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
  stage.setTrails(0);
  stage.setTrailRate(10);
  
  cat = new Sprite(this,stage);
  cat.addDefaultCostumes();
  cat.goToXY(0,height/2);
  cat.drawOwnCanvas();
  cat.penDown = true;
  cat.penWidth(3);
  cat.penColor((int)random(0,255),(int)random(0,255),(int)random(0,255));
  cat.rotationStyle = rotationStyle_leftRight;
}
  
void draw() {
  if (keyIsDown['8']) cat.pointInDirection(90);
  if (keyIsDown['2']) cat.pointInDirection(270);
  if (keyIsDown['4']) cat.pointInDirection(180);
  if (keyIsDown['6']) cat.pointInDirection(0);

  cat.move(2);
  cat.wrapAtEdges();
  cat.draw();    
  stage.draw();
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
