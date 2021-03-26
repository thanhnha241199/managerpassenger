import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:managepassengercar/blocs/savelocation/blocs/model/addressmodel.dart';
import 'package:managepassengercar/repository/address_repository.dart';
import 'package:managepassengercar/src/models/address.dart';

part 'location_event.dart';

part 'location_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressRepository addressRepository;

  AddressBloc(AddressState initialState, this.addressRepository)
      : super(initialState);

  @override
  Stream<AddressState> mapEventToState(AddressEvent addressEvent) async* {
    // TODO: implement mapEventToState
    if (addressEvent is DoFetchEvent) {
      yield LoadingState();
      try {
        var address = await addressRepository.fetchAddress();
        var addressmodel = await addressRepository.fetchAddressModel();
        yield SuccessState(address: address, addressmodel: addressmodel);
      } catch (e) {
        yield FailureState(msg: e.toString());
      }
    }
    if (addressEvent is UpdateEvent) {
      yield UpdateLoadingState();
      if (addressEvent.name.isEmpty || addressEvent.address.isEmpty) {
        yield UpdateNullState();
      } else {
        try {
          String msg = await addressRepository.updateAddress(
              addressEvent.id, addressEvent.name, addressEvent.address);
          if (msg == "true") {
            yield UpdateSuccessState();
            yield LoadingState();
            try {
              var address = await addressRepository.fetchAddress();
              yield SuccessState(address: address);
            } catch (e) {
              yield FailureState(msg: e.toString());
            }
          }
        } catch (error) {
          yield UpdateFailureState(msg: error.toString());
        }
      }
    }
    if (addressEvent is AddEvent) {
      yield AddLoadingState();
      if (addressEvent.name.isEmpty || addressEvent.address.isEmpty) {
        yield AddNullState();
      } else {
        try {
          String msg = await addressRepository.addAddress(
              addressEvent.id, addressEvent.name, addressEvent.address);
          if (msg == "true") {
            yield AddSuccessState();
            yield LoadingState();
            try {
              var address = await addressRepository.fetchAddress();
              yield SuccessState(address: address);
            } catch (e) {
              yield FailureState(msg: e.toString());
            }
          }
        } catch (error) {
          yield AddFailureState(msg: error.toString());
        }
      }
    }
    if (addressEvent is DeleteEvent) {
      yield DeleteLoadingState();
      try {
        String msg = await addressRepository.deleteAddress(addressEvent.id);
        if (msg == "true") {
          yield DeleteSuccessState();
          yield LoadingState();
          try {
            var address = await addressRepository.fetchAddress();
            yield SuccessState(address: address);
          } catch (e) {
            yield FailureState(msg: e.toString());
          }
        }
      } catch (error) {
        yield DeleteFailureState(msg: error.toString());
      }
    }
  }
}
