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
ArrayList lines = new ArrayList<String>();
  int current = 0;

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
  cat.drawOnStage(stage);
  //cat.drawOwnPen();
  cat.penWidth(3);
  cat.ghostEffect = 50;
  cat.penColor((int)random(0,255),(int)random(0,255),(int)random(0,255));
  
  lines.add("It's BACON!!!");
  lines.add("This ought to be roughly two lines, with a bit more.");
  lines.add("Bacon ipsum dolor sit amet bresaola frankfurter prosciutto turkey, pork loin strip steak spare ribs bacon ball tip landjaeger capicola ribeye. Jerky pork belly turducken, landjaeger spare ribs meatball rump. Porchetta pork belly andouille ground round. Short ribs pancetta swine porchetta kielbasa pork chop ribeye frankfurter. Tail shankle biltong beef ribs ball tip chicken meatloaf turkey. Kevin rump frankfurter, boudin biltong kielbasa spare ribs tenderloin porchetta ground round tri-tip venison ham hock doner meatball.");
}
  
void draw() {
  stage.draw();
  cat.draw();    
  cat.move(2);
  cat.colorEffect += 1;
  if (arrowDown[upArrow]) cat.pos.y -= 10;
  if (arrowDown[downArrow]) cat.pos.y += 10;
  cat.wrapAtEdges();
  cat.think(""+lines.get(current));
  stage.scrollBackdrop(0,-2);
  println(stage.timer());
}

void nextLine() {
  current++;
  if (current > lines.size()-1) current = 0;
  println(current+" "+lines.size());
}

void keyPressed() {
 if (key == ' ') nextLine();
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
