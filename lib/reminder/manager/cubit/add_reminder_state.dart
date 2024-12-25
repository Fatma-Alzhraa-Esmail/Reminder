part of 'add_reminder_cubit.dart';

@immutable
sealed class AddReminderState {}

final class AddReminderInitial extends AddReminderState {}


class AddReminderLoading extends AddReminderState {}

class AddReminderSuccess extends AddReminderState {}

class AddReminderFailure extends AddReminderState {
  final String errMessage;

  AddReminderFailure(this.errMessage);
}
