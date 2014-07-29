Stage stage;
Sprite cat;

static int rotationStyle_AllAround=0;
static int rotationStyle_LeftRight=1;
static int rotationStyle_DontRotate=2;


void setup() {
  // never change these first X lineswhy you so testy
  
  size(480, 360);
  stage = new Stage(this);
  cat = new Sprite(this);
  stage.loadDefaultBackdrop();
  cat.loadDefaultCostumes();
  cat.setCostume(0);
  stage.setBackdrop(0);
  stage.update();
  // add your own initialization code here
}
  
void draw() {
  cat.goToXY(0,0);
  stage.update();
  cat.update();
}

void keyPressed() {
}
