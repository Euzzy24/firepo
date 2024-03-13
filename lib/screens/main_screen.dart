import 'package:firepo/screen_design/add.dart';
import 'package:firepo/screen_design/list_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/friends.dart';
import '../screen_design/user_info.dart';

class HomeFolio extends StatefulWidget {
  final int selected;
  const HomeFolio({super.key, required this.selected});

  @override
  HomeFolioState createState() => HomeFolioState();
}

class HomeFolioState extends State<HomeFolio> {
  int _selectedIndex = 0;
  late Stream<List<Friends>> _friendsStream;
  List<Friends> _friends = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _friendsStream = Friends.fetchStream();
    _currentIndex = widget.selected;
  }

  void _updateCurrent(int Newindex) {
    setState(() {
      _currentIndex = Newindex + 1;
    });
  }

  void _nextPage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % (_friends.length);
    });
  }

  void _previousPage() {
    setState(() {
      _currentIndex = (_currentIndex - 1) % (_friends.length);
    });
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Friends>>(
      stream: _friendsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          _friends = snapshot.data ?? [];
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 121, 115, 179),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddFriendModal();
                  },
                );
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            endDrawer: Drawer(
              backgroundColor: Color.fromARGB(255, 187, 183, 214),
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  SizedBox(
                    height: 60,
                    child: DrawerHeader(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 121, 115, 179),
                        ),
                        child: Text('Merrjielyn',
                            style: GoogleFonts.jost(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold)))),
                  ),
                  ExpansionTile(
                    title: Text("Friends"),
                    children: [
                      FriendsList(
                          friends: _friends, onFriendSelected: _updateCurrent),
                    ],
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 121, 115, 179),
              automaticallyImplyLeading: false,
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Image.asset(
                  "assets/images/fire.png",
                  fit: BoxFit.contain,
                ),
              ),
              title: Text(
                'FirePo',
                style: GoogleFonts.jost(
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 252, 251, 251),
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            body: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    SingleChildScrollView(
                      child: Expanded(
                        child: _friends.isEmpty
                            ? const Center(child: Text('No friends found.'))
                            : FriendCard(friend: _friends[_currentIndex]),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 5,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/choose');
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Color.fromARGB(255, 4, 4, 4),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 380,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _previousPage,
                        child: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: _nextPage,
                        child: const Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 100,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 350,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              _friends.asMap().entries.skip(1).map((entry) {
                            final index = entry.key;
                            final friendnum = index;
                            final friend = entry.value;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: () {
                                  showDialog(
                                    barrierColor: Color.fromARGB(193, 0, 0, 0),
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        // contentPadding: EdgeInsets.zero,
                                        backgroundColor:
                                            Color.fromARGB(255, 121, 115, 179),
                                        title: Text(
                                          'Friend $friendnum',
                                          style: GoogleFonts.jost(
                                              textStyle: (TextStyle(
                                                  color: Colors.white))),
                                        ),
                                        content: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Container(
                                            color: Colors.white,
                                            padding: EdgeInsets.all(10),
                                            child: SingleChildScrollView(
                                              child: FriendCard(friend: friend),
                                            ),
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Close',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  'Friend $friendnum',
                                  style: GoogleFonts.jost(
                                      textStyle: (TextStyle(
                                          color:
                                              Color.fromARGB(255, 0, 0, 0)))),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            bottomNavigationBar: Info(
              tabs: const ["Friends", "Followers", "Following"],
              selectedIndex: _selectedIndex,
              onTabSelected: _onTabSelected,
              icons: const [
                Icons.person,
                Icons.follow_the_signs,
                Icons.people_sharp
              ],
            ),
          );
        }
      },
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    super.key,
    required this.tabs,
    required this.onTabSelected,
    required this.selectedIndex,
    required this.icons,
  });

  final List<String> tabs;
  final ValueChanged<int> onTabSelected;
  final int selectedIndex;
  final List<IconData> icons;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromARGB(255, 187, 183, 214),
      items: List.generate(tabs.length, (index) {
        return BottomNavigationBarItem(
          icon: Icon(
            icons[index],
            color: Color.fromARGB(255, 255, 255, 255),
          ), // Use the icon based on the index
          label: tabs[index],
        );
      }),
      currentIndex: selectedIndex,
      onTap: onTabSelected,
    );
  }
}
