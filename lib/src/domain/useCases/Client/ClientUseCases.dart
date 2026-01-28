import 'package:ecommerce_prueba/src/domain/useCases/Client/GetCitiesByProvinceUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Client/GetCitiesUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Client/GetClientByIdUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Client/GetClientsUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Client/GetProvincesUseCase.dart';

class ClientUseCases {
  GetClientsUseCase getClients;
  GetClientByIdUseCase getClientById;
  GetProvincesUseCase getProvinces;
  GetCitiesByProvince getCitiesByProvince;
  GetCitiesUseCase getCities;
  ClientUseCases({
    required this.getClients,
    required this.getClientById,
    required this.getProvinces,
    required this.getCitiesByProvince,
    required this.getCities,
  });
}
