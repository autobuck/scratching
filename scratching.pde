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
  
  cat = new Sprite(this,stage);
  cat.addDefaultCostumes();
  cat.goToXY(width/2,height/2);
  cat.penDown = true;
  cat.penColor(0,0,0);
}
  
void draw() {
  stage.draw();
  cat.draw();    
 
  if (arrowDown[upArrow]) cat.changeXY(0,-10);
  if (arrowDown[downArrow]) cat.changeXY(0,10);
  
  if (keyIsDown['a']) cat.colorEffect ++;
  if (keyIsDown['w']) cat.ghostEffect ++;

  cat.wrapAtEdges();
}

void keyPressed() {
 // you can add new code. but removing the lines below may break something
 if (stage.askingQuestion) stage.questionKeycheck();
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
 // you can add new code. but removing the lines below may break something
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
