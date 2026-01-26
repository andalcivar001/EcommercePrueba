import 'package:ecommerce_prueba/src/domain/repository/ClientRepository.dart';

class GetCitiesByProvince {
  ClientRepository clientRepository;
  GetCitiesByProvince(this.clientRepository);
  run(String provinceId) => clientRepository.getCitiesByProvince(provinceId);
}
