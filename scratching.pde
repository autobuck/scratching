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
  size(1500, 1000);
  // next, initialize a Stage object with the X-Y grid backdrop
  stage = new Stage(this);
  stage.addDefaultBackdrop();
  // now add a "cat" Sprite object & attach it to our stage. Go to the center of the screen.
  cat = new Sprite(this, stage);
  cat.addDefaultCostumes();
  cat.goToXY(width/2, height/2);
  cat.penDown();
  cat.penColor(255, 0, 255);
  cat.direction = 90;
}

void draw() {
  cat.goToXY(mouseX, mouseY);

  // finally, draw the stage and then draw the cat 
  stage.draw();
  cat.draw();  
  frame.setTitle("FPS: "+frameRate);

  if (mousePressed) stage.addTrail();
  else stage.removeTrail();
}


// the code below is essential for Scratching keyboard functions. Do not change keyPressed
// or keyReleased unless you're absolute sure you know what you're doing!
void keyPressed() { 
  keyDownCheck();
}

void keyReleased() {
  keyUpCheck();
}

void keyUpCheck() {
  if (key<256) {
    keyIsDown[key] = false;
  }
  if (key==CODED) {
    switch (keyCode) {
    case UP: 
      arrowIsDown[upArrow]=false; 
      break;
    case DOWN: 
      arrowIsDown[downArrow]=false; 
      break;
    case LEFT: 
      arrowIsDown[leftArrow]=false;  
      break;
    case RIGHT: 
      arrowIsDown[rightArrow]=false; 
      break;
    }
  }
}

void keyDownCheck() {
  if (stage.askingQuestion) stage.questionKeycheck();
  if (key<256) {
    keyIsDown[key] = true;
  }
  if (key==CODED) {
    switch (keyCode) {
    case UP: 
      arrowIsDown[upArrow]=true; 
      break;
    case DOWN: 
      arrowIsDown[downArrow]=true; 
      break;
    case LEFT: 
      arrowIsDown[leftArrow]=true;  
      break;
    case RIGHT: 
      arrowIsDown[rightArrow]=true; 
      break;
    }
  }
}
