class FaceAction {
  String type;
  String argument;

  FaceAction(String type, String argument) {
    this.type = type;
    this.argument = argument;
  }  

  void execute() {
    if (type.equals("Link")) {
      link(argument);
    } 
    else {
      println(argument);
    }
  }
}

