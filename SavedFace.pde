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
  
  SavedFace(){}
  
  String print(){
    return "mW: " + mouthWidth + "\tmH: " + mouthHeight + "\tebR: " + eyebrowRight + "\tebL: " + eyebrowLeft + "\teL: " + eyeLeft + "\teR: " + eyeRight + "\tj: " + jaw + "\tn: " + nostrils;
  }
  
  boolean match(SavedFace otherFace){
    return score(otherFace) <= threshold;
  }
  
  float score(SavedFace otherFace){
    float error = 0;
    error += abs(otherFace.mouthWidth - mouthWidth );
    error += abs(otherFace.mouthHeight - mouthHeight );
    error += abs(otherFace.eyebrowLeft - eyebrowLeft );
    error += abs(otherFace.eyebrowRight - eyebrowRight );
    error += abs(otherFace.eyeLeft - eyeLeft );
    error += abs(otherFace.eyebrowLeft - eyeRight );
    error += abs(otherFace.eyebrowRight - jaw );
    error += abs(otherFace.eyeLeft - nostrils );  
    return error; 
  }
  
}
