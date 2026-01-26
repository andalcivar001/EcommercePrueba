import 'package:ecommerce_prueba/src/domain/useCases/Client/GetCitiesByProvinceUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Client/GetClientByIdUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Client/GetClientsUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Client/GetProvincesUseCase.dart';

class ClientUseCases {
  GetClientsUseCase getClients;
  GetClientByIdUseCase getClientById;
  GetProvincesUseCase getProvinces;
  GetCitiesByProvince getCitiesByProvince;
  ClientUseCases({
    required this.getClients,
    required this.getClientById,
    required this.getProvinces,
    required this.getCitiesByProvince,
  });
}
