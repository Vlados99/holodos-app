import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holodos/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required name,
      required email,
      required password,
      products,
      favoriteRecipes})
      : super(
          name: name,
          email: email,
          password: password,
          products: products,
          favoriteRecipes: favoriteRecipes,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      name: snapshot.data().toString().contains("name")
          ? snapshot.get('name')
          : '',
      email: snapshot.data().toString().contains("email")
          ? snapshot.get('email')
          : '',
      password: snapshot.data().toString().contains("password")
          ? snapshot.get('password')
          : '',
      products: snapshot.data().toString().contains("products")
          ? snapshot.get('products')
          : [],
      favoriteRecipes: snapshot.data().toString().contains("favoriteRecipes")
          ? snapshot.get('favoriteRecipes')
          : [],
    );
  }

  Map<String, dynamic> createUser() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'products': products,
      'favoriteRecipes': favoriteRecipes,
    };
  }
}
