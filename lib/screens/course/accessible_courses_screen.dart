import 'package:agile_unify/components/custom_drawer/custom_drawer.dart';
import 'package:agile_unify/components/error_box.dart';
import 'package:agile_unify/core/app_colors.dart';
import 'package:agile_unify/stores/course_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'components/course_tile.dart';

class AccessibleCoursesScreen extends StatelessWidget {
  final CourseStore courseStore = GetIt.I<CourseStore>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: const Text('Cursos Acessíveis'),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.fromLTRB(15, 12, 15, 12),
            child: Observer(builder: (_) {
              if (courseStore.error != null) {
                return ErrorBox(
                  message: courseStore.error,
                );
              } else if (courseStore.accessibleCourseList.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppColors.purple),
                  ),
                );
              } else {
                final courses = courseStore.accessibleCourseList;

                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  itemCount: courses.length,
                  itemBuilder: (_, index) {
                    final course = courses[index];

                    return CourseTile(course);
                  },
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
