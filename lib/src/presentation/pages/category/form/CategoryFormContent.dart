import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultTextField.dart';
import 'package:flutter/material.dart';

class CategoryFormContent extends StatelessWidget {
  Category? category;

  CategoryFormContent(this.category);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Form(
                  child: Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFF1E3C72), // azul corporativo
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 18,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        Text(
                          'Mantenimiento de Categoría',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        _textDescripcion(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textDescripcion() {
    return DefaultTextField(
      label: 'Descripcion',
      icon: Icons.edit,
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onChanged: (text) {},
    );
  }
}
