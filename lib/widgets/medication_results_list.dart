import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:medify/cubit/nav_bar_cubit.dart';
import 'package:medify/database1/model_queries/medication_queries.dart';
import 'package:medify/cubit/medication_form_cubit.dart';
import 'package:medify/repositories/medication_event_repository.dart';
import 'package:medify/repositories/medication_info_repository.dart';
import 'package:medify/repositories/user_repository.dart';
import 'package:medify/screens/add_medication_screen.dart';
import 'package:medify/screens/medication_details_screen.dart';
import 'package:medify/scale.dart';

class MedicationResultsList extends StatelessWidget {
  final medications;

  MedicationResultsList(this.medications, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: medications.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black26)),
            ),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.sv, horizontal: 10.sh),
              title: Text(
                medications[index].brandName,
                style: TextStyle(fontSize: 16.sf),
              ),
              trailing: PlatformIconButton(
                padding: EdgeInsets.all(0),
                icon: Icon(
                  Icons.add,
                  size: 24.sf,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (newContext) => RepositoryProvider.value(
                        value: RepositoryProvider.of<MedicationEventRepository>(
                            context),
                        child: RepositoryProvider.value(
                          value:
                              RepositoryProvider.of<MedicationInfoRepository>(
                                  context),
                          child: BlocProvider.value(
                            value: BlocProvider.of<NavBarCubit>(context),
                            child: BlocProvider<MedicationFormCubit>(
                              create: (context) => MedicationFormCubit(
                                MedicationQueries(),
                                RepositoryProvider.of<MedicationInfoRepository>(
                                    context),
                                RepositoryProvider.of<
                                    MedicationEventRepository>(context),
                                RepositoryProvider.of<UserRepository>(context),
                              ),
                              child: AddMedicationScreen(medications[index]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MedicationDetailsScreen(medications[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
