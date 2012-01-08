class SavedFace {
  float mouthWidth;
  float mouthHeight;
  float eyebrowLeft;
  float eyebrowRight;
  float eyeLeft;
  float eyeRight;
  float jaw;
  float nostrils;
  float threshold;
  
  PImage img;
  
  FaceAction action;
  
  SavedFace(){
    threshold = 2;
  }
  
  void load(PApplet app, String xmlPath){
    XML xml = new XML(app, xmlPath);


    for(int i = 0; i < xml.getChildCount() - 1; i++){
      XML featureNode = xml.getChild(i);
      if(featureNode.getName() == null){
       continue;
      }
      if(featureNode.getName().equals("mouthHeight")){
        mouthHeight = float(featureNode.getContent());
      }
      if(featureNode.getName().equals("mouthWidth")){
        mouthWidth = float(featureNode.getContent());
      }
      if(featureNode.getName().equals("eyebrowLeft")){
        eyebrowLeft = float(featureNode.getContent());
      }
      if(featureNode.getName().equals("eyebrowRight")){
        eyebrowRight = float(featureNode.getContent());
      }
      if(featureNode.getName().equals("eyeRight")){
        eyeRight = float(featureNode.getContent());
      }
      if(featureNode.getName().equals("eyeLeft")){
        eyeLeft = float(featureNode.getContent());
      }
      if(featureNode.getName().equals("jaw")){
        jaw = float(featureNode.getContent());
      }
       if(featureNode.getName().equals("nostrils")){
        nostrils = float(featureNode.getContent());
      }
      
     if(featureNode.getName().equals("imagePath")){
       println(featureNode.getContent());
        img = loadImage(featureNode.getContent());
      }
      
      if(featureNode.getName().equals("url")){
        action = new FaceAction("Link", featureNode.getContent());
      }


      
    }
  }
  
  String print(){
    return "mW: " + mouthWidth + "\tmH: " + mouthHeight + "\tebR: " + eyebrowRight + "\tebL: " + eyebrowLeft + "\teL: " + eyeLeft + "\teR: " + eyeRight + "\tj: " + jaw + "\tn: " + nostrils;
  }
  
  boolean match(SavedFace otherFace){
    return score(otherFace) <= threshold;  
  }

  float score(SavedFace otherFace){
    float error = 0;
    error += sq(otherFace.mouthWidth - mouthWidth );
    error += sq(otherFace.mouthHeight - mouthHeight );
    error += sq(otherFace.eyebrowLeft - eyebrowLeft );
    error += sq(otherFace.eyebrowRight - eyebrowRight );
    error += sq(otherFace.eyeLeft - eyeLeft );
    error += sq(otherFace.eyeRight - eyeRight );
    error += sq(otherFace.jaw - jaw );
    error += sq(otherFace.nostrils - nostrils );  
    return error; 
  }
  
  void save(){
    saveStrings("yourcode_" + random(100) + ".xml", xml());
  }
  
  String[] xml(){
    String[] result = new String[10];
    result[0] = "<savedFace><mouthWidth>" + mouthWidth + "</mouthWidth>";
    result[1] = "<mouthHeight>" + mouthHeight + "</mouthHeight>";
    result[2] = "<eyebrowLeft>" + eyebrowLeft + "</eyebrowLeft>";
    result[3] = "<eyebrowLeft>" + eyebrowLeft + "</eyebrowLeft>";
    result[4] = "<eyebrowRight>" + eyebrowRight + "</eyebrowRight>";
    result[5] = "<eyeLeft>" + eyeLeft + "</eyeLeft>";
    result[6] = "<eyeRight>" + eyeRight + "</eyeRight>";
    result[7] = "<jaw>" + jaw + "</jaw>";
    result[8] = "<nostrils>" + nostrils + "</nostrils>";
    result[9] = "</savedFace>";
    return result;
  }
  
}
