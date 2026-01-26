import 'package:ecommerce_prueba/src/presentation/pages/client/list/bloc/ClientListBloc.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_prueba/src/domain/models/Client.dart';

class ClientListItem extends StatelessWidget {
  final ClientListBloc? bloc;
  final Client client;

  const ClientListItem(this.bloc, this.client, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String tipoIdentificacion = client.tipoIdentificacion == 'C'
        ? 'Cédula'
        : client.tipoIdentificacion == 'R'
        ? 'Ruc'
        : 'Pasaporte';
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 12),

            // Centro: texto con espacio real
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    client.nombre,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),

                  Wrap(
                    spacing: 10,
                    runSpacing: 6,
                    children: [
                      _InfoChip(label: 'Tipo', value: tipoIdentificacion),
                      _InfoChip(
                        label: '# Ident.',
                        value: client.numeroIdentificacion,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Derecha: botones más grandes + mejor tap target
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  visualDensity: VisualDensity.compact,
                  tooltip: 'Editar',
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    // Navigator.pushNamed(
                    //   context,
                    //   'client/form',
                    //   arguments: client.id,
                    // );
                  },
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  tooltip: 'Eliminar',
                  icon: Icon(Icons.delete, color: Colors.red),
                  color: theme.colorScheme.error,
                  onPressed: () {
                    // selectConfirmDialog(
                    //   context,
                    //   () => bloc?.add(DeleteClientListEvent(id: client.id)),
                    // );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final String value;

  const _InfoChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text('$label: $value', style: theme.textTheme.labelMedium),
    );
  }
}
