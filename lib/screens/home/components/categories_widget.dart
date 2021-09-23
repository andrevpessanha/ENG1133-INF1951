import 'package:agile_unify/core/app_colors.dart';
import 'package:agile_unify/models/category.dart';
import 'package:agile_unify/stores/category_store.dart';
import 'package:agile_unify/stores/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class CategoriesWidget extends StatelessWidget {
  CategoriesWidget(this.selected);

  final Category selected;

  final CategoryStore categoryStore = GetIt.I<CategoryStore>();
  final HomeStore homeStore = GetIt.I<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: Observer(builder: (_) {
          if (categoryStore.error != null) {
            return Container();
          } else if (categoryStore.categoryList.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final categories = categoryStore.allCategoryList;

            return ListView.builder(
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final category = categories[index];

                return Row(
                  children: [
                    InkWell(
                      onTap: () {
                        homeStore.setChangeCategory(true);
                        homeStore.setCategory(category);
                      },
                      child: Card(
                        elevation: 8,
                        color: category.id == selected?.id
                            ? AppColors.purple
                            : AppColors.purple.withAlpha(140),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.0),
                            side: BorderSide(color: AppColors.purple)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                          child: Text(
                            category.title,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                );
              },
            );
          }
        }));
  }
}
