Sprite cat;
Sprite alsoCat;

/* I really don't like this here */
public void begin(int _width, int _height) {
    size(_width, _height);
    //translate(100, 100);
    //Global.origin.set(width/2, height/2);
}
  
void setup() {
  begin(600,600);
  cat = new Sprite(this);
  cat.size = 50;
  cat.pos.set(0, 0);
  
  /*alsoCat = new Sprite(this);
  cat.size=50;
  cat.goToXY(300,300);
  alsoCat.size=25;
  alsoCat.goToXY(500,500);*/
}

void draw() {
   background(0);
   
   /*PVector temp = new PVector(mouseX,mouseY);
   //if (cat.xPosition<mouseX) {cat.move(10); }
   //if (cat.xPosition>mouseX) { cat.move(-10); }
   //if (cat.yPosition<mouseY) { cat.goToXY(cat.xPosition,cat.yPosition+10); }
   //if (cat.yPosition>mouseY) { cat.goToXY(cat.xPosition,cat.yPosition-10); }
   //cat.pointTowardsMouse();
   cat.pointTowards(alsoCat);
   cat.move(10);
   cat.nextCostume();
   cat.update();
   alsoCat.nextCostume();
   alsoCat.update();
   if (alsoCat.touchingSprite(cat)) { alsoCat.hide(); cat.goToXY(300,300); } 
   else alsoCat.show();
   delay(100);*/
   
   cat.nextCostume();
   cat.update();
   cat.move(20);
   delay(100);
}

//void mouseClicked() { cat.pointTowards(alsoCat); }
