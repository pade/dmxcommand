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
#define CHANNEL '3'

/*
 * Limited max message lenght to preserve RAM
 */
//#define RH_ASK_MAX_MESSAGE_LEN 40

/*
 * Global varaible
 */
RH_ASK driver;

void setup() {

  pinMode(LED_BUILTIN, OUTPUT);
  for (int i=0; i<10; i++)
  {
    digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
    delay(100);              // wait
    digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
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

  if (driver.recv(buf, &buflen)) // Non-blocking
  {
    // Message with a good checksum received, dump it.
    //Serial.write(buf, buflen);
    //Serial.println("");

    // Check if message is for our channel
    if((buf[0] == CHANNEL) && (buf[1] == ':'))
    {
      // Get order from message
      if((buf[2] == 'O') && (buf[3] == 'N'))
      {
        // TODO: ON
        //Serial.println("ON");
        digitalWrite(LED_BUILTIN, HIGH);
      }
      else if((buf[2] == 'O') && (buf[3] == 'F') && (buf[4] == 'F'))
      {
        // TODO: OFF
        //Serial.println("OFF");
        digitalWrite(LED_BUILTIN, LOW);
      }
    }
  }
}


