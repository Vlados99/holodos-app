import 'package:equatable/equatable.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';

class UserEntity extends Equatable {
  final String uId;
  final String name;
  final String email;
  final String status;
  final String password;
  final List<ProductEntity>? products;
  final List<RecipeEntity>? favoriteRecipes;

  const UserEntity({
    required this.uId,
    required this.name,
    required this.email,
    required this.status,
    required this.password,
    required this.products,
    required this.favoriteRecipes,
  });

  @override
  List<Object?> get props =>
      [uId, name, email, status, password, products, favoriteRecipes];
}
