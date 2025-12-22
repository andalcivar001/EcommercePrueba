import 'package:flutter/material.dart';

Future<void> SelectOptionImageDialog(
  BuildContext context,
  Function() pickImage,
  Function() takePhoto,
) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: const [
            Icon(Icons.image_outlined),
            SizedBox(width: 10),
            Expanded(child: Text('Selecciona una opción')),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dialogOption(
              context: ctx,
              icon: Icons.photo_library_outlined,
              title: 'Galería',
              subtitle: 'Elegir una imagen del teléfono',
              onTap: () {
                Navigator.pop(ctx);
                pickImage();
              },
            ),
            const SizedBox(height: 8),
            _dialogOption(
              context: ctx,
              icon: Icons.photo_camera_outlined,
              title: 'Cámara',
              subtitle: 'Tomar una foto ahora',
              onTap: () {
                Navigator.pop(ctx);
                takePhoto();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
        ],
      );
    },
  );
}

Widget _dialogOption({
  required BuildContext context,
  required IconData icon,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade100,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.12),
              ),
              child: Icon(icon, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    ),
  );
}
