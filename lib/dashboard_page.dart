import 'dart:async';

import 'package:flutter/material.dart';

import 'login_page.dart';
import 'detail_dashboard.dart';
import 'app_strings.dart';
import 'main.dart' show languageNotifier;

class DashboardPage extends StatefulWidget {
  final String email;

  const DashboardPage({Key? key, required this.email}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  static const Color medisyTeal = Color(0xFF00897B);
  static const Color medisyTealDark = Color(0xFF00695C);

  int _seconds = 0;
  bool _isRunning = false;
  Timer? _stopwatchTimer;

  late DateTime _now;
  Timer? _clockTimer;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _stopwatchTimer?.cancel();
    _clockTimer?.cancel();
    super.dispose();
  }

  void _startStopwatch() {
    setState(() => _isRunning = true);
    _stopwatchTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _seconds++);
    });
  }

  void _pauseStopwatch() {
    _stopwatchTimer?.cancel();
    setState(() => _isRunning = false);
  }

  void _resetStopwatch() {
    _stopwatchTimer?.cancel();
    setState(() {
      _seconds = 0;
      _isRunning = false;
    });
  }

  String _formatTime(int totalSeconds) {
    final m = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  String _getNameFromEmail(String email) {
    final namePart = email.split('@').first;
    return namePart
        .replaceAll(RegExp(r'[._]'), ' ')
        .split(' ')
        .map(
          (w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '',
        )
        .join(' ');
  }

  void _navigateMenu(BuildContext context, String titleId) {
    Widget page;
    switch (titleId) {
      case 'profil':
        page = ProfilPage(email: widget.email);
        break;
      case 'pengaturan':
        page = const PengaturanPage();
        break;
      case 'bantuan':
        page = const BantuanPage();
        break;
      case 'informasi':
        page = const InformasiPage();
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, anim, __, child) {
          return FadeTransition(opacity: anim, child: child);
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AppStrings strings) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          strings.logoutTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: medisyTeal,
          ),
        ),
        content: Text(strings.logoutMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              strings.cancel,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(strings.logout),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, lang, _) {
        final strings = AppStrings.of(lang);
        final colorScheme = Theme.of(context).colorScheme;
        final menus = [
          {
            'id': 'profil',
            'title': strings.profile,
            'icon': Icons.person_outline,
            'color': const Color(0xFF00897B),
          },
          {
            'id': 'pengaturan',
            'title': strings.settings,
            'icon': Icons.settings_outlined,
            'color': const Color(0xFF0288D1),
          },
          {
            'id': 'bantuan',
            'title': strings.help,
            'icon': Icons.help_outline,
            'color': const Color(0xFF7B1FA2),
          },
          {
            'id': 'informasi',
            'title': strings.information,
            'icon': Icons.info_outline,
            'color': const Color(0xFF00838F),
          },
        ];

        return Scaffold(
          backgroundColor: colorScheme.surface,
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      _buildHeader(context, strings),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildStopwatch(context, strings),
                            const SizedBox(height: 32),
                            Text(
                              strings.mainMenu,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 16),
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    crossAxisSpacing: 14,
                                    mainAxisSpacing: 14,
                                    childAspectRatio: 1.0,
                                  ),
                              itemCount: menus.length,
                              itemBuilder: (context, index) {
                                final menu = menus[index];
                                final Color color = menu['color'] as Color;
                                return GestureDetector(
                                  onTap: () => _navigateMenu(
                                    context,
                                    menu['id'] as String,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: colorScheme.surfaceContainer,
                                      borderRadius: BorderRadius.circular(18),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.06),
                                          blurRadius: 12,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 28,
                                          backgroundColor: color.withOpacity(
                                            0.12,
                                          ),
                                          child: Icon(
                                            menu['icon'] as IconData,
                                            size: 30,
                                            color: color,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          menu['title'] as String,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: colorScheme.onSurface,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
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

  Widget _buildHeader(BuildContext context, AppStrings strings) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [medisyTealDark, medisyTeal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 28,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.local_hospital,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'MEDISY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () => _showLogoutDialog(context, strings),
                icon: const Icon(Icons.logout_rounded, color: Colors.white),
                tooltip: strings.logout,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      strings.getSalam(_now.hour),
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getNameFromEmail(widget.email),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    strings.formatDate(_now),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStopwatch(BuildContext context, AppStrings strings) {
    final colorScheme = Theme.of(context).colorScheme;
    final toggleButton = ElevatedButton.icon(
      onPressed: () {
        if (_isRunning) {
          _pauseStopwatch();
        } else {
          _startStopwatch();
        }
      },
      icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow, size: 20),
      label: Text(_isRunning ? strings.pause : strings.resume),
      style: ElevatedButton.styleFrom(
        backgroundColor: medisyTeal,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
    );
    final resetButton = OutlinedButton.icon(
      onPressed: _resetStopwatch,
      icon: const Icon(Icons.refresh, size: 20),
      label: Text(strings.reset),
      style: OutlinedButton.styleFrom(
        foregroundColor: medisyTeal,
        padding: const EdgeInsets.symmetric(vertical: 13),
        side: const BorderSide(color: medisyTeal, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.timer_outlined, color: medisyTeal, size: 22),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'Stopwatch',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _isRunning
                      ? Colors.green.withOpacity(0.1)
                      : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isRunning ? Colors.green : Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _isRunning ? strings.running : strings.stopped,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _isRunning
                            ? Colors.green[700]
                            : Colors.orange[800],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                _formatTime(_seconds),
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text(
              strings.secondsDesc(_seconds),
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 360) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    toggleButton,
                    const SizedBox(height: 12),
                    resetButton,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: toggleButton),
                  const SizedBox(width: 12),
                  Expanded(child: resetButton),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
