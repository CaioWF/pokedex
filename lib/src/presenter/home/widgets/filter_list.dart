import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pokedex/src/core/config/pokemon_types.dart';
import 'package:pokedex/src/shared/components/common/type_icon.dart';
import 'package:pokedex/src/shared/theme/colors.dart';

class FilterList extends StatefulWidget {
  final Set<String> selectedTypes;
  final Set<String> selectedWeaknesses;
  final Function() onResetFilters;
  final Function(Set<String> selectedTypes, Set<String> selectedWeaknesses) onApplyFilters;

  const FilterList({
    super.key,
    required this.selectedTypes,
    required this.selectedWeaknesses,
    required this.onResetFilters,
    required this.onApplyFilters,
  });

  @override
  State<FilterList> createState() => _FiltersListState();
}

class _FiltersListState extends State<FilterList> {
  late Set<String> _selectedTypes;
  late Set<String> _selectedWeaknesses;

  @override
  void initState() {
    super.initState();
    _selectedTypes = widget.selectedTypes;
    _selectedWeaknesses = widget.selectedWeaknesses;
  }

  void _toggleTypeSelection(String type) {
    setState(() {
      if (_selectedTypes.contains(type)) {
        _selectedTypes.remove(type);
      } else {
        _selectedTypes.add(type);
      }
    });
  }

  void _toggleWeaknessesSelection(String weakness) {
    setState(() {
      if (_selectedWeaknesses.contains(weakness)) {
        _selectedWeaknesses.remove(weakness);
      } else {
        _selectedWeaknesses.add(weakness);
      }
    });
  }

  void _resetFilters() {
    setState(() {
      _selectedTypes.clear();
      _selectedWeaknesses.clear();
    });
    widget.onResetFilters();
    Navigator.pop(context);
  }

  void _applyFilters() {
    widget.onApplyFilters(_selectedTypes, _selectedWeaknesses);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            AppLocalizations.of(context)!.typeFilterTitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textBlack,
              height: 1.19,
            ),
          ),
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemCount: PokemonTypes.all.length,
            itemBuilder: (context, index) {
              final type = PokemonTypes.all[index];
              final isSelected = _selectedTypes.contains(type);
              return Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: GestureDetector(
                  onTap: () => _toggleTypeSelection(type),
                  child: TypeIcon(
                    type: type,
                    isSelected: isSelected,
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
          child: Text(
            AppLocalizations.of(context)!.weaknessesFilterTitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textBlack,
              height: 1.19,
            ),
          ),
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemCount: PokemonTypes.all.length,
            itemBuilder: (context, index) {
              final weaknesses = PokemonTypes.all[index];
              final isSelected = _selectedWeaknesses.contains(weaknesses);
              return Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: GestureDetector(
                  onTap: () => _toggleWeaknessesSelection(weaknesses),
                  child: TypeIcon(
                    type: weaknesses,
                    isSelected: isSelected,
                  ),
                ),
              );
            },
          ),
        ),
        const Spacer(),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: _resetFilters,
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundDefaultInput,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.clearFilters,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.textGrey,
                      height: 1.19,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ),
            const SizedBox(width: 14),
            Expanded(
              child: GestureDetector(
                onTap: _applyFilters,
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.typePsychic,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.typePsychic.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.applyFilters,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.textWhite,
                      height: 1.19,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ),
          ],
        )
      ],
    );
  }
}