// TODO:
// - implement faceactions on detection
// - action to add a face?

import oscP5.*;

OscP5 oscP5;
SavedFace currentFace;
ArrayList<SavedFace> candidateFaces;

SavedFace matchedFace;

String[] faces = {
  "bazaar", "bicego", "aspinal"
};

boolean hasFace = false;

void setup() {
  size(575, 544);
  frameRate(30);
  background(0);

   currentFace = new SavedFace(); 

  candidateFaces = new ArrayList();

  for (int i = 0; i < faces.length; i++) {
    SavedFace f = new SavedFace();
    f.load(this, "yourcode_"+faces[i]+".xml");
    println("loading: yourcode_"+faces[i]+".xml" );
    candidateFaces.add(f);
  }

  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
  oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
  oscP5.plug(this, "eyebrowLeftReceived", "/gesture/eyebrow/left");
  oscP5.plug(this, "eyebrowRightReceived", "/gesture/eyebrow/right");
  oscP5.plug(this, "eyeLeftReceived", "/gesture/eye/left");
  oscP5.plug(this, "eyeRightReceived", "/gesture/eye/right");
  oscP5.plug(this, "jawReceived", "/gesture/jaw");
  oscP5.plug(this, "nostrilsReceived", "/gesture/nostrils");
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "poseOrientation", "/pose/orientation");
  oscP5.plug(this, "posePosition", "/pose/position");
  oscP5.plug(this, "poseScale", "/pose/scale");

 
}


void mouseClicked() {
  if (matchedFace !=null && matchedFace.action !=null) {
    matchedFace.action.execute();
  }
}

void draw() {  
  background(0);
  fill(255);
  String output = "";

  boolean hasMatch = false;
  
  String action = "";

  float bestScore = 20.0;

  if (hasFace) {
    for (int i = 0; i < candidateFaces.size(); i++) {
      SavedFace testFace = candidateFaces.get(i);
      output += "Face " + i + ": " + testFace.score(currentFace) + "\n";
      if (testFace.match(currentFace)) {
        hasMatch = true;
        float currentScore = testFace.score(currentFace);
        if(currentScore < bestScore){
          matchedFace = testFace;
          bestScore = bestScore;
        }
      }
    }
    
    if(hasMatch && matchedFace.action != null){
      action += "\nAction:\n" + matchedFace.action.argument;
    }
  } 
  else {
    output += "NO FACE";
  }

  textSize(12);
  text(output, 10, 40);
  
  textSize(10);
  text(action, 10, 150);

  if (hasMatch) {
    if(matchedFace.img != null){
      image(matchedFace.img, width-408, 0, 408, 544);
    }
  } 
  else {
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

public void found(int i) {
  hasFace = (i == 1);
}

public void posePosition(float x, float y) {
  // println("position\tX: " + x + " Y: " + y );
}

public void poseScale(float s) {
  // println("scale: " + s);
}

public void poseOrientation(float x, float y, float z) {
  //  println("orientation\tX: " + x + " Y: " + y + " Z: " + z);
}




void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.isPlugged()==false) {
    println("UNPLUGGED: " + theOscMessage);
  }
}

