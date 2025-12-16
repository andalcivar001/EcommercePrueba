import 'package:ecommerce_prueba/src/domain/repository/AuthRepository.dart';

class LogoutUseCase {
  AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  run() => authRepository.logout();
}
