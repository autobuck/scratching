Sprite cat;
Sprite alsoCat;
int myY;

void setup() {
  cat = new Sprite(this);
  alsoCat = new Sprite(this);
  size(600,600);
  cat.size=50;
  cat.goToXY(50,300);
  alsoCat.size=25;
  alsoCat.goToXY(300,300);
  myY=0;
}

void draw() {
   background(0);
   PVector temp = new PVector(mouseX,mouseY);
   if (cat.xPosition<mouseX) { cat.direction=90; cat.move(10); }
   if (cat.xPosition>mouseX) { cat.direction=-90; cat.move(10); }
   if (cat.yPosition<mouseY) { cat.goToXY(cat.xPosition,cat.yPosition+10); }
   if (cat.yPosition>mouseY) { cat.goToXY(cat.xPosition,cat.yPosition-10); }
   cat.nextCostume();
   cat.update();
   alsoCat.nextCostume();
   alsoCat.update();
   if (alsoCat.touchingSprite(cat)) alsoCat.hide(); else alsoCat.show();
   delay(100);
}

void mouseClicked() { if (cat.visible) cat.visible=false; else cat.visible=true; }
