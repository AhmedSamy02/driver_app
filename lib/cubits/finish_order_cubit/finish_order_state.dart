class FinishOrderState {}

class FinishOrderInitialState extends FinishOrderState {}

class FinishOrderFailedState extends FinishOrderState {}

class FinishOrderSuccessState extends FinishOrderState {
  String status;
  FinishOrderSuccessState({required this.status});
}

class FinishOrderLoadingState extends FinishOrderState {}
