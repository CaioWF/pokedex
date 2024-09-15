import 'package:flutter/material.dart';
import 'package:pokedex/src/shared/theme/colors.dart';

class DraggableBottomSheet extends StatelessWidget {
  final List<String> items;
  final String selectedItem;
  final void Function(String) onItemSelected;
  final String title;
  final double maxChildSize;

  const DraggableBottomSheet({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onItemSelected,
    required this.title,
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
              padding: const EdgeInsets.all(40),
              decoration: const BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return ListTile(
                          title: Text(item),
                          trailing: selectedItem == item
                              ? const Icon(Icons.check, color: Colors.green)
                              : null,
                          onTap: () {
                            onItemSelected(item);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
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