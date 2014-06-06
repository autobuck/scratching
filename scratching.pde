Stage stage;

static int rotationStyle_AllAround=0;
static int rotationStyle_LeftRight=1;
static int rotationStyle_DontRotate=2;

String someString = "";

void setup() {
  // never change these first X lineswhy you so testy
  
  size(480, 360);
  stage = new Stage(this);

  // add your own initialization code here
    stage.ask("What is your quest?");
}
  
void draw() {
  stage.update();
  someString = stage.answer();
  
  if (someString!="") { println(someString); someString=""; stage.ask("What is your favorite color?"); }
}

void keyPressed() {
  stage.questionKeycheck();
}
