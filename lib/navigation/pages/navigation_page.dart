import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickcue/home/manager/navigation/navigation_cubit.dart';
import 'package:quickcue/home/manager/navigation/navigation_state.dart';
import 'package:quickcue/router/navigator.dart';
import 'package:quickcue/router/routers.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NavigationCubit(),
      child: BlocConsumer<NavigationCubit, NavigationState>(
          listener: (BuildContext context, NavigationState state) {},
          builder: (BuildContext context, NavigationState state) {
            NavigationCubit cubit = NavigationCubit.get(context);
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                  width: double.infinity,
                  child: cubit.screens[cubit.currentIndex]),
              bottomNavigationBar: Theme(
                data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: BottomAppBar(
                  clipBehavior: Clip.antiAlias,
                  height: 65,
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  shadowColor: Colors.grey,
                  shape: CircularNotchedRectangle(),
                  notchMargin: 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          cubit.currentIndex = 0;
                          cubit.changeIndex(cubit.currentIndex);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.menu)],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          cubit.currentIndex = 1;
                          cubit.changeIndex(cubit.currentIndex);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.search)],
                        ),
                      )
                    ],
                  ),
                  elevation: 40,
                ),

                // This trailing comma makes auto-formatting nice
              ),
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                shape: CircleBorder(),
                onPressed: () {
                  CustomNavigator.push(Routes.reminder);
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
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButtonAnimator:
                  FloatingActionButtonAnimator.scaling,
            );
          }),
    );
  }
}
