import 'package:flutter/material.dart';

// Dummy user data
List<Map<String, String>> users = [
  {"name": "Muhammad Ali", "avatarUrl": "https://randomuser.me/api/portraits/men/1.jpg"},
  {"name": "Muhammad Huzaifa", "avatarUrl": "https://randomuser.me/api/portraits/men/2.jpg"},
  {"name": "Muhammad Hanzala", "avatarUrl": "https://randomuser.me/api/portraits/men/3.jpg"},
];

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Center(child: Text("Chats")),
        backgroundColor: Colors.tealAccent,
        foregroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 40,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user["avatarUrl"]!),
            ),
            title: Text(
              user["name"]!,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // Navigate to the chat screen when a user is clicked
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(userName: user["name"]!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String userName;

  ChatScreen({required this.userName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Static data for chat messages
  List<Map<String, String>> messages = [
    {"sender": "User 1", "message": "Hey, how are you?"},
    {"sender": "User 2", "message": "I'm good! How about you?"},
    {"sender": "User 1", "message": "I'm doing great, thanks!"},
    {"sender": "User 2", "message": "That's awesome!"},
    {"sender": "User 1", "message": "Let's catch up soon."},
  ];

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Black background
      appBar: AppBar(
        title: Text(widget.userName), // Show the name of the user being chatted with
        backgroundColor: Colors.tealAccent,
        foregroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: true,
        toolbarHeight: 40,
      ),
      body: Column(
        children: [
          // Chat messages area
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Align(
                    alignment: message["sender"] == "User 1"
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: message["sender"] == "User 1"
                            ? Colors.grey[700]
                            : Colors.tealAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        message["message"]!,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Input field area
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.tealAccent),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      setState(() {
                        messages.add({
                          "sender": "User 1",
                          "message": _controller.text
                        });
                        _controller.clear();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
