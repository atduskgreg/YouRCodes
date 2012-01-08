// TODO:
// - check to see when we lose a face and consider no-face a fail

import oscP5.*;

OscP5 oscP5;
SavedFace currentFace;
ArrayList<SavedFace> candidateFaces;

PImage matchedImage;

String[] faces = {"elliot", "greg", "james"};

void setup() {
  size(575, 544);
  frameRate(30);
  background(0);


  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
  oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
  oscP5.plug(this, "eyebrowLeftReceived", "/gesture/eyebrow/left");
  oscP5.plug(this, "eyebrowRightReceived", "/gesture/eyebrow/right");
  oscP5.plug(this, "eyeLeftReceived", "/gesture/eye/left");
  oscP5.plug(this, "eyeRightReceived", "/gesture/eye/right");
  oscP5.plug(this, "jawReceived", "/gesture/jaw");
  oscP5.plug(this, "nostrilsReceived", "/gesture/nostrils");

  currentFace = new SavedFace(); 
  
  candidateFaces = new ArrayList();
  
  for(int i = 0; i < faces.length; i++){
    SavedFace f = new SavedFace();
    f.load(this, "yourcode_"+faces[i]+".xml");
    println("loading: yourcode_"+faces[i]+".xml" );
    candidateFaces.add(f);
  }
}



void draw() {  
  background(0);
  fill(255);
  String output = "";
  for(int i = 0; i < candidateFaces.size(); i++){
    SavedFace testFace = candidateFaces.get(i);
    output += "Face " + i + ": " + testFace.score(currentFace) + "\n";
    if(testFace.match(currentFace)){
      matchedImage = testFace.img;
    }
  }
  
  text(output, 10, 40);
  
  if(matchedImage != null){
    image(matchedImage, width-408, 0, 408, 544);
  } else {
    fill(175);
    stroke(0);
    rect(width-408, 0, 408, 544);
    fill(0);
    text("no image", 408/2 + 125, height/2);
  }
  

}

public void mouthWidthReceived(float w) {
  currentFace.mouthWidth = w;
}

public void mouthHeightReceived(float h) {
  currentFace.mouthHeight = h;
}

public void eyebrowLeftReceived(float h) {
  currentFace.eyebrowLeft = h;
}

public void eyebrowRightReceived(float h) {
  currentFace.eyebrowRight = h;
}

public void eyeLeftReceived(float h) {
  currentFace.eyeLeft = h;
}

public void eyeRightReceived(float h) {
  currentFace.eyeRight = h;
}

public void jawReceived(float h) {
  currentFace.jaw = h;
}

public void nostrilsReceived(float h) {
  currentFace.nostrils = h;
}



void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.isPlugged()==false) {
    //println("UNPLUGGED: " + theOscMessage);
  }
}

