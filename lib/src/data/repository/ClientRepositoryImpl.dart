import 'package:ecommerce_prueba/src/data/datasource/remote/services/CityService.dart';
import 'package:ecommerce_prueba/src/data/datasource/remote/services/ClientService.dart';
import 'package:ecommerce_prueba/src/data/datasource/remote/services/ProvinceService.dart';
import 'package:ecommerce_prueba/src/domain/models/City.dart';
import 'package:ecommerce_prueba/src/domain/models/Client.dart';
import 'package:ecommerce_prueba/src/domain/models/Province.dart';
import 'package:ecommerce_prueba/src/domain/repository/ClientRepository.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';

class ClientRepositoryImpl extends ClientRepository {
  ClientService clienteService;
  ProvinceService provinceService;
  CityService cityService;
  ClientRepositoryImpl(
    this.clienteService,
    this.provinceService,
    this.cityService,
  );

  @override
  Future<Resource<List<City>>> getCitiesByProvince(String idProvince) async {
    return await cityService.getCitiesByProvince(idProvince);
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
    return await provinceService.getProvinces();
  }

  @override
  Future<Resource<List<City>>> getCities() async {
    return await cityService.getCities();
  }

  @override
  Future<Resource<Client>> create(Client client) async {
    return await clienteService.create(client);
  }

  @override
  Future<Resource<Client>> update(Client client, String id) async {
    return await clienteService.update(client, id);
  }

  @override
  Future<Resource<bool>> delete(String id) async {
    return await clienteService.delete(id);
  }
}
