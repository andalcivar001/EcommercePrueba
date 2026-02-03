import 'package:ecommerce_prueba/src/domain/repository/ClientRepository.dart';

class DeleteClientUseCase {
  ClientRepository clientRepository;
  DeleteClientUseCase(this.clientRepository);
  run(String id) => clientRepository.delete(id);
}
