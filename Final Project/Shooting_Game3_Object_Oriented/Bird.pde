class Bird {

  float posY;
  float posX = map(pressure, 50, 4000, 0, 700);
  boolean moveRight = true; //this is for birds starts moving right
  float radius;

  PImage bird;

  Bird() {
    posX = 100;
    posY = 100;
    moveRight = true;
    radius = 30;
    
    bird = loadImage("bird.png");
  }

  void display() {
    image(bird, posX, posY, 80, 50);
  }

  void birdFly() {
    if (moveRight == true) {
      posX = posX +4;
    }

    if (posX <= 650) {
      moveRight = true;
    }

    if (posX > 650) {
      posX = 0;
      moveRight = true;
      countA = countA + 1;
      //countA++;
    }
  }
  void die(){
     moveRight = false;
     posX = posX+500;
  }
  
}
