part of 'category_cubit.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  final List<ArCategory> arCategory;

  const CategoryLoaded({required this.arCategory});
  @override
  List<Object> get props => [arCategory];
}
