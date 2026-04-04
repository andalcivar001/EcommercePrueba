import 'package:ecommerce_prueba/src/domain/models/Client.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/list/bloc/ClientListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/list/bloc/ClientListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/utils/SelectConfirmDialog.dart';
import 'package:flutter/material.dart';

class ClientListItem extends StatelessWidget {
  final ClientListBloc? bloc;
  final Client client;

  const ClientListItem(this.bloc, this.client, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isActive = client.isActive ?? true;
    final tipoIdentificacion = client.tipoIdentificacion == 'C'
        ? 'Cedula'
        : client.tipoIdentificacion == 'R'
        ? 'Ruc'
        : 'Pasaporte';
    final identificacion = client.numeroIdentificacion;
    final telefono = (client.telefono ?? '').trim();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Color(0xffF6F9FF)],
        ),
        border: Border.all(color: const Color(0xffDCE6F8)),
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            spreadRadius: -8,
            color: const Color(0xff24408E).withValues(alpha: 0.18),
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () {
            Navigator.pushNamed(context, 'client/form', arguments: client.id);
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: isActive
                          ? const [Color(0xff4A6CF7), Color(0xff6EA8FE)]
                          : const [Color(0xffC5CEDB), Color(0xffE1E7F0)],
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isActive
                          ? const [Color(0xff3154F6), Color(0xff6AA4FF)]
                          : const [Color(0xffAEB7C4), Color(0xffD3DBE6)],
                    ),
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        client.nombre,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff1E293B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        client.email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: const Color(0xff64748B),
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _InfoChip(
                            icon: Icons.badge_outlined,
                            text: identificacion,
                          ),
                          if (telefono.isNotEmpty)
                            _InfoChip(
                              icon: Icons.phone_outlined,
                              text: telefono,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xffFEECEE),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: IconButton(
                        onPressed: () {
                          selectConfirmDialog(
                            context,
                            () =>
                                bloc?.add(DeleteClientListEvent(id: client.id)),
                          );
                        },
                        tooltip: 'Eliminar registro',
                        splashRadius: 22,
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          color: Color(0xffD92D20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _StatusChip(isActive: isActive),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xffEEF4FF),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: const Color(0xff4A6CF7)),
          const SizedBox(width: 6),
          Text(
            text,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: const Color(0xff335CFF),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final bool isActive;

  const _StatusChip({required this.isActive});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isActive
        ? const Color(0xffE8F7EE)
        : const Color(0xffEEF2F6);
    final foregroundColor = isActive
        ? const Color(0xff157347)
        : const Color(0xff667085);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: foregroundColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            isActive ? 'Activo' : 'Inactivo',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
