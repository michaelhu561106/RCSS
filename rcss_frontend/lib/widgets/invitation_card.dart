import 'package:flutter/material.dart';
import 'package:rcss_frontend/service_implementation/friend_service.dart';

class InvitationCard extends Card {
  final String uuid;
  final String friendUuid;
  final String createdDate;
  final String userName;

  InvitationCard({
    super.key,
    required this.uuid,
    required this.friendUuid,
    required this.createdDate,
    required this.userName,
  });

  final FriendService _friendService = FriendService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 16),
              Text(
                this.userName,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 28),
              Text(
                this.createdDate.split('T')[0],
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 16),
              IconButton(
                  onPressed: () => {
                        _friendService.confirmFriendInvitation(
                          uuid,
                          friendUuid,
                          DateTime.now().toUtc().toString(),
                        ),
                        Navigator.pop(context),
                      },
                  icon: Icon(Icons.circle_outlined)),
              IconButton(
                  onPressed: () => {
                        _friendService.confirmFriendInvitation(
                          uuid,
                          friendUuid,
                          null,
                        ),
                        Navigator.pop(context),
                      },
                  icon: Icon(Icons.close)),
            ],
          )),
    );
  }
}
