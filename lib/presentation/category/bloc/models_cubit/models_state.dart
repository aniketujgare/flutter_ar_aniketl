part of 'models_cubit.dart';

sealed class ModelsState extends Equatable {
  const ModelsState();

  @override
  List<Object> get props => [];
}

final class ModelsInitial extends ModelsState {}

final class ModelsLoading extends ModelsState {}

final class ModelsLoaded extends ModelsState {
  final List<ArModel> arModels;

  const ModelsLoaded({required this.arModels});
  @override
  List<Object> get props => [arModels];
}
