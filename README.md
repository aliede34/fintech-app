# Fintech App

Modern ve kullanıcı dostu bir fintech mobil uygulaması. Flutter ve Dart ile geliştirilmiştir.

## 🚀 Özellikler

### 🔐 Kimlik Doğrulama
- Kullanıcı girişi ve kayıt
- Güvenli veri saklama (Flutter Secure Storage)
- Demo hesap desteği

### 💰 Finansal İşlemler
- Para transferi
- Para yatırma ve çekme
- Ödeme işlemleri
- İşlem geçmişi görüntüleme
- Gerçek zamanlı bakiye takibi

### 📱 Kullanıcı Arayüzü
- Modern ve responsive tasarım
- Material Design 3
- Google Fonts entegrasyonu
- Gradient arka planlar
- Animasyonlu geçişler

### 🛡️ Güvenlik
- Biyometrik kimlik doğrulama desteği
- PIN kodu ayarları
- Güvenli veri şifreleme
- İşlem onay mekanizmaları

### ⚙️ Ayarlar ve Profil
- Kişisel bilgi yönetimi
- Bildirim ayarları
- Dil ve para birimi seçenekleri
- Karanlık mod desteği

## 📋 Gereksinimler

- Flutter SDK (3.0.0 veya üzeri)
- Dart SDK (3.0.0 veya üzeri)
- Android Studio / VS Code
- Android 5.0+ / iOS 11.0+

## 🛠️ Kurulum

1. **Projeyi klonlayın:**
   ```bash
   git clone <repository-url>
   cd fintech_app
   ```

2. **Bağımlılıkları yükleyin:**
   ```bash
   flutter pub get
   ```

3. **Uygulamayı çalıştırın:**
   ```bash
   flutter run
   ```

## 📦 Kullanılan Paketler

- **http**: API istekleri için
- **shared_preferences**: Yerel veri saklama
- **local_auth**: Biyometrik kimlik doğrulama
- **crypto**: Veri şifreleme
- **intl**: Tarih ve para formatı
- **provider**: State management
- **sqflite**: Yerel veritabanı
- **flutter_secure_storage**: Güvenli veri saklama
- **google_fonts**: Font entegrasyonu
- **lottie**: Animasyonlar

## 🏗️ Proje Yapısı

```
lib/
├── main.dart                 # Ana uygulama dosyası
├── models/                   # Veri modelleri
│   ├── user.dart
│   └── transaction.dart
├── providers/                # State management
│   ├── auth_provider.dart
│   └── transaction_provider.dart
├── screens/                  # Ekranlar
│   ├── auth/                 # Kimlik doğrulama
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   ├── home/                 # Ana sayfa
│   │   └── dashboard_screen.dart
│   ├── transaction/          # İşlemler
│   │   ├── transfer_screen.dart
│   │   └── transaction_history_screen.dart
│   ├── profile/              # Profil
│   │   ├── profile_screen.dart
│   │   └── settings_screen.dart
│   └── splash_screen.dart    # Açılış ekranı
└── utils/                    # Yardımcı dosyalar
    └── theme.dart            # Tema ayarları
```

## 🎨 Tema ve Tasarım

Uygulama, modern ve kullanıcı dostu bir tasarıma sahiptir:

- **Ana Renkler**: Mavi tonları (#1E3A8A, #3B82F6)
- **Vurgu Renkleri**: Yeşil (#10B981), Turuncu (#F59E0B)
- **Font**: Google Fonts - Inter
- **Tasarım Sistemi**: Material Design 3

## 🔧 Demo Hesap

Uygulamayı test etmek için aşağıdaki demo hesabı kullanabilirsiniz:

- **E-posta**: demo@fintech.com
- **Şifre**: 123456

## 📱 Ekran Görüntüleri

### Ana Özellikler:
- 🏠 **Dashboard**: Bakiye görüntüleme ve hızlı işlemler
- 💸 **Para Transferi**: Güvenli para transferi
- 📊 **İşlem Geçmişi**: Detaylı işlem listesi
- 👤 **Profil**: Kullanıcı bilgileri ve ayarlar
- ⚙️ **Ayarlar**: Uygulama tercihleri

## 🚀 Gelecek Özellikler

- [ ] QR kod ile para transferi
- [ ] Fatura ödeme sistemi
- [ ] Yatırım takibi
- [ ] Kripto para desteği
- [ ] Çoklu para birimi
- [ ] Offline mod desteği

## 🤝 Katkıda Bulunma

1. Fork yapın
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Commit yapın (`git commit -m 'Add amazing feature'`)
4. Push yapın (`git push origin feature/amazing-feature`)
5. Pull Request oluşturun

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için `LICENSE` dosyasına bakın.

## 📞 İletişim

- **E-posta**: destek@fintech.com
- **Telefon**: 0850 123 4567
- **Website**: https://fintech.com

## 🙏 Teşekkürler

- Flutter ekibine harika framework için
- Tüm açık kaynak paket geliştiricilerine
- Topluluk desteği için

---

**Not**: Bu uygulama demo amaçlı geliştirilmiştir. Gerçek finansal işlemler için uygun güvenlik önlemleri alınmalıdır.
