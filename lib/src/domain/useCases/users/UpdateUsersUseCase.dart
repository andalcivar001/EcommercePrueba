import 'package:ecommerce_prueba/src/domain/models/User.dart';
import 'package:ecommerce_prueba/src/domain/repository/UserRepository.dart';
import 'dart:io';

class UpdateUsersUseCase {
  UserRepository userRepository;
  UpdateUsersUseCase(this.userRepository);
  run(int id, User user, File file) => userRepository.update(id, user, file);
}
