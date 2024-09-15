import 'package:flutter/material.dart';

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
          clipBehavior: Clip.none, // Permite que a barra fique fora da área visível
          children: [
            // Conteúdo principal do BottomSheet
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16), // Espaço para o handle fora do BottomSheet
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
                            onItemSelected(item); // Chama o callback ao selecionar o item
                            Navigator.pop(context); // Fecha o BottomSheet
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Barra de arrasto posicionada fora do BottomSheet
            Positioned(
              top: -20, // Posiciona a barra para fora do BottomSheet
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onVerticalDragUpdate: (details) {
                    Navigator.of(context).pop(); // Para capturar o arrasto direto
                  },
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
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