import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_aura_flutter/core/constants.dart';
import 'package:urban_aura_flutter/features/search/presentation/bloc/search_bloc.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) => Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.black),
            height: 20,
            width: 20,
            child: Center(
                child: Text(
              state.appliedFilterCount.toString(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                  ),
              textAlign: TextAlign.center,
            )),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            onPressed: () => searchPageKey.currentState?.openEndDrawer(),
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
    );
  }
}
