import 'package:flutter/foundation.dart';
import '../models/transaction.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Demo işlemler
  List<Transaction> get demoTransactions => [
    Transaction(
      id: '1',
      type: TransactionType.transfer,
      amount: 500.0,
      description: 'Ahmet Yılmaz\'a transfer',
      recipientName: 'Ahmet Yılmaz',
      recipientAccount: '9876543210',
      date: DateTime.now().subtract(const Duration(days: 1)),
      status: TransactionStatus.completed,
    ),
    Transaction(
      id: '2',
      type: TransactionType.deposit,
      amount: 2000.0,
      description: 'Maaş yatırımı',
      date: DateTime.now().subtract(const Duration(days: 3)),
      status: TransactionStatus.completed,
    ),
    Transaction(
      id: '3',
      type: TransactionType.withdrawal,
      amount: 150.0,
      description: 'ATM çekimi',
      date: DateTime.now().subtract(const Duration(days: 5)),
      status: TransactionStatus.completed,
    ),
    Transaction(
      id: '4',
      type: TransactionType.payment,
      amount: 75.50,
      description: 'Market alışverişi',
      date: DateTime.now().subtract(const Duration(days: 7)),
      status: TransactionStatus.completed,
    ),
  ];

  // İşlemleri yükle
  Future<void> loadTransactions() async {
    _setLoading(true);
    _clearError();

    try {
      // Simüle edilmiş API çağrısı
      await Future.delayed(const Duration(seconds: 1));
      _transactions = demoTransactions;
      _setLoading(false);
    } catch (e) {
      _setError('İşlemler yüklenirken bir hata oluştu: $e');
      _setLoading(false);
    }
  }

  // Yeni işlem ekle
  Future<bool> addTransaction(Transaction transaction) async {
    _setLoading(true);
    _clearError();

    try {
      // Simüle edilmiş API çağrısı
      await Future.delayed(const Duration(seconds: 1));
      
      _transactions.insert(0, transaction);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('İşlem eklenirken bir hata oluştu: $e');
      _setLoading(false);
      return false;
    }
  }

  // Para transferi
  Future<bool> transferMoney({
    required String recipientName,
    required String recipientAccount,
    required double amount,
    required String description,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      // Simüle edilmiş API çağrısı
      await Future.delayed(const Duration(seconds: 2));
      
      final transaction = Transaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: TransactionType.transfer,
        amount: amount,
        description: description,
        recipientName: recipientName,
        recipientAccount: recipientAccount,
        date: DateTime.now(),
        status: TransactionStatus.completed,
      );
      
      _transactions.insert(0, transaction);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Transfer işlemi sırasında bir hata oluştu: $e');
      _setLoading(false);
      return false;
    }
  }

  // Para yatırma
  Future<bool> depositMoney({
    required double amount,
    required String description,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      // Simüle edilmiş API çağrısı
      await Future.delayed(const Duration(seconds: 1));
      
      final transaction = Transaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: TransactionType.deposit,
        amount: amount,
        description: description,
        date: DateTime.now(),
        status: TransactionStatus.completed,
      );
      
      _transactions.insert(0, transaction);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Para yatırma işlemi sırasında bir hata oluştu: $e');
      _setLoading(false);
      return false;
    }
  }

  // Para çekme
  Future<bool> withdrawMoney({
    required double amount,
    required String description,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      // Simüle edilmiş API çağrısı
      await Future.delayed(const Duration(seconds: 1));
      
      final transaction = Transaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: TransactionType.withdrawal,
        amount: amount,
        description: description,
        date: DateTime.now(),
        status: TransactionStatus.completed,
      );
      
      _transactions.insert(0, transaction);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Para çekme işlemi sırasında bir hata oluştu: $e');
      _setLoading(false);
      return false;
    }
  }

  // Ödeme yapma
  Future<bool> makePayment({
    required double amount,
    required String description,
    required String merchantName,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      // Simüle edilmiş API çağrısı
      await Future.delayed(const Duration(seconds: 1));
      
      final transaction = Transaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: TransactionType.payment,
        amount: amount,
        description: description,
        recipientName: merchantName,
        date: DateTime.now(),
        status: TransactionStatus.completed,
      );
      
      _transactions.insert(0, transaction);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Ödeme işlemi sırasında bir hata oluştu: $e');
      _setLoading(false);
      return false;
    }
  }

  // İşlem geçmişini filtrele
  List<Transaction> getTransactionsByType(TransactionType type) {
    return _transactions.where((transaction) => transaction.type == type).toList();
  }

  // Son N günün işlemlerini getir
  List<Transaction> getRecentTransactions(int days) {
    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    return _transactions.where((transaction) => transaction.date.isAfter(cutoffDate)).toList();
  }

  // Toplam gelir
  double get totalIncome {
    return _transactions
        .where((transaction) => 
            transaction.type == TransactionType.deposit && 
            transaction.status == TransactionStatus.completed)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  // Toplam gider
  double get totalExpense {
    return _transactions
        .where((transaction) => 
            (transaction.type == TransactionType.transfer || 
             transaction.type == TransactionType.withdrawal || 
             transaction.type == TransactionType.payment) && 
            transaction.status == TransactionStatus.completed)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
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
