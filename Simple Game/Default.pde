class Default { // Generic class for every object in the game
  float xpos; // floats due to calculations of movements and sizes
  float ypos;
  float xsize;
  float ysize;
  
  Default(float ypos){
    this.ypos = ypos;
  }

  boolean isMouseOverlapping() { // checks if mouse is overlapping a specific object
    if (mouseX > xpos - xsize/2 && mouseX < xpos + xsize/2 && mouseY > ypos - ysize/2 && mouseY < ypos + ysize/2) {
      return true;
    } else {
      return false;
    }
  }
}
