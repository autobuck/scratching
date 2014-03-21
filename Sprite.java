import processing.core.PApplet;
import processing.core.PShape;
import processing.core.PImage;

public class Sprite {
  PApplet processing;
  public int xPosition,yPosition,direction,rotationStyle;
  public int costumeNumber,size; public boolean visible;
  public int volume,tempo;
  public int penColor,penSize; public boolean penUp;
  // add images as costumes;
  PShape[] costumes;

  // "momekeeps track of long-term movements such as glideTo
  private int momentum;
  
  // without this, built-in functions are broken. use processing.whatever to access functionality
  Sprite (PApplet parent) {
    processing = parent;
    costumes = new PShape[2];
    costumes[0] = processing.loadShape("images/cat.costume1.svg");
    costumes[1] = processing.loadShape("images/cat.costume2.svg");
    costumeNumber=0;
  }
  
  public void test() {   
    processing.shape(costumes[costumeNumber],processing.mouseX,processing.mouseY);
  }
  
  // "update" routine will draw sprite in new position, continue acting if set in motion by Move, etc
  public void update() { move(momentum); }
  
  // "getter" and "setter" functions for private vars
  // objective-c habit. probably easier to keep the variables public.
/*  public int xPosition() { return xPosition; }
  public int yPosition() { return yPosition; }
  public int direction() { return direction; }
  public int costumeNumber() { return costumeNumber; }
  public int size() { return size; }
  */
  
  // "looks" blocks
  public void addCostume() {}
  public void nextCostume() { costumeNumber++; if (costumeNumber>costumes.length-1) costumeNumber=0;}
  public void previousCostume() {}
  public void switchToCostume(int number) {}
  public void show() {}
  public void hide() {}
  public void say(String what) { processing.print("\""); processing.print(what); processing.println("\""); }
  public void think(String what) { processing.print(". o O ("); processing.print(what); processing.println(")");}
  //public void changeSize, setSize, say/think(ForSeconds)

  // "motion" blocks
  public void move(int distance) { }
  public void turnLeft(int degrees) {direction=direction-degrees; if (direction<0) direction=direction+360;}
  public void turnRight(int degrees) { direction=direction+degrees; if (direction>360) direction=direction-360;}
  public void pointTowardsXY(int x, int y) { }
  public void pointInDirection(int newDirection) { direction=newDirection; }
  public void pointTowardsSprite(Sprite target) { pointTowardsXY(target.xPosition,target.yPosition); }
  public void goToXY(int x, int y) { xPosition=x;yPosition=y; }
  public void goToSprite(Sprite target) { xPosition=target.xPosition; yPosition=target.yPosition; }
  public void glideToXY(int x, int y, int time) { pointTowardsXY(x,y); momentum=distanceToXY(x,y)/time;}
  
  // "sensing" blocks
  public boolean touchingSprite(Sprite target) { return false; }
  //public boolean touchingColor(processing.color target) { return false; }
  public int distanceToXY(int x,int y) { return 0; }
  public int distanceToSprite(Sprite target) { return distanceToXY(target.xPosition,target.yPosition); }
  

}
