import 'dart:math';
import 'package:hive/hive.dart';
import '../models/message.dart';

class MessageService {
  static final MessageService _instance = MessageService._internal();
  factory MessageService() => _instance;
  MessageService._internal();

  final Box<Message> _messageBox = Hive.box<Message>('messages');
  final Random _random = Random();

  // Predefined support agent responses
  final List<String> _supportResponses = [
    "Thanks for reaching out! How can I help you today? 😊",
    "I'm here to assist you. What's on your mind?",
    "Got it! Let me look into that for you.",
    "That's a great question! Here's what I can tell you...",
    "I understand your concern. Let me help you with that.",
    "Thanks for your patience! I'm checking on this now.",
    "Absolutely! I can help you with that.",
    "I appreciate you bringing this to my attention.",
    "Let me connect you with the right information.",
    "Perfect! I've got just the solution for you.",
  ];

  final List<String> _emojiResponses = [
    "😊 Happy to help!",
    "👍 Got it!",
    "🎉 Awesome!",
    "💡 Great idea!",
    "🤔 Let me think about that...",
    "✅ Done!",
    "❤️ Thanks!",
    "🙌 Excellent!",
  ];

  List<Message> getAllMessages() {
    return _messageBox.values.toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  Future<void> addMessage(Message message) async {
    await _messageBox.add(message);
  }

  Future<void> sendMessage(String content, MessageType type) async {
    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      timestamp: DateTime.now(),
      isOutgoing: true,
      type: type,
      isRead: true,
    );

    await addMessage(message);

    // Simulate support agent response after a delay
    Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      _generateAutoReply(content, type);
    });
  }

  Future<void> _generateAutoReply(String userMessage, MessageType userType) async {
    String response;
    MessageType responseType = MessageType.text;

    // Check if user sent emoji
    if (userType == MessageType.emoji || _containsOnlyEmoji(userMessage)) {
      response = _emojiResponses[_random.nextInt(_emojiResponses.length)];
      responseType = MessageType.emoji;
    } else {
      response = _supportResponses[_random.nextInt(_supportResponses.length)];
    }

    final replyMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: response,
      timestamp: DateTime.now(),
      isOutgoing: false,
      type: responseType,
      isRead: false,
    );

    await addMessage(replyMessage);
  }

  bool _containsOnlyEmoji(String text) {
    final emojiRegex = RegExp(
      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])',
    );
    final stripped = text.replaceAll(emojiRegex, '').trim();
    return stripped.isEmpty && text.isNotEmpty;
  }

  int getUnreadCount() {
    return _messageBox.values.where((msg) => !msg.isRead && !msg.isOutgoing).length;
  }

  Future<void> markAllAsRead() async {
    for (var message in _messageBox.values) {
      if (!message.isRead && !message.isOutgoing) {
        final index = _messageBox.values.toList().indexOf(message);
        final updatedMessage = message.copyWith(isRead: true);
        await _messageBox.putAt(index, updatedMessage);
      }
    }
  }

  Future<void> clearAllMessages() async {
    await _messageBox.clear();
  }
}
