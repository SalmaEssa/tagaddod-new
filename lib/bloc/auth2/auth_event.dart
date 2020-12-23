abstract class AuthEvent {}

class SendOTP extends AuthEvent {
  String phoneNumber;
  SendOTP(this.phoneNumber);
}

class GetthePhone extends AuthEvent {}

class VerifyCode extends AuthEvent {
  String code;
  VerifyCode(this.code);
}

class ReSendOTP extends AuthEvent {}

class LogOut extends AuthEvent {}

class CheackHasUser extends AuthEvent {}
