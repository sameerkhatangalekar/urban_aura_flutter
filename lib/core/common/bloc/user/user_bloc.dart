import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_aura_flutter/core/common/domain/entities/address_entity.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/get_addresses_usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/update_address_usecase.dart';
import 'package:urban_aura_flutter/core/usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/create_address_usecase.dart';
import 'package:urban_aura_flutter/core/common/domain/usecase/delete_address_usecase.dart';


part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetAddressesUsecase _getAddressesUsecase;
  final CreateAddressUsecase _createAddressUsecase;
  final UpdateAddressUsecase _updateAddressUsecase;
  final DeleteAddressUsecase _deleteAddressUsecase;

  UserBloc({
    required GetAddressesUsecase getAddressesUsecase,
    required CreateAddressUsecase createAddressUsecase,
    required UpdateAddressUsecase updateAddressUsecase,
    required DeleteAddressUsecase deleteAddressUsecase,
  })  : _getAddressesUsecase = getAddressesUsecase,
        _createAddressUsecase = createAddressUsecase,
        _updateAddressUsecase = updateAddressUsecase,
        _deleteAddressUsecase = deleteAddressUsecase,
        super(const UserInitialState()) {
    on<GetAddressesEvent>((event, emit) async {
      emit(const UserAddressLoadingState());

      final result = await _getAddressesUsecase(const NoParams());

      result.fold((l) => emit(UserAddressFailedState(message: l.message)),
          (r) => emit(UserAddressLoadedState(addresses: r)));
    });

    on<CreateAddressActionEvent>((event, emit) async {
      emit(const UserActionLoadingState('Registering address...'));

      final result = await _createAddressUsecase(CreateAddressParams(
          name: event.name,
          city: event.city,
          state: event.state,
          country: event.country,
          contact: event.contact,
          line_one: event.line_one,
          postal_code: event.postal_code));

      result.fold((l) => emit(UserActionFailedState(message: l.message)), (r) {
        emit(
          UserActionSuccessState(message: r.message),
        );
        add(const GetAddressesEvent());
      });
    });

    on<UpdateAddressActionEvent>((event, emit) async {
      emit(const UserActionLoadingState('Updating address...'));

      final result = await _updateAddressUsecase(UpdateAddressParams(
          name: event.name,
          city: event.city,
          state: event.state,
          country: event.country,
          contact: event.contact,
          line_one: event.line_one,
          postal_code: event.postal_code,
          addressId: event.addressId));

      result.fold((l) => emit(UserActionFailedState(message: l.message)), (r) {
        emit(
          UserActionSuccessState(message: r.message),
        );
        add(const GetAddressesEvent());
      });
    });

    on<DeleteAddressActionEvent>((event, emit) async {
      emit(const UserActionLoadingState('Deleting address...'));

      final result = await _deleteAddressUsecase(event.addressId);

      result.fold(
        (l) => emit(UserActionFailedState(message: l.message)),
        (r) {
          emit(
            UserActionSuccessState(message: r.message),
          );
          add(const GetAddressesEvent());
        },
      );
    });
  }
}
