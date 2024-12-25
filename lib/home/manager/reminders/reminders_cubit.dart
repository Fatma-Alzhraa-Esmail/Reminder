import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:quickcue/reminder/models/reminder_model.dart';
import 'package:quickcue/utils/constants.dart';

part 'reminders_state.dart';

class RemindersCubit extends Cubit<RemindersState> {
  RemindersCubit() : super(RemindersInitial());
  List<ReminderModel> reminders=[];
  fetchAllReminders() {
    var notesBox = Hive.box<ReminderModel>(kNotesBox);

    reminders = notesBox.values.toList();
    emit(ReminderSuccess(
      reminders: reminders
    ));
  }
}
