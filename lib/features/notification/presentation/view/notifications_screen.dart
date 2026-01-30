import 'package:flutter/material.dart';
import 'package:machinfy_agent/core/constants.dart';
import 'package:machinfy_agent/core/typography.dart';
import 'package:machinfy_agent/features/notification/presentation/widget/notification_tile.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Mark all read',
              style: Style.bodysmall.copyWith(color: kPrimaryColor),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          NotificationTile(
            icon: Icons.school_outlined,
            title: 'New Course Available',
            message: 'Advanced Machine Learning course is now available',
            time: '2 hours ago',
            isRead: false,
            onTap: () {},
          ),
          NotificationTile(
            icon: Icons.workspace_premium_outlined,
            title: 'Certificate Earned',
            message:
                'Congratulations! You earned a certificate in Data Science',
            time: '1 day ago',
            isRead: false,
            onTap: () {},
          ),
          NotificationTile(
            icon: Icons.assignment_outlined,
            title: 'Assignment Reminder',
            message: 'Your assignment is due in 2 days',
            time: '2 days ago',
            isRead: true,
            onTap: () {},
          ),
          NotificationTile(
            icon: Icons.chat_bubble_outline,
            title: 'New Message',
            message: 'You have a new message from your instructor',
            time: '3 days ago',
            isRead: true,
            onTap: () {},
          ),
          NotificationTile(
            icon: Icons.update_outlined,
            title: 'Course Update',
            message: 'New content added to Python Programming course',
            time: '1 week ago',
            isRead: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
