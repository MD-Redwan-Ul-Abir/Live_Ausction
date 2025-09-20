import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/text_styles.dart';
import '../../../infrastructure/utils/app_images.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';
import 'controllers/conversations.controller.dart';

class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({super.key});

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  final ConversationsController controller = Get.find<ConversationsController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: AppColors.neutral950,
        appBar: CustomAppBar(
          title: "Auction Chat",
          centerTitle: true,
          backgroundColor: AppColors.neutral950,
        ),
        body: Column(
          children: [
            // Chat messages area
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary800,
                    ),
                  );
                }

                return controller.groupedMessages.isEmpty
                    ? Center(
                        child: Text(
                          'No messages yet',
                          style: AppTextStyles.paragraph_2_Regular.copyWith(
                            color: AppColors.neutral400,
                          ),
                        ),
                      )
                    : ListView.builder(
                        controller: controller.scrollController,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        itemCount: controller.groupedMessages.length,
                        itemBuilder: (context, index) {
                          final item = controller.groupedMessages[index];

                          if (item['type'] == 'date') {
                            return _buildDateSeparator(item['date']);
                          } else {
                            return _buildMessageBubble(item);
                          }
                        },
                      );
              }),
            ),

            // Message input area
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSeparator(String date) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1.h,
              color: AppColors.neutral700,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              date,
              style: AppTextStyles.paragraph_2_Regular.copyWith(
                color: AppColors.neutral400,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 1.h,
              color: AppColors.neutral700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final bool isUser = message['isUser'] ?? false;
    final String text = message['text'] ?? '';
    final DateTime? timestamp = message['timestamp'];
    final String senderName = message['senderName'] ?? '';

    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            // Other user avatar
            Container(
              width: 32.w,
              height: 32.h,
              margin: EdgeInsets.only(right: 8.w,  ),
              decoration: BoxDecoration(
                color: AppColors.primary800,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: Text(
                  senderName.isNotEmpty ? senderName[0].toUpperCase() : 'U',
                  style: AppTextStyles.paragraph_2_Medium.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
          
          // Message bubble
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isUser
                    ? AppColors.primary800
                    : AppColors.neutral800,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                  bottomLeft: isUser ? Radius.circular(16.r) : Radius.circular(4.r),
                  bottomRight: isUser ? Radius.circular(4.r) : Radius.circular(16.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Message text
                  if (text.isNotEmpty) ...[
                    Text(
                      text,
                      style: AppTextStyles.paragraph_2_Regular.copyWith(
                        color: Colors.white,
                        height: 1.4,
                      ),
                    ),
                  ],
                  
                  // Timestamp
                  if (timestamp != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      _formatMessageTime(timestamp),
                      style: AppTextStyles.paragraph_2_Regular.copyWith(
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          
          if (isUser) ...[
            // Current user avatar
            Container(
              width: 32.w,
              height: 32.h,
              margin: EdgeInsets.only(left: 8.w,  ),
              decoration: BoxDecoration(
                color: AppColors.neutral600,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: Text(
                  'Y',
                  style: AppTextStyles.paragraph_2_Medium.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatMessageTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.neutral950,
        border: Border(
          top: BorderSide(
            color: AppColors.neutral800,
            width: 1,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: AppColors.neutral800,
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(
            color: AppColors.neutral700,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Text input
            Expanded(
              child: TextField(
                controller: controller.messageController,
                style: AppTextStyles.paragraph_2_Regular.copyWith(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  hintStyle: AppTextStyles.paragraph_2_Regular.copyWith(
                    color: AppColors.neutral400,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                ),
                maxLines: null,
                textInputAction: TextInputAction.send,
                onSubmitted: (value) => controller.sendMessage(),
              ),
            ),
            
            SizedBox(width: 8.w),
            
            // Send button with loading state
            Obx(() => GestureDetector(
              onTap: controller.isSendingMessage.value
                  ? null
                  : () => controller.sendMessage(),
              child: Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: controller.messageController.text.trim().isEmpty
                      ? AppColors.neutral600
                      : AppColors.primary800,
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: controller.isSendingMessage.value
                    ? SizedBox(
                        width: 16.w,
                        height: 16.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 18.sp,
                      ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}