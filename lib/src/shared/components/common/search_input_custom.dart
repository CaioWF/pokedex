import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/src/shared/theme/colors.dart';

class SearchInputCustom extends StatefulWidget {
  const SearchInputCustom({super.key});

  @override
  State<SearchInputCustom> createState() => _SearchInputCustomState();
}

class _SearchInputCustomState extends State<SearchInputCustom> {
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      print('Calling: $query');
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      decoration: BoxDecoration(
        color: AppColors.backgroundDefaultInput,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/search.svg',
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(AppColors.textGrey, BlendMode.srcIn)
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: _onSearchChanged,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textBlack,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: AppLocalizations.of(context)!.inputSearch,
                hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textGrey,
                  height: 1.19,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}