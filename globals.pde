/* globals.pde
 * This file contains global elements (non-sprite specific)
 */

/* The global origin.
 * We want a cartesian system (with pt(0,0) in the middle, rather
 * than in the UL corner (as most graphics languages do).
 * This will be set by the init() function.
 */
public PVector globOrigin = new PVector();

/* begin()
 * This MUST be called at the beginning of setup(). It acts in place
 * of the builtin size() function so that the global origin can also
 * be set.
 */
public void begin(int _width, int _height) {
  size(_width, _height);
  globOrigin.set(width/2, height/2);
}

