import 'dart:async';

class LoginBloc {
  StreamController userController = new StreamController();
  StreamController passController = new StreamController();

  Stream get userStream => userController.stream;
  Stream get passStream => passController.stream;

  /*bool isValidInfor(String username, String pass) {
    if (!Validations.isValidUser(username)) {
      userController.sink.addError("Tài khoản không hợp lệ");
      return false;
    }
    userController.sink.add("OK");
    if (!Validations.isValidPass(pass)) {
      passController.sink.addError("Mật khẩu phải trên 6 kí tự");
      return false;
    }
    passController.sink.add("OK");
    return true;
  }*/
  void dispose(){
    userController.close();
    passController.close();
  }
}
