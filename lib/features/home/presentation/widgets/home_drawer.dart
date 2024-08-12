import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_aura_flutter/core/common/bloc/auth/auth_bloc.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DrawerHeader(
              child: SvgPicture.asset(
                'assets/icons/logo.svg',
                theme: const SvgTheme(
                  currentColor: Colors.white,
                ),
              ),
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              tileColor: Colors.grey.shade100,
              trailing: const FaIcon(
                FontAwesomeIcons.userAstronaut,
                color: Colors.black,
              ),
              title: const Text(
                'Account',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Scaffold.of(context).closeDrawer();
                context.push('/user');
              },
            ),
            const SizedBox(
              height: 4,
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              tileColor: Colors.grey.shade100,
              trailing: const FaIcon(
                FontAwesomeIcons.gifts,
                color: Colors.black,
              ),
              title: const Text(
                'My Orders',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Scaffold.of(context).closeDrawer();
                context.push('/orders');
              },
            ),
            const Spacer(),
            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              tileColor: Colors.black,
              trailing: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                context.read<AuthBloc>().add(const SignOutEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}
