import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/friends.dart';
import 'main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<List<Friends>> _friendsStream;

  @override
  void initState() {
    super.initState();
    _friendsStream = Friends.fetchStream();
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
          List<Friends> friends = snapshot.data ?? [];
          return Scaffold(
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
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: friends.length - 1,
                        itemBuilder: (context, index) {
                          Friends friend = friends[index + 1];
                          return Column(
                            children: [
                              Material(
                                elevation: 4.0,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ListTile(
                                  title: Text(friend.name ?? ""),
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            HomeFolio(selected: index + 1),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 8.0), // Add a SizedBox
                            ],
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const HomeFolio(selected: 0),
                          ),
                        );
                      },
                      child: Text('My Profile'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
