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
int startTimeInSeconds;
int gameTimeInSeconds;
PFont font;

void setup() {
  // never change these first X lines
  size(480, 360);
  stage = new Stage(this);
  font = createFont("Arial Bold",16,true);
  
  // add backdrops to the stage
  stage.addBackdrop("images/bg_title2.png");
  stage.addBackdrop("images/bg_highway.png");
  stage.addBackdrop("images/bg_gameover.png");
    
  // add your own initialization code here
  cat = new Sprite(this);
  cat.size=20;
  cat.goToXY(0,0);
  
  car1 = new traffic(this);
  car2 = new traffic(this);
  car3 = new traffic(this);
  car4 = new traffic(this);
  car5 = new traffic(this);
  car6 = new traffic(this);
  
  car1.ignition();
  car1.size=115;
  car2.ignition();
  car2.size=115;
  car3.ignition();
  car3.size=115;
  car4.ignition();
  car4.size=115;
  car5.ignition();
  car5.size=115;
  car6.ignition();
  car6.size=115;
  
  cat.update(); // this makes sure a translate gets called before the title screen b/g is displayed
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
  // we don't need to process (gamestate==paused) because we'd just tell it to "do nothing" anyway
  // although we might add a sprite or backdrop that says "game paused press p to resume"
}

void startTheGame() {
   startTimeInSeconds = millis()/1000;
   gamestate = "playing";
}

int gameTime() {
  int temp = millis()/1000;
  return temp-startTimeInSeconds;
} 

void mouseClicked() {
    if (gamestate=="title") startTheGame();
    if (gamestate=="game over") { setup(); gamestate = "title"; }

}

void showTitleScreen() {
  //cat.update();
  stage.switchToBackdrop(stage.bg_title);
}

void showGameOverScreen() {
  stage.switchToBackdrop(stage.bg_gameover);
}

void drawTimer() {
  //textFont(font,18);
  textAlign(CENTER);
  text("Time: "+gameTime(),width/2,10);
}

// this is the main game logic. we have this here instead of "draw" so that we can accomodate other "game modes"
// such as "title screen" and "game over screen" where the behavior of mouse, keyboard, and sprites may be different
void gameloop() {
  stage.switchToBackdrop(stage.bg_highway);
  pointCatAtMouseAndMove();
  makeCarsDrive();
  
  car1.update();
  car2.update();
  car3.update();
  car4.update();
  car5.update();
  car6.update();
  cat.update(); // update cat last so cat appears on top
  drawTimer();
  
  delay(50);
}

void keyPressed() {  
  if ((key=='p')|(key=='P')) pauseOrUnpause();
  else if (gamestate=="playing")
    switch(key) {
      case(' '): makeCatJump(); break;
      case('q'): case('Q'): gamestate="game over"; break;
    }
}

void makeCatJump() {
  if (speed_Y==-99) {
    speed_Y = -10;
    standing_Y = (int)cat.pos.y;
  }
}

void pauseOrUnpause() {
  if (gamestate=="playing") gamestate="paused";
  else gamestate="playing";
  // prevent "slow motion" cheating by holding pause. or at least make it so slow that you wouldn't want to.
  delay(250);
}

void pointCatAtMouseAndMove() {
  // if jump speed is resting (-99) and the mouse is more than 15px from the cat, aim the cat and walk the cat
  if ((cat.distanceToXY(mouseX,mouseY) > 15)&(speed_Y == -99)) {
    cat.pointTowardsMouse();
    println(cat.direction);
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
  if (speed_Y==-99&touchingACar()) { gamestate = "game over"; }
  wrapAtEdges(cat);
}

boolean touchingACar() {
  return (cat.touchingTraffic(car1)|
  cat.touchingTraffic(car2)|
  cat.touchingTraffic(car3)|
  cat.touchingTraffic(car4)|
  cat.touchingTraffic(car5)|
  cat.touchingTraffic(car6));
}

void makeCarsDrive() {
  car1.drive();
  car2.drive();
  car3.drive();
  car4.drive();
  car5.drive();
  car6.drive();
 
  checkCarBoundaries(car1);
  checkCarBoundaries(car2);
  checkCarBoundaries(car3);
  checkCarBoundaries(car4);
  checkCarBoundaries(car5);
  checkCarBoundaries(car6);
}

void checkCarBoundaries(traffic car) {
  if ((car.pos.x<-300)|(car.pos.x>300)) {
    car.ignition();
  }
}
