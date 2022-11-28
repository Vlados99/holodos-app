part of 'recipe_comments_cubit.dart';

abstract class CommentState extends Equatable {
  const CommentState();
}

class CommentInitial extends CommentState {
  @override
  List<Object> get props => [];
}

class CommentLoading extends CommentState {
  @override
  List<Object> get props => [];
}

class CommentFailure extends CommentState {
  @override
  List<Object> get props => [];
}

class CommentsLoaded extends CommentState {
  final List<CommentEntity> comments;

  CommentsLoaded({required this.comments});

  @override
  List<Object> get props => [];
}

class CommentLoaded extends CommentState {
  CommentLoaded();

  @override
  List<Object> get props => [];
}
