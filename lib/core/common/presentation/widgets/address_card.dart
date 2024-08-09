import 'package:flutter/material.dart';
import 'package:urban_aura_flutter/core/theme/app_palette.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/address_entity.dart';

class AddressCard extends StatelessWidget {
  final  bool isSelected;
  final AddressEntity _addressEntity;

  const AddressCard({super.key, required AddressEntity addressEntity,  this.isSelected = false})
      : _addressEntity = addressEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:   BoxDecoration(color: isSelected ? Colors.grey.shade100: Colors.white54),
      padding: const EdgeInsets.all(12),
      width: MediaQuery.sizeOf(context).width,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            _addressEntity.name,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            _addressEntity.line_one,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppPalette.label),
          ),
          Text(
            _addressEntity.city,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppPalette.label),
          ),
          Text(
            _addressEntity.state,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppPalette.label),
          ),
          Text(
            _addressEntity.country,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppPalette.label),
          ),
          Text(
            _addressEntity.postal_code,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppPalette.label),
          ),
          Text(
            _addressEntity.contact,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppPalette.label),
          ),
        ],
      ),
    );
  }
}
