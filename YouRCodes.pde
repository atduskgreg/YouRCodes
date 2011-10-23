import oscP5.*;
import fsm.*;

FSM app;
State targetMode = new State(this, "enterTarget", "doTarget", "exitTarget");
State matchMode = new State(this, "enterMatch", "doMatch", "exitMatch");


OscP5 oscP5;
SavedFace targetFace;
SavedFace candidateFace;
SavedFace currentFace;


void setup() {
  size(1000,400);
  frameRate(25);
  background(0);
  
  app = new FSM(targetMode);

  oscP5 = new OscP5(this,8338);
  oscP5.plug(this,"mouthWidthReceived","/gesture/mouth/width");
  oscP5.plug(this,"mouthHeightReceived","/gesture/mouth/height");
  oscP5.plug(this,"eyebrowLeftReceived","/gesture/eyebrow/left");
  oscP5.plug(this,"eyebrowRightReceived","/gesture/eyebrow/right");
  oscP5.plug(this,"eyeLeftReceived","/gesture/eye/left");
  oscP5.plug(this,"eyeRightReceived","/gesture/eye/right");
  oscP5.plug(this,"jawReceived","/gesture/jaw");
  oscP5.plug(this,"nostrilsReceived","/gesture/nostrils");

  targetFace = new SavedFace();  
  candidateFace = new SavedFace();  
  
  currentFace = targetFace;
  
  enterTarget(); // FSM bug  
}

void draw() {  
  app.update();

  fill(255);
  text("target: " + targetFace.print(), 10,20);
  text("candidate: " + candidateFace.print(), 10,50);
  
  float score = targetFace.score(candidateFace);
  textSize(20);
  text("score: " + score, 10, 70);
  
}

public void mouthWidthReceived(float w){
   currentFace.mouthWidth = w;
}

public void mouthHeightReceived(float h){
  currentFace.mouthHeight = h;
}

public void eyebrowLeftReceived(float h){
  currentFace.eyebrowLeft = h;
}

public void eyebrowRightReceived(float h){
  currentFace.eyebrowRight = h;
}

public void eyeLeftReceived(float h){
  currentFace.eyeLeft = h;
}

public void eyeRightReceived(float h){
  currentFace.eyeRight = h;
}

public void jawReceived(float h){
  currentFace.jaw = h;
}

public void nostrilsReceived(float h){
  currentFace.nostrils = h;
}

void mousePressed(){
  if(app.isInState(targetMode)){
    currentFace = candidateFace;
    app.transitionTo(matchMode);
  }
}

void oscEvent(OscMessage theOscMessage) {
  /* with theOscMessage.isPlugged() you check if the osc message has already been
   * forwarded to a plugged method. if theOscMessage.isPlugged()==true, it has already 
   * been forwared to another method in your sketch. theOscMessage.isPlugged() can 
   * be used for double posting but is not required.
  */  
  if(theOscMessage.isPlugged()==false) {
  /* print the address pattern and the typetag of the received OscMessage */
  //println("### received an osc message.");
  //println("### addrpattern\t"+theOscMessage.addrPattern());
  //println("### typetag\t"+theOscMessage.typetag());
  }
}




