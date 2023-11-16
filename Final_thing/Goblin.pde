class Goblin extends Enemy { //goblin enemy
  Goblin(float tempY, int tempSpawn) {
    super(tempY, tempSpawn);
    
    xsize = height*0.04;
    ysize = height*0.04;
    speed = 2;
  }
}
