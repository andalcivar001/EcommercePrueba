import 'dart:io';

import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/domain/models/SubCategory.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/form/bloc/ProductFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/form/bloc/ProductFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/form/bloc/ProductFormState.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:ecommerce_prueba/src/presentation/utils/SelectOptionImageDialog.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultButton.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultIconBack.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultTextField.dart';
import 'package:flutter/material.dart';

class ProductFormContent extends StatelessWidget {
  final ProductFormBloc? bloc;
  final ProductFormState state;
  final List<Category> listaCategories;
  final List<SubCategory> listaSubCategories;

  const ProductFormContent(
    this.bloc,
    this.state,
    this.listaCategories,
    this.listaSubCategories, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isEditing = state.id.isNotEmpty;
    final title = isEditing ? 'Editar producto' : 'Nuevo producto';
    final subtitle = isEditing
        ? 'Actualiza la informacion, imagenes y clasificacion del producto.'
        : 'Crea un producto completo con imagenes, precio e inventario.';

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffEEF4FF), Color(0xffF9FBFF), Colors.white],
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              top: -70,
              right: -20,
              child: _BackgroundBubble(
                size: 180,
                colors: [Color(0xffDCE8FF), Color(0xffEEF4FF)],
              ),
            ),
            const Positioned(
              top: 110,
              left: -55,
              child: _BackgroundBubble(
                size: 130,
                colors: [Color(0xffEAF7F1), Color(0xffF5FBF7)],
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 72, 22, 24),
              child: Form(
                key: state.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _HeroHeader(
                      title: title,
                      subtitle: subtitle,
                      isEditing: isEditing,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: const Color(0xffD7E3F8)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xff24408E,
                            ).withValues(alpha: 0.10),
                            blurRadius: 28,
                            spreadRadius: -10,
                            offset: const Offset(0, 18),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informacion general',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xff1E293B),
                                ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Completa la descripcion, codigo, precio, inventario, categoria e imagenes del producto.',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: const Color(0xff64748B),
                                  height: 1.35,
                                ),
                          ),
                          const SizedBox(height: 22),
                          _FieldBlock(
                            label: 'Imagenes del producto',
                            helper: '',
                            child: Row(
                              children: [
                                Expanded(child: _imagen1(context)),
                                const SizedBox(width: 12),
                                Expanded(child: _imagen2(context)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 18),
                          _FieldBlock(
                            label: 'Descripcion',
                            helper: '',
                            child: _textDescripcion(),
                          ),
                          const SizedBox(height: 18),
                          _FieldBlock(
                            label: 'Codigo alterno',
                            helper: '',
                            child: _textCodAlterno(),
                          ),
                          const SizedBox(height: 18),
                          Row(
                            children: [
                              Expanded(
                                child: _FieldBlock(
                                  label: 'Precio',
                                  helper: '',
                                  child: _textPrecio(),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: _FieldBlock(
                                  label: 'Stock',
                                  helper: '',
                                  child: _textStock(),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          _FieldBlock(
                            label: 'Categoria',
                            helper: '',
                            child: _dropDownCategory(context),
                          ),
                          const SizedBox(height: 18),
                          _FieldBlock(
                            label: 'Subcategoria',
                            helper: '',
                            child: _dropDownSubcategory(context),
                          ),
                          const SizedBox(height: 18),
                          _switchEstado(context),
                          const SizedBox(height: 24),
                          _buttonActualizar(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 12,
              left: 18,
              child: DefaultIconBack(left: 0, top: 0, color: Color(0xff243B6B)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _seleccionarImagen() {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff3154F6), Color(0xff6AA4FF)],
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_photo_alternate_outlined,
            size: 34,
            color: Colors.white,
          ),
          SizedBox(height: 8),
          Text(
            'Seleccionar\nimagen',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _imagen1(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () {
          SelectOptionImageDialog(
            context,
            () => bloc?.add(const PickImageProductFormEvent1()),
            () => bloc?.add(const TakePhotoProductFormEvent1()),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: _contenidoImagen(
            file: state.file1,
            imageUrl: state.imagenUrl1,
          ),
        ),
      ),
    );
  }

  Widget _imagen2(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () {
          SelectOptionImageDialog(
            context,
            () => bloc?.add(const PickImageProductFormEvent2()),
            () => bloc?.add(const TakePhotoProductFormEvent2()),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: _contenidoImagen(
            file: state.file2,
            imageUrl: state.imagenUrl2,
          ),
        ),
      ),
    );
  }

  Widget _contenidoImagen({required File? file, required String? imageUrl}) {
    if (file == null && imageUrl == null) return _seleccionarImagen();

    if (file != null) {
      return Image.file(file, fit: BoxFit.cover);
    }

    if (imageUrl != null && imageUrl.isNotEmpty) {
      return FadeInImage.assetNetwork(
        image: imageUrl,
        placeholder: 'assets/img/no_image.jpg',
        fit: BoxFit.cover,
        fadeInDuration: const Duration(seconds: 1),
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/img/no_image.jpg', fit: BoxFit.cover);
        },
      );
    }

    return _seleccionarImagen();
  }

  Widget _textDescripcion() {
    return DefaultTextField(
      key: ValueKey('descripcion-${state.id}'),
      label: 'Descripcion',
      icon: Icons.inventory_2_outlined,
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      initialValue: state.descripcion.value,
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
      hinText: 'Ej: Coca Cola 500ml, Laptop Lenovo, Silla ejecutiva',
    );
  }

  Widget _textCodAlterno() {
    return DefaultTextField(
      key: ValueKey('codAlterno-${state.id}'),
      label: 'Cod. alterno',
      icon: Icons.qr_code_rounded,
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      initialValue: state.codAlterno ?? '',
      onChanged: (text) {
        bloc?.add(CodAlternoChangedProductFormEvent(codAlterno: text));
      },
      hinText: 'Opcional',
    );
  }

  Widget _textStock() {
    return DefaultTextField(
      key: ValueKey('stock-${state.id}'),
      label: 'Stock',
      icon: Icons.numbers_rounded,
      textInputType: TextInputType.number,
      textInputAction: TextInputAction.next,
      initialValue: state.stock.toString(),
      onChanged: (text) {
        bloc?.add(StockChangedProductFormEvent(stock: int.tryParse(text) ?? 0));
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese el stock';
        }
        return null;
      },
      hinText: 'Cantidad disponible',
    );
  }

  Widget _textPrecio() {
    return DefaultTextField(
      key: ValueKey('precio-${state.id}'),
      label: 'Precio',
      icon: Icons.attach_money_rounded,
      textInputType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: TextInputAction.next,
      initialValue: state.precio.toString(),
      onChanged: (text) {
        bloc?.add(
          PrecioChangedProductFormEvent(precio: double.tryParse(text) ?? 0),
        );
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese el precio';
        }
        return null;
      },
      hinText: '0.00',
    );
  }

  Widget _dropDownCategory(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: state.idCategory.isNotEmpty ? state.idCategory : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffF8FAFC),
        labelText: 'Categoria',
        prefixIcon: const Icon(Icons.category_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xffD7E3F8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xffD7E3F8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xff4A6CF7)),
        ),
      ),
      items: listaCategories
          .map(
            (x) => DropdownMenuItem<String>(value: x.id, child: Text(x.nombre)),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) return;
        bloc?.add(CategoryChangedProductFormEvent(idCategory: value));
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Seleccione una categoria';
        }
        return null;
      },
    );
  }

  Widget _dropDownSubcategory(BuildContext context) {
    final subs = listaSubCategories
        .where((x) => x.idCategory == state.idCategory)
        .toList();

    return DropdownButtonFormField<String>(
      initialValue: subs.any((x) => x.id == state.idSubcategory)
          ? state.idSubcategory
          : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffF8FAFC),
        labelText: 'Subcategoria',
        prefixIcon: const Icon(Icons.account_tree_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xffD7E3F8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xffD7E3F8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xff4A6CF7)),
        ),
        hintText: state.idCategory.isEmpty
            ? 'Primero selecciona una categoria'
            : 'Selecciona una subcategoria',
      ),
      items: subs
          .map(
            (x) => DropdownMenuItem<String>(value: x.id, child: Text(x.nombre)),
          )
          .toList(),
      onChanged: state.idCategory.isEmpty
          ? null
          : (value) {
              if (value == null) return;
              bloc?.add(
                SubcategoryChangedProductFormEvent(idSubcategory: value),
              );
            },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Seleccione una subcategoria';
        }
        return null;
      },
    );
  }

  Widget _switchEstado(BuildContext context) {
    final activeColor = const Color(0xff16A34A);
    final inactiveColor = const Color(0xff94A3B8);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAFC),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xffE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: (state.isActive ? activeColor : inactiveColor).withValues(
                alpha: 0.12,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              state.isActive ? Icons.check_circle_outline : Icons.pause_circle,
              color: state.isActive ? activeColor : inactiveColor,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Estado del producto',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  state.isActive
                      ? 'El producto estara disponible para venderse.'
                      : 'El producto quedara desactivado temporalmente.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xff64748B),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: state.isActive,
            activeThumbColor: Colors.white,
            activeTrackColor: activeColor,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xffCBD5E1),
            onChanged: (value) {
              bloc?.add(EstadoChangedProductFormEvent(isActive: value));
            },
          ),
        ],
      ),
    );
  }

  Widget _buttonActualizar() {
    return DefaultButton(
      text: state.id.isEmpty ? 'Crear producto' : 'Guardar cambios',
      onPressed: () {
        if (state.formKey!.currentState!.validate()) {
          bloc?.add(const SubmittedProductFormEvent());
        } else {
          AppToast.error('Formulario invalido');
        }
      },
    );
  }
}

class _HeroHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isEditing;

  const _HeroHeader({
    required this.title,
    required this.subtitle,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff1D4ED8), Color(0xff2563EB), Color(0xff60A5FA)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff2563EB).withValues(alpha: 0.24),
            blurRadius: 30,
            spreadRadius: -10,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
            ),
            child: Icon(
              isEditing ? Icons.edit_note_rounded : Icons.add_box_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.90),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldBlock extends StatelessWidget {
  final String label;
  final String helper;
  final Widget child;

  const _FieldBlock({
    required this.label,
    required this.helper,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xff1E293B),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          helper,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: const Color(0xff64748B)),
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

class _BackgroundBubble extends StatelessWidget {
  final double size;
  final List<Color> colors;

  const _BackgroundBubble({required this.size, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
    );
  }
}
