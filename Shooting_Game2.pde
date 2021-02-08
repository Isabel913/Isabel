float gunX = 350;
float bulletY = 650;
float bulletX = 355;

float ellX = 350;
float ellY = 0;

boolean moveDown = true; //this is for birds starts moving down
boolean moveUp = false; //this is for bullet starts off not moving

boolean bullet = true;

int countA = 0; //score for aliens
int countY = 0; //score for user

PFont font; //this is for the font used for scores
PImage background;
PImage bird;
PImage arrow;


void setup () {

  size (700,700); //canvas size
  background = loadImage("bg.png");
  bird = loadImage("bird.png");
  arrow = loadImage("arrow.png");
  //img = loadImage("bird.png");
  //background (0); //bg color black
  font = loadFont("Arial-BoldMT-24.vlw");
}

void draw () {

  image(background, 0, 0);

  
  textFont (font);
  
  image(bird, ellX, ellY, 80, 50);
  //ellipse (ellX, ellY, 50, 50); //bird ball
  
  fill (0, 0, 0); //black
  text("Birds", 50, 50);
  text (countA, 230, 50); // score for aliens
  
  fill (0, 0, 0); //black
  //image(gun, gunX, 600, 15, 100);
  rect (gunX, 600, 15, 100); //gun
  text ("You", 450, 50);
  text (countY, 570, 50); //score for user
  
  bulletX = gunX +5;
  //fill (255, 0, 0);
  image (arrow, bulletX, bulletY, 5, 50);
  //rect (bulletX, bulletY, 5, 50); //bullet hidden in gun
  
  
  if(keyPressed == true && key == CODED && keyCode == LEFT) {
    gunX = gunX - 6;
  }
  if(keyPressed == true && key == CODED && keyCode == RIGHT) {
    gunX = gunX + 6;
  }
  
  if(moveDown == true) {
    ellY = ellY +4;
  }
  if(ellY <= 650) {
    moveDown = true;
  }
  if(ellY > 650) {
    ellY = 0;
    ellX = random (30, 670);
    moveDown = true;
    
    countA++;
  }
  
  if (keyPressed && key == ' ')
  {
    moveUp = true;
  }
  if (moveUp == true){
    bulletY = bulletY - 10;
  }
  
  if (bulletY <10) {
    bulletY = 650;
    moveUp = false;
  }
  
  if (bulletY < ellY + 50 && bulletY > ellY - 50 && bulletX < ellX + 50 && bulletX > ellX - 50) {
    ellY = 0;
    ellX = random (30 , 670);
    moveDown = true;
    countY++;
  }
}
