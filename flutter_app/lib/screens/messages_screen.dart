import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../models/message.dart';
import '../services/message_service.dart';
import '../widgets/message_bubble.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final MessageService _messageService = MessageService();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Mark messages as read when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _messageService.markAllAsRead();
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom({bool animated = true}) {
    if (_scrollController.hasClients) {
      if (animated) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    }
  }

  Future<void> _sendMessage() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    _textController.clear();
    _focusNode.unfocus();

    await _messageService.sendMessage(text, MessageType.text);

    // Scroll to bottom after sending
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollToBottom();
    });

    // Scroll again after auto-reply
    Future.delayed(const Duration(seconds: 2), () {
      _scrollToBottom();
    });
  }

  void _showEmojiPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Quick Emoji',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                '😊', '😂', '❤️', '👍', '🎉', '🔥',
                '😍', '🤔', '👏', '💯', '✨', '🙌',
              ].map((emoji) => InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _messageService.sendMessage(emoji, MessageType.emoji);
                  Future.delayed(const Duration(milliseconds: 100), () {
                    _scrollToBottom();
                  });
                  Future.delayed(const Duration(seconds: 2), () {
                    _scrollToBottom();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    emoji,
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Support Chat'),
            Text(
              'Online',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'clear') {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Clear Messages'),
                    content: const Text('Are you sure you want to delete all messages?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          _messageService.clearAllMessages();
                          Navigator.pop(context);
                        },
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline),
                    SizedBox(width: 8),
                    Text('Clear Messages'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box<Message>('messages').listenable(),
              builder: (context, Box<Message> box, _) {
                final messages = _messageService.getAllMessages();

                if (messages.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No messages yet',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Start a conversation!',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Auto-scroll when new messages arrive
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToBottom(animated: true);
                });

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final showDateHeader = index == 0 ||
                        !_isSameDay(
                          messages[index - 1].timestamp,
                          message.timestamp,
                        );

                    return Column(
                      children: [
                        if (showDateHeader) ...[
                          if (index > 0) const SizedBox(height: 16),
                          _DateHeader(date: message.timestamp),
                          const SizedBox(height: 16),
                        ],
                        MessageBubble(message: message),
                        const SizedBox(height: 8),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          _MessageInput(
            controller: _textController,
            focusNode: _focusNode,
            onSend: _sendMessage,
            onEmojiTap: _showEmojiPicker,
          ),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}

class _DateHeader extends StatelessWidget {
  final DateTime date;

  const _DateHeader({required this.date});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final messageDate = DateTime(date.year, date.month, date.day);

    String dateText;
    if (messageDate == DateTime(now.year, now.month, now.day)) {
      dateText = 'Today';
    } else if (messageDate == yesterday) {
      dateText = 'Yesterday';
    } else {
      dateText = DateFormat('MMMM d, yyyy').format(date);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        dateText,
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSend;
  final VoidCallback onEmojiTap;

  const _MessageInput({
    required this.controller,
    required this.focusNode,
    required this.onSend,
    required this.onEmojiTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              onPressed: onEmojiTap,
              icon: const Icon(Icons.emoji_emotions_outlined),
              tooltip: 'Send Emoji',
            ),
            Expanded(
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceVariant,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                textCapitalization: TextCapitalization.sentences,
                maxLines: null,
                onSubmitted: (_) => onSend(),
              ),
            ),
            const SizedBox(width: 4),
            IconButton(
              onPressed: onSend,
              icon: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.primary,
              ),
              tooltip: 'Send',
            ),
          ],
        ),
      ),
    );
  }
}
