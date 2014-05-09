Sprite cat;
traffic car;
Stage stage;

static int rotationStyle_AllAround=0;
static int rotationStyle_LeftRight=1;
static int rotationStyle_DontRotate=2;

void setup() {
  // never change these first X lines
  size(480, 360);
  stage = new Stage(this);

  // add your own initialization code here
  cat = new Sprite(this);
  car = new traffic(this);
  cat.size=25;
  cat.goToXY(0,0);
  car.startOnLeft();
  car.size=125;
}
  
void wrapAtEdges(Sprite whoever) {
  if (whoever.pos.x>230) whoever.pos.x=-230;
  if (whoever.pos.x<-230) whoever.pos.x=230;
  if (whoever.pos.y>170) whoever.pos.y=-170;
  if (whoever.pos.y<-170) whoever.pos.y=170;
}  

void draw() {
  stage.switchToBackdrop(0);
  stage.update();

  //cat.pointTowards(alsoCat);
  if (cat.distanceToXY(mouseX,mouseY) > 11) {
    cat.pointTowardsMouse();
    cat.move(10);
    cat.nextCostume();
  }
  cat.update();
  if (cat.touchingTraffic(car)) { cat.goToXY(0,0); }
  
  car.drive();
  if ((car.pos.x<-300)|(car.pos.x>300)) {
    int foo = (int)random(1,2);
   println(foo); 
    if (foo>1) car.startOnLeft(); else car.startOnRight(); 
  }
  car.update();

  wrapAtEdges(cat);

  delay(100);
  
}


void mouseClicked() {
    //answer = ask("What is your quest?");
}
