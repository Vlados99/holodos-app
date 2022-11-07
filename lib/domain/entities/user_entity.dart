import 'package:equatable/equatable.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';

class UserEntity extends Equatable {
  final String? uId;
  final String? name;
  final String? email;
  final String? password;
  final List<ProductEntity>? products;
  final List<RecipeEntity>? favoriteRecipes;

  const UserEntity({
    this.uId,
    this.name,
    this.email,
    this.password,
    this.products,
    this.favoriteRecipes,
  });

  @override
  List<Object?> get props =>
      [uId, name, email, password, products, favoriteRecipes];
}
