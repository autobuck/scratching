Sprite cat;

void setup() {
  cat = new Sprite(this);
  size(600,600);
  cat.size=50;
  cat.goToXY(300,300);
}

void draw() {
   background(0);
   PVector temp = new PVector(mouseX,mouseY);
   int dist=(int)(temp.dist(cat.vectorPosition))/25;
   println(dist);
   if (cat.xPosition<mouseX) { cat.direction=90; cat.move(dist); }
   if (cat.xPosition>mouseX) { cat.direction=-90; cat.move(dist); }
   cat.yPosition=300;
   //cat.pointTowardsXY(mouseX,mouseY);
   cat.nextCostume();
   cat.update();
   delay(100);
}

void mouseClicked() { cat.nextCostume(); }
