import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String email;
  final String uid;
  final String status;
  final String password;

  User(this.name, this.email, this.uid, this.status, this.password);

  @override
  List<Object?> get props => [name, email, uid, status, password];
}
