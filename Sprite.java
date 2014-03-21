//could add private "distance to target" or "momentum" var which is processed by "update" routine


import processing.core.PApplet;

public class Sprite {
  PApplet processing;
  public int xPosition,yPosition,direction,rotationStyle;
  public int costume,size; public boolean visible;
  public int volume,tempo;
  public int penColor,penSize; public boolean penUp;
  
  Sprite (PApplet parent) {
    processing = parent;
  }
  
  // "update" routine will draw sprite in new position, continue acting if set in motion by Move, etc
  public void update() { }

  public void move(int distance) { }
  public void turnLeft(int degrees) {direction=direction-degrees; if (direction<0) direction=direction+360;}
  public void turnRight(int degrees) { direction=direction+degrees; if (direction>360) direction=direction-360;}
  public void pointInDirection(int newDirection) { direction=newDirection; }
  public void pointTowardsSprite(Sprite target) {}
  public void pointTowardsXY(int x, int y) { }
  public void goTo(int x, int y) {}
  public void goToSprite(Sprite target) { xPosition=target.xPosition; yPosition=target.yPosition; }
  public void glideTo(int x, int y, int time) { pointTowardsXY(x,y); }
  
  public boolean touchingSprite(Sprite target) { return false; }
  // public boolean touchingColor(color target) { return 0; }
  public int distanceToSprite(Sprite target) { return 0; }
  

}
