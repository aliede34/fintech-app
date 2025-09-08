import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  // Kullanıcı girişi
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      // Simüle edilmiş API çağrısı
      await Future.delayed(const Duration(seconds: 2));
      
      // Demo kullanıcı kontrolü
      if (email == 'demo@fintech.com' && password == '123456') {
        _currentUser = User(
          id: '1',
          email: email,
          name: 'Demo Kullanıcı',
          phoneNumber: '+90 555 123 4567',
          balance: 15000.50,
          accountNumber: '1234567890',
        );
        
        await _saveUserData();
        _setLoading(false);
        return true;
      } else {
        _setError('Geçersiz email veya şifre');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('Giriş yapılırken bir hata oluştu: $e');
      _setLoading(false);
      return false;
    }
  }

  // Kullanıcı kaydı
  Future<bool> register(String name, String email, String password, String phoneNumber) async {
    _setLoading(true);
    _clearError();

    try {
      // Simüle edilmiş API çağrısı
      await Future.delayed(const Duration(seconds: 2));
      
      _currentUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        name: name,
        phoneNumber: phoneNumber,
        balance: 0.0,
        accountNumber: _generateAccountNumber(),
      );
      
      await _saveUserData();
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Kayıt olurken bir hata oluştu: $e');
      _setLoading(false);
      return false;
    }
  }

  // Kullanıcı çıkışı
  Future<void> logout() async {
    _currentUser = null;
    await _clearUserData();
    notifyListeners();
  }

  // Uygulama başlangıcında kullanıcı verilerini yükle
  Future<void> loadUserData() async {
    try {
      final email = await _secureStorage.read(key: 'user_email');
      final name = await _secureStorage.read(key: 'user_name');
      final phoneNumber = await _secureStorage.read(key: 'user_phone');
      final balanceStr = await _secureStorage.read(key: 'user_balance');
      final accountNumber = await _secureStorage.read(key: 'user_account');
      final userId = await _secureStorage.read(key: 'user_id');

      if (email != null && name != null && userId != null) {
        _currentUser = User(
          id: userId,
          email: email,
          name: name,
          phoneNumber: phoneNumber ?? '',
          balance: double.tryParse(balanceStr ?? '0') ?? 0.0,
          accountNumber: accountNumber ?? '',
        );
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Kullanıcı verileri yüklenirken hata: $e');
    }
  }

  // Kullanıcı verilerini güvenli depolamada sakla
  Future<void> _saveUserData() async {
    if (_currentUser != null) {
      await _secureStorage.write(key: 'user_id', value: _currentUser!.id);
      await _secureStorage.write(key: 'user_email', value: _currentUser!.email);
      await _secureStorage.write(key: 'user_name', value: _currentUser!.name);
      await _secureStorage.write(key: 'user_phone', value: _currentUser!.phoneNumber);
      await _secureStorage.write(key: 'user_balance', value: _currentUser!.balance.toString());
      await _secureStorage.write(key: 'user_account', value: _currentUser!.accountNumber);
    }
  }

  // Kullanıcı verilerini temizle
  Future<void> _clearUserData() async {
    await _secureStorage.deleteAll();
  }

  // Hesap numarası oluştur
  String _generateAccountNumber() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return (timestamp % 10000000000).toString().padLeft(10, '0');
  }

  // Bakiye güncelle
  void updateBalance(double newBalance) {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(balance: newBalance);
      _saveUserData();
      notifyListeners();
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
