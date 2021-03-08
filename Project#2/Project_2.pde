import processing.serial.*;

Serial myConnection;

//float radius = 0;
float rStep = 30;
float rMax = 400;
float circleHue = random(0,360);
float circleSat = 100;

float background = 0;

color[] colArray = new color[6];

int colArrayCounter;


void setup() {
  size(800, 800);
  surface.setLocation(987, 70);
  noStroke();
  frameRate(10);
  
  randomColor();
  colorMode(HSB, 360, 100, 100);

  printArray(Serial.list());
  myConnection = new Serial(this, Serial.list()[1], 9600);
  myConnection.bufferUntil('\n');
}

void draw() {

  background(0,0,0);
  
  if (background == 1) {
    circleHue = random(0,360);
    randomColor();
  } 

  translate(width/2, height/2);


  for (float r=0; r<rMax; r+=rStep) {

    float c = 2*PI*r;
    float cSegment = map(r, 0, rMax, rStep*3/4, rStep/2);
    float aSegment = floor(c/cSegment);
    float ellipseSize = map(r, 0, rMax, rStep*3/4-1, rStep/4);


    for (float a=0; a<360; a+=360/aSegment) {
      colArrayCounter++;
      if (colArrayCounter>5) colArrayCounter=0;
      fill(colArray[colArrayCounter]);

      //fill(colArray[int(random(5))]);

      pushMatrix();
      rotate(radians(a));
      ellipse(r, 0, ellipseSize, ellipseSize);
      popMatrix();
    }
  }
}

void serialEvent(Serial conn) {
  String fromSerial = conn.readString();

  if (fromSerial != null) {
    fromSerial = trim(fromSerial);

    String[] data = split(fromSerial, ',');
    printArray(data);

    if (data.length == 2) {
      background = float(data[0]);

      rMax = float(data[1]);
      rMax = map(rMax, 0, 4096, 0, 360);
    }
  }

  println(fromSerial);
}

void randomColor(){
  for(int i = 0; i < colArray.length; i++){
    colArray[i] = color(circleHue, circleSat, 100);
    circleSat = circleSat -20;
  }
}
