import 'package:hive/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 0)
class Message extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final DateTime timestamp;

  @HiveField(3)
  final bool isOutgoing;

  @HiveField(4)
  final MessageType type;

  @HiveField(5)
  final bool isRead;

  Message({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.isOutgoing,
    this.type = MessageType.text,
    this.isRead = false,
  });

  Message copyWith({
    String? id,
    String? content,
    DateTime? timestamp,
    bool? isOutgoing,
    MessageType? type,
    bool? isRead,
  }) {
    return Message(
      id: id ?? this.id,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      isOutgoing: isOutgoing ?? this.isOutgoing,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
    );
  }
}

@HiveType(typeId: 1)
enum MessageType {
  @HiveField(0)
  text,
  
  @HiveField(1)
  emoji,
  
  @HiveField(2)
  image,
}
