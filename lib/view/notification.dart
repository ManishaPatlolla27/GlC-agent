import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, dynamic>> notifications = [
    {
      'id': 'ALRTSOS 01',
      'type': 'Alert',
      'status': 'Approved',
      'message':
          'Congratulations, Your project has been successfully approved.',
      'isUnread': true,
    },
    {
      'id': 'ALRTSOS 01',
      'type': 'Alert',
      'status': 'Dismissed',
      'message':
          'Some documents regarding background verification are missing please check.',
      'isUnread': false,
    },
    {
      'id': 'GLCSOS 01',
      'type': 'Project',
      'status': 'Approved',
      'message':
          'Congratulations, Your project has been successfully approved, the amount will be credited within 24 Hrs.',
      'isUnread': false,
    },
    {
      'id': 'GLCSOS 01',
      'type': 'Project',
      'status': 'Rejected',
      'message':
          'Some documents regarding background verification are missing please check.',
      'isUnread': false,
    },
    {
      'id': 'GLCSOS 01',
      'type': 'Project',
      'status': 'Rejected',
      'message':
          'Some documents regarding background verification are missing please check.',
      'isUnread': false,
    },
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Dismissed':
        return Colors.red;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF8280FF),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Notifications (${notifications.length})",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];

          return Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            margin: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1)
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Image & Unread Indicator
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        'assets/farmland.png', // Replace with actual image asset
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (notification['isUnread'])
                      Positioned(
                        left: 0,
                        top: 4,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: 12),

                // Notification Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.black, fontSize: 14, height: 1.5),
                          children: [
                            TextSpan(
                              text:
                                  "${notification['type']} ID: ${notification['id']} ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: "has been "),
                            TextSpan(
                              text: notification['status'],
                              style: TextStyle(
                                color: getStatusColor(notification['status']),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        notification['message'],
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      SizedBox(height: 10),

                      // Actions (Mark as Read & Clear)
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                notifications[index]['isUnread'] = false;
                              });
                            },
                            child: Text(
                              "Mark as read",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          SizedBox(width: 16),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                notifications.removeAt(index);
                              });
                            },
                            child: Text(
                              "Clear",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
