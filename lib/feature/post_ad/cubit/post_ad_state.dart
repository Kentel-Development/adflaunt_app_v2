part of 'post_ad_cubit.dart';

abstract class PostAdState extends Equatable {
  const PostAdState();

  @override
  List<Object> get props => [];
}

class PostAdInitial extends PostAdState {}

class PostAdNotify extends PostAdState {}

class PostAdLoading extends PostAdState {}

class PostAdSuccess extends PostAdState {}

class PostListingError extends PostAdState {
  final String error;
  PostListingError(this.error);

  @override
  List<Object> get props => [error];
}
