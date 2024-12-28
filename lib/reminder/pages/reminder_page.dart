import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quickcue/reminder/manager/add_reminder_cubit/add_reminder_cubit.dart';
import 'package:quickcue/reminder/models/reminder_model.dart';
import 'package:quickcue/reminder/widgets/color_list.dart';
import 'package:quickcue/router/navigator.dart';
import 'package:quickcue/utils/app_text_style.dart';
import 'package:quickcue/utils/colors.dart';
import 'package:quickcue/utils/components/text_input_field.dart';

// ignore: must_be_immutable
class ReminderPage extends StatefulWidget {
  ReminderPage({super.key, required this.isEdit, this.reminderItem});
  bool isEdit;
  ReminderModel? reminderItem;

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  double _textFieldHeight = 60.0;

  final double _maxTextFieldHeight = 300.0;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDateTime;
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    widget.isEdit
        ? _titleController.text = widget.reminderItem!.title ?? ""
        : _titleController.text = "";
    widget.isEdit
        ? _descriptionController.text = widget.reminderItem!.description ?? ""
        : _descriptionController.text = "";

    widget.isEdit
        ? _selectedDateTime = DateTime.tryParse(widget.reminderItem!.date)
        : null; 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.isEdit
          ? (AddReminderCubit()..color = Color(widget.reminderItem!.color))
          : AddReminderCubit(),
      child: BlocConsumer<AddReminderCubit, AddReminderState>(
        listener: (context, state) {
          if (state is AddReminderFailure) {}

          if (state is AddReminderSuccess) {
            CustomNavigator.pop(result: true);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () => CustomNavigator.pop(),
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.mainColor,
                  size: 26,
                ),
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
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 0,
                        children: [
                          InkWell(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: widget.isEdit?DateTime.tryParse(widget.reminderItem!.date):DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              ).then((selectedDate) {
                                // After selecting the date, display the time picker.
                                if (selectedDate != null) {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((selectedTime) {
                                    // Handle the selected date and time here.
                                    if (selectedTime != null) {
                                      DateTime selectedDateTime = DateTime(
                                        selectedDate.year,
                                        selectedDate.month,
                                        selectedDate.day,
                                        selectedTime.hour,
                                        selectedTime.minute,
                                      );
                                      setState(() {
                                        _selectedDateTime = selectedDateTime;
                                      });
                                    }
                                  });
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _selectedDateTime == null
                                      ? "Choose DateTime"
                                      : DateFormat('d MMM yyyy HH:mm')
                                          .format(_selectedDateTime!),
                                  style: AppTextStyle.w500
                                      .copyWith(color: Colors.grey[700]),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextInputField(
                                  controller: _titleController,
                                  borderType: BorderType.None,
                                  hintText: "Write Title....",
                                  maxLines: 1,
                                  withBottomPadding: false,
                                  inputStyle: AppTextStyle.w700,
                                  hintStyle: AppTextStyle.w800.copyWith(
                                      color: Colors.grey, fontSize: 26),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  var noteModel = ReminderModel(
                                      title: _titleController.text,
                                      description: _descriptionController.text,
                                      date: _selectedDateTime.toString(),
                                      color: BlocProvider.of<AddReminderCubit>(
                                              context)
                                          .color
                                          .value);
                                  if (widget.isEdit == false) {
                                    BlocProvider.of<AddReminderCubit>(context)
                                        .addReminder(noteModel);
                                  } else {
                                    widget.reminderItem!.title =
                                        _titleController.text ??
                                            widget.reminderItem!.title;
                                    widget.reminderItem!.description =
                                        _descriptionController.text ??
                                            widget.reminderItem!.description;
                                    widget.reminderItem!.color =
                                        BlocProvider.of<AddReminderCubit>(
                                                    context)
                                                .color
                                                .value ??
                                            widget.reminderItem!.color;

                                    widget.reminderItem!.date =
                                        _selectedDateTime.toString() ??
                                            widget.reminderItem!.date;
                                    widget.reminderItem!.save();
                                    CustomNavigator.pop(result: true);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 1,
                                            color: const Color.fromARGB(
                                                255, 199, 197, 197),
                                            offset: Offset(0, 1),
                                            spreadRadius: 1)
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                                    final newHeight =
                                        numberOfLines * 24.0 + 18.0;
                                    setState(() {
                                      _textFieldHeight = newHeight.clamp(
                                          50.0, _maxTextFieldHeight);
                                    });
                                  },
                                  hintStyle: AppTextStyle.w500
                                      .copyWith(color: Colors.grey),
                                  withBottomPadding: true,
                                  inputStyle: AppTextStyle.w500
                                      .copyWith(color: Colors.black87),
                                ),
                              ),
                            ),
                          ),
                          ColorsListView(),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    )
                  ],
                )),
          );
        },
      ),
    );
  }
}
