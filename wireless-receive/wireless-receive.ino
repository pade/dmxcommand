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

  Serial.begin(9600);
  if (!driver.init())
         Serial.println("RF driver failed");

}

void loop() {

  uint8_t buf[RH_ASK_MAX_MESSAGE_LEN];
  uint8_t buflen = sizeof(buf);

  if (driver.recv(buf, &buflen)) // Non-blocking
  {
    // Message with a good checksum received, dump it.
    driver.printBuffer("Got:", buf, buflen);
  }
}
