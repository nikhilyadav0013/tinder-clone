import 'package:flutter/material.dart';
import 'editscreen.dart';
import 'package:camera/camera.dart';
import 'camera.dart';

class ProfileScreen extends StatefulWidget {
  final String userName;
  final int userAge;
  final String imageUrl;

  ProfileScreen({
    required this.userName,
    required this.userAge,
    required this.imageUrl,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String _userName;
  late int _userAge;

  @override
  void initState() {
    super.initState();
    _userName = widget.userName;
    _userAge = widget.userAge;
  }

  void updateProfile(String name, int age) {
    setState(() {
      _userName = name;
      _userAge = age;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(widget.imageUrl),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 16.0,
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        final cameras = await availableCameras();
                        final firstCamera = cameras.first;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CameraScreen(camera: firstCamera),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              "$_userName, $_userAge",
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              "Height: 6'2\", Sex: Male",
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              "About Me",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              "Likes & Dislikes",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              "Likes: Reading, Traveling\nDislikes: Arrogance",
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              "Hobbies",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              "Cooking, Photography",
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfileScreen(
                userName: _userName,
                userAge: _userAge,
                imageUrl:
                    "https://cdna.artstation.com/p/assets/images/images/057/061/772/large/hyung-woo-kim-untitled-1.jpg?1670749089",
              ),
            ),
          );

          if (result != null && result is Map<String, dynamic>) {
            updateProfile(result['name'], result['age']);
          }
        },
        label: const Text("Edit Profile"),
        icon: const Icon(Icons.edit),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
