import 'package:ecommerce_prueba/src/domain/models/City.dart';
import 'package:ecommerce_prueba/src/domain/models/Client.dart';
import 'package:ecommerce_prueba/src/domain/models/Province.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';

abstract class ClientRepository {
  Future<Resource<List<Province>>> getProvinces();
  Future<Resource<List<City>>> getCities();
  Future<Resource<List<City>>> getCitiesByProvince(String idProvince);
  Future<Resource<List<Client>>> getClients();
  Future<Resource<Client>> getClientById(String id);
  Future<Resource<Client>> create(Client client);
  Future<Resource<Client>> update(Client client, String id);
  Future<Resource<bool>> delete(String id);
}
