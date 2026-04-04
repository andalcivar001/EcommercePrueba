import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/list/bloc/CategoryListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/list/bloc/CategoryListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/utils/SelectConfirmDialog.dart';
import 'package:flutter/material.dart';

class CategoryListItem extends StatelessWidget {
  final Category category;
  final CategoryListBloc? bloc;

  const CategoryListItem(this.bloc, this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasDescription = (category.descripcion ?? '').trim().isNotEmpty;

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
            Navigator.pushNamed(context, 'category/form', arguments: category);
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
                      colors: category.isActive
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
                      colors: category.isActive
                          ? const [Color(0xff3154F6), Color(0xff6AA4FF)]
                          : const [Color(0xffAEB7C4), Color(0xffD3DBE6)],
                    ),
                  ),
                  child: const Icon(
                    Icons.category_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              category.nombre,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff1E293B),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        hasDescription
                            ? category.descripcion!.trim()
                            : 'Categoria lista para editar y organizar productos.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: const Color(0xff64748B),
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.edit_outlined,
                            size: 16,
                            color: Color(0xff4A6CF7),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Tocar para editar',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: const Color(0xff4A6CF7),
                              fontWeight: FontWeight.w600,
                            ),
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
                            () => bloc?.add(
                              DeleteCategoryListEvent(id: category.id),
                            ),
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
                    _StatusChip(isActive: category.isActive),
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
            isActive ? 'Activa' : 'Inactiva',
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
