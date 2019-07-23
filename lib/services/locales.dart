import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:begin/assets/language/messages_all.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get welTxtLoginScreen {
    return Intl.message(
      'Hello \nWelcome Back',
      name: 'welTxtLoginScreen',
    );
  }

  String get userNameTxtBox {
    return Intl.message(
      "Username",
      name: 'userNameTxtBox',
    );
  }

  String get passwordTxtBox {
    return Intl.message(
      'Password',
      name: 'passwordTxtBox',
    );
  }

  String get reenterPassTxtBox {
    return Intl.message(
      'Re-enter password',
      name: 'reenterPassTxtBox',
    );
  }

  String get hideTitle {
    return Intl.message(
      'Hide',
      name: 'hideTitle',
    );
  }

  String get signUpBtn {
    return Intl.message(
      'Sign up',
      name: 'signUpBtn',
    );
  }

  String get forgotPasswordScreenTitle {
    return Intl.message(
      'Forgot your password',
      name: 'forgotPasswordScreenTitle',
    );
  }

  String get enterEmailMessage {
    return Intl.message(
      'Please enter the email you use to register your account : ',
      name: 'enterEmailMessage',
    );
  }

  String get confirmBtnTitle {
    return Intl.message(
      'Confirm',
      name: 'confirmBtnTitle',
    );
  }

  String get cancelBtnTitle {
    return Intl.message(
      'Cancel',
      name: 'cancelBtnTitle',
    );
  }

  String get enterVerifyCodeMessage {
    return Intl.message(
      'An email has just been sent to your inbox, check and enter the code you received :',
      name: 'enterVerifyCodeMessage',
    );
  }

  String get showTitle {
    return Intl.message(
      'Show',
      name: 'showTitle',
    );
  }

  String get loginBtn {
    return Intl.message(
      'Log in',
      name: 'loginBtn',
    );
  }

  String get newUserQues {
    return Intl.message(
      'New User?',
      name: 'newUserQues',
    );
  }

  String get registerTitle {
    return Intl.message(
      'REGISTER',
      name: 'registerTitle',
    );
  }

  String get forgotPasswordTitle {
    return Intl.message(
      'FORGOT PASSWORD',
      name: 'forgotPasswordTitle',
    );
  }

  String get titleHomeScreen {
    return Intl.message(
      'Home',
      name: 'titleHomeScreen',
    );
  }

  String get textHomeScreen {
    return Intl.message(
      'This is home screen',
      name: 'textHomeScreen',
    );
  }

  String get titleSettingsScreen {
    return Intl.message(
      'Settings',
      name: 'titleSettingsScreen',
    );
  }

  String get themeColorTitle {
    return Intl.message(
      'Theme color',
      name: 'themeColorTitle',
    );
  }

  String get profileTitle {
    return Intl.message(
      'Profile',
      name: 'profileTitle',
    );
  }

  String get logoutTitle {
    return Intl.message(
      'Logout',
      name: 'logoutTitle',
    );
  }

  String get emailAddressTitle {
    return Intl.message(
      'Email address: ',
      name: 'emailAddressTitle',
    );
  }

  String get phoneTitle {
    return Intl.message(
      'Phone',
      name: 'phoneTitle',
    );
  }

  String get roleTitle {
    return Intl.message(
      'Role',
      name: 'roleTitle',
    );
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'vi'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) {
    return true;
  }
}
