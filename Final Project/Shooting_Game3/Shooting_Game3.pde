import processing.serial.*;

Serial myConnection;

String serialValue = ",";

float gunX = 350;
//float bulletX = 355;
//float bulletY = 650;
float bulletX = 5;
float bulletY = 0;

float ellX = 0;
float ellY = random (30,  400);

boolean moveRight = true; //this is for birds starts moving right
boolean moveUp = false; //this is for gun starts off not moving

boolean bullet = true;

int countA = 0; //score for birds
int countY = 0; //score for hunter

PFont font;
PImage background;
PImage bird;
PImage arrow;

float button = 0;
float potentiometer = 0;
float pressure = 0;


void setup () {

  size (700, 700);
  background = loadImage("bg.png");
  bird = loadImage("bird.png");
  arrow = loadImage("arrow.png");
  font = loadFont("Arial-BoldMT-24.vlw");

  printArray(Serial.list());
  myConnection = new Serial(this, Serial.list()[1], 9600);
  myConnection.bufferUntil('\n');
  frameRate(30);
}

void draw () {

  image(background, 0, 0);
  textFont (font);
  
  float ellX = map(pressure, 50, 4000, 0, 700);
  float rotationAngle = map(potentiometer, 0, 4096, 0, PI*1.5);
  println(rotationAngle);
  pushMatrix();
  translate(350, 600);
  rotate(rotationAngle); 

  fill (255); 
  rect (0, 0, 20, 100); //gun
  fill (0);
  rect (bulletX, bulletY, 5, 50); //bullet

  //image (arrow, bulletX, bulletY, 5, 50);
  //fill(255, 0, 255);
  //ellipse(0, 0, 100, 100);
  //stroke(10);
  //line(0, 0, 40, 40);

  if (button == 1)
  {  
    moveUp = true;
  }
  



  popMatrix();

  image(bird, ellX, ellY, 80, 50); //bird

  fill (0, 0, 0);
  text("Birds", 50, 50);
  text (countA, 230, 50); // score for birds


  text ("Hunter", 450, 50);
  text (countY, 570, 50); //score for hunter

  //bulletX = gunX +5;
  //image (arrow, bulletX, bulletY, 5, 50);

  if (moveRight == true) {
    ellX = ellX +4;
  }
  if (ellX <= 650) {
    moveRight = true;
  }
  
  if (ellX > 650) {
    ellX = 0;
    ellY = random (30, 400);
    moveRight = true;

    countA++;
  }


  if (moveUp == true) {
    bulletY = bulletY + 20;
  }

  if (bulletY >700) {
    bulletY = 0;
    moveUp = false;
  }

  if (bulletY < ellY + 50 && bulletY > ellY - 50 && bulletX < ellX + 50 && bulletX > ellX - 50) {
    ellX = 0;
    ellY = 0;
    moveRight = true;
    ;
  }



}


void serialEvent(Serial conn) {
  String fromSerial = conn.readString();

  if (fromSerial != null) {
    //fromSerial = trim(fromSerial);

    String[] data = split(fromSerial, ',');
    printArray(data);


    if (data.length == 3) {
      button = float(data[0]);
      potentiometer = float(data[1]);
      pressure = float(data[2]);
    }
  }
  println();
}
