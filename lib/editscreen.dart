import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final String userName;
  final int userAge;
  final String imageUrl;

  EditProfileScreen({
    required this.userName,
    required this.userAge,
    required this.imageUrl,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController ageController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userName);
    ageController = TextEditingController(text: widget.userAge.toString());
  }

  void saveChanges() {
    String newName = nameController.text;
    int newAge = int.tryParse(ageController.text) ?? 0;
    Navigator.pop(context, {'name': newName, 'age': newAge});
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(widget.imageUrl),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: saveChanges,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
