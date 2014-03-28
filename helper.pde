/* helper.pde
 * 
 * This file includes non-java universal helper functions.
 * (This was the best way of doing it to prevent having another end-user class)
 */


public void begin(int _width, int _height) {
  size(_width, _height);
  global.origin.set(width/2, height/2);
}

