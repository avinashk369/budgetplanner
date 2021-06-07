part of 'caffair_bloc.dart';

@immutable
abstract class CaffairEvent extends Equatable {
  const CaffairEvent();
}

class LoadCaffairListEvent extends CaffairEvent {
  final int pageNumber;
  const LoadCaffairListEvent({required this.pageNumber});
  @override
  List<Object> get props => [];
}
