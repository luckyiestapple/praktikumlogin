import 'package:flutter/material.dart';
import 'main.dart' show isDarkModeNotifier, languageNotifier;
import 'app_strings.dart';

// =============================================================================
// Warna konstanta bersama
// =============================================================================
const Color _medisyTeal = Color(0xFF00897B);
const Color _medisyTealDark = Color(0xFF00695C);

// =============================================================================
// 1. PROFIL PAGE
// =============================================================================
class ProfilPage extends StatelessWidget {
  final String email;

  const ProfilPage({Key? key, required this.email}) : super(key: key);

  String _getNameFromEmail(String email) {
    final namePart = email.split('@').first;
    return namePart
        .replaceAll(RegExp(r'[._]'), ' ')
        .split(' ')
        .map((w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '')
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final name = _getNameFromEmail(email);
    final initial = name.isNotEmpty ? name[0].toUpperCase() : 'P';

    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, lang, _) {
        final strings = AppStrings.of(lang);

        return Scaffold(
          backgroundColor: const Color(0xFFF2F4F7),
          appBar: AppBar(
            title: Text(strings.profile, style: const TextStyle(fontWeight: FontWeight.w700)),
            backgroundColor: _medisyTeal,
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                children: [
                  Container(width: double.infinity, height: 30, color: _medisyTeal),
                  Transform.translate(
                    offset: const Offset(0, -45),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: _medisyTealDark,
                          child: Text(
                            initial,
                            style: const TextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          name,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Transform.translate(
                      offset: const Offset(0, -30),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 14, offset: const Offset(0, 4)),
                          ],
                        ),
                        child: Column(
                          children: [
                            _InfoTile(icon: Icons.email_outlined, label: 'Email', value: email, showDivider: true),
                            _InfoTile(icon: Icons.local_hospital_outlined, label: strings.clinicLabel, value: 'Klinik Utama Medisy', showDivider: true),
                            _InfoTile(icon: Icons.badge_outlined, label: strings.statusLabel, value: strings.patientStatus, showDivider: false),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Widget tile info baris
class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool showDivider;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Icon(icon, color: _medisyTeal, size: 22),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                    const SizedBox(height: 2),
                    Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (showDivider) Divider(height: 1, color: Colors.grey[100], indent: 56),
      ],
    );
  }
}

// =============================================================================
// 2. PENGATURAN PAGE
// =============================================================================
class PengaturanPage extends StatefulWidget {
  const PengaturanPage({Key? key}) : super(key: key);

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  bool _notifikasi = true;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, lang, _) {
        final strings = AppStrings.of(lang);

        return Scaffold(
          backgroundColor: const Color(0xFFF2F4F7),
          appBar: AppBar(
            title: Text(strings.settings, style: const TextStyle(fontWeight: FontWeight.w700)),
            backgroundColor: _medisyTeal,
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 14, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Toggle Mode Gelap
                      ValueListenableBuilder<bool>(
                        valueListenable: isDarkModeNotifier,
                        builder: (context, isDark, _) {
                          return SwitchListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                            secondary: const Icon(Icons.dark_mode_outlined, color: _medisyTeal, size: 26),
                            title: Text(strings.darkModeTitle, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                            subtitle: Text(strings.darkModeDesc, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                            value: isDark,
                            activeColor: _medisyTeal,
                            onChanged: (val) => isDarkModeNotifier.value = val,
                          );
                        },
                      ),
                      Divider(height: 1, color: Colors.grey[100], indent: 20),

                      // Toggle Notifikasi
                      SwitchListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        secondary: const Icon(Icons.notifications_outlined, color: _medisyTeal, size: 26),
                        title: Text(strings.notifTitle, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        subtitle: Text(strings.notifDesc, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                        value: _notifikasi,
                        activeColor: _medisyTeal,
                        onChanged: (val) => setState(() => _notifikasi = val),
                      ),
                      Divider(height: 1, color: Colors.grey[100], indent: 20),

                      // Pilihan Bahasa
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        leading: const Icon(Icons.language_outlined, color: _medisyTeal, size: 26),
                        title: Text(strings.languageTitle, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        subtitle: Text(strings.currentLang, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                        trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            builder: (context) {
                              return SafeArea(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Text(
                                        strings.selectLang,
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    ...supportedLanguages.map((langItem) {
                                      return ListTile(
                                        leading: Text(langItem['flag']!, style: const TextStyle(fontSize: 24)),
                                        title: Text(langItem['name']!),
                                        trailing: lang == langItem['code']
                                            ? const Icon(Icons.check, color: _medisyTeal)
                                            : null,
                                        onTap: () {
                                          languageNotifier.value = langItem['code']!;
                                          Navigator.pop(context);
                                        },
                                      );
                                    }).toList(),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// =============================================================================
// 3. BANTUAN PAGE
// =============================================================================
class BantuanPage extends StatefulWidget {
  const BantuanPage({Key? key}) : super(key: key);

  @override
  State<BantuanPage> createState() => _BantuanPageState();
}

class _BantuanPageState extends State<BantuanPage> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, lang, _) {
        final strings = AppStrings.of(lang);
        final faqs = strings.faqs;

        return Scaffold(
          backgroundColor: const Color(0xFFF2F4F7),
          appBar: AppBar(
            title: Text(strings.help, style: const TextStyle(fontWeight: FontWeight.w700)),
            backgroundColor: _medisyTeal,
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: faqs.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final faq = faqs[index];
                  final isExpanded = _expandedIndex == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 3)),
                      ],
                      border: isExpanded ? Border.all(color: _medisyTeal.withOpacity(0.4), width: 1.2) : null,
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => setState(() => _expandedIndex = isExpanded ? null : index),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.help_outline, color: _medisyTeal, size: 20),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    faq['q']!,
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E), height: 1.4),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.grey[400], size: 22),
                              ],
                            ),
                            if (isExpanded) ...[
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Text(
                                  faq['a']!,
                                  style: TextStyle(fontSize: 13, color: Colors.grey[600], height: 1.5),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

// =============================================================================
// 4. INFORMASI PAGE
// =============================================================================
class InformasiPage extends StatelessWidget {
  const InformasiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, lang, _) {
        final strings = AppStrings.of(lang);

        return Scaffold(
          backgroundColor: const Color(0xFFF2F4F7),
          appBar: AppBar(
            title: Text(strings.information, style: const TextStyle(fontWeight: FontWeight.w700)),
            backgroundColor: _medisyTeal,
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 14, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 32),
                      Image.asset(
                        'assets/images/logo.png',
                        height: 56,
                        errorBuilder: (_, __, ___) => const Icon(Icons.local_hospital, size: 64, color: _medisyTeal),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'MEDISY',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 2, color: _medisyTeal),
                      ),
                      const SizedBox(height: 4),
                      Text('Klinik Utama Medisy', style: TextStyle(fontSize: 13, color: Colors.grey[500])),
                      const SizedBox(height: 24),
                      Divider(height: 1, color: Colors.grey[100]),
                      _InfoTile(icon: Icons.tag, label: strings.versionLabel, value: '1.0.0', showDivider: true),
                      _InfoTile(icon: Icons.code, label: strings.builtWithLabel, value: 'Flutter', showDivider: true),
                      _InfoTile(icon: Icons.phone_outlined, label: strings.contactLabel, value: '(021) 1234-5678', showDivider: true),
                      _InfoTile(icon: Icons.location_on_outlined, label: strings.addressLabel, value: 'Jl. Medisy Raya No.1, Jakarta', showDivider: false),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: OutlinedButton.icon(
                          onPressed: () {
                            showAboutDialog(
                              context: context,
                              applicationName: 'Medisy',
                              applicationVersion: '1.0.0',
                              applicationIcon: const Icon(Icons.local_hospital, color: _medisyTeal, size: 36),
                              children: [Text(strings.aboutDesc)],
                            );
                          },
                          icon: const Icon(Icons.article_outlined, size: 18),
                          label: Text(strings.licenseBtn),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: _medisyTeal,
                            side: const BorderSide(color: _medisyTeal),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            minimumSize: const Size(double.infinity, 44),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
