
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:urban_aura_flutter/core/theme/app_palette.dart';

import 'custom_divider.dart';
import 'spacer_box.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Center(
          child: Text(
            'FOLLOW US',
            style: GoogleFonts.tenorSans(
                fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                letterSpacing: 4,
                color: AppPalette.titleActive),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FaIcon(FontAwesomeIcons.twitter),
            FaIcon(FontAwesomeIcons.facebook),
            FaIcon(FontAwesomeIcons.instagram)
          ],
        ),
        const SpacerBox(),
        const CustomDivider(),
        const SizedBox(
          height: 12,
        ),
        Center(
          child: Text(
            'support@openfashion.com',
            style: GoogleFonts.tenorSans(
                fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                color: AppPalette.body),
          ),
        ),
        Center(
          child: Text(
            '+60 825 876',
            style: GoogleFonts.tenorSans(
                fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                color: AppPalette.body),
          ),
        ),
        Center(
          child: Text(
            '08:00 - 22:00 - Everyday',
            style: GoogleFonts.tenorSans(
                fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                color: AppPalette.body),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        const CustomDivider(),
        const SpacerBox(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: GoogleFonts.tenorSans(
                  fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                  color: AppPalette.titleActive),
            ),
            Text(
              'Contact',
              style: GoogleFonts.tenorSans(
                  fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                  color: AppPalette.titleActive),
            ),
            Text(
              'Blog',
              style: GoogleFonts.tenorSans(
                  fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                  color: AppPalette.titleActive),
            ),
          ],
        ),
        const SpacerBox(),
        Container(
          width: size.width,
          height: 40,
          color: AppPalette.cardBackground,
          child: Center(
            child: Text(
              'Copyright© OpenFashion All Rights Reserved.',
              style: GoogleFonts.tenorSans(
                  fontSize: Theme.of(context).textTheme.labelLarge?.fontSize,
                  color: AppPalette.label),
            ),
          ),
        )
      ],
    );
  }
}
