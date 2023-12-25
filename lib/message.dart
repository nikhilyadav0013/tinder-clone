import 'package:flutter/material.dart';
import 'chat.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<ChatListItem> allChats = List.generate(
    10,
    (index) => ChatListItem(
      name: 'Chat User $index',
      time: '12:34 PM',
    ),
  );

  List<ChatListItem> displayedChats = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    displayedChats = List.from(allChats);
    super.initState();
  }

  void filterChats(String query) {
    if (query.isEmpty) {
      setState(() {
        displayedChats = List.from(allChats);
      });
    } else {
      setState(() {
        displayedChats = allChats
            .where((chat) =>
                chat.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: filterChats,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedChats.length,
              itemBuilder: (context, index) {
                return displayedChats[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChatListItem extends StatelessWidget {
  final String name;
  final String time;

  ChatListItem({required this.name, required this.time});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
      ),
      title: Text(name),
      subtitle: Text('Last message here'),
      trailing: Text(time),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatScreen()),
        );
      },
    );
  }
}
