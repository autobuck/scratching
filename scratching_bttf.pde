Sprite cat;
traffic car1;
traffic car2;
traffic car3;
Stage stage;

static int rotationStyle_AllAround=0;
static int rotationStyle_LeftRight=1;
static int rotationStyle_DontRotate=2;
String gamestate = "title";

void setup() {
  // never change these first X lines
  size(480, 360);
  stage = new Stage(this);

  // add your own initialization code here
  cat = new Sprite(this);
  car1 = new traffic(this);
  car2 = new traffic(this);
  car3 = new traffic(this);
  cat.size=25;
  cat.goToXY(0,0);
  car1.startOnLeft();
  car1.size=110;
  car2.startOnLeft();
  car2.size=110;
  car3.startOnLeft();
  car3.size=110;
  cat.update();
}
  
void wrapAtEdges(Sprite whoever) {
  if (whoever.pos.x>230) whoever.pos.x=-230;
  if (whoever.pos.x<-230) whoever.pos.x=230;
  //if (whoever.pos.y>170) whoever.pos.y=-170;
  //if (whoever.pos.y<-170) whoever.pos.y=170;
}  

void draw() {
  if (gamestate=="title") showTitleScreen();
  else if (gamestate=="playing") gameloop();
  else if (gamestate=="game over") showGameOverScreen();  
}

void mouseClicked() {
    //answer = ask("What is your quest?");
    if (gamestate=="title") gamestate = "playing";
    if (gamestate=="game over") { setup(); gamestate = "title"; }

}

void showTitleScreen() {
  //cat.update();
  stage.switchToBackdrop(1);
}

void showGameOverScreen() {
  stage.switchToBackdrop(3);
}

void gameloop() {
  stage.switchToBackdrop(2);

  //cat.pointTowards(alsoCat);
  if (cat.distanceToXY(mouseX,mouseY) > 11) {
    cat.pointTowardsMouse();
    cat.move(10);
    if (cat.pos.y<-100) cat.pos.y=-100;
    if (cat.pos.y>170) cat.pos.y=170;
    cat.nextCostume();
  }
  cat.update();
  //println(cat.direction);
  //println(cat.pos.y);
  if (cat.touchingTraffic(car1)|cat.touchingTraffic(car2)|cat.touchingTraffic(car3)) { gamestate = "game over"; }
  
  car1.drive();
  car2.drive();
  car3.drive();
  if ((car1.pos.x<-300)|(car1.pos.x>300)) {
    int foo = (int)random(1,3);
    if (foo>1) car1.startOnLeft(); else car1.startOnRight(); 
  }
  if ((car2.pos.x<-300)|(car2.pos.x>300)) {
    int foo = (int)random(1,3);
    if (foo>1) car2.startOnLeft(); else car2.startOnRight(); 
  }
  if ((car3.pos.x<-300)|(car3.pos.x>300)) {
    int foo = (int)random(1,3);
    if (foo>1) car3.startOnLeft(); else car3.startOnRight(); 
  }
  car1.update();
  car2.update();
  car3.update();

  wrapAtEdges(cat);

  delay(50);
}
