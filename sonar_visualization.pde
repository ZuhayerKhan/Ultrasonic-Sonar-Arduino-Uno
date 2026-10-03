import processing.serial.*;

Serial myPort;

String angle = "";
String distance = "";
String data = "";
String noObject;

float pixsDistance;

int iAngle = 0;
int iDistance = 0;

int index1 = 0;

void setup() {

  size(1200, 700);
  smooth();

  myPort = new Serial(this, "COM3", 9600);
  myPort.bufferUntil('.');
}


void draw() {

  fill(98, 245, 31);

  noStroke();

  fill(0, 4);

  rect(
    0,
    0,
    width,
    height - height * 0.065
  );

  fill(98, 245, 31);

  drawRadar();

  drawLine();

  drawObject();

  drawText();
}


void serialEvent(Serial myPort) {

  data = myPort.readStringUntil('.');

  if (data != null) {

    data = trim(data);

    if (data.length() > 1) {

      data = data.substring(
        0,
        data.length() - 1
      );

      index1 = data.indexOf(",");

      if (index1 > 0) {

        angle = data.substring(
          0,
          index1
        );

        distance = data.substring(
          index1 + 1
        );

        iAngle = int(angle);

        iDistance = int(distance);
      }
    }
  }
}


void drawRadar() {

  pushMatrix();

  translate(
    width / 2,
    height - height * 0.074
  );

  noFill();

  strokeWeight(2);

  stroke(
    98,
    245,
    31
  );

  // 10 cm
  arc(
    0,
    0,
    width - width * 0.0625,
    width - width * 0.0625,
    PI,
    TWO_PI
  );

  // 20 cm
  arc(
    0,
    0,
    width - width * 0.27,
    width - width * 0.27,
    PI,
    TWO_PI
  );

  // 30 cm
  arc(
    0,
    0,
    width - width * 0.479,
    width - width * 0.479,
    PI,
    TWO_PI
  );

  // 40 cm
  arc(
    0,
    0,
    width - width * 0.687,
    width - width * 0.687,
    PI,
    TWO_PI
  );

  // Horizontal line
  line(
    -width / 2,
    0,
    width / 2,
    0
  );

  // Angle lines
  line(
    0,
    0,
    (-width / 2) * cos(radians(30)),
    (-width / 2) * sin(radians(30))
  );

  line(
    0,
    0,
    (-width / 2) * cos(radians(60)),
    (-width / 2) * sin(radians(60))
  );

  line(
    0,
    0,
    (-width / 2) * cos(radians(90)),
    (-width / 2) * sin(radians(90))
  );

  line(
    0,
    0,
    (-width / 2) * cos(radians(120)),
    (-width / 2) * sin(radians(120))
  );

  line(
    0,
    0,
    (-width / 2) * cos(radians(150)),
    (-width / 2) * sin(radians(150))
  );

  popMatrix();
}


void drawObject() {

  pushMatrix();

  translate(
    width / 2,
    height - height * 0.074
  );

  strokeWeight(8);

  stroke(
    255,
    10,
    10
  );

  // Convert cm to pixels
  pixsDistance =
    iDistance *
    ((height - height * 0.1666) * 0.025);

  // Only show objects within 40 cm
  if (iDistance > 0 && iDistance < 40) {

    line(
      pixsDistance * cos(radians(iAngle)),
      -pixsDistance * sin(radians(iAngle)),

      (width - width * 0.505) *
        cos(radians(iAngle)),

      -(width - width * 0.505) *
        sin(radians(iAngle))
    );
  }

  popMatrix();
}


void drawLine() {

  pushMatrix();

  translate(
    width / 2,
    height - height * 0.074
  );

  strokeWeight(6);

  stroke(
    30,
    250,
    60
  );

  line(
    0,
    0,

    (height - height * 0.12) *
      cos(radians(iAngle)),

    -(height - height * 0.12) *
      sin(radians(iAngle))
  );

  popMatrix();
}


void drawText() {

  pushMatrix();

  if (iDistance > 40) {

    noObject = "Out of Range";

  } else {

    noObject = "Object Detected";
  }

  fill(0);

  noStroke();

  rect(
    0,
    height - height * 0.0648,
    width,
    height
  );

  fill(
    98,
    245,
    31
  );

  textSize(25);

  text(
    "10cm",
    width - width * 0.3854,
    height - height * 0.0833
  );

  text(
    "20cm",
    width - width * 0.281,
    height - height * 0.0833
  );

  text(
    "30cm",
    width - width * 0.177,
    height - height * 0.0833
  );

  text(
    "40cm",
    width - width * 0.0729,
    height - height * 0.0833
  );

  textSize(36);

  text(
    "ULTRASONIC RADAR",
    width - width * 0.875,
    height - height * 0.0277
  );

  text(
    "Angle: " + iAngle + " °",
    width - width * 0.48,
    height - height * 0.0277
  );

  text(
    "Distance: " + iDistance + " cm",
    width - width * 0.26,
    height - height * 0.0277
  );

  textSize(25);

  fill(
    98,
    245,
    60
  );

  text("30°", 100, 445);

  text("60°", 250, 245);

  text("90°", 575, 165);

  text("120°", 870, 245);

  text("150°", 1020, 445);

  popMatrix();
}
