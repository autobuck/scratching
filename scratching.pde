Sprite cat;
PShape[] test;

void setup() {
  cat = new Sprite(this);
  size(400,400);
}

void draw() {
   background(0);
   cat.test();
}

void mouseClicked() { cat.nextCostume(); }
