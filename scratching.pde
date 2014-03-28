Sprite cat;
Sprite alsoCat;
int myY;

public PVector globOrigin = new PVector();


/* start()
 * This MUST be called at the beginning of setup(). It acts in place
 * of the builtin size() function so that the global origin can also
 * be set.
 */
public void start(int _width, int _height) {
  size(_width, _height);
  globOrigin.set(width/2, height/2);
}


void setup() {
  start(600,600);
  cat = new Sprite(this);
  alsoCat = new Sprite(this);
  cat.size=50;
  cat.goToXY(300,300);
  alsoCat.size=25;
  alsoCat.goToXY(500,500);
  myY=0;
}

void draw() {
   background(0);
   PVector temp = new PVector(mouseX,mouseY);
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
   delay(100);
}

void mouseClicked() { cat.pointTowards(alsoCat); }
