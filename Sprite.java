import processing.core.PApplet;

public class Sprite {
  PApplet processing;
  public int xPosition,yPosition,direction,rotationStyle;
  // "momentum" keeps track of long-term moments such as glideTo
  private int momentum;
  public int costumeNumber,size; public boolean visible;
  public int volume,tempo;
  public int penColor,penSize; public boolean penUp;
 
 // add images as costumes;
  
  // without this, built-in functions are broken. use processing.whatever to access functionality
  Sprite (PApplet parent) {
    processing = parent;
  }
  
  // "update" routine will draw sprite in new position, continue acting if set in motion by Move, etc
  public void update() { move(momentum); }
  
  // "looks" blocks
  public void addCostume() {}
  public void nextCostume() {}
  public void previousCostume() {}
  public void switchToCostume(int number) {}
  public void show() {}
  public void hide() {}
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
  
  public boolean touchingSprite(Sprite target) { return false; }
  // public boolean touchingColor(color target) { return 0; }
  public int distanceToXY(int x,int y) { return 0; }
  public int distanceToSprite(Sprite target) { return distanceToXY(target.xPosition,target.yPosition); }
  

}
