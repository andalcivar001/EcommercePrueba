import 'dart:io';

import 'package:ecommerce_prueba/src/data/datasource/remote/services/UserService.dart';
import 'package:ecommerce_prueba/src/domain/models/User.dart';
import 'package:ecommerce_prueba/src/domain/repository/UserRepository.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';

class UserRepositoryImpl extends UserRepository {
  UserService userService;

  UserRepositoryImpl(this.userService);

  @override
  Future<Resource<User>> update(int id, User user, File? file) async {
    if (file != null) {
      return await userService.updateImage(user, id, file);
    } else {
      return await userService.update(user, id);
    }
  }
}
