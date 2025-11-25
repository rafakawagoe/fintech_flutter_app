class CardModel {
  final String id;
  final String profileId;
  final String name;
  final int closingDay;
  final int dueDay;
  final double limitAmount;
  final String createdAt;
  final String updatedAt;

  CardModel({
    required this.id,
    required this.profileId,
    required this.name,
    required this.closingDay,
    required this.dueDay,
    required this.limitAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'profileId': profileId,
      'name': name,
      'closingDay': closingDay,
      'dueDay': dueDay,
      'limitAmount': limitAmount,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'],
      profileId: map['profileId'],
      name: map['name'],
      closingDay: map['closingDay'],
      dueDay: map['dueDay'],
      limitAmount: map['limitAmount'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }
}
