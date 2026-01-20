import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/domain/models/Product.dart';
import 'package:ecommerce_prueba/src/domain/models/SubCategory.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/form/bloc/ProductFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/form/bloc/ProductFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/form/bloc/ProductFormState.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultButton.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultTextField.dart';
import 'package:flutter/material.dart';

class ProductFormContent extends StatelessWidget {
  ProductFormBloc? bloc;
  ProductFormState state;
  Product? product;
  List<Category> listaCategories = [];
  List<SubCategory> listaSubCategories = [];

  ProductFormContent(
    this.bloc,
    this.state,
    this.product,
    this.listaCategories,
    this.listaSubCategories,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: double.infinity,
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 80, left: 24, right: 24),

            child: Form(
              key: state.formKey,
              child: Container(
                width: double.infinity,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 24,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Mantenimiento de Productos',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),
                    Row(
                      children: [
                        _seleccionarImagen1(),
                        SizedBox(width: 10),
                        _seleccionarImagen2(),
                      ],
                    ),
                    SizedBox(height: 16),
                    _textDescripcion(),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(flex: 6, child: _textCodAlterno()),
                        SizedBox(width: 10),
                        Expanded(flex: 4, child: _textStock()),
                      ],
                    ),
                    SizedBox(height: 16),
                    _dropDownCategory(),
                    SizedBox(height: 16),
                    _dropDownSubcategory(),
                    SizedBox(height: 16),
                    _switchEstado(),
                    SizedBox(height: 16),
                    _buttonActualizar(),
                    // Aquí van los campos del formulario
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _seleccionarImagen1() {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.add_photo_alternate, size: 36, color: Colors.black),
                SizedBox(height: 8),
                Text(
                  'Seleccionar\nimagen',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _seleccionarImagen2() {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.add_photo_alternate, size: 36, color: Colors.black),
                SizedBox(height: 8),
                Text(
                  'Seleccionar\nimagen',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textDescripcion() {
    return DefaultTextField(
      label: 'Descripción',
      icon: Icons.edit,
      textInputAction: TextInputAction.next,
      initialValue: product?.descripcion ?? '',
      onChanged: (text) {
        bloc?.add(
          DescripcionChangedProductFormEvent(
            descripcion: BlocFormItem(value: text),
          ),
        );
      },
      validator: (value) {
        return state.descripcion.error;
      },
    );
  }

  Widget _textCodAlterno() {
    return DefaultTextField(
      label: 'Cod. Alterno',
      icon: Icons.qr_code,
      textInputAction: TextInputAction.next,
      initialValue: product?.codAlterno ?? '',
      onChanged: (text) {
        bloc?.add(CodAlternoChangedProductFormEvent(codAlterno: text));
      },
    );
  }

  Widget _textStock() {
    return DefaultTextField(
      label: 'Stock',
      icon: Icons.numbers,
      textInputType: TextInputType.number,
      textInputAction: TextInputAction.next,
      initialValue: product?.stock.toString(),
      onChanged: (text) {
        bloc?.add(StockChangedProductFormEvent(stock: int.tryParse(text) ?? 0));
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese el stock';
        }
        return null;
      },
    );
  }

  Widget _dropDownCategory() {
    final idExists = product?.id ?? '';
    return DropdownButtonFormField<String>(
      initialValue: idExists.isNotEmpty ? state.idCategory : null,
      decoration: const InputDecoration(
        labelText: 'Categoría',
        prefixIcon: Icon(Icons.category),
        border: OutlineInputBorder(),
      ),
      items: listaCategories.map((Category x) {
        return DropdownMenuItem<String>(value: x.id, child: Text(x.nombre));
      }).toList(),
      onChanged: (value) {
        if (value == null) return;
        bloc?.add(CategoryChangedProductFormEvent(idCategory: value));
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Seleccione una categoría';
        }
        return null;
      },
    );
  }

  Widget _dropDownSubcategory() {
    final exists = listaSubCategories.any((x) => x.id == state.idSubcategory);
    return DropdownButtonFormField<String>(
      initialValue: exists ? state.idSubcategory : null,
      decoration: InputDecoration(
        labelText: 'Subategoría',
        prefixIcon: Icon(Icons.subdirectory_arrow_right),
        border: OutlineInputBorder(),
        hintText: state.idCategory.isEmpty
            ? 'Primero elija una categoría'
            : 'Seleccione una subcategoría',
      ),
      items: listaSubCategories.map((SubCategory x) {
        return DropdownMenuItem<String>(value: x.id, child: Text(x.nombre));
      }).toList(),
      onChanged: state.idCategory.isEmpty
          ? null
          : (value) {
              bloc?.add(
                SubcategoryChangedProductFormEvent(idSubcategory: value ?? ''),
              );
            },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Seleccione una subcategoría';
        }
        return null;
      },
    );
  }

  Widget _switchEstado() {
    return SwitchListTile(
      title: Text('Estado:', style: TextStyle(fontSize: 14)),
      value: state.isActive,
      onChanged: (value) {
        bloc?.add(EstadoChangedProductFormEvent(isActive: value));
      },
      activeThumbColor: Colors.white,
      activeTrackColor: Colors.green,
      inactiveThumbColor: Colors.grey,
      inactiveTrackColor: Colors.grey.shade300,
    );
  }

  Widget _buttonActualizar() {
    return DefaultButton(
      text: product == null ? 'Crear' : 'Actualizar',
      onPressed: () {
        if (state.formKey!.currentState!.validate()) {
          // bloc?.add(SubmittedSubCategoryFormEvent());
        } else {
          AppToast.error('Formulario inválido');
        }
      },
    );
  }
}
