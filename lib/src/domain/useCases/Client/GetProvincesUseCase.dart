import 'package:ecommerce_prueba/src/domain/repository/ClientRepository.dart';

class GetProvincesUseCase {
  ClientRepository clientRepository;
  GetProvincesUseCase(this.clientRepository);
  run() => clientRepository.getProvinces();
}
