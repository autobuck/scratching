Sprite cat;
Sprite alsoCat;
Stage stage;
int numberOfSprites=0;
String questionText = "your text here";
boolean askingAQuestion = false;
String test = "";

PFont f;
// Variable to store text currently being typed
String typing = "";
// Variable to store saved text when return is hit
String answer = "";
String Qanswer = "";


static int rotationStyle_AllAround=0;
static int rotationStyle_LeftRight=1;
static int rotationStyle_DontRotate=2;

void setup() {
  // never change these first three lines
  size(480, 360);
  f = createFont("Arial",16,true);
  stage = new Stage(this);

  // add your own initialization code here
  cat = new Sprite(this);
  numberOfSprites++;
  alsoCat = new Sprite(this);
  numberOfSprites++;
  cat.size=50;
  cat.goToXY(0,0);
  alsoCat.size=25;
  alsoCat.pos.set(150,150);
  alsoCat.direction=00;
}
  
void wrapAtEdges(Sprite whoever) {
  if (whoever.pos.x>230) whoever.pos.x=-230;
  if (whoever.pos.x<-230) whoever.pos.x=230;
  if (whoever.pos.y>170) whoever.pos.y=-170;
  if (whoever.pos.y<-170) whoever.pos.y=170;
}  

void draw() {
  stage.switchToBackdrop(0);
  stage.update();

  //cat.pointTowards(alsoCat);
  if (cat.distanceToXY(mouseX,mouseY) > 11) {
    cat.pointTowardsMouse();
    cat.move(10);
    cat.nextCostume();
  }
  cat.update();
  updateAlsoCat();
  
  wrapAtEdges(cat);
  wrapAtEdges(alsoCat);
   
   
  delay(100);
  answer = ask("What is your quest?");
  if (answer!="") 
    println(answer);
}

void updateAlsoCat() {
  alsoCat.nextCostume();
  if (alsoCat.touchingSprite(cat)) { alsoCat.hide(); cat.goToXY(0,0); } 
  else alsoCat.show();
  alsoCat.update();
}

void mouseClicked() {
  test = "";
  while (test=="") {  
    test = stage.ask("What is your quest?");
    println(test);
  }
}

String ask(String question) {
  askingAQuestion = true;
  textFont(f,18);
  // this adds a blinking cursor after your text, at the expense of redrawing everything every frame
  //text(question+(frameCount/10 % 2 == 0 ? "_" : ""), 35, 45);
  drawQuestionBox(question);
  if (typing.length()>0) {
    if (typing.charAt(typing.length()-1)==ENTER|typing.charAt(typing.length()-1)==RETURN) {
      println(typing.length()+": "+typing+"("+(int)typing.charAt(typing.length()-1)+")");
      typing = "";
      return Qanswer;
    }
    else return "";
  } else return "";
}

  void drawQuestionBox(String question) {
    pushStyle();
    fill(255);
    stroke(0);
    rect(5,315,470,30,5);
    textFont(f,16);
    fill(0);
    textAlign(LEFT);
    text(question+" "+typing+(frameCount/10 % 2 == 0 ? "_" : ""),10,335);
    popStyle();
  }

  void keyPressed() {
    // If the return key is pressed, save the String and clear it
    if (key!=CODED) {
      if (key == '\n' ) {
        Qanswer = typing;
        typing = "";
        println(Qanswer);
      } else if (key == BACKSPACE) {
           typing = typing.substring(0,max(0,typing.length()-1));
      } else 
        // Otherwise, concatenate the String
        // Each character typed by the user is added to the end of the String variable.
        typing = typing + key;
 
    }
  }

