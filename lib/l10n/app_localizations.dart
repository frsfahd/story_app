import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// No description provided for @loginHeader.
  ///
  /// In id, this message translates to:
  /// **'Masuk'**
  String get loginHeader;

  /// No description provided for @loginSubHeader.
  ///
  /// In id, this message translates to:
  /// **'Masuk ke akun Anda untuk melihat dan mengelola cerita pengalaman belajar Anda.'**
  String get loginSubHeader;

  /// No description provided for @loginEmailHintText.
  ///
  /// In id, this message translates to:
  /// **'Masukkan email yang terdaftar'**
  String get loginEmailHintText;

  /// No description provided for @loginEmailValidator.
  ///
  /// In id, this message translates to:
  /// **'Mohon masukkan email yang telah terdaftar'**
  String get loginEmailValidator;

  /// No description provided for @loginEmailValidator2.
  ///
  /// In id, this message translates to:
  /// **'Mohon masukkan email yang valid'**
  String get loginEmailValidator2;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In id, this message translates to:
  /// **'Kata Sandi'**
  String get loginPasswordLabel;

  /// No description provided for @loginPasswordHIntText.
  ///
  /// In id, this message translates to:
  /// **'Masukkan kata sandi'**
  String get loginPasswordHIntText;

  /// No description provided for @loginPasswordValidator.
  ///
  /// In id, this message translates to:
  /// **'Mohon masukkan kata sandi'**
  String get loginPasswordValidator;

  /// No description provided for @loginPasswordValidator2.
  ///
  /// In id, this message translates to:
  /// **'Kata sandi minimal 8 karakter'**
  String get loginPasswordValidator2;

  /// No description provided for @loginButton.
  ///
  /// In id, this message translates to:
  /// **'Masuk'**
  String get loginButton;

  /// No description provided for @loginForgetPassword.
  ///
  /// In id, this message translates to:
  /// **'Lupa kata sandi ?'**
  String get loginForgetPassword;

  /// No description provided for @loginToRegisterText.
  ///
  /// In id, this message translates to:
  /// **'Belum punya akun ?'**
  String get loginToRegisterText;

  /// No description provided for @loginToRegisterButton.
  ///
  /// In id, this message translates to:
  /// **'Daftar'**
  String get loginToRegisterButton;

  /// No description provided for @registerSuccessSnackbar.
  ///
  /// In id, this message translates to:
  /// **'Pendaftaran berhasil, silakan masuk'**
  String get registerSuccessSnackbar;

  /// No description provided for @registerHeader.
  ///
  /// In id, this message translates to:
  /// **'Daftar'**
  String get registerHeader;

  /// No description provided for @registerSubHeader.
  ///
  /// In id, this message translates to:
  /// **'Buat akun untuk melihat dan mengelola cerita pengalaman belajar Anda.'**
  String get registerSubHeader;

  /// No description provided for @registerNameLabel.
  ///
  /// In id, this message translates to:
  /// **'Nama'**
  String get registerNameLabel;

  /// No description provided for @registerNameHintText.
  ///
  /// In id, this message translates to:
  /// **'Masukkan nama anda'**
  String get registerNameHintText;

  /// No description provided for @registerNameValidator.
  ///
  /// In id, this message translates to:
  /// **'Mohon masukkan nama lengkap'**
  String get registerNameValidator;

  /// No description provided for @registerNameValidator2.
  ///
  /// In id, this message translates to:
  /// **'Nama minimal 3 karakter'**
  String get registerNameValidator2;

  /// No description provided for @registerEmailHintText.
  ///
  /// In id, this message translates to:
  /// **'Masukkan email anda'**
  String get registerEmailHintText;

  /// No description provided for @registerEmailValidator.
  ///
  /// In id, this message translates to:
  /// **'Mohon masukkan email anda'**
  String get registerEmailValidator;

  /// No description provided for @registerEmailValidator2.
  ///
  /// In id, this message translates to:
  /// **'Mohon maasukkan email yang valid'**
  String get registerEmailValidator2;

  /// No description provided for @registerPasswordLabel.
  ///
  /// In id, this message translates to:
  /// **'Kata Sandi'**
  String get registerPasswordLabel;

  /// No description provided for @registerPasswordHintText.
  ///
  /// In id, this message translates to:
  /// **'Masukkan kata sandi'**
  String get registerPasswordHintText;

  /// No description provided for @registerPasswordValidator.
  ///
  /// In id, this message translates to:
  /// **'Mohon masukkan kata sandi'**
  String get registerPasswordValidator;

  /// No description provided for @registerPasswordValidator2.
  ///
  /// In id, this message translates to:
  /// **'Kata sandi minimal 8 karakter'**
  String get registerPasswordValidator2;

  /// No description provided for @registerPasswordConfirmLabel.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi kata sandi'**
  String get registerPasswordConfirmLabel;

  /// No description provided for @registerPasswordConfirmHintText.
  ///
  /// In id, this message translates to:
  /// **'Masukkan ulang kata sandi'**
  String get registerPasswordConfirmHintText;

  /// No description provided for @registerPasswordConfirmValidator.
  ///
  /// In id, this message translates to:
  /// **'Mohon konfirmasi kata sandi'**
  String get registerPasswordConfirmValidator;

  /// No description provided for @registerPasswordConfirmValidator2.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi kata sandi tidak cocok'**
  String get registerPasswordConfirmValidator2;

  /// No description provided for @registerButton.
  ///
  /// In id, this message translates to:
  /// **'Daftar'**
  String get registerButton;

  /// No description provided for @registerAccountExisted.
  ///
  /// In id, this message translates to:
  /// **'Sudah punya akun ?'**
  String get registerAccountExisted;

  /// No description provided for @registerToLoginButton.
  ///
  /// In id, this message translates to:
  /// **'Masuk'**
  String get registerToLoginButton;

  /// No description provided for @homeTitle.
  ///
  /// In id, this message translates to:
  /// **'Semua Cerita'**
  String get homeTitle;

  /// No description provided for @homeErrNoStory.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada cerita tersedia'**
  String get homeErrNoStory;

  /// No description provided for @homeStoryDate.
  ///
  /// In id, this message translates to:
  /// **'Diunggah pada {createdAt}'**
  String homeStoryDate(DateTime createdAt);

  /// No description provided for @homeLogout.
  ///
  /// In id, this message translates to:
  /// **'Keluar'**
  String get homeLogout;

  /// No description provided for @homeLogoutCancel.
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get homeLogoutCancel;

  /// No description provided for @homeLogoutConfirmContent.
  ///
  /// In id, this message translates to:
  /// **'Apakah Anda yakin ingin keluar?'**
  String get homeLogoutConfirmContent;

  /// Button to create a new story
  ///
  /// In id, this message translates to:
  /// **'Buat Cerita'**
  String get homeNewStoryButton;

  /// No description provided for @detailTitle.
  ///
  /// In id, this message translates to:
  /// **'Cerita'**
  String get detailTitle;

  /// No description provided for @detailDate.
  ///
  /// In id, this message translates to:
  /// **'{date} • {time}'**
  String detailDate(DateTime date, DateTime time);

  /// No description provided for @newStoryTitle.
  ///
  /// In id, this message translates to:
  /// **'Cerita Baru'**
  String get newStoryTitle;

  /// No description provided for @newStoryCameraButton.
  ///
  /// In id, this message translates to:
  /// **'Kamera'**
  String get newStoryCameraButton;

  /// No description provided for @newStoryGalleryButton.
  ///
  /// In id, this message translates to:
  /// **'Galeri'**
  String get newStoryGalleryButton;

  /// No description provided for @newStoryDescLabel.
  ///
  /// In id, this message translates to:
  /// **'Deskripsi'**
  String get newStoryDescLabel;

  /// No description provided for @newStoryErrEmptyPic.
  ///
  /// In id, this message translates to:
  /// **'Gambar tidak boleh kosong'**
  String get newStoryErrEmptyPic;

  /// No description provided for @newStoryErrEmptyDesc.
  ///
  /// In id, this message translates to:
  /// **'Deskripsi tidak boleh kosong'**
  String get newStoryErrEmptyDesc;

  /// No description provided for @newStoryButton.
  ///
  /// In id, this message translates to:
  /// **'Unggah'**
  String get newStoryButton;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
