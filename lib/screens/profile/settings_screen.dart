import 'package:flutter/material.dart';
import '../../utils/theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _smsNotifications = true;
  bool _biometricAuth = false;
  bool _darkMode = false;
  String _selectedLanguage = 'Türkçe';
  String _selectedCurrency = 'TRY';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.primaryColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Bildirim ayarları
                _SettingsSection(
                  title: 'Bildirimler',
                  children: [
                    _SettingsSwitch(
                      title: 'Push Bildirimleri',
                      subtitle: 'Uygulama bildirimlerini al',
                      value: _pushNotifications,
                      onChanged: (value) {
                        setState(() {
                          _pushNotifications = value;
                        });
                      },
                    ),
                    _SettingsSwitch(
                      title: 'E-posta Bildirimleri',
                      subtitle: 'E-posta ile bildirim al',
                      value: _emailNotifications,
                      onChanged: (value) {
                        setState(() {
                          _emailNotifications = value;
                        });
                      },
                    ),
                    _SettingsSwitch(
                      title: 'SMS Bildirimleri',
                      subtitle: 'SMS ile bildirim al',
                      value: _smsNotifications,
                      onChanged: (value) {
                        setState(() {
                          _smsNotifications = value;
                        });
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Güvenlik ayarları
                _SettingsSection(
                  title: 'Güvenlik',
                  children: [
                    _SettingsSwitch(
                      title: 'Biyometrik Kimlik Doğrulama',
                      subtitle: 'Parmak izi veya yüz tanıma kullan',
                      value: _biometricAuth,
                      onChanged: (value) {
                        setState(() {
                          _biometricAuth = value;
                        });
                      },
                    ),
                    _SettingsItem(
                      title: 'Şifre Değiştir',
                      subtitle: 'Hesap şifrenizi güncelleyin',
                      icon: Icons.lock_outline,
                      onTap: () => _showChangePasswordDialog(),
                    ),
                    _SettingsItem(
                      title: 'PIN Ayarla',
                      subtitle: 'Hızlı giriş için PIN oluşturun',
                      icon: Icons.pin_outlined,
                      onTap: () => _showSetPinDialog(),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Görünüm ayarları
                _SettingsSection(
                  title: 'Görünüm',
                  children: [
                    _SettingsSwitch(
                      title: 'Karanlık Mod',
                      subtitle: 'Koyu tema kullan',
                      value: _darkMode,
                      onChanged: (value) {
                        setState(() {
                          _darkMode = value;
                        });
                      },
                    ),
                    _SettingsDropdown(
                      title: 'Dil',
                      subtitle: 'Uygulama dili',
                      value: _selectedLanguage,
                      items: const ['Türkçe', 'English', 'العربية'],
                      onChanged: (value) {
                        setState(() {
                          _selectedLanguage = value!;
                        });
                      },
                    ),
                    _SettingsDropdown(
                      title: 'Para Birimi',
                      subtitle: 'Varsayılan para birimi',
                      value: _selectedCurrency,
                      items: const ['TRY', 'USD', 'EUR'],
                      onChanged: (value) {
                        setState(() {
                          _selectedCurrency = value!;
                        });
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Hesap ayarları
                _SettingsSection(
                  title: 'Hesap',
                  children: [
                    _SettingsItem(
                      title: 'Hesap Bilgileri',
                      subtitle: 'Kişisel bilgilerinizi görüntüleyin',
                      icon: Icons.person_outline,
                      onTap: () => _showAccountInfoDialog(),
                    ),
                    _SettingsItem(
                      title: 'Hesap Kapatma',
                      subtitle: 'Hesabınızı kalıcı olarak kapatın',
                      icon: Icons.delete_outline,
                      onTap: () => _showDeleteAccountDialog(),
                      isDestructive: true,
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Uygulama bilgileri
                _SettingsSection(
                  title: 'Uygulama',
                  children: [
                    _SettingsItem(
                      title: 'Sürüm',
                      subtitle: '1.0.0',
                      icon: Icons.info_outline,
                      onTap: () => _showVersionInfoDialog(),
                    ),
                    _SettingsItem(
                      title: 'Gizlilik Politikası',
                      subtitle: 'Veri kullanımı ve gizlilik',
                      icon: Icons.privacy_tip_outlined,
                      onTap: () => _showPrivacyPolicyDialog(),
                    ),
                    _SettingsItem(
                      title: 'Kullanım Şartları',
                      subtitle: 'Hizmet şartları ve koşullar',
                      icon: Icons.description_outlined,
                      onTap: () => _showTermsOfServiceDialog(),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Sıfırla butonu
                Container(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => _showResetDialog(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Ayarları Sıfırla',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Şifre Değiştir'),
        content: const Text('Şifre değiştirmek için müşteri hizmetleri ile iletişime geçin.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  void _showSetPinDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('PIN Ayarla'),
        content: const Text('PIN ayarlamak için müşteri hizmetleri ile iletişime geçin.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  void _showAccountInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hesap Bilgileri'),
        content: const Text('Hesap bilgilerinizi görüntülemek için müşteri hizmetleri ile iletişime geçin.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hesap Kapatma'),
        content: const Text('Hesabınızı kapatmak için müşteri hizmetleri ile iletişime geçin. Bu işlem geri alınamaz.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
            ),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }

  void _showVersionInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sürüm Bilgileri'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fintech App'),
            Text('Sürüm: 1.0.0'),
            Text('Build: 1'),
            SizedBox(height: 16),
            Text('© 2024 Fintech App. Tüm hakları saklıdır.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Gizlilik Politikası'),
        content: const Text('Gizlilik politikamızı görüntülemek için müşteri hizmetleri ile iletişime geçin.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  void _showTermsOfServiceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kullanım Şartları'),
        content: const Text('Kullanım şartlarımızı görüntülemek için müşteri hizmetleri ile iletişime geçin.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ayarları Sıfırla'),
        content: const Text('Tüm ayarları varsayılan değerlere sıfırlamak istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _pushNotifications = true;
                _emailNotifications = false;
                _smsNotifications = true;
                _biometricAuth = false;
                _darkMode = false;
                _selectedLanguage = 'Türkçe';
                _selectedCurrency = 'TRY';
              });
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Ayarlar sıfırlandı'),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            },
            child: const Text('Sıfırla'),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

class _SettingsSwitch extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsSwitch({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Colors.grey[600],
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.primaryColor,
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDestructive;

  const _SettingsItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? AppTheme.errorColor : AppTheme.primaryColor,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: isDestructive ? AppTheme.errorColor : null,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Colors.grey[600],
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}

class _SettingsDropdown extends StatelessWidget {
  final String title;
  final String subtitle;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _SettingsDropdown({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Colors.grey[600],
        ),
      ),
      trailing: DropdownButton<String>(
        value: value,
        onChanged: onChanged,
        underline: Container(),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }
}
