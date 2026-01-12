import 'package:ecommerce_prueba/src/domain/models/SubCategory.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/form/bloc/SubCategoryFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/form/bloc/SubCategoryFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/form/bloc/SubCategoryFormState.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultButton.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultIconBack.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultTextField.dart';
import 'package:flutter/material.dart';

class SubCategoryFormContent extends StatelessWidget {
  SubCategoryFormBloc? bloc;
  SubCategoryFormState state;
  SubCategory? subCategory;
  SubCategoryFormContent(this.bloc, this.state, this.subCategory);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Stack(
          children: [
            DefaultIconBack(left: 20, top: 15, color: Colors.black),
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Form(
                  key: state.formKey,
                  child: Container(
                    padding: EdgeInsets.all(16),
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
                          'Mantenimiento de SubCategoría',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        _textNombre(),
                        SizedBox(height: 16),
                        _textDescripcion(),
                        SizedBox(height: 16),
                        _dropDownCategory(),
                        SizedBox(height: 16),
                        _switchEstado(),
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

  Widget _textNombre() {
    return DefaultTextField(
      label: 'Nombre',
      icon: Icons.home,
      textInputAction: TextInputAction.next,
      initialValue: subCategory?.nombre ?? '',
      onChanged: (text) {
        bloc?.add(
          NombreChangedSubCategoryFormEvent(nombre: BlocFormItem(value: text)),
        );
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Ingrese la descripcion';
        }
        return null;
      },
    );
  }

  Widget _textDescripcion() {
    return DefaultTextField(
      maxLines: 4,
      label: 'Descripción',
      icon: Icons.edit,
      textInputAction: TextInputAction.next,
      initialValue: subCategory?.descripcion ?? '',
      onChanged: (text) {
        bloc?.add(
          DescripcionChangedSubCategoryFormEvent(
            descripcion: BlocFormItem(value: text),
          ),
        );
      },
      validator: (value) {
        return state.descripcion.error;
      },
    );
  }

  Widget _dropDownCategory() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 3, right: 3),
      child: SizedBox(
        width: double.infinity,
        child: DropdownMenu<String>(
          initialSelection: state.categoria,
          label: const Text('Categoría'),
          leadingIcon: const Icon(Icons.category),
          dropdownMenuEntries: state.listCategory!
              .map(
                (x) => DropdownMenuEntry<String>(value: x.id, label: x.nombre),
              )
              .toList(),
          onSelected: (value) {
            if (value == null) return;
            bloc?.add(CategoriaChangedSubCategoryFormEvent(categoria: value));
          },
        ),
      ),
    );
  }

  // List<DropdownMenuItem<String>> _dropDownItems() {
  //   List<DropdownMenuItem<String>> list = [];
  //   state.listCategory!.forEach((x) {
  //     list.add(
  //       DropdownMenuItem(
  //         value: x.id,x
  //         child: Container(
  //           margin: EdgeInsets.only(top: 7),
  //           child: Text(x.nombre),
  //         ),
  //       ),
  //     );
  //   });
  //   return list;
  // }

  Widget _buttonActualizar() {
    return DefaultButton(
      text: subCategory == null ? 'Crear' : 'Actualizar',
      onPressed: () {
        if (state.formKey!.currentState!.validate()) {
          bloc?.add(SubmittedSubCategoryFormEvent());
        } else {
          AppToast.error('Formulario inválido');
        }
      },
    );
  }

  Widget _switchEstado() {
    return SwitchListTile(
      title: Text('Estado:', style: TextStyle(fontSize: 14)),
      value: state.isActive,
      onChanged: (value) {
        bloc?.add(EstadoChangedSubCategoryFormEvent(isActive: value));
      },
      activeThumbColor: Colors.white,
      activeTrackColor: Colors.green,
      inactiveThumbColor: Colors.grey,
      inactiveTrackColor: Colors.grey.shade300,
    );
  }
}
