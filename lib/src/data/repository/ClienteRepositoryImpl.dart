import 'package:ecommerce_prueba/src/data/datasource/remote/services/ClientService.dart';
import 'package:ecommerce_prueba/src/domain/models/City.dart';
import 'package:ecommerce_prueba/src/domain/models/Client.dart';
import 'package:ecommerce_prueba/src/domain/models/Province.dart';
import 'package:ecommerce_prueba/src/domain/repository/ClientRepository.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';

class ClientRepositoryImpl extends ClientRepository {
  ClienteService clienteService;
  ClientRepositoryImpl(this.clienteService);

  @override
  Future<Resource<List<City>>> getCitiesByProvince(String idProvince) async {
    return await clienteService.getCitiesByProvince(idProvince);
  }

  @override
  Future<Resource<Client>> getClientById(String id) async {
    return await clienteService.getClientById(id);
  }

  @override
  Future<Resource<List<Client>>> getClients() async {
    return await clienteService.getClients();
  }

  @override
  Future<Resource<List<Province>>> getProvinces() async {
    return await clienteService.getProvinces();
  }
}
