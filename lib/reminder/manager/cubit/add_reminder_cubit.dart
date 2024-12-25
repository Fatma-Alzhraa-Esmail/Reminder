import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:quickcue/reminder/models/reminder_model.dart';
import 'package:quickcue/utils/constants.dart';

part 'add_reminder_state.dart';

class AddReminderCubit extends Cubit<AddReminderState> {
  AddReminderCubit() : super(AddReminderInitial());
  

  Color color = const Color(0xffAC3931);
  addReminder(ReminderModel reminder) async {
    reminder.color = color.value;
    emit(AddReminderLoading());
    try {
      var reminderBox = Hive.box<ReminderModel>(kNotesBox);
      await reminderBox.add(reminder);
      emit(AddReminderSuccess());
    } catch (e) {
      emit(AddReminderFailure(e.toString()));
    }
  }

}
