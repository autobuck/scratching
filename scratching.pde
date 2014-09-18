// these values are "static," which means they do not change.
static int rotationStyle_360degrees=0;
static int rotationStyle_leftRight=1;
static int rotationStyle_dontRotate=2;
static int upArrow=0;
static int downArrow=1;
static int leftArrow=2;
static int rightArrow=3;
// These arrays contain boolean values for each key and arrow key
boolean[] keyIsDown = new boolean[256];
boolean[] arrowIsDown = new boolean[4];

// User variables and objects are "declared", or listed, here.
// Our sample includes one Stage object, called stage, and one Sprite object, called cat.
Stage stage;
Sprite cat;

// Setup runs once, and sets some default values
void setup() {
  // first, create a Processing window 500 px by 500 px
  size(500, 500);
  
  // next, initialize a Stage object with the X-Y grid backdrop
  stage = new Stage(this);
  stage.addDefaultBackdrop();
  
  // now add a "cat" Sprite object & attach it to our stage. Go to the center of the screen.
  cat = new Sprite(this,stage);
  cat.addDefaultCostumes();
  cat.goToXY(width/2,height/2);
}
  
void draw() {
  // check arrow keys and move the cat up and down
  if (arrowIsDown[upArrow]) cat.changeY(-10);
  if (arrowIsDown[downArrow]) cat.changeY(10);
  cat.wrapAtEdges(); // if the cat is off one edge, reappear at the opposite end
  
  // check letter keys & adjust visual effects
  if (keyIsDown['a']) cat.colorEffect ++;
  if (keyIsDown['w']) cat.ghostEffect ++;

  // finally, draw the stage and then draw the cat 
  stage.draw();
  cat.draw();    
 
}

// the code below is essential for certain Scratching functions. Do not change keyPressed
// or keyReleased - unless you're absolute sure you know what you're doing!
void keyPressed() { 
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

// the code below is essential for certain Scratching functions. Do not change keyPressed
// or keyReleased - unless you're absolute sure you know what you're doing!
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
