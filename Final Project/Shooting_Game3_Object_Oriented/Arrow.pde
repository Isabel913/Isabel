class Arrow {

  float posX, posY;   
  boolean moveUp = false; //this is for gun starts off not moving
  boolean bullet = true;

  Arrow() {
    posX = 350;
    posY = 700;

    moveUp = false;
  }


  void display() {

    float rotationAngle = map(potentiometer, 0, 4096, PI*0.5, PI*1.5);
    
    println(rotationAngle);
    pushMatrix();
    translate(350, 600);
    rotate(rotationAngle); 

    fill (255); 
    rect (0, 0, 20, 100); //gun
    fill (0);
    rect (0, 0, 5, 50); //bullet
    
    popMatrix();
    
  }

  void shoot() {
    if (button == 1)
    {  
      moveUp = true;
    }
    if (moveUp == true) {
      posY = posY - 10;
    }
    if (posY <10) {
      posY = 650;
      moveUp = false;
    }
  }
}
