


#include "types.h"
/* radiohead: 433MHz communication library
 * https://github.com/pade/radiohead.git
 */
#include <RH_ASK.h>

// needed for radiohead to compile
#include <SPI.h>


/*
 * Number of input channel
 */
#define NB_CHANNEL 4


/*
 * Global data
 */
const unsigned int buttonPin[NB_CHANNEL] = {8, 9, 10, 11};
RH_ASK driver;

void setup() {

  unsigned int i;

  Serial.begin(9600);
  if (!driver.init())
         Serial.println("RF driver failed");
  
  // Initialize input pin for button
  for(i=0; i<NB_CHANNEL; i++)
  {
    // configure pin as input with the pullup
    pinMode(buttonPin[i], INPUT_PULLUP);
  }

}

void loop() {

  // dmxState and lastDmxState: must be keep at every loop, so declare as static
  /*static unsigned int dmxState[NB_CHANNEL] = {0, 0, 0, 0};
  static unsigned int lastDmxState[NB_CHANNEL] = {0, 0, 0, 0};
*/

  static int lastSendState[NB_CHANNEL] = {OFF, OFF, OFF, OFF};

  for( int i=0; i<NB_CHANNEL; i++)
  {
    String strtosend = "";
    strtosend += i;
    strtosend += ":";
    
    if ((getButtonOrder(i) == NO_CHANGE) && (getDmxOrder(i) == NO_CHANGE))
    {
      /* No new order, send last order */
      if (lastSendState[i] == ON)
        strtosend += "ON" ;
      else
        strtosend += "OFF";  
    }
    else if ((getButtonOrder(i) != NO_CHANGE) && (getDmxOrder(i) == NO_CHANGE))
    {
      /* New button order, send it*/
      if (getButtonOrder(i) == ON)
      {
        strtosend += "ON" ;
        lastSendState[i] = ON ;
      }   
      else
      {
        strtosend += "OFF" ;
        lastSendState[i] = OFF ;
      }
    }
    else if ((getButtonOrder(i) == NO_CHANGE) && (getDmxOrder(i) != NO_CHANGE))
    {
      /* New DMX order, send it*/
      if (getDmxOrder(i) == ON)
      {
        strtosend += "ON" ;
        lastSendState[i] = ON ;
      }   
      else
      {
        strtosend += "OFF" ;
        lastSendState[i] = OFF ;
      }
    }
    else
    {
      /* New button order AND new DMX order, at the same time
       * We priorize button order
       */
      if (getButtonOrder(i) == ON)
      {
        strtosend += "ON" ;
        lastSendState[i] = ON ;
      }   
      else
      {
        strtosend += "OFF" ;
        lastSendState[i] = OFF ;
      }       
    }
         
    /*
     * Send order
     */
    driver.send((uint8_t *)strtosend.c_str(), strtosend.length());
    driver.waitPacketSent();
  }

}

orderState_t getDmxOrder(unsigned int channel)
{
  /*
   * TODO
   */
   return NO_CHANGE;
}

orderState_t getButtonOrder(unsigned int channel)
{
  /*
   * Return 3 state order, according to selected channel
   *  - NO_CHANGE: same state as previous one
   *  - ORDER_OFF: button state switch to OFF (preceding state was ON)
   *  - ORDER_ON: button state switch to ON (preceding state was OFF)
   */
   
  // inputState and lastInputState: must be keep at every loop, so declare as static
  // initialze to -1 to force a return different from NO_CHANGE for the first call
  static int lastInputState[NB_CHANNEL] = {-1, -1, -1, -1};

  int buttonState = (int) readButton(channel);


  if (lastInputState[channel] != buttonState)
  {
    lastInputState[channel] = buttonState;
    if (buttonState == ON)
    {
      return ORDER_ON;    
    }
    else
    {
      return ORDER_OFF;
    }
  }
  else
  {
    return NO_CHANGE;
  }
}

unsigned int readButton(unsigned int channel)
{
  /* Return the state of input pin
   * @param channel: channel to read
   * Return value change on falling edge of the input pin:
   * 
   * OFF---ON-------------OFF------------
   * ______          _____      _________
   *       |________|     |____|
   *       
   * Nota: default state (button not pressed) is HIGH (pull-up)
   */
   
  int val;

  static unsigned int lastButton[NB_CHANNEL]= {HIGH, HIGH, HIGH, HIGH};
  static unsigned int lastReturnValue[NB_CHANNEL]= {OFF, OFF, OFF, OFF};

  val = digitalRead(buttonPin[channel]) ;
  if ((val == LOW) && (lastButton[channel] == HIGH)) 
  {
    //input is low and last state was high, means falling edge
    if  (lastReturnValue[channel] == ON)
    {
      lastReturnValue[channel] = OFF;
    }
    else
    {
      lastReturnValue[channel] = ON;
    }
    lastButton[channel] = val;
  }
  else
  {
    lastButton[channel] = val;
  }
  return lastReturnValue[channel];
}


