import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pokedex/src/shared/theme/colors.dart';
import 'package:pokedex/src/shared/utils/order_options.dart';

class OrderSelectList extends StatefulWidget {
  final OrderOption selectedOrder;
  final List<OrderOption> orderOptions;
  final Function(OrderOption) onItemSelected;
  final ScrollController scrollController;

  const OrderSelectList({
    super.key,
    required this.selectedOrder,
    required this.orderOptions,
    required this.onItemSelected,
    required this.scrollController,
  });

  @override
  State<OrderSelectList> createState() => _OrderSelectListState();
}

class _OrderSelectListState extends State<OrderSelectList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      clipBehavior: Clip.none,
      controller: widget.scrollController,
      itemCount: widget.orderOptions.length,
      itemBuilder: (context, index) {
        final selectedOption = widget.orderOptions[index];
        bool isSelected = selectedOption == widget.selectedOrder;

        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? 
                AppColors.typePsychic
                : AppColors.backgroundDefaultInput,
              borderRadius: BorderRadius.circular(10),
              boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.typePsychic.withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [], 
            ),
            height: 60,
            alignment: Alignment.center,
            child: ListTile(
              title: Text(
                AppLocalizations.of(context)!.order('${selectedOption.orderBy}_${selectedOption.order}'),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: isSelected ? AppColors.textWhite : AppColors.textGrey,
                  height: 1.19,
                ),
                textAlign: TextAlign.center,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              onTap: () {
                widget.onItemSelected(selectedOption);
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }
}