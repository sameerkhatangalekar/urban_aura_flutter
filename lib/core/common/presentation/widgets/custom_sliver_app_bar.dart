import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_aura_flutter/core/helper/custom_search_delegate.dart';

class CustomSliverAppBar extends StatefulWidget {
  final bool showBackButton;

  const CustomSliverAppBar({super.key, this.showBackButton = false});

  @override
  State<CustomSliverAppBar> createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<CustomSliverAppBar> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        floating: true,
        stretch: true,
        // expandedHeight: 120,
        centerTitle: true,
        leading: widget.showBackButton
            ? IconButton(
                onPressed: () => context.pop(), icon: const Icon(Icons.close))
            : GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: SvgPicture.asset(
                  'assets/icons/menu_icon.svg',
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
              ),
        title: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 78,
            maxWidth: 78,
            minHeight: 32,
            maxHeight: 32,
          ),
          child: SvgPicture.asset(
            'assets/icons/logo.svg',
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {

            },
            child: SvgPicture.asset(
              'assets/icons/search_icon.svg',
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          GestureDetector(
            onTap: () {
              context.push('/cart');
            },
            child: SvgPicture.asset(
              'assets/icons/shopping_bag_icon.svg',
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(
            width: 16,
          )
        ],
        stretchTriggerOffset: 5,
        onStretchTrigger: () async {
          debugPrint('called');
        });
  }
}
