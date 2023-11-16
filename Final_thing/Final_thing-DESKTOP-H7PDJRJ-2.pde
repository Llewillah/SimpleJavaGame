// different enemy functions
// menu
// images


// Initialising Arrays for objects

Enemy[] enemies;
Button[] buttons;

// Initialising main global variables

int level = 1;
String gameState = "game";
int playerHealth = 10;
int fadeCounter = 0; //Counter for end of level fade out

// ALL CLASSES

class Object { // Generic class for every object in the game
  float xpos; // floats due to calculations of movements and sizes
  float ypos;
  float xsize;
  float ysize;

  boolean isMouseOverlapping() { // checks if mouse is overlapping a specific object
    if (mouseX > xpos - xsize/2 && mouseX < xpos + xsize/2 && mouseY > ypos - ysize/2 && mouseY < ypos + ysize/2) {
      return true;
    } else {
      return false;
    }
  }
}

// ALL OF THE ENEMY TYPE CLASSES

class Enemy extends Object { //parent enemy class
  int spawnCounter;
  boolean isAlive;
  float speed;
  int attackTimer = 60;
  int attackCounter = 0;

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
}

class Troll extends Enemy { //troll enemy
  Troll(float tempX, float tempY, float tempXSize, float tempYSize, boolean tempAlive, int tempSpawn, float tempSpeed) {
    xpos = tempX;
    ypos = tempY;
    xsize = tempXSize;
    ysize = tempYSize;
    isAlive = tempAlive;
    spawnCounter = tempSpawn;
    speed = tempSpeed;
  }
}

class Orc extends Enemy { //orc enemy
  Orc(float tempX, float tempY, float tempXSize, float tempYSize, boolean tempAlive, int tempSpawn, float tempSpeed) {
    xpos = tempX;
    ypos = tempY;
    xsize = tempXSize;
    ysize = tempYSize;
    isAlive = tempAlive;
    spawnCounter = tempSpawn;
    speed = tempSpeed;
  }
}

class Goblin extends Enemy { //goblin enemy
  Goblin(float tempX, float tempY, float tempXSize, float tempYSize, boolean tempAlive, int tempSpawn, float tempSpeed) {
    xpos = tempX;
    ypos = tempY;
    xsize = tempXSize;
    ysize = tempYSize;
    isAlive = tempAlive;
    spawnCounter = tempSpawn;
    speed = tempSpeed;
  }
}

// ALL OF THE MENU TYPE CLASSES

class Button extends Object {
  String text;

  Button(float tempX, float tempY, float tempXSize, float tempYSize, String tempText) {
    xpos = tempX;
    ypos = tempY;
    xsize = tempXSize;
    ysize = tempYSize;
    text = tempText;
  }
}

// ALL OF THE PLAYER / ALLY / FRIENDLY CLASSES

void createEnemies() {
  enemies = new Enemy[(level*3) + 2];

  for (int i = 0; i<(level*3) + 2; i++) {
    int enemyType = (int)random(0, 6);
    if (enemyType <= 2) {
      enemies[i] = new Orc(20f, random(height/5 + 50, height), height*0.04, height*0.06, true, (int)random(0, 500), 1);
    } else if (enemyType >= 2 && enemyType <= 4) {
      enemies[i] = new Goblin(20f, random(height/5 + 50, height), height*0.04, height*0.04, true, (int)random(0, 500), 2);
    } else if (enemyType > 4) {
      enemies[i] = new Troll(20f, random(height/5 + 50, height), height*0.06, height*0.08, true, (int)random(0, 500), 0.5);
    }
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

    if (enemies[i].isAlive == true && enemies[i].spawnCounter == 500) { //updates the enemies positions
      enemies[i].display();
      enemies[i].move();
    } else if (enemies[i].spawnCounter < 500) {
      enemies[i].spawnCounter++;
    }

    if (enemies[i].isMouseOverlapping() && mousePressed) { //checks if enemy is clicked on
      enemies[i].isAlive = false; //kills enemy
    }
  }
}

void drawBackground() { //draws background
  fill(0, 0, 255); // changes colour to blue
  rect(width/2, height/5, width, height/3); //sky rectangle
  fill(0, 255, 0); // changes colour to green
  rect(width/2, height - height/5, width, height); //ground rectangle
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

void endLevel() {
  if (fadeCounter <  255) {
    fade();
    fadeCounter++;
    println();
  } else {
    fadeCounter = 0;
    level++;
    createEnemies();
    gameState = "game";
  }
}

void fade() {
  fill(0, 0, 0, fadeCounter);
  rect(width/2, height/2, width, height);
}


//Program

void setup() {
  size(1280, 720);
  createEnemies();
}

void draw() {
  switch (gameState) {
  case "menu":
    break;
    
  case "game":
    drawBackground();
    fill(255, 255);
    text("Level: "+level, 20, 50);
    text("Health: "+playerHealth, 100, 50);
    drawEnemies();
    
    if (playerHealth <= 0) {
      gameState = "gameOver";
    }
    if (enemyDeathCounter()) {
      gameState = "levelEnd";
    }
    break;
    
  case "levelEnd":
    endLevel();
    break;
    
  case "gameOver":
    background(0);
    text("GAME OVER",width/2, height/2);
  }
}
