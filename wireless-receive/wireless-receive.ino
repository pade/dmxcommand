#include "types.h"
/* radiohead: 433MHz communication library
 * https://github.com/pade/radiohead.git
 */
#include <RH_ASK.h>

// needed for radiohead to compile
#include <SPI.h>


/*
 * Input channel affected to this board
 * TODO: select input thanks to a DIP switch
 */
#define CHANNEL 1

/*
 * Limited max message lenght to preserve RAM
 */
#define RH_ASK_MAX_MESSAGE_LEN 40

/*
 * Global varaible
 */
RH_ASK driver;

void setup() {

  pinMode(13, OUTPUT);
  for (int i=0; i<10; i++)
  {
    digitalWrite(13, HIGH);   // turn the LED on (HIGH is the voltage level)
    delay(100);              // wait
    digitalWrite(13, LOW);    // turn the LED off by making the voltage LOW
    delay(100);              // wait
  }

  Serial.begin(9600);
  Serial.println("Receiver initialisation...");
  if (!driver.init())
         Serial.println("RF driver failed");

}

void loop() {

  uint8_t buf[RH_ASK_MAX_MESSAGE_LEN];
  uint8_t buflen = sizeof(buf);
  char c;
  uint8_t *p;

  if (driver.recv(buf, &buflen)) // Non-blocking
  {
    // Message with a good checksum received, dump it.
    //driver.printBuffer("Got:", buf, buflen);
    Serial.write(buf, buflen);
    Serial.println("");

  }
}


