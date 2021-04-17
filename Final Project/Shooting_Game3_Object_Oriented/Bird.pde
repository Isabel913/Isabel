class Bird {

  float posY;
  float posX = map(pressure, 50, 4000, 0, 700);
  boolean moveRight = true; //this is for birds starts moving right
  float radius;



  Bird() {
    //posX = 100;
    posY = 100;
    moveRight = true;
    radius = 30;
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

  void hit() {

    for (Bird b : birds) {
      if (b.radius > dist(mouseX, mouseY, b.posX, b.posY)) {
        b.moveRight = false;
        b.posX = b.posX+500;
        //countY = countY + 1;
        //countA = countA+0;
        countY++;
        countA= countA-1;
        break;
      }
        //if (b.radius > dist(700, 0, b.posX, b.posY)) {
        //  b.moveRight = false;
        //  b.posX = b.posX+500;
        //  //countY = countY + 1;
        //  countA = countA+1;
          
        //  break;
        //}
      

      
    }
  }
}
