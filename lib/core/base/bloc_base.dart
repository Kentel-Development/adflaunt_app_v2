import 'package:flutter_bloc/flutter_bloc.dart';

/// This class contains the base bloc.
class BaseBloc<V, T> extends Bloc<V, T> {
  /// Creates a new [BaseBloc].
  BaseBloc(super.initialState);

  /// Emits the state safely.
  void safeEmit(T state) {
    if (isClosed) return;
    // ignore: invalid_use_of_visible_for_testing_member
    emit(state);
  }
}
