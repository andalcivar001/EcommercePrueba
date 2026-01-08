import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/form/bloc/CategoryFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/form/bloc/CategoryFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/form/bloc/CategoryFormState.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultButton.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultTextField.dart';
import 'package:flutter/material.dart';

class CategoryFormContent extends StatelessWidget {
  Category? category;
  CategoryFormBloc? bloc;
  CategoryFormState state;

  CategoryFormContent(this.bloc, this.state, this.category);

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
                  key: state.formKey,
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        _textDescripcion(),
                        SizedBox(height: 16),
                        _buttonActualizar(),
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
      onChanged: (text) {
        bloc?.add(
          DescripcionChangedCategoryFormEvent(
            descripcion: BlocFormItem(value: text),
          ),
        );
      },
      initialValue: category?.descripcion,
      validator: (value) {
        return state.descripcion.error;
      },
    );
  }

  Widget _buttonActualizar() {
    return DefaultButton(
      text: category == null ? 'Crear' : 'Actualizar',
      onPressed: () {
        if (state.formKey!.currentState!.validate()) {
          bloc?.add(FormSubmittedCategoryFormEvent());
        } else {
          AppToast.error('Formulario inválido');
        }
      },
    );
  }
}
