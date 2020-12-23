import 'auth_event.dart';
import '../bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tagaddod/resources/strings.dart';
import 'package:tagaddod/services/user_service.dart';
import 'package:tagaddod/bloc/auth2/auth_state.dart';
import 'package:auth_provider/AppException.dart';
import 'package:auth_provider/UserInterface.dart';

class AuthBloc extends BLoC<AuthEvent> {
  final UserService _usersService = GetIt.instance<UserService>();
  final PublishSubject<AuthState> authStateSubject = PublishSubject();
  String _phone;
  String _code;
  AuthUser user;

  @override
  void dispatch(AuthEvent event) {
    if (event is SendOTP)
      sendOTP(event.phoneNumber);
    else if (event is GetthePhone)
      getPhone();
    else if (event is VerifyCode)
      verifyCode(event.code);
    else if (event is ReSendOTP)
      resendOTP();
    else if (event is LogOut)
      logOutFromApp();
    else if (event is CheackHasUser) cheackForUser();

    // TODO: implement dispatch
  }

  Future<void> cheackForUser() async {
    var user = await _usersService.getuser();
    if (user == null)
      authStateSubject.add(HasUser(false));
    else
      authStateSubject.add(HasUser(true));
  }

  Future<void> logOutFromApp() async {
    await _usersService.logout();
    authStateSubject.add(LogedOut());
  }

  Future<void> verifyCode(String c) async {
    _code = c;
    print("inside verifyyyy codeeeee222e");
    print(_code);
    try {
      print("inside verifyyyy codeeeeee");
      user = await _usersService.logIn(_code);
      print("Still  in tryyy");
      print(user.id);
      authStateSubject.add(LogedIn(user));
      return;
    } catch (error) {
      print("erooooooor user verifyyy");
      if (error is AppException) {
        authStateSubject.add(LogInError(
          error.beautifulMsg,
        ));
        return;
      }

      print("the erorrrr is ");
      // print(error.toString());
      authStateSubject.add(LogInError(AppStrings.contactUsForInfo));
      // print(user.id);
    }
  }

  void getPhone() {
    print("geeeet phonee wooork");
    authStateSubject.add(PhoneNumberis(_phone));
  }

  void sendOTP(String phone) {
    _phone = phone;
    try {
      _usersService.sendOTP('+2$_phone');
    } catch (error) {
      authStateSubject.add(LogInError(AppStrings.contactSupport));
    }
  }

  void resendOTP() {
    try {
      _usersService.sendOTP('+2$_phone');
      authStateSubject.add(OTPResend());
      print("resend woorksssss");
    } catch (ex) {
      print("resend faileeeeeeed");

      authStateSubject.add(LogInError(AppStrings.contactUsForInfo));
    }
  }
}
