Sprite cat;
traffic car1;
traffic car2;
traffic car3;
traffic car4;
traffic car5;
traffic car6;
Stage stage;

static int rotationStyle_AllAround=0;
static int rotationStyle_LeftRight=1;
static int rotationStyle_DontRotate=2;
int speed_Y = -99; 
int standing_Y;
String gamestate = "title";

void setup() {
  // never change these first 2 lines
  size(480, 360);
  stage = new Stage(this);
  
  // add backdrops to the stage
  stage.addBackdrop("images/bg_title2.png");
  stage.addBackdrop("images/bg_highway.png");
  stage.addBackdrop("images/bg_gameover.png");
    
  // add your own initialization code here
  cat = new Sprite(this);
  cat.size=25;
  cat.goToXY(0,0);
  
  car1 = new traffic(this);
  car2 = new traffic(this);
  car3 = new traffic(this);
  car1 = new traffic(this);
  car2 = new traffic(this);
  car3 = new traffic(this);
  
  car1.startOnLeft();
  car1.size=110;
  car2.startOnLeft();
  car2.size=110;
  car3.startOnLeft();
  car3.size=110;
  car4.startOnLeft();
  car4.size=110;
  car5.startOnLeft();
  car5.size=110;
  car6.startOnLeft();
  car6.size=110;
  
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
    if (gamestate=="title") gamestate = "playing";
    if (gamestate=="game over") { setup(); gamestate = "title"; }

}

void showTitleScreen() {
  //cat.update();
  stage.switchToBackdrop(stage.bg_title);
}

void showGameOverScreen() {
  stage.switchToBackdrop(stage.bg_gameover);
}

void keyPressed() {  
  switch(key) {
    case('q'):case('Q'): makeCatJump(); break;
  }
}

void makeCatJump() {
  if (speed_Y==-99) {
    speed_Y = -10;
    standing_Y = (int)cat.pos.y;
  }
}

void pointCatAtMouseAndMove() {
  // if jump speed is resting (-99) and the mouse is more than 15px from the cat, aim the cat and walk the cat
  if ((cat.distanceToXY(mouseX,mouseY) > 15)&(speed_Y == -99)) {
    cat.pointTowardsMouse();
    cat.move(10);
    if (cat.pos.y<-100) cat.pos.y=-100; 
    if (cat.pos.y>170) cat.pos.y=170;
    cat.nextCostume();
  }
  // if cat is jumping (speed is not resting speed of -99) do a jump
  if (speed_Y != -99) {
    cat.pos.y = (cat.pos.y + speed_Y);
    if (cat.pos.y >= standing_Y) cat.pos.y = standing_Y;
    speed_Y++;
    if (speed_Y > 10) speed_Y = -99;
  }
  // this checks if the cat is touching a car and ends the game but only if the cat is not jumping (speed=-99)
  if (speed_Y==-99&(cat.touchingTraffic(car1)|cat.touchingTraffic(car2)|cat.touchingTraffic(car3))) { gamestate = "game over"; }
}

// this is the main game logic. we have this here instead of "draw" so that we can accomodate other "game modes"
// such as "title screen" and "game over screen" where the behavior of mouse, keyboard, and sprites may be different
void gameloop() {
  stage.switchToBackdrop(stage.bg_highway);
  pointCatAtMouseAndMove();
  
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

  wrapAtEdges(cat);
  car1.update();
  car2.update();
  car3.update();
  cat.update();
  delay(50);
}
