import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../utils/theme.dart';
import '../models/message.dart';
import '../models/user.dart';

class ChatPage extends StatefulWidget {
  final UserModel recipient;

  const ChatPage({super.key, required this.recipient});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late List<Message> _messages;
  late UserModel _currentUser;

  @override
  void initState() {
    super.initState();
    // Use AuthProvider for current user
    // Use FirestoreService().getChatMessages() for messages
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        Message(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          senderId: _currentUser.id,
          receiverId: widget.recipient.id,
          content: _messageController.text.trim(),
          timestamp: DateTime.now(),
        ),
      );
      _messageController.clear();
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color:
                Theme.of(context).appBarTheme.iconTheme?.color ??
                Theme.of(context).colorScheme.onBackground,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18.w,
              backgroundImage: NetworkImage(
                widget.recipient.photoUrl ?? 'https://via.placeholder.com/150',
              ),
              onBackgroundImageError: (exception, stackTrace) {
                print('Error loading recipient image: $exception');
              },
            ),
            SizedBox(width: 12.w),
            Text(
              widget.recipient.name,
              style: AppTheme.heading3.copyWith(color: Colors.white),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final bool isMe = message.senderId == _currentUser.id;
                return _buildMessageBubble(message, isMe);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isMe ? AppTheme.primaryColor : AppTheme.darkSurfaceColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppTheme.borderRadius),
            topRight: Radius.circular(AppTheme.borderRadius),
            bottomLeft: isMe
                ? Radius.circular(AppTheme.borderRadius)
                : Radius.circular(4.r),
            bottomRight: isMe
                ? Radius.circular(4.r)
                : Radius.circular(AppTheme.borderRadius),
          ),
        ),
        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: AppTheme.bodyMedium.copyWith(color: Colors.white),
            ),
            SizedBox(height: 4.h),
            Text(
              DateFormat('HH:mm').format(message.timestamp),
              style: AppTheme.bodySmall.copyWith(
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              style: AppTheme.bodyMedium.copyWith(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.textLightColor,
                ),
                filled: true,
                fillColor: AppTheme.darkSurfaceColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppTheme.borderRadiusLarge,
                  ),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppTheme.borderRadiusLarge,
                  ),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppTheme.borderRadiusLarge,
                  ),
                  borderSide: const BorderSide(color: AppTheme.primaryColor),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 12.h,
                ),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          SizedBox(width: 8.w),
          FloatingActionButton(
            onPressed: _sendMessage,
            backgroundColor: AppTheme.primaryColor,
            mini: true,
            elevation: 0,
            child: Icon(Icons.send, color: Colors.white, size: 20.w),
          ),
        ],
      ),
    );
  }
}
