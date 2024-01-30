import 'package:flutter/material.dart';
import '../../../core/util/styles.dart';

class QuestionText extends StatelessWidget {
  const QuestionText({
    super.key,
    required this.question,
  });

  final String question;

  @override
  Widget build(BuildContext context) {
    return Text(
      question,
      textAlign: TextAlign.center,
      style: AppTextStyles.nunito160w500textCol,
    );
  }
}
