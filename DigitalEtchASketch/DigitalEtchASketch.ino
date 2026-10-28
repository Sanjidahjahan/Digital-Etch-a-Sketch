#define JOY_X 39
#define JOY_Y 32
#define JOY_SW 33
#define BUTTON_PIN 2
#define POT_PIN 36

void setup() {
  Serial.begin(9600);

  pinMode(JOY_SW, INPUT_PULLUP);
  pinMode(BUTTON_PIN, INPUT_PULLUP);
}

void loop() {
  int xVal = analogRead(JOY_X);
  int yVal = analogRead(JOY_Y);
  int joyClick = digitalRead(JOY_SW);
  int clearButton = digitalRead(BUTTON_PIN);
  int potValue = analogRead(POT_PIN);

  Serial.print(xVal);
  Serial.print(",");
  Serial.print(yVal);
  Serial.print(",");
  Serial.print(joyClick);
  Serial.print(",");
  Serial.print(clearButton);
  Serial.print(",");
  Serial.println(potValue);

  delay(20);
}

