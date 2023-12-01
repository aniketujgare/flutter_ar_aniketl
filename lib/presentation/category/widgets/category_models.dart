import 'package:flutter/material.dart';

import '../../../api/api.dart';
import '../../../data/models/ar_category.dart';
import 'category_page_view.dart';

class CategoryModels extends StatelessWidget {
  const CategoryModels({
    super.key,
    required this.isMobile,
  });

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: API().getCategories(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ArCategory>?> snapshot) {
        if (snapshot.hasData) {
          return CategoryPageView(
              isMobile: isMobile, arCategoryies: snapshot.data!);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
