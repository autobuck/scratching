/* Stage.java
 * Scratching  -- Scratch for Processing
 *
 * This file seeks to implement Scratch blocks and sprites in
 * Processing, in order to facilitate a transition from Scratch
 * into p.
 * See: http://wiki.scratch.mit.edu/wiki/Blocks
 *
 * This Stage class has just a few simple functions for handling
 * the background. 
 *
 * switchToBackdrop(#); can replace the background(#);
 * command at the top of your draw() loop.
 *
 * The backdrop size should match your stage size.
 * Who knows what might happen if it does not?!
 *
 */

import processing.core.PApplet;
import processing.core.PImage;
import processing.core.PFont;
import java.util.ArrayList;

public class Stage {

  // without this, built-in functions are broken. use p.whatever to access functionality
  PApplet p;

  public int backdropNumber, numberOfBackdrops;
  public ArrayList<PImage> backdrops = new ArrayList<PImage>();
  PFont f;
  String answer;
  boolean questionAnswered;
  
  Stage (PApplet parent) {
    p = parent;
    backdropNumber=0;
    numberOfBackdrops=0;
    loadDefaultGrid();
    f=p.createFont("Arial",16,true);
  }

  void processKeyboardInput() {
    int keyIndex = -1;
    if (p.key >= 'A' && p.key <= 'Z') {
      keyIndex = p.key - 'A';
    } else if (p.key >= 'a' && p.key <= 'z') {
      keyIndex = p.key - 'a';
    }
    if (keyIndex == -1) {
      // If it's not a letter key, clear the screen
      questionAnswered=true; // exit loop after "Enter" key pressed
    } else { 
      // It's a letter key, add the key to the string
      answer=answer+Character.toString(p.key);
    }
    p.print(questionAnswered); p.print(keyIndex); p.println(answer);
  }

  void drawQuestionBox() {
    p.pushStyle();
    p.fill(255);
    p.stroke(0);
    p.rect(5,315,470,30,5);
    p.textFont(f,16);
    p.fill(0);
    p.textAlign(p.LEFT);
    p.text(question,10,335);
    p.popStyle();
  }

  // this function pops up a window asking a question and waiting for keyboard input, pausing all action
  public String ask(String question) {
    questionAnswered = false;
    answer = "";
    while (!questionAnswered) {
      drawQuestionBox();
      if (p.key!=0) processKeyboardInput();
    }
    return "Monkey shines";
  }

  public void draw() {    
      p.image(backdrops.get(backdropNumber), p.width/2, p.height/2, backdrops.get(backdropNumber).width,
        backdrops.get(backdropNumber).height);
  }

  // load xy grid as backdrop 0
  public void loadDefaultGrid() {
    addBackdrop("images/xy-grid.png");
  }

  // add costume from bitmap image file
  public void addBackdrop(String filePath) {
    numberOfBackdrops++;
    backdrops.add(p.loadImage(filePath));
  }

  // change to next backdrop
  public void nextBackdrop() { 
    backdropNumber++;
    if (backdropNumber > numberOfBackdrops + 1) backdropNumber=0;
    draw();
  }

  // change to previous backdrop
  public void previousCostume() {
    backdropNumber--;
    if (backdropNumber < 0) backdropNumber=backdropNumber;
    draw();
  }

  // switch to specific costume
  public void switchToBackdrop(int newBackdropNumber) {
    backdropNumber=newBackdropNumber;
    draw();
  }
  
}
