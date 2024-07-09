import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class CustomSliverAppBar extends StatelessWidget {
  final bool showBackButton;
  const CustomSliverAppBar({super.key,  this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leading:showBackButton ?  IconButton(onPressed: ()=> context.pop(), icon: const Icon(Icons.close)) :  InkWell(
        onTap: () {},
        splashColor: Colors.grey.shade300,
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
        InkWell(
          onTap: () {},
          splashColor: Colors.grey.shade300,
          child: SvgPicture.asset(
            'assets/icons/search_icon.svg',
            width: 24,
            height: 24,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        InkWell(
          onTap: () {
            context.push('/cart');
          },
          splashColor: Colors.grey.shade300,
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
    );
  }
}
