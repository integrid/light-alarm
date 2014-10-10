#include <Adafruit_NeoPixel.h>

#define PIN 6

#define MODE_IDLE 0
#define MODE_WAKE 1

Adafruit_NeoPixel strip = Adafruit_NeoPixel(60, PIN, NEO_GRB + NEO_KHZ800);
uint32_t startTime;
uint32_t duration;
uint32_t color;

uint8_t mode;

String inputString;
boolean inputStringComplete = false;

void setup() {
  Serial.begin(9600);
  inputString.reserve(32);

  strip.begin();
  strip.show(); // Initialize all pixels to 'off'

  mode = MODE_IDLE;
}

void loop() {
  if (inputStringComplete) {
    if (inputString.startsWith("trigger")) {
      String r = inputString.substring(7, 10);
      String g = inputString.substring(10, 13);
      String b = inputString.substring(13, 16);
      String l = inputString.substring(16);
      color = strip.Color(r.toInt(), g.toInt(), b.toInt());
      startTime = millis();
      duration = l.toInt() * 60000;  // minutes to milli
      mode = MODE_WAKE;
    } else if (inputString.startsWith("set")) {
      String r = inputString.substring(3, 6);
      String g = inputString.substring(6, 9);
      String b = inputString.substring(9, 12);
      String brightness = inputString.substring(12, 15);
      stripSet(strip.Color(r.toInt(), g.toInt(), b.toInt()), brightness.toInt());
      strip.show();
      mode = MODE_IDLE;
    } else if (inputString.startsWith("stop")) {
      stripSet(strip.Color(0, 0, 0), 0);  // turn off lights
      mode = MODE_IDLE;
    }
    inputString = "";
    inputStringComplete = false;
  }
  switch (mode) {
    case MODE_WAKE:
      uint32_t curTime = millis() - startTime;
      stripSet(color, curTime * 255 / duration);
      break;
  }
  delay(5000);
}

void serialEvent() {
  while (Serial.available()) {
    char inChar = (char) Serial.read();
    if (inChar == '\n') {
      // TODO: copy to separate string to avoid potential read/write conflict
      inputStringComplete = true;
      break;
    } else {
      inputString += inChar;
    }
  }
}

void stripSet(uint32_t c, uint32_t brightness) {
  for (uint8_t i = 0; i < strip.numPixels(); i++) {
    strip.setPixelColor(i, c);
  }
  strip.setBrightness(min(255, max(1, brightness)));
  strip.show();
}
