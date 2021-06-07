part of 'caffair_bloc.dart';

@immutable
abstract class CaffairState extends Equatable {
  const CaffairState();
}

class CaffairInitializing extends CaffairState {
  @override
  List<Object> get props => [];
}

class CaffairLoading extends CaffairState {
  @override
  List<Object> get props => [];
}

class CaffairListLoaded extends CaffairState {
  @override
  // TODO: implement props
  CaffairModel caffairList;

  CaffairListLoaded({required this.caffairList});

  @override
  // TODO: implement props
  List<Object> get props => [caffairList];
}

class CaffairError extends CaffairState {
  String message;
  CaffairError({required this.message});
  @override
  // TODO: implement props
  List<Object> get props => [message];
}
