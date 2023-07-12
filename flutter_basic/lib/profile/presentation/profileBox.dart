import 'package:flutter/material.dart';
import 'package:flutter_basic/profile/application/profleRequests.dart';
import 'package:image_network/image_network.dart';

class ProfileBox extends StatefulWidget {
  final double fem;
  final List map;
  final bool myProfile;

  const ProfileBox(
      {required this.fem, required this.map, required this.myProfile});

  @override
  _ProfileBoxState createState() => _ProfileBoxState();
}

class _ProfileBoxState extends State<ProfileBox> {
  bool isEditing = false;
  late TextEditingController _textEditingController;
  late String description = '';
  late String follow;
  String imageUrl = '';

  @override
  initState() {
    super.initState();
    if (!widget.myProfile) {
      isFollowing();
    }

    description = widget.map[2];
    _textEditingController = TextEditingController(text: description);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> isFollowing() async {
    List following = await ProfileRequests.getFollowingList();
    print("comeu");
    print(following);
    print(widget.map[0]);
    print(following.contains(widget.map[0]));
    if (following.contains(widget.map[0])) {
      setState(() {
        follow = 'Seguindo';
      });
    } else {
      setState(() {
        follow = 'Seguir';
      });
    }
  }

  editProfile() {}

  changeFollow() {
    if (follow == 'Seguindo') {
      ProfileRequests.unfollowUser(widget.map[0]);
      setState(() {
        follow = 'Seguir';
      });
    } else {
      ProfileRequests.followUser(widget.map[0]);
      setState(() {
        follow = 'Seguindo';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 200,
        width: 650,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: [
                  ImageNetwork(
                    image: imageUrl,
                    height: 120,
                    width: 120,
                  ),
                  SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.map[4],
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Email: ${widget.map[3]} \nDepartamento: ${widget.map[1]}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  OutlinedButton(
                    onPressed: widget.myProfile ? editProfile : changeFollow,
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(100, 50),
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      widget.myProfile ? 'Editar' : follow,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: isEditing
                  ? TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    )
                  : Text(description),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
