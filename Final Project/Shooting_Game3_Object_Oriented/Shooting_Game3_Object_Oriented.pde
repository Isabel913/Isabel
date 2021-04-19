import processing.serial.*;

Serial myConnection;

String serialValue = ",";

float button = 0;
float potentiometer = 0;
float pressure = 0;

boolean moveRight = true; //this is for birds starts moving right
boolean moveUp = false; //this is for gun starts off not moving

boolean bullet = true;

int countA = 0; //score for birds
int countY = 0; //score for hunter

PFont font;
PImage background;

PImage arrow;

Bird myBird;
ArrayList<Arrow> arrows;


void setup () {
  size (700, 700);
  
  background = loadImage("bg.png");
  
  arrow = loadImage("arrow.png");
  font = loadFont("Arial-BoldMT-24.vlw");

  myBird = new Bird();

  arrows = new ArrayList<Arrow>();
  arrows.add(new Arrow());
  
  
  printArray(Serial.list());
  myConnection = new Serial(this, Serial.list()[1], 9600);
  myConnection.bufferUntil('\n');

}

void draw () {

  image(background, 0, 0);
  textFont (font);
  fill (0, 0, 0);
  text("Birds", 50, 50);
  text (countA, 230, 50); // score for birds
  text ("Hunter", 450, 50);
  text (countY, 570, 50); //score for hunter

  myBird.posX = map(pressure, 50, 4000, 0, 700);

  myBird.birdFly();
  myBird.display();

  for (Arrow a : arrows) {
    a.display();
    a.shoot();
    if(a.checkHit(myBird.posX, myBird.posY) == true){
      myBird.die();
      countY= countY+1;
      break;
    }
  }
}

//void hit() {

//  for (Bird b : birds) {
//    if (b.radius > dist(mouseX, mouseY, b.posX, b.posY)) {
//      b.moveRight = false;
//      b.posX = b.posX+500;
//      break;
//    }
//  }
//  for (Arrow a : arrows) {
//    if (a.posY >= 10) {
//      a.moveUp = false;
//      a.posY = 350;
//      break;
//    }
//  }



//println(rotationAngle);

//pushMatrix();
//translate(350, 600);
//rotate(rotationAngle); 

//fill (255); 
//rect (0, 0, 20, 100); //gun

//popMatrix();
//if (b.display()=a.display()){
//  moveRight = false;
  
//}


//if (a.posY < b.radius + 50 && a.posY > b.radius - 50 && a.posX < b.radius + 50 && a.posX > b.radius - 50) {
//  moveRight = false;
//  countY++;
//}


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
