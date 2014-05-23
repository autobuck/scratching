Sprite mario;
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
  mario = new Sprite(this);
  mario.size=70;
  mario.goToXY(0,0);
  
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
  
  mario.update(); // this makes sure a translate gets called before the title screen b/g is displayed
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
  //mario.update();
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
  pointMarioAtMouseAndMove();
  makeCarsDrive();
  
  car1.update();
  car2.update();
  car3.update();
  car4.update();
  car5.update();
  car6.update();
  mario.update(); // update mario last so mario appears on top
  drawTimer();
  
  delay(50);
}

void keyPressed() {  
  if ((key=='p')|(key=='P')) pauseOrUnpause();
  else if (gamestate=="playing")
    switch(key) {
      case(' '): makeMarioJump(); break;
      case('q'): case('Q'): gamestate="game over"; break;
    }
}

void makeMarioJump() {
  if (speed_Y==-99) {
    speed_Y = -10;
    standing_Y = (int)mario.pos.y;
    mario.setCostume(mario.costume_ducking);
  }
}

void pauseOrUnpause() {
  if (gamestate=="playing") gamestate="paused";
  else gamestate="playing";
  // prevent "slow motion" cheating by holding pause. or at least make it so slow that you wouldn't want to.
  delay(250);
}

void nextWalkingCostume() {
  mario.nextCostume();
  if (mario.costumeNumber>=mario.costume_lastWalking) mario.setCostume(mario.costume_firstWalking);
}

void pointMarioAtMouseAndMove() {
  // this checks if the mario is touching a car and ends the game but only if the mario is not jumping (speed=-99)
  if (speed_Y==-99&touchingACar()) { gamestate = "game over"; }
  // if jump speed is resting (-99) and the mouse is more than 15px from the mario, aim the mario and walk the cat  
  else if ((mario.distanceToXY(mouseX,mouseY) > 15)&(speed_Y == -99)) {
    mario.pointTowardsMouse();
    println(mario.direction);
    mario.move(10);
    if (mario.pos.y<-100) mario.pos.y=-100; 
    if (mario.pos.y>170) mario.pos.y=170;
    nextWalkingCostume();
  }
  // if mario is jumping (speed is not resting speed of -99) do a jump
  else if (speed_Y != -99) {
    mario.pos.y = (mario.pos.y + speed_Y);
    if (mario.pos.y >= standing_Y) mario.pos.y = standing_Y;
    speed_Y++;
    if (speed_Y > 10) speed_Y = -99;
    mario.setCostume(mario.costume_jumping);
  }
  // mario is doing nothing, so make him stand still. you might put an "idle animation" here such as when Sonic the Hedgehog taps his feet
  else mario.setCostume(mario.costume_standing);
  wrapAtEdges(mario);
}

boolean touchingACar() {
  return (mario.touchingTraffic(car1)|
  mario.touchingTraffic(car2)|
  mario.touchingTraffic(car3)|
  mario.touchingTraffic(car4)|
  mario.touchingTraffic(car5)|
  mario.touchingTraffic(car6));
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
