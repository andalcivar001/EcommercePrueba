import 'package:ecommerce_prueba/src/domain/models/Client.dart';
import 'package:ecommerce_prueba/src/domain/repository/ClientRepository.dart';

class UpdateClientUseCase {
  ClientRepository clientRepository;
  UpdateClientUseCase(this.clientRepository);
  run(Client client, String id) => clientRepository.update(client, id);
}
