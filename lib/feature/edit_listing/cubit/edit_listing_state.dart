part of 'edit_listing_cubit.dart';

sealed class EditListingState extends Equatable {
  const EditListingState();

  @override
  List<Object> get props => [];
}

final class EditListingInitial extends EditListingState {}

final class EditListingLoading extends EditListingState {}

final class EditListingNotify extends EditListingState {}
