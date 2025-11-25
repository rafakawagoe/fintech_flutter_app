class TransactionModel {
  final String id;
  final String profileId;
  final String? cardId;
  final String? categoryId;
  final double amount;
  final String description;
  final String type;
  final String date;
  final bool isRecurring;
  final String? recurrenceFrequency;
  final int? installmentNumber;
  final int? totalInstallments;
  final String status;
  final String createdAt;
  final String updatedAt;

  TransactionModel({
    required this.id,
    required this.profileId,
    this.cardId,
    this.categoryId,
    required this.amount,
    required this.description,
    required this.type,
    required this.date,
    required this.isRecurring,
    this.recurrenceFrequency,
    this.installmentNumber,
    this.totalInstallments,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'profileId': profileId,
      'cardId': cardId,
      'categoryId': categoryId,
      'amount': amount,
      'description': description,
      'type': type,
      'date': date,
      'isRecurring': isRecurring ? 1 : 0,
      'recurrenceFrequency': recurrenceFrequency,
      'installmentNumber': installmentNumber,
      'totalInstallments': totalInstallments,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      profileId: map['profileId'],
      cardId: map['cardId'],
      categoryId: map['categoryId'],
      amount: map['amount'],
      description: map['description'],
      type: map['type'],
      date: map['date'],
      isRecurring: map['isRecurring'] == 1,
      recurrenceFrequency: map['recurrenceFrequency'],
      installmentNumber: map['installmentNumber'],
      totalInstallments: map['totalInstallments'],
      status: map['status'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }
}
