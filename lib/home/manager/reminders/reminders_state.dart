part of 'reminders_cubit.dart';

sealed class RemindersState {}

final class RemindersInitial extends RemindersState {}

class ReminderSuccess extends RemindersState {
  final List<ReminderModel> reminders;

  ReminderSuccess({required this.reminders});
}
