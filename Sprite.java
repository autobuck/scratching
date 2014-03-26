import processing.core.PApplet;
//import processing.core.PShape;
import processing.core.PImage;
import processing.core.PVector;

public class Sprite {
  
  static final int rotationStyle_LeftRight=1;
  static final int rotationStyle_noRotation=2;
  
  PApplet processing;
  public int xPosition, yPosition, direction, rotationStyle;
  public int costumeNumber;
  public float size; 
  public boolean visible;
  public int volume, tempo;
  public int penColor, penSize; 
  public boolean penUp;
  
  private PVector vectorDirection;
  private PVector vectorPosition;
  
  // add images as costumes;
  PImage[] costumes;

  // "momentum" will keep track of long-term movements such as glideTo
  //private int momentum;

  // without this, built-in functions are broken. use processing.whatever to access functionality
  Sprite (PApplet parent) {
    processing = parent;
    costumes = new PImage[2];
    costumes[0] = processing.loadImage("images/cat.costume1.png");
    costumes[1] = processing.loadImage("images/cat.costume2.png");
    costumeNumber=0;
    size=100;
    rotationStyle=rotationStyle_LeftRight;
    vectorPosition = new PVector(xPosition,yPosition);
    vectorDirection = new PVector(0,0);
  }

  public void test() {   
    nextCostume();
  }

  // "update" routine will draw sprite in new position, continue acting if set in motion by Move, etc
  public void update() {    
    if (((direction<0) | (direction>180)) & (rotationStyle==rotationStyle_LeftRight)) processing.image(getReversePImage(costumes[costumeNumber]), xPosition, yPosition, costumes[costumeNumber].width*(size/100), costumes[costumeNumber].height*(size/100));
    else processing.image(costumes[costumeNumber], xPosition, yPosition, costumes[costumeNumber].width*(size/100), costumes[costumeNumber].height*(size/100));
    }

  // "getter" and "setter" functions for private vars
  // objective-c habit. probably easier to keep the variables public.
  /*  public int xPosition() { return xPosition; }
   public int yPosition() { return yPosition; }
   public int direction() { return direction; }
   public int costumeNumber() { return costumeNumber; }
   public int size() { return size; }
   */

  // "looks" blocks
  public void addCostume() {
  }
  public void nextCostume() { 
    costumeNumber++;
    if (costumeNumber>costumes.length-1) costumeNumber=0;
  }
  public void previousCostume() {
  }
  public void switchToCostume(int number) {
  }
  public void show() {
  }
  public void hide() {
  }
  public void say(String what) { 
    processing.print("\""); 
    processing.print(what); 
    processing.println("\"");
  }
  public void think(String what) { 
    processing.print(". o O ("); 
    processing.print(what); 
    processing.println(")");
  }
  //public void changeSize, setSize, say/think(ForSeconds)

  public PImage getReversePImage( PImage image ) {
     PImage reverse = new PImage( image.width, image.height );
     for( int i=0; i < image.width; i++ ){
       for(int j=0; j < image.height; j++){
         reverse.set( image.width - 1 - i, j, image.get(i, j) );
       }   
     }
     return reverse;
    }

  // "motion" blocks
  public void move(int distance) {
  }
  public void turnLeft(int degrees) {
    direction=direction-degrees; 
    if (direction<0) direction=direction+360;
  }
  public void turnRight(int degrees) { 
    direction=direction+degrees; 
    if (direction>360) direction=direction-360;
  }
  public void pointTowardsXY(int x, int y) {
    PVector target = new PVector(x,y);
    //direction=vectorDirection.heading(target);    
  }
  public void pointInDirection(int newDirection) { 
    direction=newDirection;
  }
  public void pointTowardsSprite(Sprite target) { 
    pointTowardsXY(target.xPosition, target.yPosition);
  }
  public void goToXY(int x, int y) { 
    xPosition=x;
    yPosition=y;
  }
  public void goToSprite(Sprite target) { 
    xPosition=target.xPosition; 
    yPosition=target.yPosition;
  }
  public void glideToXY(int x, int y, int time) { 
    pointTowardsXY(x, y); 
    //momentum=distanceToXY(x, y)/time;
  }

  // "sensing" blocks
  public boolean touchingSprite(Sprite target) { 
    return false;
  }
  //public boolean touchingColor(processing.color target) { return false; }
  public float distanceToXY(int x, int y) { 
    PVector temp = new PVector(x,y);
    return vectorPosition.dist(temp);
  }
  public float distanceToSprite(Sprite target) { 
    return distanceToXY(target.xPosition, target.yPosition);
  }

  //public void wait(long seconds) { delay(seconds*1000); }
}

