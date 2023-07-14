import 'package:flutter/material.dart';
import 'package:flutter_basic/profile/application/profleRequests.dart';
import 'package:image_network/image_network.dart';

class ProfileBoxMobile extends StatefulWidget {
  final double fem;
  final String name;
  final String description;
  final String department;
  final String email;
  final String follow;
  final bool myProfile;

  const ProfileBoxMobile({
    required this.fem,
    required this.name,
    required this.description,
    required this.follow,
    required this.myProfile,
    required this.department,
    required this.email,
  });

  @override
  _ProfileBoxMobileState createState() => _ProfileBoxMobileState();
}

class _ProfileBoxMobileState extends State<ProfileBoxMobile> {
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

    description = widget.description;
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
    print(widget.name);
    print(following.contains(widget.name));
    if (following.contains(widget.name)) {
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
      ProfileRequests.unfollowUser(widget.name);
      setState(() {
        follow = 'Seguir';
      });
    } else {
      ProfileRequests.followUser(widget.name);
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
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        color: Colors.blue[50],
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Icon(
                                Icons.add_a_photo,
                                size: 24,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.email,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              widget.department,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            OutlinedButton(
                              onPressed: widget.myProfile
                                  ? editProfile
                                  : changeFollow,
                              style: OutlinedButton.styleFrom(
                                fixedSize: Size(120, 50),
                                backgroundColor: Colors.blue,
                              ),
                              child: Text(
                                widget.myProfile ? 'Editar' : widget.follow,
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
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
