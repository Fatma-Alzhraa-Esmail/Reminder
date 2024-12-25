import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickcue/home/manager/navigation/navigation_state.dart';
import 'package:quickcue/home/pages/home_page.dart';



class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NaviagtionInitial());
  static NavigationCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
  MyHomePage()
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }
}
