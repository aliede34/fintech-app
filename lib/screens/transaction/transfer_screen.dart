import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/transaction_provider.dart';
import '../../utils/theme.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _formKey = GlobalKey<FormState>();
  final _recipientNameController = TextEditingController();
  final _recipientAccountController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _recipientNameController.dispose();
    _recipientAccountController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _transferMoney() async {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text);
      final currentBalance = context.read<AuthProvider>().currentUser?.balance ?? 0;

      if (amount > currentBalance) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Yetersiz bakiye'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
        return;
      }

      // Onay dialog'u göster
      final confirmed = await _showConfirmationDialog(amount);
      if (confirmed == true) {
        final success = await context.read<TransactionProvider>().transferMoney(
          recipientName: _recipientNameController.text.trim(),
          recipientAccount: _recipientAccountController.text.trim(),
          amount: amount,
          description: _descriptionController.text.trim(),
        );

        if (success && mounted) {
          // Bakiye güncelle
          final authProvider = context.read<AuthProvider>();
          authProvider.updateBalance(currentBalance - amount);

          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Transfer başarıyla tamamlandı'),
              backgroundColor: AppTheme.successColor,
            ),
          );
        } else if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.read<TransactionProvider>().errorMessage ?? 'Transfer başarısız'),
              backgroundColor: AppTheme.errorColor,
            ),
          );
        }
      }
    }
  }

  Future<bool?> _showConfirmationDialog(double amount) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Transfer Onayı'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Alıcı: ${_recipientNameController.text}'),
            Text('Hesap: ${_recipientAccountController.text}'),
            Text('Miktar: ₺${amount.toStringAsFixed(2)}'),
            if (_descriptionController.text.isNotEmpty)
              Text('Açıklama: ${_descriptionController.text}'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.warningColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.warningColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber, color: AppTheme.warningColor, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Bu işlem geri alınamaz. Lütfen bilgileri kontrol edin.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.warningColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Onayla'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Para Transferi'),
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
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Mevcut bakiye kartı
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Mevcut Bakiye',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                          return Text(
                            '₺${authProvider.currentUser?.balance.toStringAsFixed(2).replaceAllMapped(
                              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]}.',
                            ) ?? '0.00'}',
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Transfer formu
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Transfer Bilgileri',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Alıcı adı
                        TextFormField(
                          controller: _recipientNameController,
                          decoration: const InputDecoration(
                            labelText: 'Alıcı Adı Soyadı',
                            prefixIcon: Icon(Icons.person_outlined),
                            hintText: 'Alıcının adını ve soyadını girin',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Alıcı adı gerekli';
                            }
                            if (value.trim().split(' ').length < 2) {
                              return 'Ad ve soyad girin';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // Alıcı hesap numarası
                        TextFormField(
                          controller: _recipientAccountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Hesap Numarası',
                            prefixIcon: Icon(Icons.account_balance_outlined),
                            hintText: '10 haneli hesap numarası',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Hesap numarası gerekli';
                            }
                            if (value.trim().length != 10) {
                              return 'Hesap numarası 10 haneli olmalı';
                            }
                            if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
                              return 'Sadece rakam girin';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // Transfer miktarı
                        TextFormField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Transfer Miktarı',
                            prefixIcon: Icon(Icons.attach_money),
                            prefixText: '₺',
                            hintText: '0.00',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Transfer miktarı gerekli';
                            }
                            final amount = double.tryParse(value);
                            if (amount == null || amount <= 0) {
                              return 'Geçerli bir miktar girin';
                            }
                            if (amount < 1) {
                              return 'Minimum transfer miktarı ₺1';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // Açıklama
                        TextFormField(
                          controller: _descriptionController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'Açıklama (İsteğe bağlı)',
                            prefixIcon: Icon(Icons.description_outlined),
                            hintText: 'Transfer açıklaması...',
                            alignLabelWithHint: true,
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Transfer butonu
                        Consumer<TransactionProvider>(
                          builder: (context, transactionProvider, child) {
                            return ElevatedButton(
                              onPressed: transactionProvider.isLoading ? null : _transferMoney,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: transactionProvider.isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Text(
                                      'Transfer Et',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Hızlı miktar butonları
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hızlı Miktar',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _QuickAmountButton(
                              amount: 100,
                              onTap: () => _amountController.text = '100',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _QuickAmountButton(
                              amount: 500,
                              onTap: () => _amountController.text = '500',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _QuickAmountButton(
                              amount: 1000,
                              onTap: () => _amountController.text = '1000',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Güvenlik uyarısı
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.warningColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.warningColor.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.security,
                        color: AppTheme.warningColor,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Güvenlik Uyarısı',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: AppTheme.warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Transfer işlemi geri alınamaz. Alıcı bilgilerini dikkatli kontrol edin.',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.warningColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickAmountButton extends StatelessWidget {
  final double amount;
  final VoidCallback onTap;

  const _QuickAmountButton({
    required this.amount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppTheme.primaryColor.withOpacity(0.3),
          ),
        ),
        child: Center(
          child: Text(
            '₺${amount.toStringAsFixed(0)}',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
