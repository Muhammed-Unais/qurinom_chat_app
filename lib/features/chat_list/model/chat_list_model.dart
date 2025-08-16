import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:_qurinom_chat_app/features/auth/model/auth_response.dart';

class ChatModel {
  final String id;
  final bool isGroupChat;
  final List<User> participants;
  final DateTime createdAt;
  final DateTime updatedAt;
  final LastMessage? lastMessage;

  ChatModel({
    required this.id,
    required this.isGroupChat,
    required this.participants,
    required this.createdAt,
    required this.updatedAt,
    this.lastMessage,
  });

  ChatModel copyWith({
    String? id,
    bool? isGroupChat,
    List<User>? participants,
    DateTime? createdAt,
    DateTime? updatedAt,
    LastMessage? lastMessage,
  }) {
    return ChatModel(
      id: id ?? this.id,
      isGroupChat: isGroupChat ?? this.isGroupChat,
      participants: participants ?? this.participants,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'isGroupChat': isGroupChat,
      'participants': participants.map((x) => x.toJson()).toList(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'lastMessage': lastMessage?.toMap(),
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['_id'] as String,
      isGroupChat: map['isGroupChat'] as bool,
      participants: List<User>.from(
        (map['participants'] as List).map<User>(
          (x) => User.fromJson(x as Map<String, dynamic>),
        ),
      ),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      lastMessage:
          map['lastMessage'] != null
              ? LastMessage.fromMap(map['lastMessage'] as Map<String, dynamic>)
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(id: $id, isGroupChat: $isGroupChat, participants: $participants, createdAt: $createdAt, updatedAt: $updatedAt, lastMessage: $lastMessage)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.isGroupChat == isGroupChat &&
        listEquals(other.participants, participants) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.lastMessage == lastMessage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        isGroupChat.hashCode ^
        participants.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        lastMessage.hashCode;
  }
}

class LastMessage {
  final String id;
  final String senderId;
  final String content;
  final String messageType;
  final String? fileUrl;
  final DateTime createdAt;

  LastMessage({
    required this.id,
    required this.senderId,
    required this.content,
    required this.messageType,
    this.fileUrl,
    required this.createdAt,
  });

  LastMessage copyWith({
    String? id,
    String? senderId,
    String? content,
    String? messageType,
    String? fileUrl,
    DateTime? createdAt,
  }) {
    return LastMessage(
      id: id ?? this.id,
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
      'senderId': senderId,
      'content': content,
      'messageType': messageType,
      'fileUrl': fileUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory LastMessage.fromMap(Map<String, dynamic> map) {
    return LastMessage(
      id: map['_id'] as String,
      senderId: map['senderId'] as String,
      content: map['content'] as String,
      messageType: map['messageType'] as String,
      fileUrl: map['fileUrl'] != null ? map['fileUrl'] as String : null,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LastMessage.fromJson(String source) =>
      LastMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LastMessage(id: $id, senderId: $senderId, content: $content, messageType: $messageType, fileUrl: $fileUrl, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant LastMessage other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.senderId == senderId &&
        other.content == content &&
        other.messageType == messageType &&
        other.fileUrl == fileUrl &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        senderId.hashCode ^
        content.hashCode ^
        messageType.hashCode ^
        fileUrl.hashCode ^
        createdAt.hashCode;
  }
}
