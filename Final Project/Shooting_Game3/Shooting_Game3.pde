import processing.serial.*;

Serial myConnection;

float val = 0.0;
String serialValue = ",";

float gunX = 350;
float bulletY = 650;
float bulletX = 355;

float ellX = 0;
float ellY = 350;

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


void setup () {

  size (700, 700);
  background = loadImage("bg.png");
  bird = loadImage("bird.png");
  arrow = loadImage("arrow.png");
  font = loadFont("Arial-BoldMT-24.vlw");

  printArray(Serial.list());
  myConnection = new Serial(this, Serial.list()[3], 9600);
  myConnection.bufferUntil('\n');
}

void draw () {
  image(background, 0, 0);
  textFont (font);

  float rotationAngle = map(val, 0.0, 1023.0, 0.0, PI*1.5);

  rotate(-rotationAngle); 
  fill (0, 0, 0); 
  rect (gunX, 600, 15, 100); //gun
  fill(255, 0, 255);
  ellipse(350, 600, 100, 100);
  stroke(10);
  line(350, 600, 40, 40);

  image(bird, ellX, ellY, 80, 50);

  fill (0, 0, 0);
  text("Birds", 50, 50);
  text (countA, 230, 50); // score for birds

  fill (0, 0, 0); 
  rect (gunX, 600, 15, 100); //gun
  text ("Hunter", 450, 50);
  text (countY, 570, 50); //score for user

  bulletX = gunX +5;
  image (arrow, bulletX, bulletY, 5, 50);


  if (keyPressed == true && key == CODED && keyCode == LEFT) {
    gunX = gunX - 6;
  }
  if (keyPressed == true && key == CODED && keyCode == RIGHT) {
    gunX = gunX + 6;
  }

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

  if (button == 1)
  {
    moveUp = true;
  } else {
    moveUp = false;
  }

  if (moveUp == true) {
    bulletY = bulletY - 10;
  }

  if (bulletY <10) {
    bulletY = 650;
    moveUp = false;
  }

  if (bulletY < ellY + 50 && bulletY > ellY - 50 && bulletX < ellX + 50 && bulletX > ellX - 50) {
    ellX = 0;
    ellY = random (30, 400);
    moveRight = true;
    countY++;
  }
}

void serialEvent(Serial conn) {
  String fromSerial = conn.readString();

  if (fromSerial != null) {
    fromSerial = trim(fromSerial);

    String[] data = split(fromSerial, ',');
    printArray(data);

    if (data.length == 2) {
      button = float(data[0]);
    }
  }

  println(fromSerial);
}
