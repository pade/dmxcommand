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
const unsigned int buttonPin[NB_CHANNEL] = {8, 9, 10, 11}; // pin of inputs buttons
RH_ASK driver;
String inputString = "";         // a string to hold incoming data
boolean stringComplete = false;  // whether the string is complete

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

  // Initialize input pin for button
  for (i = 0; i < NB_CHANNEL; i++)
  {
    // configure pin as input with the pullup
    pinMode(buttonPin[i], INPUT_PULLUP);
  }
  

}

void loop() {

  /* Get DMX data from serial line */
  serialEvent();
  
  // dmxState and lastDmxState: must be keep at every loop, so declare as static
  /*static unsigned int dmxState[NB_CHANNEL] = {0, 0, 0, 0};
  static unsigned int lastDmxState[NB_CHANNEL] = {0, 0, 0, 0};
  */

  static int lastSendState[NB_CHANNEL] = {OFF, OFF, OFF, OFF};

  for ( int i = 0; i < NB_CHANNEL; i++)
  {
    String strtosend = "";
    strtosend += i;
    strtosend += ":";

    orderState_t buttonOrder = getButtonOrder(i) ;;
    orderState_t dmxOrder = getDmxOrder(i);

    if ((buttonOrder == NO_CHANGE) && (dmxOrder == NO_CHANGE))
    {
      /* No new order, send last order */
      if (lastSendState[i] == ON)
        strtosend += "ON" ;
      else
        strtosend += "OFF";
    }
    else if ((buttonOrder != NO_CHANGE) && (dmxOrder == NO_CHANGE))
    {
      /* New button order, send it*/
      if (buttonOrder == ORDER_ON)
      {
        strtosend += "ON" ;
        lastSendState[i] = ON ;
        digitalWrite(13, HIGH);

      }
      else
      {
        strtosend += "OFF" ;
        lastSendState[i] = OFF ;
        digitalWrite(13, LOW);
      }
    }
    else if ((buttonOrder == NO_CHANGE) && (dmxOrder != NO_CHANGE))
    {
      /* New DMX order, send it*/
      if (getDmxOrder(i) == ORDER_ON)
      {
        strtosend += "ON" ;
        lastSendState[i] = ON ;
        digitalWrite(13, HIGH);
      }
      else
      {
        strtosend += "OFF" ;
        lastSendState[i] = OFF ;
        digitalWrite(13, LOW);
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
        digitalWrite(13, HIGH);
      }
      else
      {
        strtosend += "OFF" ;
        lastSendState[i] = OFF ;
        digitalWrite(13, LOW);
      }
    }

    /*
     * Send order
     */
    //Serial.println(strtosend);
    driver.send((uint8_t *)strtosend.c_str(), strtosend.length());
    driver.waitPacketSent();
    delay(200);
  }

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

  String inputOrder[NB_CHANNEL];

  /* if a new order is received */
  if (stringComplete)
  {
    Serial.println("INPUT: " + inputString);
    splitInputString(inputString, inputOrder) ;
    Serial.println("CH VAL: " + inputOrder[channel]);
    
    /* This order is for our channel */
    if (inputOrder[channel] == "ON")
    {
      if (lastDmxState[channel] != ORDER_ON)
      {
        /* New ON order */
        lastDmxState[channel] = ORDER_ON;
        return ORDER_ON;
      }
    }
    else if (inputOrder[channel] == "OFF")
    {
      if (lastDmxState[channel] != ORDER_OFF)
      {
        /* New OFF order */
        lastDmxState[channel] = ORDER_OFF;
        return ORDER_OFF;
      }
    }
    // clear the string
    inputString = "";
    stringComplete = false; 
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

/*
  SerialEvent occurs whenever a new data comes in the
 hardware serial RX.  This routine is run between each
 time loop() runs.  Multiple bytes of data may be available.
 */
void serialEvent()
{
  while (Serial.available())
  {
    // get the new byte:
    char inChar = (char)Serial.read();
    // add it to the inputString:
    inputString += inChar;
    // if the incoming character is a newline, set a flag
    // so the main loop can do something about it:
    if (inChar == '\n')
    {
      stringComplete = true;
    }
  }
}

void splitInputString(String input, String return_value[NB_CHANNEL])
{
  char *data[64]= {0};
  char *token, *subtoken;
  int i = 0, channel;

  // Copy input string
  input.toCharArray(*data, sizeof(data));

  while ((data != NULL) && (i < NB_CHANNEL))
  {
    token = strsep(data, "&");
    subtoken = strsep(&token, ":");
    channel = atoi(subtoken);
    return_value[channel] = String(token);
    i++;
  }
}

