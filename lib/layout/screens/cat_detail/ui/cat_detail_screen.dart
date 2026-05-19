import 'package:flutter/material.dart';
import 'package:pet_ai_project/data/models/cat.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';

import 'widgets/cat_detail_header.dart';
import 'widgets/cat_detail_info_row.dart';

class CatDetailScreen extends StatelessWidget {
  const CatDetailScreen({super.key, required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        title: Text('Cat Profile', style: AppFonts.f16s),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            CatDetailHeader(cat: cat),
            const SizedBox(height: 8),
            CatDetailInfoRow(label: 'Name', value: cat.name),
            Divider(height: 1, color: AppColors.borderPrimary),
            CatDetailInfoRow(label: 'Age', value: cat.formattedAge),
            Divider(height: 1, color: AppColors.borderPrimary),
            CatDetailInfoRow(label: 'Sex', value: cat.sex),
            Divider(height: 1, color: AppColors.borderPrimary),
            CatDetailInfoRow(label: 'Breed', value: cat.breed),
            Divider(height: 1, color: AppColors.borderPrimary),
            CatDetailInfoRow(
              label: 'Special conditions',
              value: cat.formattedConditions,
            ),
          ],
        ),
      ),
    );
  }
}
