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
import java.util.ArrayList;

public class Stage {

  // without this, built-in functions are broken. use p.whatever to access functionality
  PApplet p;

  public int backdropNumber, numberOfBackdrops;
  public ArrayList<PImage> backdrops = new ArrayList<PImage>();
  
  Stage (PApplet parent) {
    p = parent;
    backdropNumber=0;
    numberOfBackdrops=0;
    loadDefaultGrid();
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
