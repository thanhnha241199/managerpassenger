part of 'payment_bloc.dart';

class PaymentState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PaymentInitialState extends PaymentState {}

class LoadingState extends PaymentState {}

class AddSuccessState extends PaymentState {}

class DeleteSuccessState extends PaymentState {}

class SuccessState extends PaymentState {
  List<CardModel> card;
  SuccessState({this.card});
}

class FailureState extends PaymentState {
  String msg;

  FailureState({this.msg});
}
