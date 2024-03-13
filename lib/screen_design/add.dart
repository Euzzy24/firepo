import 'package:flutter/material.dart';

import '../model/friends.dart';

class AddFriendModal extends StatefulWidget {
  const AddFriendModal({super.key});
  @override
  AddFriendModalState createState() => AddFriendModalState();
}

class AddFriendModalState extends State<AddFriendModal> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _profileController = TextEditingController();

  Future<void> _addFriend() async {
    String name = _nameController.text;
    String description = _descriptionController.text;
    int idNumber = int.tryParse(_idNumberController.text) ?? 0;
    String position = _positionController.text;
    String profile = _profileController.text;

    // Show a loading indicator
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
      barrierDismissible: false,
    );

    await Future.delayed(Duration(seconds: 1));

    // Adding friends
    await Friends.addFriend(
      name: name,
      description: description,
      idNumber: idNumber,
      position: position,
      profile: profile,
    );

    Navigator.pop(context);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Friend'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _idNumberController,
              decoration: InputDecoration(labelText: 'ID Number'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _positionController,
              decoration: InputDecoration(labelText: 'Position'),
            ),
            TextField(
              controller: _profileController,
              decoration: InputDecoration(labelText: 'Profile'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the modal
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _addFriend,
          child: Text('Add'),
        ),
      ],
    );
  }
}
