class UserModel {

  final String id;
  final String email;

  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.createdAt,
  });

  // FROM FIRESTORE
  factory UserModel.fromMap(
    Map<String, dynamic> map,
    String documentId,
  ) {

    return UserModel(
      id: documentId,

      email:
          map['email'] ?? '',

      createdAt:
          map['created_at']
              .toDate(),
    );
  }

  // TO FIRESTORE
  Map<String, dynamic> toMap() {

    return {
      'email': email,
      'created_at': createdAt,
    };
  }
}