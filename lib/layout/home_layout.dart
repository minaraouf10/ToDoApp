import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled3/shared/components/components.dart';
import 'package:untitled3/shared/cubit/cubit.dart';
import 'package:untitled3/shared/cubit/state.dart';

class HomeLayout extends StatelessWidget {
  late Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..createDataBase(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if (state is AppInsertDataBaseState) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            AppCubit cubit = BlocProvider.of(context);
            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: Text(cubit.Title[cubit.currentIndex]),
              ),
              body: ConditionalBuilder(
                  condition: state is! AppGetDataBaseLoadingState,
                  builder: (context) => cubit.screens[cubit.currentIndex],
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator())),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.isBottomSheetShown) {
                    if (formKey.currentState!.validate()) {
                      cubit.insertToDatabase(titleController.text,
                          timeController.text, dateController.text);
                    }
                  } else {
                    scaffoldKey.currentState
                        ?.showBottomSheet(
                          (context) => Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defaultFormField(
                                      controller: titleController,
                                      type: TextInputType.text,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'title must be not empty';
                                        }
                                        return null;
                                      },
                                      label: 'Text Title',
                                      prefix: Icons.title,
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    defaultFormField(
                                      controller: timeController,
                                      type: TextInputType.datetime,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'time must be not empty';
                                        }
                                        return null;
                                      },
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        )
                                            .then((value) => {
                                                  timeController.text = value!
                                                      .format(context)
                                                      .toString()
                                                })
                                            .catchError((onError) {});
                                      },
                                      label: 'Text Time',
                                      prefix: Icons.watch_later_outlined,
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    defaultFormField(
                                      controller: dateController,
                                      type: TextInputType.datetime,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'date must be not empty';
                                        }
                                        return null;
                                      },
                                      onTap: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    '2022-12-31'))
                                            .then((value) => {
                                                  dateController.text =
                                                      DateFormat.yMMMd()
                                                          .format(value!)
                                                });
                                      },
                                      label: 'Text Date',
                                      prefix: Icons.watch_later_outlined,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          elevation: 20.0,
                        )
                        .closed
                        .then((value) {
                      cubit.changeBottomSheetState(
                          isShow: false, icon: Icons.edit);
                    }); // to closed bottom sheet manual
                    cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                  }
                },
                child: Icon(cubit.fabIcon),
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                elevation: 15.0,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined),
                    label: 'Archived',
                  ),
                ],
              ),
            );
          },
        ));
  }
}
