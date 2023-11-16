class Troll extends Enemy { //troll enemy
  Troll(float tempY, int tempSpawn) {
    super(tempY, tempSpawn);
    
    speed = 0.75;
    xsize = height*0.06;
    ysize = height*0.08;
  }
}
