import 'dart:convert';

class MessageModel {
  final String id;
  final String chatId;
  final String senderId;
  final String content;
  final String messageType;
  final String? fileUrl;
  final DateTime? createdAt;

  MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.messageType,
    this.fileUrl,
    this.createdAt,
  });

  MessageModel copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? content,
    String? messageType,
    String? fileUrl,
    DateTime? createdAt,
  }) {
    return MessageModel(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      messageType: messageType ?? this.messageType,
      fileUrl: fileUrl ?? this.fileUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'chatId': chatId,
      'senderId': senderId,
      'content': content,
      'messageType': messageType,
      'fileUrl': fileUrl,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['_id'] as String,
      chatId: map['chatId'] as String,
      senderId: map['senderId'] as String,
      content: map['content'] as String,
      messageType: map['messageType'] as String,
      fileUrl: map['fileUrl'] != null ? map['fileUrl'] as String : null,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(id: $id, chatId: $chatId, senderId: $senderId, content: $content, messageType: $messageType, fileUrl: $fileUrl, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.chatId == chatId &&
        other.senderId == senderId &&
        other.content == content &&
        other.messageType == messageType &&
        other.fileUrl == fileUrl &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        chatId.hashCode ^
        senderId.hashCode ^
        content.hashCode ^
        messageType.hashCode ^
        fileUrl.hashCode ^
        createdAt.hashCode;
  }
}
