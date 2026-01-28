import 'package:ecommerce_prueba/src/domain/repository/ClientRepository.dart';

class GetCitiesUseCase {
  ClientRepository clientRepository;
  GetCitiesUseCase(this.clientRepository);

  run() => clientRepository.getCities();
}
