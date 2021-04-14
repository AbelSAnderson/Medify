part of 'medication_form_cubit.dart';

class MedicationFormState extends Equatable {
  final Medication medication;
  final String interval;
  final DateTime startDate;
  final TimeOfDay time;
  final int pillAmount;
  final bool isPillAmountValid;
  final int medType;

  const MedicationFormState({
    @required this.medication,
    @required this.interval,
    @required this.startDate,
    @required this.time,
    @required this.pillAmount,
    @required this.isPillAmountValid,
    @required this.medType,
  });

  MedicationFormState.initial()
      : this(
          medication: null,
          interval: "Weekly",
          startDate: DateTime.now(),
          time: TimeOfDay.now(),
          pillAmount: null,
          isPillAmountValid: false,
          medType: 0,
        );

  MedicationFormState copyWith({
    Medication medication,
    String interval,
    DateTime startDate,
    TimeOfDay time,
    int pillAmount,
    bool isPillAmountValid,
    int medType,
  }) {
    return MedicationFormState(
      medication: medication ?? this.medication,
      interval: interval ?? this.interval,
      startDate: startDate ?? this.startDate,
      time: time ?? this.time,
      pillAmount: pillAmount ?? this.pillAmount,
      isPillAmountValid: isPillAmountValid ?? this.isPillAmountValid,
      medType: medType ?? this.medType,
    );
  }

  @override
  List<Object> get props => [
        medication,
        interval,
        startDate,
        time,
        pillAmount,
        isPillAmountValid,
        medType,
      ];

  @override
  String toString() {
    return "${medication.brandName} $interval $startDate $time $pillAmount $medType";
  }
}
