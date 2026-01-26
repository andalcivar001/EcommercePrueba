import 'package:ecommerce_prueba/src/domain/repository/ClientRepository.dart';

class GetClientsUseCase {
  ClientRepository clientRepository;
  GetClientsUseCase(this.clientRepository);
  run() => clientRepository.getClients();
}
