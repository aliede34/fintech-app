enum TransactionType {
  transfer,
  deposit,
  withdrawal,
  payment,
}

enum TransactionStatus {
  pending,
  completed,
  failed,
  cancelled,
}

class Transaction {
  final String id;
  final TransactionType type;
  final double amount;
  final String description;
  final String? recipientName;
  final String? recipientAccount;
  final DateTime date;
  final TransactionStatus status;

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    this.recipientName,
    this.recipientAccount,
    required this.date,
    required this.status,
  });

  // İşlem türü için Türkçe açıklama
  String get typeDescription {
    switch (type) {
      case TransactionType.transfer:
        return 'Para Transferi';
      case TransactionType.deposit:
        return 'Para Yatırma';
      case TransactionType.withdrawal:
        return 'Para Çekme';
      case TransactionType.payment:
        return 'Ödeme';
    }
  }

  // İşlem durumu için Türkçe açıklama
  String get statusDescription {
    switch (status) {
      case TransactionStatus.pending:
        return 'Beklemede';
      case TransactionStatus.completed:
        return 'Tamamlandı';
      case TransactionStatus.failed:
        return 'Başarısız';
      case TransactionStatus.cancelled:
        return 'İptal Edildi';
    }
  }

  // İşlem türü için ikon
  String get typeIcon {
    switch (type) {
      case TransactionType.transfer:
        return '↗️';
      case TransactionType.deposit:
        return '⬇️';
      case TransactionType.withdrawal:
        return '⬆️';
      case TransactionType.payment:
        return '💳';
    }
  }

  // İşlem türü için renk
  String get typeColor {
    switch (type) {
      case TransactionType.transfer:
        return '#3B82F6'; // Mavi
      case TransactionType.deposit:
        return '#10B981'; // Yeşil
      case TransactionType.withdrawal:
        return '#F59E0B'; // Turuncu
      case TransactionType.payment:
        return '#8B5CF6'; // Mor
    }
  }

  // Tarih formatı
  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Bugün ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Dün ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} gün önce';
    } else {
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    }
  }

  // Tutar formatı
  String get formattedAmount {
    return '₺${amount.toStringAsFixed(2).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    )}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.index,
      'amount': amount,
      'description': description,
      'recipientName': recipientName,
      'recipientAccount': recipientAccount,
      'date': date.toIso8601String(),
      'status': status.index,
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] ?? '',
      type: TransactionType.values[json['type'] ?? 0],
      amount: (json['amount'] ?? 0.0).toDouble(),
      description: json['description'] ?? '',
      recipientName: json['recipientName'],
      recipientAccount: json['recipientAccount'],
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      status: TransactionStatus.values[json['status'] ?? 0],
    );
  }

  @override
  String toString() {
    return 'Transaction(id: $id, type: $type, amount: $amount, description: $description, date: $date, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Transaction &&
        other.id == id &&
        other.type == type &&
        other.amount == amount &&
        other.description == description &&
        other.recipientName == recipientName &&
        other.recipientAccount == recipientAccount &&
        other.date == date &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        amount.hashCode ^
        description.hashCode ^
        recipientName.hashCode ^
        recipientAccount.hashCode ^
        date.hashCode ^
        status.hashCode;
  }
}
