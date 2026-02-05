import 'package:flutter/material.dart';
import 'package:ecommerce_prueba/src/domain/models/Product.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/list/bloc/ProductListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/list/bloc/ProductListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/utils/SelectConfirmDialog.dart';

class ProductListItem extends StatelessWidget {
  final ProductListBloc? bloc;
  final Product product;

  const ProductListItem(this.bloc, this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageUrl = (product.imagen1?.isNotEmpty ?? false)
        ? product.imagen1!
        : (product.imagen2?.isNotEmpty ?? false)
        ? product.imagen2!
        : null;
    final precio = product.precio ?? 0;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _AvatarImage(imageUrl: imageUrl),
            const SizedBox(width: 12),

            // Centro: texto con espacio real
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.descripcion,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),

                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      _InfoChip(label: 'Precio', value: precio.toString()),
                      _InfoChip(label: 'Stock', value: '${product.stock}'),
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
                    Navigator.pushNamed(
                      context,
                      'product/form',
                      arguments: product.id,
                    );
                  },
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  tooltip: 'Eliminar',
                  icon: Icon(Icons.delete, color: Colors.red),
                  color: theme.colorScheme.error,
                  onPressed: () {
                    selectConfirmDialog(
                      context,
                      () => bloc?.add(DeleteProductListEvent(id: product.id)),
                    );
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

Widget _noImage() {
  return Image.asset('assets/img/no_image.jpg', fit: BoxFit.cover);
}

class _AvatarImage extends StatelessWidget {
  final String? imageUrl;
  const _AvatarImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFF1E3C72);

    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
      ),
      child: ClipOval(
        child: imageUrl == null
            ? _noImage()
            : FadeInImage.assetNetwork(
                image: imageUrl!,
                placeholder: 'assets/img/no_image.jpg',
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 250),
                imageErrorBuilder: (context, error, stackTrace) {
                  return _noImage();
                },
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
      width: 100,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text('$label: $value', style: theme.textTheme.labelMedium),
    );
  }
}
