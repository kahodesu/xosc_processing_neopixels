/////////////////////////////////////////////////////
///////  NEOPIXELS WITH XOSC   //////////////////////
/////////////////////////////////////////////////////
//Based on....                                     //
//RGB Control with Processing Example              //
//http://www.x-io.co.uk/rgb-control-with-processing//
//Send Simple Message by Ad Spiers - 12 Feb 2014   //
//and sent to X-OSC led via OSCP5 and netP5        //
//oscP5 website at http://www.sojamo.de/oscP5      //
/////////////////////////////////////////////////////

//LIBRARIES
import oscP5.*; 
import netP5.*; 

//OSC VARIABLES
OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(255, 255); 
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 9000 */
  oscP5 = new OscP5(this, 9000);
  /* IP Address of the X-OSC */
  myRemoteLocation = new NetAddress("169.254.1.1", 9000);
}

void draw() {
  OscMessage myMessage = new OscMessage("/outputs/rgb/16"); //address pattern

  byte[] blob = { //this is the blob where all the RGB info goes
    byte(255), byte(182), byte(193),  //First Neopixel R,G,B (light pink)
    byte(51), byte(161), byte(201),   //Second Neopixel R,G,B (teal)
    byte(154), byte(205), byte(50)    //Third Neopixel R,G,B (olive)
    };
    
  myMessage.add(blob); //puts blob into message
  //println(" myMessage: "+myMessage); //FOR DEBUG
  oscP5.send(myMessage, myRemoteLocation);//sends blob over
}

/* This handles incoming messages, we are not using this right now */
/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}

