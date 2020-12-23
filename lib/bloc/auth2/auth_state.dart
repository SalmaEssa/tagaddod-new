import '../bloc.dart';
import 'auth_state.dart';
import 'package:auth_provider/UserInterface.dart';

abstract class AuthState {}

class LogInError extends AuthState {
  String msg;
  String title;
  LogInError(this.msg, {this.title});
}

class PhoneNumberis extends AuthState {
  String phone;
  PhoneNumberis(this.phone);
}

class OTPResend extends AuthState {}

class LogedIn extends AuthState {
  AuthUser user;
  LogedIn(this.user);
}

class LogedOut extends AuthState {}

class HasUser extends AuthState {
  bool has_user;
  HasUser(this.has_user);
}
