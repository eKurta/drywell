class ChatUser {
  final String id;
  final String name;
  final String? photoUrl;

  ChatUser({required this.id, required this.name, this.photoUrl});

  factory ChatUser.fromJson(Map<dynamic, dynamic> json) {
    return ChatUser(
        id: json['id'], name: json['name'], photoUrl: json['photoUrl']);
  }
}
