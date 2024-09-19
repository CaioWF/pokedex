import 'package:flutter/material.dart';
import 'package:pokedex/src/shared/theme/colors.dart';

class DraggableBottomSheet extends StatelessWidget {
  final Widget content;
  final String title;
  final String description;
  final double maxChildSize;

  const DraggableBottomSheet({
    super.key,
    required this.content,
    required this.title,
    required this.description,
    required this.maxChildSize,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.48,
      minChildSize: 0.2,
      maxChildSize: maxChildSize,
      builder: (BuildContext context, ScrollController scrollController) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              decoration: const BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.textBlack,
                      height: 1.19,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textGrey,
                      height: 1.19,
                    ),
                  ),
                  const SizedBox(height: 35),
                  Expanded(
                    child: content,
                  ),
                ],
              ),
            ),
            Positioned(
              top: -12,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onVerticalDragUpdate: (details) {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 80,
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundWhite,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}