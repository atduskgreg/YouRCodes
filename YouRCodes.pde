import oscP5.*;

OscP5 oscP5;
SavedFace targetFace;
SavedFace candidateFace;

boolean needsSave = false;


void setup() {
  size(1000,400);
  frameRate(25);
  background(0);

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

}

void draw() {
  background(0);  
  fill(255);
  text("target: " + targetFace.print(), 10,20);
  text("candidate: " + candidateFace.print(), 10,50);
  
  float score = targetFace.score(candidateFace);
  textSize(20);
  text("score: " + score, 10, 70);
}

public void mouthWidthReceived(float w){
  targetFace.mouthWidth = w;
}

public void mouthHeightReceived(float h){
  targetFace.mouthHeight = h;
}

public void eyebrowLeftReceived(float h){
  targetFace.eyebrowLeft = h;
}

public void eyebrowRightReceived(float h){
  targetFace.eyebrowRight = h;
}

public void eyeLeftReceived(float h){
  targetFace.eyeLeft = h;
}

public void eyeRightReceived(float h){
  targetFace.eyeRight = h;
}

public void jawReceived(float h){
  targetFace.jaw = h;
}

public void nostrilsReceived(float h){
  targetFace.nostrils = h;
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

void mousePressed(){
  needsSave = true;
}


