// import 'package:collection/collection.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
// import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListBloc.dart';
// import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListEvent.dart';
// import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListState.dart';
// import 'package:ecommerce_prueba/src/presentation/widgets/DefaultButton.dart';
// import 'package:ecommerce_prueba/src/presentation/widgets/DefaultTextField.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';

// class OrderListFilter extends StatelessWidget {
//   OrderListBloc? bloc;
//   OrderListState state;

//   OrderListFilter(this.bloc, this.state);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 16, left: 10, right: 10),
//       width: double.infinity,
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Expanded(flex: 4, child: _textCliente()),
//               SizedBox(width: 10),
//               Expanded(flex: 2, child: _buttonBusqueda()),
//             ],
//           ),
//           SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Expanded(child: _textFechaDesde(context)),
//               SizedBox(width: 10),
//               Expanded(child: _textFechaHasta(context)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _textCliente() {
//     return DefaultTextField(label: 'Cliente', icon: Icons.search);
//   }

//   Widget _textFechaDesde(BuildContext context) {
//     final formattedController =
//         "${state.fechaDesde!.year}-"
//         "${state.fechaDesde!.month.toString().padLeft(2, '0')}-"
//         "${state.fechaDesde!.day.toString().padLeft(2, '0')}";
//     final controller = TextEditingController(
//       text: formattedController, // aquí debe estar el string "dd/MM/yyyy"
//     );

//     return DefaultTextField(
//       label: 'Desde',
//       icon: Icons.calendar_month_outlined,
//       controller: controller,
//       readOnly: true,
//       initialValue: state.fechaDesde.toString(),
//       onTap: () async {
//         final picked = await showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime(1900),
//           lastDate: DateTime(2100),
//         );

//         if (picked == null) return;

//         final formatted =
//             "${picked.year}-"
//             "${picked.month.toString().padLeft(2, '0')}-"
//             "${picked.day.toString().padLeft(2, '0')}";

//         bloc?.add(
//           FechaDesdeChangedOrderListEvent(
//             fechaDesde: DateTime.parse(formatted),
//           ),
//         );
//       },
//       validator: (value) {
//         if (value == null || value == '') {
//           return 'Ingrese fecha desde';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _textFechaHasta(BuildContext context) {
//     final controller = TextEditingController(
//       text: state.fechaHasta
//           .toString(), // aquí debe estar el string "dd/MM/yyyy"
//     );

//     return DefaultTextField(
//       label: 'Hasta',
//       icon: Icons.calendar_month_outlined,
//       controller: controller,
//       readOnly: true,
//       initialValue: state.fechaHasta.toString(),
//       onTap: () async {
//         final picked = await showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime(1900),
//           lastDate: DateTime(2100),
//         );

//         if (picked == null) return;

//         final formatted =
//             "${picked.year}-"
//             "${picked.month.toString().padLeft(2, '0')}-"
//             "${picked.day.toString().padLeft(2, '0')}";

//         bloc?.add(
//           FechaHastaChangedOrderListEvent(
//             fechaHasta: DateTime.parse(formatted),
//           ),
//         );
//       },
//       validator: (value) {
//         if (value == null || value == '') {
//           return 'Ingrese fecha hasta';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buttonBusqueda() {
//     return DefaultButton(text: 'Buscar', onPressed: () {});
//   }
// }
