import 'package:auth_provider/auth_methods/OTPAuthMethod.dart';
import 'package:fly_networking/fly.dart';
import 'package:get_it/get_it.dart';
import 'package:auth_provider/AuthProvider.dart';
import 'package:tagaddod/resources/links.dart';
import 'package:tagaddod/PODO/user.dart';

import 'package:auth_provider/UserInterface.dart';
import 'package:fly_networking/GraphQB/graph_qb.dart';

class UserService {
  AuthProvider _authProvider = GetIt.instance<AuthProvider>();
  final Fly _fly = GetIt.instance<Fly<dynamic>>();
  OTPAuthMethod _otpMethod;
  String _idToken;
  String _userEntredCode;
  String _phoneNumber;
  void sendOTP(String phone) {
    _phoneNumber = phone;
    _otpMethod =
        OTPAuthMethod(apiLink: AppLinks.fullUrl, phoneNumber: _phoneNumber);
    _otpMethod.sendSMS();
  }

  Future<User> logIn(String code) async {
    _userEntredCode = code;
    print(code);
    _idToken = await _otpMethod.getIdToken(code);
    print("the tokenis");
    print(_idToken);
    User user = await _authProvider.loginWith(
        method: _otpMethod, callType: loginWithPhoneCallbackType);
    print("yaas it's riiighh222t");

    _addFlyAuthHeader(user.jwtToken);
    print("yaas it's riiighht");
    return user;
  }

  Future<AuthUser> loginWithPhoneCallbackType(AuthUser user) async {
    Node node = Node(name: "login", args: {
      "type": "_PHONE",
      "role": "_COLLECTOR",
      "phone": _otpMethod.phoneNumber.replaceAll("+2", ""),
      "token": _idToken
    }, cols: [
      "id",
      "phone",
      "role",
      "type",
      "jwtToken",
      "expire"
    ]);
    var returnedUser =
        await _fly.mutation([node], parsers: {"login": User.empty()});
    print("backfrom jason");
    return returnedUser["login"];
  }

  void _addFlyAuthHeader(String token) {
    _fly.addHeaders({"Authorization": "Bearer " + token});
  }

  Future<void> logout() async {
    await GetIt.instance<AuthProvider>()
        .logout(from: OTPAuthMethod(phoneNumber: null, apiLink: null));
  }

  Future<AuthUser> getuser() async {
    print("no user heree");
    try {
      if (await _authProvider.hasUser() == true) {
        print("yes has userrheree!!!!");
        User user = _authProvider.user;
        _addFlyAuthHeader(user.jwtToken);
        return user;
      }
    } catch (error) {
      return null;
    }
  }
}
