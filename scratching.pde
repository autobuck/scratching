Sprite cat;

void setup() {
  cat = new Sprite(this);
  size(400,400);
}

void draw() {
   background(0);
   if (cat.xPosition<mouseX) { cat.pointInDirection(90); cat.move(10);    cat.nextCostume();}
   if (cat.xPosition>mouseX) { cat.pointInDirection(-90); cat.move(10);    cat.nextCostume();}
   cat.yPosition=250;

   cat.update();
   delay(100);
}

void mouseClicked() { cat.nextCostume(); }
