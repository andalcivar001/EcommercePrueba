import 'package:ecommerce_prueba/src/domain/models/Client.dart';
import 'package:ecommerce_prueba/src/domain/repository/ClientRepository.dart';

class CreateClientUseCase {
  ClientRepository clientRepository;
  CreateClientUseCase(this.clientRepository);
  run(Client client) => clientRepository.create(client);
}
