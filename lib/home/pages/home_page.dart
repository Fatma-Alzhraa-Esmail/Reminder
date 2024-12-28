import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickcue/home/manager/reminders/reminders_cubit.dart';
import 'package:quickcue/home/widgets/upcoming_list_widget.dart';
import 'package:quickcue/reminder/models/reminder_model.dart';
import 'package:quickcue/reminder/pages/reminder_page.dart';
import 'package:quickcue/utils/app_text_style.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RemindersCubit()..fetchAllReminders(),
      child: Scaffold(
       
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20,
                  children: [
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Reminders",
                        style: AppTextStyle.w700.copyWith(fontSize: 28),
                      ),
                    ),
                    BlocBuilder<RemindersCubit, RemindersState>(
                      builder: (context, state) {
                        var rem = context.read<RemindersCubit>();
                        List<ReminderModel> reminders = rem.reminders;
                        return Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Upcoming",
                                style: AppTextStyle.w500
                                    .copyWith(color: Colors.grey.shade700),
                              ),
                            ),
                            UpComingList(reminders: reminders),
                            SizedBox(
                              height: 16,
                            )
                          ],
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: BlocBuilder<RemindersCubit, RemindersState>(
         
          builder: (context, state) {
            return FloatingActionButton(
              
              shape: CircleBorder(),
              onPressed: () {
                // CustomNavigator.push(Routes.reminder);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReminderPage(
                            isEdit: false,
                          )),
                ).then(
                  (value) async {
                    if (value) {
                      await BlocProvider.of<RemindersCubit>(context)
                          .fetchAllReminders();
                    }
                  },
                );
              },
              tooltip: 'Increment',
              focusElevation: 5,
              highlightElevation: 2,
              isExtended: true,
              mini: false,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              elevation: 0.8,
              enableFeedback: false,
              splashColor: Colors.transparent,
              child: const Icon(Icons.add),
            );
          },
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      ),
    );
  }
}

