Enemy[] enemies;

int level = 1;

class Enemy { //parent enemy class
  float xpos;
  float ypos;
  float xsize;
  float ysize;
  boolean isAlive;

  void display() { //draws enemy
    stroke(0);
    rectMode(CENTER);
    rect(xpos, ypos, xsize, ysize);
  }

  void move() { //changes enemy xpos
    xpos += 1;
  }

  boolean isMouseOverlapping() { // checks if mouse is overlapping the enemy
    if (mouseX > xpos - xsize/2 && mouseX < xpos + xsize/2 && mouseY > ypos - ysize/2 && mouseY < ypos + ysize/2) {
      return true;
    } else {
      return false;
    }
  }
}

class Troll extends Enemy { //troll enemy
  Troll(float tempX, float tempY, float tempXSize, float tempYSize, boolean tempAlive) {
    xpos = tempX;
    ypos = tempY;
    xsize = tempXSize;
    ysize = tempYSize;
    isAlive = tempAlive;
  }
}

class Orc extends Enemy { //orc enemy
  Orc(float tempX, float tempY, float tempXSize, float tempYSize, boolean tempAlive) {
    xpos = tempX;
    ypos = tempY;
    xsize = tempXSize;
    ysize = tempYSize;
    isAlive = tempAlive;
  }
}

class Goblin extends Enemy { //goblin enemy
  Goblin(float tempX, float tempY, float tempXSize, float tempYSize, boolean tempAlive) {
    xpos = tempX;
    ypos = tempY;
    xsize = tempXSize;
    ysize = tempYSize;
    isAlive = tempAlive;
  }
}

void createEnemies() {
  for (int i = 0; i<(level*3) + 2; i++) {
    enemies[i] = new Orc(20f, (float)random(height/5 + 50, height), 20f, 30f, true);
  }

  for (int i = 0; i<(level*3) + 1; i++) {
    if (enemies[i].ypos > enemies[i + 1].ypos - enemies[i].ysize/2 && enemies[i + 1].ypos < enemies[i + 1].ypos + enemies[i].ysize/2) { //checks if enemies are overlapping
      if (enemies[i].ypos > enemies[i+1].ypos) { //attemps to alter yposition of enemies to ensure they dont overlap one another
        enemies[i].ypos += 30; //if enemy is already lower on screen, move lower
      } else if (enemies[i].ypos < enemies[i+1].ypos) {
        enemies[i].ypos -= 30; //if enemy is higher on screen, move higher
      }
    }

    if (enemies[i].ypos + 25 > height) {
      enemies[i].ypos = height - 25;
    }
    println(enemies[i].ypos);
  }

  //sort enemies based on y position
  for (int i = 0; i<(level*3) + 2; i++) {
    for (int y = 0; y<(level*3) + 1; y++) {
      if (enemies[y].ypos > enemies[y+1].ypos) { //if enemy is lower on screen, move further back into the list
        float temp = enemies[y].ypos;
        enemies[y].ypos = enemies[y + 1].ypos; // swaps y positions
        enemies[y+1].ypos = temp;
      }
    }
  }
}

void drawEnemies() {
  for (int i = 0; i<(level*3) + 2; i++) { //loops for number of enemies

    if (enemies[i].isAlive == true) { //updates the enemies positions
      enemies[i].display();
      enemies[i].move();
    }

    if (enemies[i].isMouseOverlapping() && mousePressed) { //checks if enemy is clicked on
      enemies[i].isAlive = false; //kills enemy
    }
  }
}

void drawBackground() { //draws background
  
}

boolean enemyDeathCounter() { //check how many enemies are dead
  int counter = 0;

  for (int i = 0; i<(level*3) + 2; i++) { //loops for all enemies in the level
    if (!enemies[i].isAlive) { // if enemy is dead, counter will increase
      counter++;
    }
  }
  if (counter == (level*3) + 2) {
    return true; //if all enemies created this level are dead, level will increase
  }
  return false;
}


//Program

void setup() {
  size(500, 500);
  enemies = new Enemy[50];
  createEnemies();
}

void draw() {
  background(255);
  drawBackground();
  fill(255, 255);
  drawEnemies();
  
  if (enemyDeathCounter()) {
    level++;
    createEnemies();
  }

}
