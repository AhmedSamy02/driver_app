import 'package:driver_app/cubits/finish_order_cubit/finish_order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinishOrderCubit extends Cubit<FinishOrderState> {
  FinishOrderCubit() : super(FinishOrderInitialState());

  void orderSuccess(String status) async {
    emit(FinishOrderLoadingState());
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(FinishOrderSuccessState(status: status));
    } catch (e) {
      emit(FinishOrderFailedState());
    }
  }
}