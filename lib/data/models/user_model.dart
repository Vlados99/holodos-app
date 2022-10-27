import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holodos/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({id, name, email, status, password})
      : super(
          id: id,
          name: name,
          email: email,
          status: status,
          password: password,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      id: snapshot.get('id'),
      name: snapshot.get('name'),
      email: snapshot.get('email'),
      status: snapshot.get('status'),
      password: snapshot.get('password'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'status': status,
      'password': password,
    };
  }

  //?????????????????????????????????????????????????????????????????
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      status: json["status"],
      password: json["password"],
    );
  }
}
