/* Stage.java
 * Scratching  -- Scratch for Processing
 *
 * This file seeks to implement Scratch blocks and sprites in
 * Processing, in order to facilitate a transition from Scratch
 * into p.
 * See: http://wiki.scratch.mit.edu/wiki/Blocks
 *
 * Sound blocks are NOT included (for sanity's sake). 
 * Data & list blocks are eradicated - use variables instead!
 *
 * Points are stored in the 'PVector' type because Processing
 * contains built-in functions for accessing and manipulating such
 * objects.
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
      p.image(backdrops.get(backdropNumber), -backdrops.get(backdropNumber).width, -backdrops.get(backdropNumber).height, backdrops.get(backdropNumber).width,
        backdrops.get(backdropNumber).height);
  }

  // load "Scratch" cat costumes
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
