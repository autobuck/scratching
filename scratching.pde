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
  stage.update();
  // add your own initialization code here
}
  
void draw() {
  cat.goToXY(-100,0);
  stage.update();
  cat.update();
}

void keyPressed() {
}
