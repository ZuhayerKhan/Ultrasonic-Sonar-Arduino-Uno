#include <Servo.h>

const int trigPin = 10;
const int echoPin = 11;

Servo myServo;

long duration;
int distance;

void setup() {
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  Serial.begin(9600);

  myServo.attach(12);
}

void loop() {

  // Sweep 15° to 165°
  for (int angle = 15; angle <= 165; angle++) {

    myServo.write(angle);
    delay(15);

    distance = calculateDistance();

    Serial.print(angle);
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");
  }

  // Sweep 165° to 15°
  for (int angle = 165; angle >= 15; angle--) {

    myServo.write(angle);
    delay(15);

    distance = calculateDistance();

    Serial.print(angle);
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");
  }
}

int calculateDistance() {

  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);

  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);

  digitalWrite(trigPin, LOW);

  duration = pulseIn(echoPin, HIGH, 30000);

  if (duration == 0) {
    return 400;
  }

  distance = duration * 0.0343 / 2;

  return distance;
}