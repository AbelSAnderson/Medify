import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/cubit/clients_cubit.dart';
import 'package:medify/database/models/user.dart';
import 'package:medify/screens/client_details_screen.dart';
import 'package:medify/scale.dart';

class ClientsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clients"),
      ),
      body: BlocBuilder<ClientsCubit, ClientsState>(
        builder: (context, state) {
          if (state is ClientsInitial) {
            BlocProvider.of<ClientsCubit>(context).loadClients();
          }
          if (state is ClientsLoadingInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ClientsLoaded) {
            var users = state.clients;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                var user = users[index];
                var requestedUsersLength = state.listSeperatorThreshold;
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.sv, horizontal: 8.sh),
                  child: Container(
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
                    child: index < requestedUsersLength ? _requestedUsersItem(context, users, index, requestedUsersLength) : _connectedUsersItem(context, user),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _connectedUsersItem(BuildContext context, User user) {
    return ListTile(
      title: Text(
        user.firstName + " " + user.lastName,
        style: TextStyle(fontSize: 20.sf),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        size: 24.sf,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 8.sv, horizontal: 8.sh),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ClientDetailsScreen(user)));
      },
    );
  }

  Widget _requestedUsersItem(BuildContext context, List<User> users, int index, int threshold) {
    var user = users[index];
    return ListTile(
      title: Text(
        user.firstName + " " + user.lastName,
        style: TextStyle(fontSize: 20.sf),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              Icons.cancel,
              color: Colors.red,
              size: 30.sf,
            ),
            onPressed: () {
              BlocProvider.of<ClientsCubit>(context).declineRequest(index);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.check_circle,
              color: Theme.of(context).primaryColor,
              size: 30.sf,
            ),
            onPressed: () {
              BlocProvider.of<ClientsCubit>(context).acceptRequest(index);
            },
          ),
        ],
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 8.sv, horizontal: 8.sh),
    );
  }
}
