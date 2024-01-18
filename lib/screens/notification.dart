import 'package:flutter/material.dart';

import 'assets/constants.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationItem> notifications = [
    NotificationItem(
      icon: Icons.notifications,
      title: 'New Message',
      content: 'You have a new message from John Doe.',
      time: '2 hours ago',
    ),
    NotificationItem(
      icon: Icons.event,
      title: 'Event Reminder',
      content: 'Don\'t forget about the team meeting tomorrow.',
      time: 'Yesterday',
    ),
    NotificationItem(
      icon: Icons.check_circle,
      title: 'Task Completed',
      content: 'Your task has been successfully completed.',
      time: '3 days ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppConstants.buildCustomAppBar('Fund Transfer', context),
          ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _showDetailsDialog(context, notifications[index]);
                },
                child: Dismissible(
                  key: Key(notifications[index].time),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      notifications.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Notification dismissed'),
                      ),
                    );
                  },
                  child: NotificationCard(
                    notification: notifications[index],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showDetailsDialog(BuildContext context, NotificationItem notification) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(notification.title),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Content: ${notification.content}'),
              SizedBox(height: 8.0),
              Text('Time: ${notification.time}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;

  NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: Icon(
          notification.icon,
          color: Colors.blue,
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.content),
            SizedBox(height: 4.0),
            Text(
              notification.time,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationItem {
  final IconData icon;
  final String title;
  final String content;
  final String time;

  NotificationItem({
    required this.icon,
    required this.title,
    required this.content,
    required this.time,
  });
}