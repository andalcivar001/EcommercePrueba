import 'package:ecommerce_prueba/src/domain/repository/ClientRepository.dart';

class GetClientByIdUseCase {
  ClientRepository clientRepository;
  GetClientByIdUseCase(this.clientRepository);
  run(String id) => clientRepository.getClientById(id);
}
