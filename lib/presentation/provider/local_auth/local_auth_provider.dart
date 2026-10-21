// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:miscelaneos/config/config.dart';

final canCheckBiometricsProvider = FutureProvider<bool>((ref) async {
  return await LocalAuthPlugin.canChangeBiometrics();
});

enum LocalAuthStatus { autheticated, notAutheticated, authenticating }

class LocalAuthState {
  final bool didAuthenticated;
  final LocalAuthStatus status;
  final String message;

  LocalAuthState({
     this.didAuthenticated = false,
     this.status = LocalAuthStatus.notAutheticated,
     this.message = '',
  });



  LocalAuthState copyWith({
    bool? didAuthenticated,
    LocalAuthStatus? status,
    String? message,
  }) => LocalAuthState(
      didAuthenticated: didAuthenticated ?? this.didAuthenticated,
      status: status ?? this.status,
      message: message ?? this.message,
    );

    @override
    String toString() => '''
  didAuthenticate: $didAuthenticated
  status: $status
  message: $message

                         ''';    


  
}

  class LocalAuthNotifier extends StateNotifier<LocalAuthState>{
    LocalAuthNotifier():super(LocalAuthState());

    Future<(bool, String)> autheticateUser() async{
      
      final ( didAuthenticate, message ) = await LocalAuthPlugin.authenticate();
      state = state.copyWith(
        didAuthenticated: didAuthenticate,
        message: message,
        status: didAuthenticate ? LocalAuthStatus.autheticated : LocalAuthStatus.notAutheticated


      );

      return(didAuthenticate,message);

    }

  }



final localAuthProvider = StateNotifierProvider<LocalAuthNotifier, LocalAuthState>((ref) {
  return LocalAuthNotifier();
  
});