import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/cubit/caregivers_cubit.dart';
import 'package:medify/cubit/medications_cubit.dart';
import 'package:medify/screens/medications_screen.dart';
import 'package:medify/widgets/search_bar.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        leading: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Jane Smith",
              style: TextStyle(fontSize: 32),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: BlocBuilder<MedicationsCubit, MedicationsState>(
                  builder: (context, state) {
                    if (state is MedicationsInitial) {
                      BlocProvider.of<MedicationsCubit>(context).loadMedications();
                    }
                    if (state is MedicationsLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is MedicationsLoaded) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Medications: ${state.medications.length}",
                            style: TextStyle(fontSize: 20),
                          ),
                          ElevatedButton(
                            child: Text("View Medications"),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MedicationsScreen(state.medications)));
                            },
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Caregivers",
              style: TextStyle(fontSize: 24),
            ),
          ),
          _caregiversList(context),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              child: Text("Add Caregiver"),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AddCaregiverAlertDialog(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _caregiversList(BuildContext context) {
    return BlocBuilder<CaregiversCubit, CaregiversState>(
      builder: (context, state) {
        if (state is CaregiversInitial) {
          BlocProvider.of<CaregiversCubit>(context).loadCaregivers();
        }
        if (state is CaregiversLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CaregiversLoaded) {
          return Expanded(
            child: ListView.builder(
              itemCount: state.caregivers.length,
              itemBuilder: (context, index) {
                var caregiver = state.caregivers[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black26))),
                    child: ListTile(
                      title: Text(
                        "${caregiver.firstName} ${caregiver.lastName}",
                        style: TextStyle(fontSize: 20),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 35,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}

class AddCaregiverAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      content: SearchBar(
        onSearch: (inputText) {},
      ),
    );
  }
}
