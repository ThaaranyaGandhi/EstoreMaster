part of 'address_bloc.dart';

@immutable
class AddressState {}

class AddressInitial extends AddressState {}

class Loading extends AddressState {}

class AddressCreated extends AddressState {}

class AddressListed extends AddressState {
  final List<Address> addresses;

  AddressListed(this.addresses);
}

class AddressUpdated extends AddressState {}

class Failed extends AddressState {}
