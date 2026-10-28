
import processing.serial.*;

Serial myPort;
PGraphics drawingLayer;

int joyX = 2048;
int joyY = 2048;
int joyClick = 1;
int clearButton = 1;
int potValue = 2048;

int brushSize = 4;
int brushSizeIndex = 0;

int[] brushSizes = {4, 7, 10};
boolean wasJoyClickPressed = false;
boolean wasClearPressed = false;

float penX;
float penY;
float previousX;
float previousY;

int screenX = 115;
int screenY = 130;
int screenW = 570;
int screenH = 370;

color[] penColors = {
  #6DA230,  // Green
  #FFFF64,  // Yellow
  #FF964F,  // Orange
  #002D69,  // Navy blue
  #14AEDC   // Sky blue
};

void setup() {
  size(800, 620);
  pixelDensity(1);
  smooth();

  drawingLayer = createGraphics(screenW, screenH);
  drawingLayer.beginDraw();
  drawingLayer.background(#F6E5E5);
  drawingLayer.endDraw();

  penX = screenW / 2;
  penY = screenH / 2;
  previousX = penX;
  previousY = penY;

  println(Serial.list());

  myPort = new Serial(
    this,
    "/dev/cu.wchusbserial5C491319521",
    9600
  );

  myPort.bufferUntil('\n');
}

void draw() {
  // Joystick movementkkk   kk
  float speedX = map(joyX, 0, 4095, -6, 6);
  float speedY = map(joyY, 0, 4095, -6, 6);

  if (abs(joyX - 2048) < 350) {
    speedX = 0;
  }

  if (abs(joyY - 2048) < 350) {
    speedY = 0;
  }

  penX = constrain(penX + speedX, 0, screenW - 1);
  penY = constrain(penY + speedY, 0, screenH - 1);

  // Toggle brush size with joystick click
  boolean joyPressed = joyClick == 0;

if (joyPressed && !wasJoyClickPressed) {
  brushSizeIndex++;

  if (brushSizeIndex >= brushSizes.length) {
    brushSizeIndex = 0;
  }

  brushSize = brushSizes[brushSizeIndex];
}

  wasJoyClickPressed = joyPressed;

  // Clear drawing with yellow button
  boolean clearPressed = clearButton == 0;

  if (clearPressed && !wasClearPressed) {
    drawingLayer.beginDraw();
    drawingLayer.background(#F6E5E5);
    drawingLayer.endDraw();

    previousX = penX;
    previousY = penY;
  }

  wasClearPressed = clearPressed;

  // Potentiometer selects one of five pen colors
  int colorIndex = int(map(potValue, 0, 4095, 0, 5));
  colorIndex = constrain(colorIndex, 0, 4);

  color penColor = penColors[colorIndex];

  // Draw inside the screen
  drawingLayer.beginDraw();
  drawingLayer.stroke(penColor);
  drawingLayer.strokeWeight(brushSize);
  drawingLayer.strokeCap(ROUND);
  drawingLayer.line(previousX, previousY, penX, penY);
  drawingLayer.endDraw();

  previousX = penX;
  previousY = penY;

  // Background outside the toy
  background(235);

  // Main frame shadow
  noStroke();
  fill(105, 0, 0);
  rect(22, 25, 756, 570, 30);

  // Deep red frame
  fill(#AE0000);
  rect(28, 30, 744, 555, 25);

  // Screen shadow
  fill(75, 0, 0);
  rect(screenX - 5, screenY - 5,
       screenW + 10, screenH + 10, 22);

  // Drawing surface
  image(drawingLayer, screenX, screenY);

  // Screen border
  noFill();
  stroke(130, 0, 0);
  strokeWeight(5);
  rect(screenX - 3, screenY - 3,
       screenW + 6, screenH + 6, 20);

  // Gold title
  fill(#BF9B30);
  noStroke();
  textAlign(CENTER, CENTER);
  textSize(45);
  text("Etch A Sketch", width / 2, 76);

  // Decorative labels
  textSize(22);
  text("MAGIC", 145, 75);
  text("SCREEN", 645, 75);
  
  fill(#BF9B30);
textAlign(CENTER, CENTER);
textSize(15);
text("BRUSH: " + brushSize + "  |  COLOR: " + getColorName(colorIndex), width / 2, 105);

  // Bottom red panel
  noStroke();
  fill(#AE0000);
  rect(30, 515, 740, 65, 15);

  // White knobs
  drawKnob(85, 550);
  drawKnob(715, 550);
}

void drawKnob(float x, float y) {
  noStroke();

  // Shadow
  fill(75, 0, 0);
  ellipse(x + 2, y + 4, 88, 88);

  // White knob
  fill(250);
  ellipse(x, y, 82, 82);

  fill(240);
  ellipse(x, y, 67, 67);

  fill(248);
  ellipse(x - 2, y - 2, 58, 58);

  // Knob ridges
  stroke(225);
  strokeWeight(1);

  for (int i = 0; i < 36; i++) {
    float angle = TWO_PI * i / 36.0;

    float x1 = x + cos(angle) * 34;
    float y1 = y + sin(angle) * 34;
    float x2 = x + cos(angle) * 38;
    float y2 = y + sin(angle) * 38;

    line(x1, y1, x2, y2);
  }

  noStroke();
}

void serialEvent(Serial p) {
  String data = p.readStringUntil('\n');

  if (data != null) {
    data = trim(data);
    String[] values = split(data, ',');

    if (values.length == 5) {
      try {
        joyX = int(values[0]);
        joyY = int(values[1]);
        joyClick = int(values[2]);
        clearButton = int(values[3]);
        potValue = int(values[4]);
      }
      catch (Exception e) {
        println("Could not read sensor data: " + data);
      }
    }
  }
}

String getColorName(int index) {
  if (index == 0) return "GREEN";
  if (index == 1) return "YELLOW";
  if (index == 2) return "ORANGE";
  if (index == 3) return "NAVY";
  if (index == 4) return "SKY BLUE";
  return "GREEN";
}
