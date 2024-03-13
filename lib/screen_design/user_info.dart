import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/friends.dart';

class FriendCard extends StatelessWidget {
  final Friends friend;

  const FriendCard({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                Opacity(
                  opacity: .9,
                  child: Image.asset(
                    "assets/images/dgroupp.jpg",
                    width: MediaQuery.of(context).size.width * 1,
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * -.1,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color.fromARGB(255, 187, 183, 214),
                        width: 2.0,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        friend.profile ?? "",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -100,
                  child: Text(
                    friend.name ?? "",
                    style: GoogleFonts.jost(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: -120,
                  child: Text(
                    "ID Number: ${friend.idnumber}",
                    style: GoogleFonts.jost(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 130,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    friend.description!,
                    style: GoogleFonts.jost(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Position: ${friend.position}",
                    style: GoogleFonts.jost(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
