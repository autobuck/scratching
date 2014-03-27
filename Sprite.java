import processing.core.PApplet;
//import processing.core.PShape;
import processing.core.PImage;
import processing.core.PVector;

public class Sprite {
  
  static final int rotationStyle_LeftRight=1;
  static final int rotationStyle_noRotation=2;
  
  PApplet processing;
  public int xPosition, yPosition, direction, rotationStyle;
  public int costumeNumber, numberOfCostumes;
  public float size; 
  public boolean visible;
  public int volume, tempo;
  public int penColor, penSize; 
  public boolean penUp;
  
  public PVector vectorDirection,vectorPosition;
  
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

  // "update" routine will draw sprite in new position, continue acting if set in motion by Move, etc
  public void update() {    
    if (visible) {
      if (((direction<0) | (direction>180)) & (rotationStyle==rotationStyle_LeftRight)) processing.image(getReversePImage(costumes[costumeNumber]), xPosition-((costumes[costumeNumber].width*(size/100))/2), yPosition-((costumes[costumeNumber].height*(size/100))/2), costumes[costumeNumber].width*(size/100), costumes[costumeNumber].height*(size/100));
      else processing.image(costumes[costumeNumber], xPosition-((costumes[costumeNumber].width*(size/100))/2), yPosition-((costumes[costumeNumber].height*(size/100))/2), costumes[costumeNumber].width*(size/100), costumes[costumeNumber].height*(size/100));      
    }    
  }

  public void loadDefaultCostumes() {
    addCostume("images/cat.costume1.png");
    addCostume("images/cat.costume2.png");
    costumes[0] = processing.loadImage("images/cat.costume1.png");
    costumes[1] = processing.loadImage("images/cat.costume2.png");
  }

  // "looks" blocks
  public void addCostume(String filePath) {
    numberOfCostumes++;
    costumes[numberOfCostumes] = processing.loadImage(filePath);
  }
  
  public void nextCostume() { 
    costumeNumber++;
    if (costumeNumber>numberOfCostumes+1) costumeNumber=0;
  }
  
  public void previousCostume() {
    costumeNumber--;
    if (costumeNumber<0) costumeNumber=numberOfCostumes;  }
  
  public void switchToCostume(int newCostumeNumber) {
    costumeNumber=newCostumeNumber;
  }
  
  public void show() {
    visible=true;
  }
  
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
    if ((direction==-90) | (direction==270)) xPosition=xPosition-distance;
    if (direction==90) xPosition=xPosition+distance;
    if ((direction==0) | (direction==360)) yPosition=yPosition-distance;
    if (direction==180) yPosition=yPosition+distance;
    vectorPosition=new PVector(xPosition,yPosition);
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
    PVector temp = new PVector(x,y);
    float radDirection;
    temp.sub(vectorPosition);
    processing.print("temp vector is "); processing.println(temp);
    processing.print("heading is "); processing.println(temp.heading());
    xPosition=(int)vectorPosition.x;
    yPosition=(int)vectorPosition.y;
    radDirection=vectorPosition.heading(); // probably needs some translation
    direction=(int)(radDirection * (180/3.14)); // mathwarehouse.com/trigonometry/radians/convert-degee-to-radians.php
    // probably want logic to reverse >180 to left-facing -degrees but this will do for now
    processing.print("direction is "); processing.println(direction);
  }
  
  public void pointInDirection(int newDirection) { 
    direction=newDirection;
    //need to set the vectorDirection
  }
  
  public void pointTowardsSprite(Sprite target) { 
    pointTowardsXY(target.xPosition, target.yPosition);
  }
  
  public void goToXY(int x, int y) { 
    xPosition=x;
    yPosition=y;
    vectorPosition = new PVector(xPosition,yPosition);
  }
  
  public void goToSprite(Sprite target) { 
    xPosition=target.xPosition; 
    yPosition=target.yPosition;
    vectorPosition=new PVector(target.xPosition,target.yPosition);
  }

  // "sensing" blocks
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

