/* global.java
 * This file contains global elements (non-sprite specific)
 * 
 * These are variables, mostly. helper functions are in helper.pde
 */

import processing.core.PVector;


public class global {
  /* The global origin.
   * We want a cartesian system (with pt(0,0) in the middle, rather
   * than in the UL corner (as most graphics languages do).
   * This will be set by the init() function.
   */
  public static PVector origin = new PVector();


}

