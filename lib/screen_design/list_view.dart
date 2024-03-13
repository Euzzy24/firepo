import 'package:flutter/material.dart';

import '../model/friends.dart';

class FriendsList extends StatelessWidget {
  final List<Friends> friends;
  final Function(int) onFriendSelected;

  const FriendsList(
      {super.key, required this.friends, required this.onFriendSelected});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: friends.length - 1,
      itemBuilder: (context, index) {
        final friend = friends[index + 1];
        return ListTile(
          title: Text(friend.name ?? ''),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(friend.profile ?? ''),
          ),
          onTap: () {
            onFriendSelected(index);
          },
        );
      },
    );
  }
}
