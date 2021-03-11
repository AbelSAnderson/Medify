import 'package:flutter/material.dart';
import 'package:medify/database/models/user.dart';

class ClientsScreen extends StatefulWidget {
  @override
  _ClientsScreenState createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  List<User> _users = [];
  List<User> _requestedUsers = [];
  List<User> _connectedUsers = [];

  @override
  void initState() {
    super.initState();
    User user = User(0, "firstName", "lastName", "pharmacyNumber", "doctorNumber");
    _connectedUsers = [user, user, user, user, user];
    _requestedUsers = [user, user];
    _users.addAll(_requestedUsers);
    _users.addAll(_connectedUsers);
  }

  Widget _connectedUsersItem(User user) {
    return ListTile(
      title: Text(user.firstName + " " + user.lastName),
      trailing: Icon(Icons.keyboard_arrow_right),
      contentPadding: EdgeInsets.all(8),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => null));
      },
    );
  }

  Widget _requestedUsersItem(User user) {
    return ListTile(
      title: Text(user.firstName + " " + user.lastName),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              Icons.cancel,
              color: Colors.red,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.check_circle,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
      contentPadding: EdgeInsets.all(8),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          var user = _users[index];
          return Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
            child: index < _requestedUsers.length ? _requestedUsersItem(user) : _connectedUsersItem(user),
          );
        });
  }
}
