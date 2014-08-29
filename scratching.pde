// This example asks a series of questions then draws a rectangle in response.

Stage stage;
PFont questionFont;

static int rotationStyle_AllAround=0;
static int rotationStyle_LeftRight=1;
static int rotationStyle_DontRotate=2;
String someString;

int x,boxWidth;
int y,boxHeight;
int roundness;
int question;

void setup() {
  // never change these first X lines
  size(500, 500);
  stage = new Stage(this);
  stage.addDefaultBackdrop();

  // add your own initialization code here
  question = 1;
  askNextQuestion();
}
  
void draw() {
  stage.draw();
  if (stage.answer()!="") processAnswer(stage.answer());
}

void keyPressed() {
  stage.questionKeycheck();
}

void askNextQuestion() {
  if (question==1) stage.ask("Where X?");
  else if (question==2) stage.ask("Where Y?");
  else if (question==3) stage.ask("How wide?");
  else if (question==4) stage.ask("How tall?"); 
  else if (question==5) stage.ask("How much rounding?"); 
}

void processAnswer(String theAnswerIs) {
  if (question==1) x=Integer.parseInt(theAnswerIs);
  else if (question==2) y=Integer.parseInt(theAnswerIs);
  else if (question==3) boxWidth=Integer.parseInt(theAnswerIs);
  else if (question==4) boxHeight=Integer.parseInt(theAnswerIs);
  else if (question==5) roundness=Integer.parseInt(theAnswerIs);
  else if (question>=6) { rect(x,y,boxWidth,boxHeight,roundness); }

  question++;
  askNextQuestion();
}
