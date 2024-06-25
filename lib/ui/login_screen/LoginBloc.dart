import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rridefraser/data/Repository/NetworkRepositry.dart';
import 'package:rridefraser/domain/constants.dart';
import 'package:rridefraser/domain/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

sealed class LoginState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginLoadingState extends LoginState {}

class LoginCompletedState extends LoginState {
  LoginCompletedState({required this.response});
  final String response;
  @override
  // TODO: implement props
  List<Object?> get props => [response];
}

class LoginRetrieveState extends LoginState {
  final List<Product> products;
  LoginRetrieveState({required this.products});
  @override
  // TODO: implement props
  List<Object?> get props => [products];
}

class LoginFailedState extends LoginState {
  LoginFailedState({required this.errorMessage});
  final String errorMessage;
}

abstract class LoginScreenEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnLoginEvent extends LoginScreenEvent {
  final String email;
  final String password;
  OnLoginEvent({required this.email, required this.password});
}

class OnRetrieveEvent extends LoginScreenEvent {}

class LoginBloc extends Bloc<LoginScreenEvent, LoginState> {
  SharedPreferences? pref = null;
  String str = "";
  LoginBloc() : super(LoginLoadingState()) {
    on<OnLoginEvent>((event, emit) async {
      pref = await SharedPreferences.getInstance();
      try {
        emit(LoginLoadingState());
        NetworkRepository nkRepo = NetworkRepository();
        str =
            await nkRepo.login(username: event.email, password: event.password);
        pref?.setString(PREFERENCES_KEY, str);
        emit(LoginCompletedState(response: str));
      } catch (e) {
        emit(LoginFailedState(errorMessage: e.toString()));
      }
    });
    on<OnRetrieveEvent>((event, emit) async {
      try {
        pref = await SharedPreferences.getInstance();
        String strToken = pref?.getString(PREFERENCES_KEY) ?? "empty token";
        NetworkRepository nkRepo = NetworkRepository();
        List<Product> products =
            await nkRepo.retrieveUserProduct(token: strToken);
        emit(LoginRetrieveState(products: products));
      } catch (e) {
        emit(LoginFailedState(errorMessage: e.toString()));
      }
    });
  }
}
