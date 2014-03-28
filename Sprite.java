/* Scratching  -- Scratch for Processing
 *
 * This file seeks to implement Scratch blocks and sprites in
 * Processing, in order to facilitate a transition from Scratch
 * into Processing.
 * See: http://wiki.scratch.mit.edu/wiki/Blocks
 *
 * Sound blocks are NOT included (for sanity's sake). 
 * Data & list blocks are eradicated - use variables instead!
 *
 * Points are stored in the 'PVector' type because Processing
 * contains built-in functions for accessing and manipulating such
 * objects.
 */

/* The global origin.
 * We want a cartesian system (with pt(0,0) in the middle, rather
 * than in the UL corner (as most graphics languages do).
 * This will be set by the init() function.
 */

import processing.core.PApplet;
//import processing.core.PShape;
import processing.core.PImage;
import processing.core.PVector;


public class Sprite {
  
  static final int rotationStyle_LeftRight=1;
  static final int rotationStyle_noRotation=2;
  public PVector globOrigin = new PVector();

  PApplet processing;

  public int xPosition, yPosition, rotationStyle;
  public int costumeNumber, numberOfCostumes;
  public float size; 
  public boolean visible;
  public int penColor, penSize; 
  public boolean penUp;
//  public float d = 0;
  public PVector vectorDirection;
  public PVector vectorPosition = new PVector(globOrigin.x, globOrigin.y);
 
  // add images as costumes;
  PImage[] costumes;

  // "momentum" will keep track of long-term movements such as glideTo
  //private int momentum;

  // without this, built-in functions are broken. use processing.whatever to access functionality
  Sprite (PApplet parent) {
  //  hitbox = new hitboxValues;
    processing = parent;
    costumes = new PImage[20];
    loadDefaultCostumes();
    costumeNumber=0;
    visible = true;
    numberOfCostumes=0;
    size=100;
    rotationStyle=rotationStyle_LeftRight;
    vectorPosition = new PVector(xPosition,yPosition);
    vectorDirection = new PVector(0,0);
  }
  
  /* DIRECTION IS IN DEGREES! any math will require conversion.
   * This for end-user simplicity.
   * Use degrees() to convert to degrees; radians() to convert to
   * radians.
   */
  public float direction = 0;
  
  /* ==== Drawing ====
   * 
   * In order to draw sprites to the screen, each one will have
   * a graphics object. This graphics object can be individually
   * manipulated during the program.
   * May support images later.
   *
   * The .update() function must be called for all sprites.
   * It may be easiest to store sprites in an array of Sprites,
   * and looping through the array to redraw all sprites.
   */
  public void update() {    
    if (visible) {
      processing.image(costumes[costumeNumber], 
        xPosition-((costumes[costumeNumber].width*(size/100))/2), 
        yPosition-((costumes[costumeNumber].height*(size/100))/2), 
        costumes[costumeNumber].width*(size/100), 
        costumes[costumeNumber].height*(size/100));
      //if (((direction<0) | (direction>180)) & (rotationStyle==rotationStyle_LeftRight)) processing.image(getReversePImage(costumes[costumeNumber]), xPosition-((costumes[costumeNumber].width*(size/100))/2), yPosition-((costumes[costumeNumber].height*(size/100))/2), costumes[costumeNumber].width*(size/100), costumes[costumeNumber].height*(size/100));
      //else processing.image(costumes[costumeNumber], xPosition-((costumes[costumeNumber].width*(size/100))/2), yPosition-((costumes[costumeNumber].height*(size/100))/2), costumes[costumeNumber].width*(size/100), costumes[costumeNumber].height*(size/100));      
    }      
 
  }

  // load "Scratch" cat costumes
  public void loadDefaultCostumes() {
    addCostume("images/cat.costume1.png");
    addCostume("images/cat.costume2.png");
    costumes[0] = processing.loadImage("images/cat.costume1.png");
    costumes[1] = processing.loadImage("images/cat.costume2.png");
  }

  // add costume from bitmap image file
  public void addCostume(String filePath) {
    numberOfCostumes++;
    costumes[numberOfCostumes] = processing.loadImage(filePath);
  }
  
  // change to next costume
  public void nextCostume() { 
    costumeNumber++;
    if (costumeNumber>numberOfCostumes+1) costumeNumber=0;
  }
  
  // change to previous costume
  public void previousCostume() {
    costumeNumber--;
    if (costumeNumber<0) costumeNumber=numberOfCostumes;  }
  
  // switch to specific costume
  public void switchToCostume(int newCostumeNumber) {
    costumeNumber=newCostumeNumber;
  }
  
  // set "visible" variable to make sprite appear
  public void show() {
    visible=true;
  }
  
  // set not visible to hide
  public void hide() {
    visible=false;
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
    /*
    if ((direction==-90) | (direction==270)) xPosition=xPosition-distance;
    if (direction==90) xPosition=xPosition+distance;
    if ((direction==0) | (direction==360)) yPosition=yPosition-distance;
    if (direction==180) yPosition=yPosition+distance;
    vectorPosition=new PVector(xPosition,yPosition);
    */
    vectorPosition.setMag(vectorPosition.mag() + distance);
    xPosition=(int)vectorPosition.x;
    yPosition=(int)vectorPosition.y;
  }
  
  // turn any angle
  public void turn(float angle) {
    direction += angle;
  }
  
  // turn right
  public void turnLeft(float angle) {
    direction -= angle;
  }
  
  // turn left
  public void turnRight(float angle) { 
    direction += angle;
  }
  
  // point towards arbitrary grid position
  public void pointTowardsXY(int x, int y) {
    PVector temp = new PVector(x,y);
    direction = processing.degrees(processing.atan2((vectorPosition.y - temp.y),
                (vectorPosition.x - temp.x)));
  }
  
  // absolute heading
  public void pointInDirection(float angle) {
    direction = angle;
  }
  
  /* Sets the direction to point towards another Sprite. */
  public void pointTowards(Sprite target) {
    direction = processing.degrees(processing.atan2((vectorPosition.y - target.vectorPosition.y),
                              (vectorPosition.x - target.vectorPosition.x)));
  }
  
  /* Same as above, but for mouse. */
  public void pointTowardsMouse() {
    direction = processing.degrees(processing.atan2(vectorPosition.y - processing.mouseY, vectorPosition.x - processing.mouseX));
  }

  /* move to specific location on grid */
  public void goToXY(int x, int y) { 
    xPosition=x;
    yPosition=y;
    vectorPosition = new PVector(xPosition,yPosition);
  }
  
  // move to position of Sprite object
  public void goToSprite(Sprite target) { 
    xPosition=target.xPosition; 
    yPosition=target.yPosition;
    vectorPosition=new PVector(target.xPosition,target.yPosition);
  }

  // check if a Sprite is touching another Sprite using simple rectangular hit box
  public boolean touchingSprite(Sprite target) {
    boolean touchingX,touchingY;
    PVector testVector;
    touchingX=false; touchingY=false;
    testVector=new PVector(target.xPosition,yPosition);
    if (vectorPosition.dist(testVector) < ((target.costumes[target.costumeNumber].width*(target.size/100))/2)+(costumes[costumeNumber].width*(size/100))/2) {
      touchingX = true; 
    }
    testVector=new PVector(xPosition,target.yPosition);
    if (vectorPosition.dist(testVector) < ((target.costumes[target.costumeNumber].height*(target.size/100))/2)+(costumes[costumeNumber].height*(size/100))/2) {
      touchingY = true; 
    }
    if (touchingX & touchingY) return true;
    else return false;
  }

  // return distance to arbitrary grid position  
  public float distanceToXY(int x, int y) { 
    PVector temp = new PVector(x,y);
    return vectorPosition.dist(temp);
  }
  
  // return distance to Sprite object
  public float distanceToSprite(Sprite target) { 
    return distanceToXY(target.xPosition, target.yPosition);
  }

}

