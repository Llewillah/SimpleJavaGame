class Enemy extends Default { //parent enemy class
  int spawnCounter;
  float speed;
  int attackTimer = 60;
  int attackCounter = 0;

  Enemy(float tempY, int tempSpawn) {
    super(tempY);

    xpos = 20f;
    spawnCounter = tempSpawn;
  }

  void display() { //draws enemy
    stroke(0);
    rectMode(CENTER);
    rect(xpos, ypos, xsize, ysize);
  }

  void move() { //changes enemy xpos
    if (xpos < width*0.9) {
      xpos += speed;
    } else if (xpos >= width*0.9) {
      damage();
    }
  }

  void damage() {
    if (attackCounter > attackTimer) {
      playerHealth--;
      attackCounter = 0;
    } else {
      attackCounter++;
    }
  }

  void update() {
    if (spawnCounter == 500) { //updates the enemies positions
      display();
      move();
    } else if (spawnCounter < 500) {
      spawnCounter++;
    }
  }
}
