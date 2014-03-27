Sprite cat;
int myY;

void setup() {
  cat = new Sprite(this);
  size(600,600);
  cat.size=50;
  cat.goToXY(300,300);
  myY=0;
}

void draw() {
   background(0);
   PVector temp = new PVector(mouseX,mouseY);
   if (cat.xPosition<mouseX) { cat.direction=90; cat.move(10); }
   if (cat.xPosition>mouseX) { cat.direction=-90; cat.move(10); }
   //cat.pointTowardsXY(mouseX,mouseY);
   cat.nextCostume();
   cat.update();
   delay(100);
}

void mouseClicked() { if (cat.visible) cat.visible=false; else cat.visible=true; }
