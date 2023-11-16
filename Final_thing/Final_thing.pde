import java.util.ArrayList;
// different enemy functions
// menu
// images
// file handling
// Complex Movements



// Initialising Arrays for objects

ArrayList<Enemy> enemies = new ArrayList<>();
Button[] buttons;

// Initialising main global variables

int level = 1;
String gameState = "game";
int playerHealth = 10;
int ammo = 5;
int ammoCounter = 0;
int fadeCounter = 0; //Counter for end of level fade out

// ALL OF THE MENU TYPE CLASSES

class Button extends Default {
  String text;

  Button(float tempX, float tempY, float tempXSize, float tempYSize, String tempText) {
    super(tempY);
    xpos = tempX;
    xsize = tempXSize;
    ysize = tempYSize;
    text = tempText;
  }
}

void createEnemies() {

  for (int i = 0; i<(level*3) + 2; i++) {
    int enemyType = (int)random(0, 6);
    if (enemyType <= 2) {
      enemies.add(new Orc(random(height/5 + 50, height), (int)random(0, 500)));
    } else if (enemyType >= 2 && enemyType <= 4) {
      enemies.add(new Goblin(random(height/5 + 50, height), (int)random(0, 500)));
    } else if (enemyType > 4) {
      enemies.add(new Troll(random(height/5 + 50, height), (int)random(0, 500)));
    }
  }

  for (Enemy i : enemies) {
    if (i.ypos + 25 > height) {
      i.ypos = height - 25;
    }
    println(i.ypos);
  }

  //sort enemies based on y position
  for (int i = 0; i<enemies.size(); i++) {
    for (int y = 0; y<enemies.size() - 1; y++) {
      if (enemies.get(y).ypos > enemies.get(y+1).ypos) { //if enemy is lower on screen, move further back into the list
        float temp = enemies.get(y).ypos;
        enemies.get(y).ypos = enemies.get(y + 1).ypos; // swaps y positions
        enemies.get(y+1).ypos = temp;
      }
    }
  }
}

void drawEnemies() {
  for (int i = 0; i < enemies.size(); i++){//loops for number of enemies
    enemies.get(i).update();

    if (enemies.get(i).isMouseOverlapping() && mousePressed && ammo > 0) { //checks if enemy is clicked on
      enemies.remove(i);
      ammo--;
    }
  }
}

void drawBackground() { //draws background
  fill(0, 0, 255); // changes colour to blue
  rect(width/2, height/5, width, height/3); //sky rectangle
  fill(0, 255, 0); // changes colour to green
  rect(width/2, height - height/5, width, height); //ground rectangle

  fill(255, 255);
  text("Level: "+level, 20, 50);
  text("Health: "+playerHealth, 100, 50);
  text("Ammo: "+ammo, 180, 50);
}

void endLevel() {
  if (fadeCounter <  255) {
    fade();
    fadeCounter++;
  } else {
    ammo = 5;
    ammoCounter = 0;
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

void ammoReload() {
  if (ammoCounter == 60) {
    ammo++;
    ammoCounter = 0;
  } else {
    ammoCounter++;
  }
}

//Method to clean up draw, does basic checking
void eventChecks() {
  if (ammo < 5) {
    ammoReload();
  }

  if (playerHealth <= 0) {
    gameState = "gameOver";
  }

  if (enemies.size() == 0) {
    gameState = "levelEnd";
  }
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
    drawEnemies();
    eventChecks();

    break;

  case "levelEnd":
    endLevel();
    break;

  case "gameOver":
    background(0);
    text("GAME OVER", width/2, height/2);
  }
}
