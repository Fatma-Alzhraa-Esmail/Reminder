import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:quickcue/home/manager/reminders/reminders_cubit.dart';
import 'package:quickcue/reminder/models/reminder_model.dart';
import 'package:quickcue/reminder/pages/reminder_page.dart';
import 'package:quickcue/utils/app_text_style.dart';

class UpComingList extends StatelessWidget {
  const UpComingList({
    super.key,
    required this.reminders,
  });

  final List<ReminderModel> reminders;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        children: reminders.map((reminder) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReminderPage(
                          isEdit: true,
                          reminderItem: reminder,
                        )),
              ).then(
                (value){
                  BlocProvider.of<RemindersCubit>(context).fetchAllReminders();
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(reminder.color),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            reminder.title ?? "No Title",
                            style: AppTextStyle.w700,
                          ),
                        ),
                        InkWell(
                          child: Icon(
                            Icons.delete_outlined,
                            color: Colors.red,
                            size: 24,
                          ),
                          onTap: () {
                            reminder.delete();
                            BlocProvider.of<RemindersCubit>(context)
                                .fetchAllReminders();
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      reminder.description ?? "No Description",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.w500.copyWith(fontSize: 17),
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: Text(
                          DateFormat('d MMM HH:mm')
                              .format(DateTime.tryParse(reminder.date)!),
                          style: AppTextStyle.w500.copyWith(fontSize: 17),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
