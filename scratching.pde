Sprite cat;

void setup() {
  cat = new Sprite(this);
  size(400,400);
}

void draw() {
   background(0);
   if (cat.xPosition<mouseX) { cat.xPosition=cat.xPosition+10; cat.direction=90; }
   if (cat.xPosition>mouseX) { cat.xPosition=cat.xPosition-10; cat.direction=-90; }
   cat.yPosition=150;
   cat.size=50;
   cat.nextCostume();
   cat.update();
   delay(100);
}

void mouseClicked() { cat.nextCostume(); }
