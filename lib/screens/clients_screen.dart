import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:medify/cubit/client_details_cubit.dart';
import 'package:medify/cubit/clients_cubit.dart';
import 'package:medify/database/model_queries/medication_event_queries.dart';
import 'package:medify/database/models/user_connection.dart';
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
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is ClientsLoaded) {
            var userConnections = state.clients;
            if (userConnections.length > 0) {
              return RefreshIndicator(
                onRefresh: () => BlocProvider.of<ClientsCubit>(context).loadClients(),
                child: ListView.builder(
                  itemCount: userConnections.length,
                  itemBuilder: (context, index) {
                    var userConnection = userConnections[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.sv, horizontal: 8.sh),
                      child: Container(
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
                        child: userConnection.status == Status.requested ? _requestedUsersItem(context, userConnection) : _connectedUsersItem(context, userConnection),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You have no clients.",
                      style: TextStyle(fontSize: 18.sf),
                    ),
                    TextButton(
                      child: Text(
                        "Reload",
                        style: TextStyle(fontSize: 14.sf),
                      ),
                      onPressed: () => BlocProvider.of<ClientsCubit>(context).loadClients(),
                    ),
                  ],
                ),
              );
            }
          }
          if (state is ClientsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "An error has occured.",
                    style: TextStyle(fontSize: 18.sf),
                  ),
                  TextButton(
                    child: Text("Reload"),
                    onPressed: () => BlocProvider.of<ClientsCubit>(context).loadClients(),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _connectedUsersItem(BuildContext context, UserConnection userConnection) {
    var user = userConnection.user;
    return ListTile(
      title: Text(
        user.name,
        style: TextStyle(fontSize: 20.sf),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        size: 24.sf,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 8.sv, horizontal: 8.sh),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (newContext) => BlocProvider.value(
              value: BlocProvider.of<ClientsCubit>(context),
              child: BlocProvider<ClientDetailsCubit>(
                create: (context) => ClientDetailsCubit(MedicationEventQueries()),
                child: ClientDetailsScreen(userConnection),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _requestedUsersItem(BuildContext context, UserConnection userConnection) {
    var user = userConnection.user;
    return ListTile(
      title: Text(
        user.name,
        style: TextStyle(fontSize: 20.sf),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PlatformIconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.cancel,
              color: Colors.red,
              size: 30.sf,
            ),
            onPressed: () {
              BlocProvider.of<ClientsCubit>(context).removeClient(userConnection);
            },
          ),
          PlatformIconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.check_circle,
              color: Theme.of(context).primaryColor,
              size: 30.sf,
            ),
            onPressed: () {
              BlocProvider.of<ClientsCubit>(context).acceptRequest(userConnection);
            },
          ),
        ],
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 8.sv, horizontal: 8.sh),
    );
  }
}
