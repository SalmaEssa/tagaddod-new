import 'package:rxdart/rxdart.dart';

class AppStrings {
  static PublishSubject<String> langChangedSubject = PublishSubject();
  static String currentCode = CodeStrings.arabicCode;

  static Map<String, Map<String, String>> _translationsMap = {
    CodeStrings.englishCode: {
      'helloWorldText': 'Hello World',
      'somethingWentWrong': 'Something went wrong',
      'forPartners': 'For Partners',
      "success": "Success",
      "fail": "Something went wrong",
      "couldntFindAccount": "We couldn’t find your account",
      "verificationCodeResent": "Verification code resent",
      "verificationCodeResentSuccess": "Verification code resent",
      "language": "Language",
      "requestHistory": "Requests History",
      "contactSupport": "Contact Support",
      "logout": "Logout",
      "chooseLanguage": "Choose Language",
      "arabic": "العربية",
      "english": "English",
      "confirm": "CONFIRM",
      "cancel": "CANCEL",
      "sureToLogout": "Are you sure you want to logout?",
      "todayRequests": "Today’s Requests",
      "requestMap": "Requests Map",
      "yesterdayRequests": "Yesterday’s Requests",
      "thisMonth": "This Month",
      "collected": "Collected",
      "remaining": "Remaining",
      "failed": "Failed",
      "noRequestsToday": "You don’t have any requests today",
      "noRequestsYesterday": "Nothing was collected yesterday",
      "successDiliver": "Collected",
      "failDeliver": "Failed",
      "goodMorning": "Good Morning",
      "goodEvening": "Good Evening",
      "verifyPhone": "Verify Phone Number",
      "writeVerifyCode": "Please type the verification code sent to",
      "confirmPhone": "Verify",
      "resendCodeIn": "Resend Code In",
      "resendCode": "Resend Code",
      "phoneNumber": "Phone Number",
      "enterPhoneNumber": "Enter phone number",
      "sendOTP": "Send Verification Code",
      "noPhone": "The phone number you entered is incorrect",
      "invalidPhone": "Invalid phone number",
      "contactUsForInfo": "Contact us for further information",
      "requestsMap": "Requests Map",
      "refresh": "Refresh",
      "youHave": "You have",
      "remainigRequests": "remaining requests",
      "directions": "Directions",
      "call": "Call",
      "quantity": "Quantity",
      "gift": "Gift",
      "notes": "Notes",
      "recieve": "Collect",
      "reportProblem": "Report an issue",
      "collectedAmount": "Collected Amount",
      "change": "Change",
      "litres": "Litres",
      "pleaseRate": "Please rate",
      "sendRating": "Submit Rating",
      "selectGift": "Select Gift",
      "downloadingGifts": "Loading Gifts",
      "donateGift": "Donate Gift",
      "selectAnotherGift": "Select another gift",
      "confirmCollect": "Confirm",
      "invalidToken": "Incorrect verification code",
      "noPastRequests": "You don't have any past requests",
      "downloading": "Loading, please wait",
      "address": "Address",
      "requestCollected": "collected",
      "requestFailed": "failed",
      "requestReported": "issue reported",
      "ratingSent": "Rating submitted",
      "sendIssue": "Submit issue",
      "describeYourIssue": "Tell us more about your issue",
      "problem": "Submitted issue",
      "problemSent": "Issue submitted",
      "weWillContactSoon": "We will contact you soon",
      "tryAgainLater": "Please try again later",
      "thanks": "Thanks",
      "youFinishedAllRequests": "You’ve finished all requests for today",
    },
    CodeStrings.arabicCode: {
      'helloWorldText': 'مرحبا',
      'somethingWentWrong': 'حدث خطأ',
      'forPartners': 'للشركاء',
      "success": "عملية ناجحة",
      "fail": "حدث خطأ",
      "couldntFindAccount": "لم يتم العثور على حسابك",
      "verificationCodeResent": "تم اعادة ارسال كود التأكيد",
      "verificationCodeResentSuccess": "تم إعادة إرسال كود التأكيد",
      "language": "اللغة",
      "requestHistory": "سجل الطلبات",
      "contactSupport": "الاتصال بالدعم",
      "logout": "تسجيل الخروج",
      "chooseLanguage": "اختار اللغة",
      "arabic": "العربية",
      "english": "English",
      "confirm": "تأكيد",
      "cancel": "الغاء",
      "sureToLogout": "هل انت متاكد من رغبتك في تسجيل الخروج؟",
      "todayRequests": "طلبات اليوم",
      "requestMap": "خريطة الطلبات",
      "yesterdayRequests": "طلبات الأمس",
      "thisMonth": "طلبات الشهر",
      "collected": "تم",
      "remaining": "متبقي",
      "failed": "فشل",
      "noRequestsToday": "ليس لديك اية طلبات اليوم",
      "noRequestsYesterday": "لم يتم إستلام أية طلبات بالأمس",
      "successDiliver": "تم الإستلام",
      "failDeliver": "فشل الإستلام",
      "goodMorning": "صباح الخير",
      "goodEvening": "مساء الخير",
      "verifyPhone": "التحقق من رقم التليفون",
      "writeVerifyCode": "يرجى كتابة رمز التحقق المرسل إلى",
      "confirmPhone": "تأكيد رقم التليفون",
      "resendCodeIn": "إعادة إرسال الكود في خلال",
      "resendCode": "إعادة إرسال الكود",
      "phoneNumber": "رقم التليفون",
      "enterPhoneNumber": "ادخل رقم تليفونك",
      "sendOTP": "ارسال كود التحقق",
      "noPhone": "رقم التليفون الذي ادخلته غير صحيح",
      "invalidPhone": "ادخل رقم التليفون الصحيح",
      "contactUsForInfo": "للمزيد من المعلومات يرجى التواصل معنا",
      "requestsMap": "خريطة الطلبات",
      "refresh": "تحديث",
      "youHave": "لديك",
      "remainigRequests": "طلبات متبقية",
      "directions": "الاتجاهات",
      "call": "اتصل",
      "quantity": "الكمية",
      "gift": "الهدية",
      "notes": "ملاحظات",
      "recieve": "إستلام",
      "reportProblem": "الإبلاغ عن مشكلة",
      "collectedAmount": "الكمية المستلمة",
      "change": "تغيير",
      "litres": "لتر",
      "pleaseRate": "من فضلك قيم",
      "sendRating": "إرسال التقييم",
      "selectGift": "اختر الهدية",
      "downloadingGifts": "جاري تحميل الهدايا",
      "donateGift": "تبرع بالهدية",
      "selectAnotherGift": "قم بإعادة اختيار الهدية",
      "confirmCollect": "تاكيد الإستلام",
      "invalidToken": "رمز التحقق غير صحيح",
      "noPastRequests": "ليس لديك أي طلبات سابقة",
      "downloading": "جاري التحميل",
      "address": "العنوان",
      "requestCollected": "تم الإستلام",
      "requestFailed": "فشل الإستلام",
      "requestReported": "تم الإبلاغ عن مشكلة",
      "ratingSent": "تم إرسال التقييم",
      "sendIssue": "إرسال المشكلة",
      "describeYourIssue": "ما المشكلة التي تواجهها؟",
      "problem": "المشكلة",
      "problemSent": "تم إرسال المشكلة",
      "weWillContactSoon": "سنتواصل معك قريبا",
      "tryAgainLater": "أعد المحاولة في وقت لاحق",
      "thanks": "شكرا",
      "youFinishedAllRequests": "لقد انتهيت من كل طلبات اليوم",
    },
  };

  static String get helloWorldText =>
      _translationsMap[currentCode]["helloWorldText"];

  static String get contactUsForInfo =>
      _translationsMap[currentCode]["contactUsForInfo"];

  static String get forPartners => _translationsMap[currentCode]["forPartners"];

  static String get success => _translationsMap[currentCode]["success"];

  static String get fail => _translationsMap[currentCode]["fail"];

  static String get couldntFindAccount =>
      _translationsMap[currentCode]["couldntFindAccount"];

  static String get verificationCodeResent =>
      _translationsMap[currentCode]["verificationCodeResent"];
  static String get verificationCodeResentSuccess =>
      _translationsMap[currentCode]["verificationCodeResentSuccess"];
  static String get language => _translationsMap[currentCode]["language"];
  static String get requestHistory =>
      _translationsMap[currentCode]["requestHistory"];
  static String get contactSupport =>
      _translationsMap[currentCode]["contactSupport"];
  static String get logout => _translationsMap[currentCode]["logout"];

  static String get chooseLanguage =>
      _translationsMap[currentCode]["chooseLanguage"];
  static String get arabic => _translationsMap[currentCode]["arabic"];
  static String get english => _translationsMap[currentCode]["english"];
  static String get confirm => _translationsMap[currentCode]["confirm"];
  static String get cancel => _translationsMap[currentCode]["cancel"];

  //Home Screen Strings
  static String get todayRequests =>
      _translationsMap[currentCode]["todayRequests"];
  static String get requestMap => _translationsMap[currentCode]["requestMap"];
  static String get yesterdayRequests =>
      _translationsMap[currentCode]["yesterdayRequests"];
  static String get thisMonth => _translationsMap[currentCode]["thisMonth"];
  static String get collected => _translationsMap[currentCode]["collected"];
  static String get remaining => _translationsMap[currentCode]["remaining"];
  static String get failed => _translationsMap[currentCode]["failed"];
  static String get noRequestsToday =>
      _translationsMap[currentCode]["noRequestsToday"];
  static String get noRequestsYesterday =>
      _translationsMap[currentCode]["noRequestsYesterday"];

  static String get sureToLogout =>
      _translationsMap[currentCode]["sureToLogout"];
  static String get successDiliver =>
      _translationsMap[currentCode]["successDiliver"];
  static String get failDeliver => _translationsMap[currentCode]["failDeliver"];
  static String get goodMorning => _translationsMap[currentCode]["goodMorning"];
  static String get goodEvening => _translationsMap[currentCode]["goodEvening"];
  static String get phoneNumber => _translationsMap[currentCode]["phoneNumber"];
  static String get enterPhoneNumber =>
      _translationsMap[currentCode]["enterPhoneNumber"];
  static String get sendOTP => _translationsMap[currentCode]["sendOTP"];

  static String get verifyPhone => _translationsMap[currentCode]["verifyPhone"];

  static String get writeVerifyCode =>
      _translationsMap[currentCode]["writeVerifyCode"];

  static String get confirmPhone =>
      _translationsMap[currentCode]["confirmPhone"];

  static String get resendCodeIn =>
      _translationsMap[currentCode]["resendCodeIn"];

  static String get resendCode => _translationsMap[currentCode]["resendCode"];
  static String get noPhone => _translationsMap[currentCode]["noPhone"];
  static String get invalidPhone =>
      _translationsMap[currentCode]["invalidPhone"];

  static String get requestsMap => _translationsMap[currentCode]["requestsMap"];
  static String get refresh => _translationsMap[currentCode]["refresh"];
  static String get youHave => _translationsMap[currentCode]["youHave"];
  static String get remainigRequests =>
      _translationsMap[currentCode]["remainigRequests"];
  static String get directions => _translationsMap[currentCode]["directions"];
  static String get call => _translationsMap[currentCode]["call"];
  static String get quantity => _translationsMap[currentCode]["quantity"];
  static String get gift => _translationsMap[currentCode]["gift"];
  static String get notes => _translationsMap[currentCode]["notes"];
  static String get recieve => _translationsMap[currentCode]["recieve"];
  static String get reportProblem =>
      _translationsMap[currentCode]["reportProblem"];
  static String get collectedAmount =>
      _translationsMap[currentCode]["collectedAmount"];
  static String get change => _translationsMap[currentCode]["change"];
  static String get litres => _translationsMap[currentCode]["litres"];
  static String get pleaseRate => _translationsMap[currentCode]["pleaseRate"];
  static String get sendRating => _translationsMap[currentCode]["sendRating"];
  static String get selectGift => _translationsMap[currentCode]["selectGift"];
  static String get downloadingGifts =>
      _translationsMap[currentCode]["downloadingGifts"];
  static String get donateGift => _translationsMap[currentCode]["donateGift"];
  static String get selectAnotherGift =>
      _translationsMap[currentCode]["selectAnotherGift"];
  static String get confirmCollect =>
      _translationsMap[currentCode]["confirmCollect"];
  static String get invalidToken =>
      _translationsMap[currentCode]["invalidToken"];

  static String get noPastRequests =>
      _translationsMap[currentCode]["noPastRequests"];
  static String get downloading => _translationsMap[currentCode]["downloading"];
  static String get address => _translationsMap[currentCode]["address"];
  static String get requestCollected =>
      _translationsMap[currentCode]["requestCollected"];
  static String get requestFailed =>
      _translationsMap[currentCode]["requestFailed"];
  static String get requestReported =>
      _translationsMap[currentCode]["requestReported"];
  static String get ratingSent => _translationsMap[currentCode]["ratingSent"];
  static String get sendIssue => _translationsMap[currentCode]["sendIssue"];
  static String get describeYourIssue =>
      _translationsMap[currentCode]["describeYourIssue"];
  static String get problem => _translationsMap[currentCode]["problem"];

  static String get problemSent => _translationsMap[currentCode]["problemSent"];
  static String get weWillContactSoon =>
      _translationsMap[currentCode]["weWillContactSoon"];
  static String get somethingWentWrong =>
      _translationsMap[currentCode]["somethingWentWrong"];
  static String get tryAgainLater =>
      _translationsMap[currentCode]["tryAgainLater"];
  static String get thanks => _translationsMap[currentCode]["thanks"];
  static String get youFinishedAllRequests =>
      _translationsMap[currentCode]["youFinishedAllRequests"];

  static void setCurrentLocal(String code) {
    currentCode = code;
    if (code != CodeStrings.englishCode && code != CodeStrings.arabicCode) {
      currentCode = CodeStrings.englishCode;
    }
    langChangedSubject.sink.add(currentCode);
  }

  void dispose() {
    langChangedSubject.close();
  }
}

class CodeStrings {
  /* Language Params */
  static const String englishCode = "en";
  static const String arabicCode = "ar";
  static const String english = "English";
  static const String german = "Deutsch";

  /* Assets */
  static const String appLogo = 'assets/app_logo.png';
  static const String splashLogo = 'assets/logo_splash.png';

  /* General */
  static const buildNumberKey = "build";
  static const localeKey = "LOCALE";
  static const userKey = "User";
  static const String databaseDevInstance = "dev";
  static const String databaseProductionInstance = "production";
  static const String usersDatabaseRef = "users";
  static const String signupNodeName = "signup";
  static const String typeArgument = "type";
  static const String emailArgument = "email";
  static const String passwordArgument = "password";
  static const String input = "input";
  static const String emailType = "_EMAIL";
  static const String customerRole = "customer";
  static const String loginNodeName = "login";
  static const String idColumn = "id";
  static const String emailColumn = "email";
  static const String roleColumn = "role";
  static const String jwtTokenColumn = "jwtToken";
  static const String expireColumn = "expire";
  static const String resetPasswordNode = "reset_password";
  static const String changePassNodeName = "reAuth_user";
  static const String credintialsArgument = "credentials";
  static const String currentPass = "oldPassword";
  static const String newPass = "newPassword";
  static const String languageHeader = "Lang";
  static const String updateCollectorNodeName = "updateCollector";
  static const String localeArgument = "locale";
  static const String invalidTokenException =
      "The SMS verification code used to create the phone auth credential is invalid. Please resend the verification code SMS and be sure to use the verification code provided by the user.";
  static const String sessionExpired =
      "The SMS code has expired. Please re-send the verification code to try again.";
  static const String googleMapsServerAPI =
      "AIzaSyBIMHpyHdaUxveX8W9gF5UAZrREH0574Dc";
  static const String invalidTokenExceptionCode = "invalid-verification-code";

  /* Request types */
  static const String rCollected = "COLLECTED";
  static const String rFailed = "FAILED";
  static const String rReported = "REPORTED";

  static const String rated = "RATED";
  static const String skipped = "SKIPPED";

  static const String googleNavigation =
      "https://www.google.com/maps/dir/?api=1&origin=Current+Location&destination=";
}

class AssetStrings {
  static const String bigLeaf = "assets/images/big_leaf.png";
  static const String smallLeaf = "assets/images/small_leaf.png";
  static const String slogan_ar = "assets/images/slogan_ar.png";
  static const String slogan_en = "assets/images/slogan_en.png";
  static const String logo_white = "assets/images/logo_white.png";
  static const String logoBusinessArGreen =
      "assets/images/logo_business_ar_green.png";
  static const String logoBusinessEnGreen =
      "assets/images/logo_business_en_green.png";
  static const String myLocation = "assets/images/my_location.png";
  static const String pickupLocation = "assets/images/pickup_location.png";
  static const String pickupLocationSelected =
      "assets/images/pickup_location_selected.png";
  static const String leafRotated = "assets/images/leafRotated.png";
  static const String yesterday = "assets/images/yesterday.png";
  static const String leaf = "assets/images/leaf.png";
  static const String rect = "assets/images/rect.png";
  static const String todayEmpty = "assets/images/today_empty.png";
  static const String emptyPastRequests = "assets/images/emptyPastRequests.png";
  static const String success = "assets/images/success.png";
}
