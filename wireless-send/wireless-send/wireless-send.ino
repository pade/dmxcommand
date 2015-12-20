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
const unsigned int buttonPin[NB_CHANNEL] = {6, 7, 8, 9}; // pin of inputs buttons
const unsigned int ledPin[NB_CHANNEL] = {2, 3, 4, 5}; // pin of output led

RH_ASK driver;
String inputString = "";         // a string to hold incoming data
boolean stringComplete = false;  // whether the string is complete
String dmxOrder[NB_CHANNEL] = {"OFF", "OFF", "OFF", "OFF"};

void setup() {

  unsigned int i;

  Serial.begin(9600);
  Serial.println("Sender initialisation...");
  // reserve 50 bytes for the inputString:
  inputString.reserve(50);
  
  pinMode(13, OUTPUT);
  for (i=0; i<10; i++)
  {
    digitalWrite(13, HIGH);   // turn the LED on (HIGH is the voltage level)
    delay(100);              // wait
    digitalWrite(13, LOW);    // turn the LED off by making the voltage LOW
    delay(100);              // wait
  }
  if (!driver.init())
    Serial.println("RF driver failed");

  // Initialize input pin for button an doutput pin for led
  for (i = 0; i < NB_CHANNEL; i++)
  {
    // configure pin as input with the pullup
    pinMode(buttonPin[i], INPUT_PULLUP);

    // configure pin as ouput
    pinMode(ledPin[i], OUTPUT);
  }
  

}

void loop() {

  /* Get DMX data from serial line */
  serialEvent();

  static int lastSendState[NB_CHANNEL] = {OFF, OFF, OFF, OFF};

  for ( int i = 0; i < NB_CHANNEL; i++)
  {
    String strtosend = "";
    strtosend += i;
    strtosend += ":";

    orderState_t buttonOrder = getButtonOrder(i) ;
    orderState_t dmxOrder = getDmxOrder(i);
    //orderState_t dmxOrder = NO_CHANGE;

    if ((buttonOrder == NO_CHANGE) && (dmxOrder == NO_CHANGE))
    {
      /* No new order, send last order */
      if (lastSendState[i] == ON)
      {
        strtosend += "ON" ;
        digitalWrite(ledPin[i], HIGH);
      }
      else
      {
        strtosend += "OFF";
        digitalWrite(ledPin[i], LOW);
      }
    }
    else if ((buttonOrder != NO_CHANGE) && (dmxOrder == NO_CHANGE))
    {
      /* New button order, send it*/
      if (buttonOrder == ORDER_ON)
      {
        strtosend += "ON" ;
        lastSendState[i] = ON ;
        digitalWrite(ledPin[i], HIGH);
      }
      else
      {
        strtosend += "OFF" ;
        lastSendState[i] = OFF ;
        digitalWrite(ledPin[i], LOW);
      }
    }
    else if ((buttonOrder == NO_CHANGE) && (dmxOrder != NO_CHANGE))
    {
      /* New DMX order, send it*/
      if (getDmxOrder(i) == ORDER_ON)
      {
        strtosend += "ON" ;
        lastSendState[i] = ON ;
        digitalWrite(ledPin[i], HIGH);
      }
      else
      {
        strtosend += "OFF" ;
        lastSendState[i] = OFF ;
        digitalWrite(ledPin[i], LOW);
      }
    }
    else
    {
      /* New button order AND new DMX order, at the same time
       * We priorize button order
       */
      if (buttonOrder == ORDER_ON)
      {
        strtosend += "ON" ;
        lastSendState[i] = ON ;
        digitalWrite(ledPin[i], HIGH);
      }
      else
      {
        strtosend += "OFF" ;
        lastSendState[i] = OFF ;
        digitalWrite(ledPin[i], LOW);
      }
    }

    /*
     * Send order
     */
    //Serial.println(strtosend);
    driver.send((uint8_t *)strtosend.c_str(), strtosend.length());
    driver.waitPacketSent();
  }
  delay(200);

}

orderState_t getDmxOrder(unsigned int channel)
{
   /*
   * Return 3 state order, according to input channel (read from serial line)
   *  - NO_CHANGE: same state as previous one
   *  - ORDER_OFF: button state switch to OFF (preceding state was ON)
   *  - ORDER_ON: button state switch to ON (preceding state was OFF)
   */
   
  // lastDmxState: must be keep at every loop, so declare as static
  // initialize to -1 to force a return different from NO_CHANGE for the first call
  static int lastDmxState[NB_CHANNEL] = { -1, -1, -1, -1};

  //Serial.println(channel);
  //Serial.println(dmxOrder[channel]);
    
  /* This order is for our channel */
  if (dmxOrder[channel] == "ON")
  {
    if (lastDmxState[channel] != ORDER_ON)
    {
      /* New ON order */
      lastDmxState[channel] = ORDER_ON;
      Serial.println("Change ON");
      return ORDER_ON;
    }
  }
  else if (dmxOrder[channel] == "OFF")
  {
    if (lastDmxState[channel] != ORDER_OFF)
    {
      /* New OFF order */
      lastDmxState[channel] = ORDER_OFF;
      Serial.println("Change OFF");
      return ORDER_OFF;
    }
  }

  /* in all other cases, return NO_CHANGE */
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

  // lastInputState: must be keep at every loop, so declare as static
  // initialize to -1 to force a return different from NO_CHANGE for the first call
  static int lastInputState[NB_CHANNEL] = { -1, -1, -1, -1};

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

  static unsigned int lastButton[NB_CHANNEL] = {HIGH, HIGH, HIGH, HIGH};
  static unsigned int lastReturnValue[NB_CHANNEL] = {OFF, OFF, OFF, OFF};

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


void serialEvent()
{
  /*
  SerialEvent occurs whenever a new data comes in the
 hardware serial RX.  This routine is run between each
 time loop() runs.  Multiple bytes of data may be available.
 */
  while (Serial.available())
  {
    int channel;
    String order;
    // get the new byte:
    char inChar = (char)Serial.read();
    // add it to the inputString:
    inputString += inChar;
    // if the incoming character is a newline, fill dmxOrder table
    if (inChar == '\n')
    {
      //Serial.println(inputString);
      if ((channel = splitInputString(inputString, &order)) != 0)
      {
        /* Save new dmxOrder */
        dmxOrder[channel-1] = order ;
      }
      else
      {
        
      /* Error: receive order is not correct */
      /* DMX order not taking into account */
      }

      // reset inputString
      inputString = "";
      break;
    }
  }
}

int splitInputString(String input, String *order)
{
  /* Split 'input' parameter order
   *  'input' must be like: "<channel number>:ON|OFF"
   *  - return the input channel, or 0 in case of error
   *  - fill 'order' parameter to the receive order
   */

  int channel;
  
  if ((channel = input.substring(0).toInt()) == 0)
  {
    /* channel is 0: means an transmit error */
    /* Set return_value to an empty String */
    *order = "" ;
    Serial.println("ERROR CHANNEL");  
    return 0;
  }

  if (channel > NB_CHANNEL)
  {
    /* channel out of range */
     *order = "" ;
     return 0;
  }
  
  *order = input.substring(2, input.length());

  if((*order).startsWith("ON"))
  {
    *order = "ON";
    return channel;
  }
  else if((*order).startsWith("OFF"))
  {
    *order = "OFF";
    return channel;
  }
  // Error: order not recognize
  return 0;
}

