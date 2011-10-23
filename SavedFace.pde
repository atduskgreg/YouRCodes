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
  
  SavedFace(){
    threshold = 2;
  }
  
  String print(){
    return "mW: " + mouthWidth + "\tmH: " + mouthHeight + "\tebR: " + eyebrowRight + "\tebL: " + eyebrowLeft + "\teL: " + eyeLeft + "\teR: " + eyeRight + "\tj: " + jaw + "\tn: " + nostrils;
  }
  
  boolean match(SavedFace otherFace){
    return score(otherFace) <= threshold;  
  }
  
  // TODO:
  // - sum of squares of differences
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
  
}
