import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quickcue/home/manager/reminders/reminders_cubit.dart';
import 'package:quickcue/reminder/models/reminder_model.dart';
import 'package:quickcue/utils/app_text_style.dart';
import 'package:timeago/timeago.dart' as timeago;

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Reminders",
                      style: AppTextStyle.w700.copyWith(fontSize: 28),
                    ),
                  ),
                  // Column(
                  //   spacing: 10,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 16),
                  //       child: Text(
                  //         "Pinned",
                  //         style: AppTextStyle.w500
                  //             .copyWith(color: Colors.grey.shade700),
                  //       ),
                  //     ),
                  //     AspectRatio(
                  //       aspectRatio: 2 / 1,
                  //       child: ListView.separated(
                  //         scrollDirection: Axis.horizontal,
                  //         padding: const EdgeInsets.symmetric(horizontal: 16),
                  //         separatorBuilder: (context, index) => SizedBox(
                  //           width: 14,
                  //         ),
                  //         itemCount: 2,
                  //         itemBuilder: (context, index) {
                  //           return Container(
                  //             width: MediaQuery.of(context).size.width / 2.3,
                  //             decoration: BoxDecoration(
                  //               color: Colors.blue[300],
                  //               borderRadius: BorderRadius.circular(16),
                  //             ),
                  //             child: Padding(
                  //               padding: const EdgeInsets.symmetric(
                  //                   horizontal: 14, vertical: 16),
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 spacing: 12,
                  //                 children: [
                  //                   Text(
                  //                     "Coffee",
                  //                     style: AppTextStyle.w800,
                  //                   ),
                  //                   Text(
                  //                     "Prepare hot coffie for friends. Prepare hot coffie for friends",
                  //                     maxLines: 2,
                  //                     style: AppTextStyle.w500
                  //                         .copyWith(fontSize: 17),
                  //                   ),
                  //                   Container(
                  //                     decoration: BoxDecoration(
                  //                       border:
                  //                           Border.all(color: Colors.black45),
                  //                       borderRadius: BorderRadius.circular(8),
                  //                     ),
                  //                     child: Padding(
                  //                       padding: const EdgeInsets.symmetric(
                  //                           horizontal: 10, vertical: 8),
                  //                       child: Text(
                  //                         "Todat, 4:30",
                  //                         style: AppTextStyle.w500
                  //                             .copyWith(fontSize: 17),
                  //                       ),
                  //                     ),
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  BlocProvider(
                    create: (context) => RemindersCubit()..fetchAllReminders(),
                    child: BlocConsumer<RemindersCubit, RemindersState>(
                      listener: (context, state) {
                        RemindersCubit reminder =
                            BlocProvider.of<RemindersCubit>(context);

                        if (state is ReminderSuccess) {
                          reminder.reminders = state.reminders;
                        }
                      },
                      builder: (context, state) {
                        List<ReminderModel> reminders =
                            BlocProvider.of<RemindersCubit>(context).reminders!;
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: StaggeredGrid.count(
                                crossAxisCount: 2,
                                mainAxisSpacing: 14,
                                crossAxisSpacing: 14,
                                children: reminders.map((reminder) {
                                  return Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[300],
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            reminder.title ?? "No Title",
                                            style: AppTextStyle.w700,
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            reminder.description ??
                                                "No Description",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyle.w500
                                                .copyWith(fontSize: 17),
                                          ),
                                          SizedBox(height: 8),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black45),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 8),
                                              child: Text(
                                                timeago.format(
                                                  DateTime.parse(reminder
                                                      .date), // Parse the string to DateTime
                                                ),
                                                style: AppTextStyle.w500
                                                    .copyWith(fontSize: 17),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
