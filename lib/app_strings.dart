/// Kelas terjemahan untuk mendukung Bahasa Indonesia dan English.
/// Gunakan: AppStrings.of(languageNotifier.value).namaGetter
class AppStrings {
  final String code;
  AppStrings._(this.code);

  static AppStrings of(String code) => AppStrings._(code);

  bool get _en => code == 'en';

  // ── LOGIN ────────────────────────────────────────────────────────────
  String get loginSubtitle => _en ? 'Sign in to continue' : 'Masuk untuk melanjutkan';
  String get passwordHint => _en ? 'Password' : 'Kata Sandi';
  String get loginButton => _en ? 'Sign In' : 'Masuk';
  String get forgotPassword => _en ? 'Forgot password?' : 'Lupa kata sandi?';
  String get loginSuccess => _en ? 'Login successful! Welcome.' : 'Login Berhasil! Selamat datang.';
  String get loginFailed => _en ? 'Incorrect email or password!' : 'Email atau Password Salah!';
  String get emailEmpty => _en ? 'Email cannot be empty' : 'Email tidak boleh kosong';
  String get emailInvalid => _en ? 'Invalid email format' : 'Format email tidak valid';
  String get passwordEmpty => _en ? 'Password cannot be empty' : 'Kata sandi tidak boleh kosong';
  String get passwordShort => _en ? 'Password min. 6 characters' : 'Kata sandi minimal 6 karakter';

  // ── SALAM & TANGGAL ──────────────────────────────────────────────────
  String getSalam(int hour) {
    if (_en) {
      if (hour < 11) return 'Good morning,';
      if (hour < 15) return 'Good afternoon,';
      if (hour < 18) return 'Good evening,';
      return 'Good night,';
    }
    if (hour < 11) return 'Selamat pagi,';
    if (hour < 15) return 'Selamat siang,';
    if (hour < 18) return 'Selamat sore,';
    return 'Selamat malam,';
  }

  String formatDate(DateTime dt) {
    if (_en) {
      const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
      const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
      return '${days[dt.weekday - 1]}, ${months[dt.month - 1]} ${dt.day}, ${dt.year}';
    }
    const hari = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    const bulan = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
    return '${hari[dt.weekday - 1]}, ${dt.day} ${bulan[dt.month - 1]} ${dt.year}';
  }

  // ── DASHBOARD ────────────────────────────────────────────────────────
  String get mainMenu => _en ? 'Main menu' : 'Menu utama';
  String get running => _en ? 'Running' : 'Berjalan';
  String get stopped => _en ? 'Stopped' : 'Berhenti';
  String get pause => _en ? 'Pause' : 'Jeda';
  String get resume => _en ? 'Continue' : 'Lanjut';
  String get reset => 'Reset';
  String secondsDesc(int s) => _en
      ? '$s seconds elapsed since page opened'
      : '$s detik berjalan sejak halaman ini dibuka';

  // ── MENU ─────────────────────────────────────────────────────────────
  String get profile => _en ? 'Profile' : 'Profil';
  String get settings => _en ? 'Settings' : 'Pengaturan';
  String get help => _en ? 'Help' : 'Bantuan';
  String get information => _en ? 'Information' : 'Informasi';
  String get opening => _en ? 'Opening' : 'Membuka';

  // ── LOGOUT ───────────────────────────────────────────────────────────
  String get logoutTitle => _en ? 'Log Out?' : 'Keluar?';
  String get logoutMessage => _en
      ? 'Are you sure you want to log out?'
      : 'Apakah Anda yakin ingin keluar dari aplikasi?';
  String get cancel => _en ? 'Cancel' : 'Batal';
  String get logout => _en ? 'Log Out' : 'Keluar';

  // ── PROFIL ───────────────────────────────────────────────────────────
  String get clinicLabel => _en ? 'Clinic' : 'Klinik';
  String get statusLabel => 'Status';
  String get patientStatus => _en ? 'Patient' : 'Pasien';

  // ── PENGATURAN ───────────────────────────────────────────────────────
  String get darkModeTitle => _en ? 'Dark mode' : 'Mode gelap';
  String get darkModeDesc => _en
      ? 'Change the entire app appearance'
      : 'Ubah tampilan seluruh aplikasi';
  String get notifTitle => _en ? 'Notifications' : 'Notifikasi';
  String get notifDesc => _en
      ? 'Receive latest clinic announcements'
      : 'Terima pengumuman terbaru dari klinik';
  String get languageTitle => _en ? 'Language' : 'Bahasa';
  String get currentLang => _en ? 'English' : 'Bahasa Indonesia';
  String get selectLang => _en ? 'Select Language' : 'Pilih Bahasa';

  // ── BANTUAN / FAQ ────────────────────────────────────────────────────
  List<Map<String, String>> get faqs => _en ? _faqsEn : _faqsId;

  static const List<Map<String, String>> _faqsId = [
    {
      'q': 'Bagaimana cara mendaftar sebagai pasien baru?',
      'a': 'Kunjungi klinik langsung atau hubungi kami via telepon. Siapkan KTP/identitas diri dan kartu BPJS (jika ada) untuk proses pendaftaran.',
    },
    {
      'q': 'Apa saja metode pembayaran yang diterima?',
      'a': 'Kami menerima pembayaran tunai, kartu debit/kredit, transfer bank, QRIS, serta BPJS Kesehatan dan asuransi swasta yang bekerja sama.',
    },
    {
      'q': 'Bagaimana cara membuat janji temu dengan dokter?',
      'a': 'Anda dapat membuat janji melalui aplikasi ini, menghubungi nomor telepon klinik, atau datang langsung ke bagian pendaftaran.',
    },
    {
      'q': 'Apakah klinik ini melayani pasien BPJS?',
      'a': 'Ya, Klinik Utama Medisy menerima pasien BPJS Kesehatan. Harap membawa kartu BPJS aktif dan surat rujukan jika diperlukan.',
    },
    {
      'q': 'Berapa lama waktu tunggu untuk konsultasi?',
      'a': 'Rata-rata waktu tunggu adalah 15–30 menit. Pembuatan janji temu lebih awal dapat membantu meminimalkan waktu tunggu Anda.',
    },
    {
      'q': 'Bagaimana cara mengambil hasil laboratorium?',
      'a': 'Hasil laboratorium dapat diambil di bagian lab klinik dengan menunjukkan bukti pembayaran dan kartu identitas, atau dikirim via email/WhatsApp.',
    },
    {
      'q': 'Bagaimana cara menghubungi klinik dalam keadaan darurat?',
      'a': 'Dalam keadaan darurat, segera hubungi nomor IGD kami di (021) 1234-5678 yang beroperasi 24 jam, atau langsung datang ke Unit Gawat Darurat.',
    },
  ];

  static const List<Map<String, String>> _faqsEn = [
    {
      'q': 'How do I register as a new patient?',
      'a': 'Visit the clinic directly or contact us by phone. Prepare your ID card and BPJS card (if applicable) for the registration process.',
    },
    {
      'q': 'What payment methods are accepted?',
      'a': 'We accept cash, debit/credit cards, bank transfers, QRIS, as well as BPJS Health and cooperating private insurance.',
    },
    {
      'q': 'How do I make an appointment with a doctor?',
      'a': 'You can make an appointment through this app, by calling the clinic phone number, or by visiting the registration desk.',
    },
    {
      'q': 'Does this clinic serve BPJS patients?',
      'a': 'Yes, Klinik Utama Medisy accepts BPJS Health patients. Please bring your active BPJS card and referral letter if required.',
    },
    {
      'q': 'How long is the waiting time for a consultation?',
      'a': 'The average waiting time is 15–30 minutes. Making an early appointment can help minimize your waiting time.',
    },
    {
      'q': 'How do I collect laboratory results?',
      'a': 'Lab results can be collected at the clinic lab by showing your payment receipt and ID card, or sent via email/WhatsApp.',
    },
    {
      'q': 'How do I contact the clinic in an emergency?',
      'a': 'In an emergency, call our ER at (021) 1234-5678 which operates 24 hours, or go directly to the Emergency Unit.',
    },
  ];

  // ── INFORMASI ────────────────────────────────────────────────────────
  String get versionLabel => _en ? 'Version' : 'Versi';
  String get builtWithLabel => _en ? 'Built with' : 'Dibuat dengan';
  String get contactLabel => _en ? 'Clinic Contact' : 'Kontak Klinik';
  String get addressLabel => _en ? 'Address' : 'Alamat';
  String get licenseBtn => _en ? 'License & about the app' : 'Lisensi & tentang aplikasi';
  String get aboutDesc => _en
      ? 'A clinic management app for Klinik Utama Medisy patients. Simplifies registration, consultation, and health monitoring.'
      : 'Aplikasi manajemen klinik untuk pasien Klinik Utama Medisy. Memudahkan pendaftaran, konsultasi, dan pemantauan kesehatan Anda.';
}

/// Daftar bahasa yang didukung
const List<Map<String, String>> supportedLanguages = [
  {'code': 'id', 'name': 'Bahasa Indonesia', 'flag': '🇮🇩'},
  {'code': 'en', 'name': 'English', 'flag': '🇬🇧'},
];
