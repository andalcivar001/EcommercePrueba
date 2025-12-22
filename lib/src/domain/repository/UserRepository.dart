import 'dart:io';

import 'package:ecommerce_prueba/src/domain/models/User.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';

abstract class UserRepository {
  Future<Resource<User>> update(int id, User user, File? file);
}
