import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holodos/data/models/product_model.dart';
import 'package:holodos/data/models/recipe_model.dart';
import 'package:holodos/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({uId, name, email, status, password, products, favoriteRecipes})
      : super(
          uId: uId,
          name: name,
          email: email,
          status: status,
          password: password,
          products: products,
          favoriteRecipes: favoriteRecipes,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      uId: snapshot.get('uId'),
      name: snapshot.get('name'),
      email: snapshot.get('email'),
      status: snapshot.get('status'),
      password: snapshot.get('password'),
      products: snapshot.get('products'),
      favoriteRecipes: snapshot.get('favoriteRecipes'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'status': status,
      'password': password,
      'products': products,
      'favoriteRecipes': favoriteRecipes,
    };
  }

  //?????????????????????????????????????????????????????????????????
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json["uId"],
      name: json["name"],
      email: json["email"],
      status: json["status"],
      password: json["password"],
      products: json["products"] != null
          ? ProductModel.fromJson(json["products"])
          : null,
      favoriteRecipes: json["favoriteRecipes"] != null
          ? RecipeModel.fromJson(json["favoriteRecipes"])
          : null,
    );
  }
}
