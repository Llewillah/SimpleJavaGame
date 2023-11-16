class Orc extends Enemy { //orc enemy
  Orc(float tempY, int tempSpawn) {
    super(tempY, tempSpawn);
    
    xsize = height*0.04;
    ysize = height*0.06;
    speed = 1;
  }
}
