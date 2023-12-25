import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'message.dart';
import 'profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final List<String> _imageUrls = [
    "https://anandaindia.org/wp-content/uploads/2018/12/happy-man.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1xK0utoW9dDGvA4oJy6JVzbKYVx5d6xMw496FN7VM53m2eaunM0ndsmsYmSdLAGcVEhA&usqp=CAU",
    "https://miro.medium.com/v2/resize:fit:1400/1*HEoLBLidT2u4mhJ0oiDgig.png",
    "https://cff2.earth.com/uploads/2019/04/11123436/Smiling-really-can-make-you-feel-happier-research-shows.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmAwf_LMvDSH7qtqoO_nixK3EB6MWGurBeyOaZbHzOLvcim9wu6LxRWV5mmweqvQZngXA&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdjl1CpA2KaiSDY6sazMFjyiqzw-SoLC5Ma1yVR31N_TzemBnve0oSDjVCazNcFvY6bZA&usqp=CAU",
  ];

  @override
  void initState() {
    for (int i = 0; i < _imageUrls.length; i++) {
      _swipeItems.add(SwipeItem(
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(_imageUrls[i]),
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "User ${i + 1}",
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        likeAction: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Liked User ${i + 1}"),
            duration: const Duration(milliseconds: 500),
          ));
        },
        nopeAction: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Nope User ${i + 1}"),
            duration: const Duration(milliseconds: 500),
          ));
        },
        superlikeAction: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Superliked User ${i + 1}"),
            duration: const Duration(milliseconds: 500),
          ));
        },
        onSlideUpdate: (SlideRegion? region) async {
          await Future.delayed(Duration.zero);
          print("Region $region");
        },
      ));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: const Text("Home"),
          actions: [
            IconButton(
              icon: const Icon(Icons.message),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MessageScreen()),
                );
              },
            ),
          ],
          leading: IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                          userName: "John Doe",
                          userAge: 25,
                          imageUrl:
                              "https://cdna.artstation.com/p/assets/images/images/057/061/772/large/hyung-woo-kim-untitled-1.jpg?1670749089",
                        )),
              );
            },
          ),
          centerTitle: true),
      body: SwipeCards(
        matchEngine: _matchEngine!,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: _swipeItems[index].content,
          );
        },
        onStackFinished: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Stack Finished"),
            duration: Duration(milliseconds: 500),
          ));
        },
        itemChanged: (SwipeItem item, int index) {},
        leftSwipeAllowed: true,
        rightSwipeAllowed: true,
        upSwipeAllowed: true,
        fillSpace: true,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _matchEngine!.currentItem?.nope();
                },
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.red,
                    minimumSize: const Size(70, 70)),
                child: const Icon(Icons.close, size: 36.0),
              ),
              ElevatedButton(
                onPressed: () {
                  _matchEngine!.currentItem?.superLike();
                },
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(70, 70)),
                child: const Icon(Icons.star, size: 36.0),
              ),
              ElevatedButton(
                onPressed: () {
                  _matchEngine!.currentItem?.like();
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: Colors.green,
                  minimumSize: const Size(70, 70),
                ),
                child: const Icon(Icons.favorite, size: 36.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
