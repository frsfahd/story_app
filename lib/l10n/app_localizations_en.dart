// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginHeader => 'Sign In';

  @override
  String get loginSubHeader =>
      'Sign In to your account to view and manage your learning stories.';

  @override
  String get loginEmailHintText => 'Enter a registered email address';

  @override
  String get loginEmailValidator => 'Please enter a registered email address';

  @override
  String get loginEmailValidator2 => 'Please enter a valid email address';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginPasswordHIntText => 'Masukkan kata sandi';

  @override
  String get loginPasswordValidator => 'Please enter your password';

  @override
  String get loginPasswordValidator2 =>
      'Minimum password length of 8 characters';

  @override
  String get loginButton => 'Sign In';

  @override
  String get loginForgetPassword => 'Forget password ?';

  @override
  String get loginToRegisterText => 'don\'t have an account yet ?';

  @override
  String get loginToRegisterButton => 'Register';

  @override
  String get registerSuccessSnackbar =>
      'Registration successful, please sign in';

  @override
  String get registerHeader => 'Registration';

  @override
  String get registerSubHeader =>
      'Create an account to view and manage your learning stories.';

  @override
  String get registerNameLabel => 'Name';

  @override
  String get registerNameHintText => 'Enter your name';

  @override
  String get registerNameValidator => 'Please enter your name';

  @override
  String get registerNameValidator2 => 'Minimum name length of 3 characters';

  @override
  String get registerEmailHintText => 'Enter your email address';

  @override
  String get registerEmailValidator => 'Please enter your email address';

  @override
  String get registerEmailValidator2 => 'Please enter a valid email address';

  @override
  String get registerPasswordLabel => 'Password';

  @override
  String get registerPasswordHintText => 'Enter a password';

  @override
  String get registerPasswordValidator => 'Please enter a password';

  @override
  String get registerPasswordValidator2 =>
      'Minimum password length of 8 characters';

  @override
  String get registerPasswordConfirmLabel => 'Password Confirmation';

  @override
  String get registerPasswordConfirmHintText => 'Re-enter your password';

  @override
  String get registerPasswordConfirmValidator =>
      'Please re-enter your password';

  @override
  String get registerPasswordConfirmValidator2 => 'Password does not match';

  @override
  String get registerButton => 'Register';

  @override
  String get registerAccountExisted => 'Already have an account ?';

  @override
  String get registerToLoginButton => 'Sign In';

  @override
  String get homeTitle => 'Stories';

  @override
  String get homeErrNoStory => 'No story available';

  @override
  String homeStoryDate(DateTime createdAt) {
    final intl.DateFormat createdAtDateFormat = intl.DateFormat.yMMMd(
      localeName,
    );
    final String createdAtString = createdAtDateFormat.format(createdAt);

    return 'Uploaded at $createdAtString';
  }

  @override
  String get homeLogout => 'Sign Out';

  @override
  String get homeLogoutCancel => 'Cancel';

  @override
  String get homeLogoutConfirmContent => 'Are you sure you want to sign out?';

  @override
  String get homeNewStoryButton => 'New Story';

  @override
  String get detailTitle => 'Story Detail';

  @override
  String detailDate(DateTime date, DateTime time) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);
    final intl.DateFormat timeDateFormat = intl.DateFormat.Hm(localeName);
    final String timeString = timeDateFormat.format(time);

    return '$dateString • $timeString';
  }

  @override
  String get newStoryTitle => 'New Story';

  @override
  String get newStoryCameraButton => 'Camera';

  @override
  String get newStoryGalleryButton => 'Gallery';

  @override
  String get newStoryDescLabel => 'Description';

  @override
  String get newStoryErrEmptyPic => 'Image must not be empty';

  @override
  String get newStoryErrEmptyDesc => 'Description must not be empty';

  @override
  String get newStoryButton => 'Upload';
}
