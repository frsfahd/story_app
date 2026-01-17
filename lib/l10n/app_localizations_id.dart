// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get loginHeader => 'Masuk';

  @override
  String get loginSubHeader =>
      'Masuk ke akun Anda untuk melihat dan mengelola cerita pengalaman belajar Anda.';

  @override
  String get loginEmailHintText => 'Masukkan email yang terdaftar';

  @override
  String get loginEmailValidator => 'Mohon masukkan email yang telah terdaftar';

  @override
  String get loginEmailValidator2 => 'Mohon masukkan email yang valid';

  @override
  String get loginPasswordLabel => 'Kata Sandi';

  @override
  String get loginPasswordHIntText => 'Masukkan kata sandi';

  @override
  String get loginPasswordValidator => 'Mohon masukkan kata sandi';

  @override
  String get loginPasswordValidator2 => 'Kata sandi minimal 8 karakter';

  @override
  String get loginButton => 'Masuk';

  @override
  String get loginForgetPassword => 'Lupa kata sandi ?';

  @override
  String get loginToRegisterText => 'Belum punya akun ?';

  @override
  String get loginToRegisterButton => 'Daftar';

  @override
  String get registerSuccessSnackbar => 'Pendaftaran berhasil, silakan masuk';

  @override
  String get registerHeader => 'Daftar';

  @override
  String get registerSubHeader =>
      'Buat akun untuk melihat dan mengelola cerita pengalaman belajar Anda.';

  @override
  String get registerNameLabel => 'Nama';

  @override
  String get registerNameHintText => 'Masukkan nama anda';

  @override
  String get registerNameValidator => 'Mohon masukkan nama lengkap';

  @override
  String get registerNameValidator2 => 'Nama minimal 3 karakter';

  @override
  String get registerEmailHintText => 'Masukkan email anda';

  @override
  String get registerEmailValidator => 'Mohon masukkan email anda';

  @override
  String get registerEmailValidator2 => 'Mohon maasukkan email yang valid';

  @override
  String get registerPasswordLabel => 'Kata Sandi';

  @override
  String get registerPasswordHintText => 'Masukkan kata sandi';

  @override
  String get registerPasswordValidator => 'Mohon masukkan kata sandi';

  @override
  String get registerPasswordValidator2 => 'Kata sandi minimal 8 karakter';

  @override
  String get registerPasswordConfirmLabel => 'Konfirmasi kata sandi';

  @override
  String get registerPasswordConfirmHintText => 'Masukkan ulang kata sandi';

  @override
  String get registerPasswordConfirmValidator => 'Mohon konfirmasi kata sandi';

  @override
  String get registerPasswordConfirmValidator2 =>
      'Konfirmasi kata sandi tidak cocok';

  @override
  String get registerButton => 'Daftar';

  @override
  String get registerAccountExisted => 'Sudah punya akun ?';

  @override
  String get registerToLoginButton => 'Masuk';

  @override
  String get homeTitle => 'Semua Cerita';

  @override
  String get homeErrNoStory => 'Tidak ada cerita tersedia';

  @override
  String homeStoryDate(DateTime createdAt) {
    final intl.DateFormat createdAtDateFormat = intl.DateFormat.yMMMd(
      localeName,
    );
    final String createdAtString = createdAtDateFormat.format(createdAt);

    return 'Diunggah pada $createdAtString';
  }

  @override
  String get homeLogout => 'Keluar';

  @override
  String get homeLogoutCancel => 'Batal';

  @override
  String get homeLogoutConfirmContent => 'Apakah Anda yakin ingin keluar?';

  @override
  String get homeNewStoryButton => 'Buat Cerita';

  @override
  String get detailTitle => 'Cerita';

  @override
  String detailDate(DateTime date, DateTime time) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);
    final intl.DateFormat timeDateFormat = intl.DateFormat.Hm(localeName);
    final String timeString = timeDateFormat.format(time);

    return '$dateString • $timeString';
  }

  @override
  String get newStoryTitle => 'Cerita Baru';

  @override
  String get newStoryCameraButton => 'Kamera';

  @override
  String get newStoryGalleryButton => 'Galeri';

  @override
  String get newStoryDescLabel => 'Deskripsi';

  @override
  String get newStoryErrEmptyPic => 'Gambar tidak boleh kosong';

  @override
  String get newStoryErrEmptyDesc => 'Deskripsi tidak boleh kosong';

  @override
  String get newStoryButton => 'Unggah';
}
