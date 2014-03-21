Sprite cat;
PShape[] test;

void setup() {
  cat = new Sprite(this);
  size(400,400);
}

void draw() {
   background(0);
   cat.test();
   cat.say("what!");
   shape(test[0],mouseX,mouseY);
}
