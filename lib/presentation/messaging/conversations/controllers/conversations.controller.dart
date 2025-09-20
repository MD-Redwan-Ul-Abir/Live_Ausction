import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ConversationsController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  
  // Observable list for conversation messages with static data
  RxList<Map<String, dynamic>> conversationList = <Map<String, dynamic>>[
    {
      'id': '1',
      'text': 'Hello! I\'m interested in this auction item.',
      'isUser': false,
      'timestamp': DateTime.now().subtract(Duration(hours: 2)),
      'senderName': 'John Doe',
      'senderImage': '',
      'attachments': [],
    },
    {
      'id': '2', 
      'text': 'Hi there! Which item are you looking at?',
      'isUser': true,
      'timestamp': DateTime.now().subtract(Duration(hours: 1, minutes: 45)),
      'senderName': 'You',
      'senderImage': '',
      'attachments': [],
    },
    {
      'id': '3',
      'text': 'The vintage watch in lot #23. What\'s the condition like?',
      'isUser': false,
      'timestamp': DateTime.now().subtract(Duration(hours: 1, minutes: 30)),
      'senderName': 'John Doe',
      'senderImage': '',
      'attachments': [],
    },
    {
      'id': '4',
      'text': 'It\'s in excellent condition. Barely worn with original box and papers.',
      'isUser': true,
      'timestamp': DateTime.now().subtract(Duration(hours: 1, minutes: 15)),
      'senderName': 'You',
      'senderImage': '',
      'attachments': [],
    },
    {
      'id': '5',
      'text': 'That sounds great! What\'s your reserve price?',
      'isUser': false,
      'timestamp': DateTime.now().subtract(Duration(minutes: 45)),
      'senderName': 'John Doe',
      'senderImage': '',
      'attachments': [],
    },
  ].obs;
  
  // Loading states
  RxBool isLoading = false.obs;
  RxBool isSendingMessage = false.obs;
  
  // Current user data (static)
  RxString currentUserName = 'You'.obs;
  RxString currentUserId = 'user123'.obs;
  
  @override
  void onInit() {
    super.onInit();
    setupScrollListener();
  }
  
  void setupScrollListener() {
    scrollController.addListener(() {
      // Auto-scroll behavior can be added here if needed
    });
  }
  
  // Group messages by date for display
  List<Map<String, dynamic>> get groupedMessages {
    final List<Map<String, dynamic>> grouped = [];
    String? lastDate;
    
    for (final message in conversationList) {
      final messageDate = _formatDate(message['timestamp'] as DateTime);
      
      if (lastDate != messageDate) {
        grouped.add({'type': 'date', 'date': messageDate});
        lastDate = messageDate;
      }
      
      grouped.add({
        'type': 'message',
        'id': message['id'],
        'text': message['text'],
        'isUser': message['isUser'],
        'timestamp': message['timestamp'],
        'senderName': message['senderName'],
        'senderImage': message['senderImage'],
        'attachments': message['attachments'],
      });
    }
    
    return grouped;
  }
  
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));
    final messageDate = DateTime(date.year, date.month, date.day);
    
    if (messageDate == today) {
      return 'Today';
    } else if (messageDate == yesterday) {
      return 'Yesterday';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
  
  // Send message method with static data
  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;
    
    isSendingMessage.value = true;
    
    // Simulate sending delay
    Future.delayed(Duration(milliseconds: 500), () {
      // Add new message to conversation
      final newMessage = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'text': text,
        'isUser': true,
        'timestamp': DateTime.now(),
        'senderName': 'You',
        'senderImage': '',
        'attachments': [],
      };
      
      conversationList.add(newMessage);
      messageController.clear();
      isSendingMessage.value = false;
      
      // Auto-scroll to bottom after sending
      _scrollToBottom();
      
      // Simulate receiving a reply after 2 seconds
      _simulateReply();
    });
  }
  
  void _simulateReply() {
    Future.delayed(Duration(seconds: 2), () {
      final replies = [
        'Thanks for the info!',
        'I\'ll consider it.',
        'When does the auction end?',
        'Can I see more photos?',
        'What\'s the shipping cost?',
      ];
      
      final randomReply = replies[DateTime.now().millisecond % replies.length];
      
      final replyMessage = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'text': randomReply,
        'isUser': false,
        'timestamp': DateTime.now(),
        'senderName': 'John Doe',
        'senderImage': '',
        'attachments': [],
      };
      
      conversationList.add(replyMessage);
      _scrollToBottom();
    });
  }
  
  void _scrollToBottom({bool animate = true}) {
    if (!scrollController.hasClients) return;
    
    Future.delayed(Duration(milliseconds: 100), () {
      if (animate) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }
  
  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
