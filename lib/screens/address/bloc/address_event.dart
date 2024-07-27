// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'address_bloc.dart';

@immutable
class AddressEvent {}

class AddAddress extends AddressEvent {

  final String hno;
  final String society;
  final String pincode;
  final String area;
  final String landmark;
  final String type;
  final String name;

  AddAddress({
    required this.hno,
    required this.society,
    required this.pincode,
    required this.area,
    required this.landmark,
    required this.type,
    required this.name,
  });

}

class GetAllAddress extends AddressEvent {}

class UpdateAddress extends AddressEvent {
  final Address address;

  UpdateAddress({
    required this.address
  });
}