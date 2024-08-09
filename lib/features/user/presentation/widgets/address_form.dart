import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_aura_flutter/core/common/bloc/user/user_bloc.dart';
import 'package:urban_aura_flutter/core/common/presentation/widgets/custom_divider.dart';
import 'package:urban_aura_flutter/core/helper/regex.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/address_entity.dart';


import 'custom_black_button.dart';

class AddressForm extends StatefulWidget {
  final AddressEntity? addressEntity;

  const AddressForm({
    super.key,
    this.addressEntity,
  });

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _lineOneController = TextEditingController();
  final _postalCodeController = TextEditingController();

  @override
  void initState() {
    if (widget.addressEntity != null) {
      _nameController.text = widget.addressEntity!.name;
      _contactController.text = widget.addressEntity!.contact;
      _cityController.text = widget.addressEntity!.city;
      _stateController.text = widget.addressEntity!.state;
      _countryController.text = widget.addressEntity!.country;
      _lineOneController.text = widget.addressEntity!.line_one;
      _postalCodeController.text = widget.addressEntity!.postal_code;
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _lineOneController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomViewInset = MediaQuery.viewInsetsOf(context).bottom;
    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(12, 12, 12, bottomViewInset),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                Text(
                  widget.addressEntity == null
                      ? 'Register Address'
                      : 'Update Address',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const CustomDivider(),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    isDense: true,
                    hintStyle: const TextStyle(color: Colors.black87),
                    labelText: 'Name',
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    labelStyle: const TextStyle(color: Colors.black87),
                    errorStyle: const TextStyle(color: Colors.redAccent),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide:
                          const BorderSide(color: Colors.redAccent, width: 1),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name cannot be empty!';
                    }
                    if (!nameRegex.hasMatch(value)) {
                      return 'Invalid name';
                    }

                    return null;
                  },
                  controller: _nameController,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    isDense: true,
                    hintStyle: const TextStyle(color: Colors.black87),
                    labelText: 'Address',
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    labelStyle: const TextStyle(color: Colors.black87),
                    errorStyle: const TextStyle(color: Colors.redAccent),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide:
                          const BorderSide(color: Colors.redAccent, width: 1),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address cannot be empty!';
                    }

                    return null;
                  },
                  controller: _lineOneController,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    isDense: true,
                    hintStyle: const TextStyle(color: Colors.black87),
                    labelText: 'Contact',
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    labelStyle: const TextStyle(color: Colors.black87),
                    errorStyle: const TextStyle(color: Colors.redAccent),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide:
                          const BorderSide(color: Colors.redAccent, width: 1),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Contact cannot be empty!';
                    }

                    if (!phoneRegex.hasMatch(value)) {
                      return 'Enter valid contact!';
                    }

                    return null;
                  },
                  controller: _contactController,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    isDense: true,
                    hintStyle: const TextStyle(color: Colors.black87),
                    labelText: 'City',
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    labelStyle: const TextStyle(color: Colors.black87),
                    errorStyle: const TextStyle(color: Colors.redAccent),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide:
                          const BorderSide(color: Colors.redAccent, width: 1),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'City cannot be empty!';
                    }
                    if (!cityRegex.hasMatch(value)) {
                      return 'Enter valid city!';
                    }
                    return null;
                  },
                  controller: _cityController,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    isDense: true,
                    hintStyle: const TextStyle(color: Colors.black87),
                    labelText: 'State',
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    labelStyle: const TextStyle(color: Colors.black87),
                    errorStyle: const TextStyle(color: Colors.redAccent),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide:
                          const BorderSide(color: Colors.redAccent, width: 1),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'State cannot be empty!';
                    }
                    if (!stateRegex.hasMatch(value)) {
                      return 'Enter valid state!';
                    }
                    return null;
                  },
                  controller: _stateController,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    isDense: true,
                    hintStyle: const TextStyle(color: Colors.black87),
                    labelText: 'Country',
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    labelStyle: const TextStyle(color: Colors.black87),
                    errorStyle: const TextStyle(color: Colors.redAccent),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide:
                          const BorderSide(color: Colors.redAccent, width: 1),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Country cannot be empty!';
                    }
                    if (!countryRegex.hasMatch(value)) {
                      return 'Enter valid country!';
                    }
                    return null;
                  },
                  controller: _countryController,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    isDense: true,
                    hintStyle: const TextStyle(color: Colors.black87),
                    labelText: 'Postal Code',
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    labelStyle: const TextStyle(color: Colors.black87),
                    errorStyle: const TextStyle(color: Colors.redAccent),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide:
                          const BorderSide(color: Colors.redAccent, width: 1),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Postal code cannot be empty!';
                    }
                    if (!postalCode.hasMatch(value)) {
                      return 'Enter valid postal code!';
                    }
                    return null;
                  },
                  controller: _postalCodeController,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomBlackButton(
                  voidCallback: widget.addressEntity == null
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            context.read<UserBloc>().add(
                                  CreateAddressActionEvent(
                                    name: _nameController.text.trim(),
                                    city: _cityController.text.trim(),
                                    state: _stateController.text.trim(),
                                    country: _countryController.text.trim(),
                                    contact: _contactController.text.trim(),
                                    line_one: _lineOneController.text.trim(),
                                    postal_code:
                                        _postalCodeController.text.trim(),
                                  ),
                                );

                            context.pop();
                          }
                        }
                      : () {
                          if (_formKey.currentState!.validate()) {
                            context.read<UserBloc>().add(
                                  UpdateAddressActionEvent(
                                    addressId: widget.addressEntity!.id,
                                    name: _nameController.text.trim(),
                                    city: _cityController.text.trim(),
                                    state: _stateController.text.trim(),
                                    country: _countryController.text.trim(),
                                    contact: _contactController.text.trim(),
                                    line_one: _lineOneController.text.trim(),
                                    postal_code:
                                        _postalCodeController.text.trim(),
                                  ),
                                );

                            context.pop();
                          }
                        },
                  label: widget.addressEntity == null
                      ? 'Add Address'
                      : 'Update Address',
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
