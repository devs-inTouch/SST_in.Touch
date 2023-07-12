import 'package:flutter/material.dart';
import 'package:flutter_basic/profile/application/profleRequests.dart';
import 'package:image_network/image_network.dart';

class ProfileBoxMobile extends StatefulWidget {
  final double fem;
  final List map;
  final bool myProfile;

  const ProfileBoxMobile(
      {required this.fem, required this.map, required this.myProfile});

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
                        height: 120,
                        width: 120,
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
                              widget.map[3],
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
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
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