import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isOutgoing = message.isOutgoing;
    final time = DateFormat('h:mm a').format(message.timestamp);

    return Align(
      alignment: isOutgoing ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Column(
          crossAxisAlignment:
              isOutgoing ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: isOutgoing
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: isOutgoing
                      ? const Radius.circular(20)
                      : const Radius.circular(4),
                  bottomRight: isOutgoing
                      ? const Radius.circular(4)
                      : const Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _MessageContent(message: message),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 11,
                          color: isOutgoing
                              ? Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer
                                  .withOpacity(0.6)
                              : Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer
                                  .withOpacity(0.6),
                        ),
                      ),
                      if (isOutgoing) ...[
                        const SizedBox(width: 4),
                        Icon(
                          Icons.check,
                          size: 14,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer
                              .withOpacity(0.6),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageContent extends StatelessWidget {
  final Message message;

  const _MessageContent({required this.message});

  @override
  Widget build(BuildContext context) {
    final isOutgoing = message.isOutgoing;

    switch (message.type) {
      case MessageType.emoji:
        return Text(
          message.content,
          style: const TextStyle(fontSize: 48),
        );
      case MessageType.image:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: Colors.grey[300],
                width: 200,
                height: 150,
                child: const Icon(Icons.image, size: 64),
              ),
            ),
            if (message.content.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                message.content,
                style: TextStyle(
                  color: isOutgoing
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
            ],
          ],
        );
      case MessageType.text:
      default:
        return Text(
          message.content,
          style: TextStyle(
            fontSize: 15,
            height: 1.4,
            color: isOutgoing
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        );
    }
  }
}
