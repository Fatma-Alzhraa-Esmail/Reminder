import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickcue/home/manager/reminders/reminders_cubit.dart';
import 'package:quickcue/reminder/manager/cubit/add_reminder_cubit.dart';
import 'package:quickcue/reminder/models/reminder_model.dart';
import 'package:quickcue/utils/app_text_style.dart';
import 'package:quickcue/utils/colors.dart';
import 'package:quickcue/utils/components/text_input_field.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  double _textFieldHeight = 60.0;

  final double _maxTextFieldHeight = 300.0;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddReminderCubit(),
      child: BlocConsumer<AddReminderCubit, AddReminderState>(
        listener: (context, state) {
          if (state is AddReminderFailure) {}

          if (state is AddReminderSuccess) {
            BlocProvider.of<RemindersCubit>(context).fetchAllReminders();
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: Icon(
                Icons.arrow_back,
                color: AppColors.mainColor,
                size: 26,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    spacing: 10,
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.push_pin_outlined,
                          color: AppColors.mainColor,
                          size: 26,
                        ),
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.notifications_none,
                          color: AppColors.mainColor,
                          size: 26,
                        ),
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.category_outlined,
                          color: AppColors.mainColor,
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                spacing: 0,
                children: [
                  TextInputField(
                    controller: _titleController,
                    borderType: BorderType.None,
                    hintText: "Write Title....",
                    maxLines: 2,
                    withBottomPadding: false,
                    inputStyle: AppTextStyle.w700,
                    hintStyle: AppTextStyle.w800
                        .copyWith(color: Colors.grey, fontSize: 26),
                  ),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: _maxTextFieldHeight,
                      ),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        height: _textFieldHeight,
                        child: TextInputField(
                          controller: _descriptionController,
                          borderType: BorderType.None,
                          hintText: "Description",
                          keyboardType: TextInputType.multiline,
                          onChange: (value) {
                            final numberOfLines =
                                '\n'.allMatches(value).length + 1;
                            final newHeight = numberOfLines * 24.0 + 18.0;
                            setState(() {
                              _textFieldHeight =
                                  newHeight.clamp(50.0, _maxTextFieldHeight);
                            });
                          },
                          hintStyle:
                              AppTextStyle.w500.copyWith(color: Colors.grey),
                          withBottomPadding: true,
                          inputStyle:
                              AppTextStyle.w500.copyWith(color: Colors.black87),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar: Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              

              child: BottomAppBar(
                clipBehavior: Clip.antiAlias,
                height: 110,
                surfaceTintColor: Colors.white,
                color: Colors.white,
                shadowColor: Colors.black,
                shape: CircularNotchedRectangle(),
                notchMargin: 12,
                elevation: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ],
                ),
              ),

              // This trailing comma makes auto-formatting nice
            ),
            resizeToAvoidBottomInset: true,
           floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
    ? FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          var currentDate = DateTime.now();

          var noteModel = ReminderModel(
              title: _titleController.text,
              description: _descriptionController.text,
              date: currentDate.toString(),
              color: Colors.blue.value);
          BlocProvider.of<AddReminderCubit>(context).addReminder(noteModel);
        },
        tooltip: 'Increment',
        heroTag: "addNote1",
        focusElevation: 5,
        highlightElevation: 2,
        isExtended: true,
        mini: false,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        elevation: 2,
        enableFeedback: false,
        splashColor: Colors.transparent,
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.check,
          size: 46,
          color: Color.fromARGB(255, 238, 188, 53),
        ),
      )
    : null,

            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            

          );
      
      
        },
      ),
    );
  }
}
