import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/models/OrderPayment.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Order/OrderUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/OrderPaymentUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/form/bloc/OrderPaymentFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/form/bloc/OrderPaymentFormState.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPaymentFormBloc
    extends Bloc<OrderPaymentFormEvent, OrderPaymentFormState> {
  OrderPaymentUseCases orderPaymentUseCases;
  OrderUseCases orderUseCases;
  OrderPaymentFormBloc(this.orderPaymentUseCases, this.orderUseCases)
    : super(OrderPaymentFormState()) {
    on<InitOrderPaymentFormEvent>(_onInit);
    on<MontoOrderPaymentFormEvent>(_onMontoChanged);
    on<ReferenciaOrderPaymentFormEvent>(_onReferenciaChanged);
    on<EntidadFinancieraOrderPaymentFormEvent>(_onEntidadFinancieraChanged);
    on<MetodoPagoOrderPaymentFormEvent>(_onMetodoPagoChanged);
    on<ObservacionesOrderPaymentFormEvent>(_onObservacionesChanged);
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onInit(
    InitOrderPaymentFormEvent event,
    Emitter<OrderPaymentFormState> emit,
  ) async {
    print('ENTRO AL BLOC');
    emit(state.copyWith(loading: true, formKey: formKey));
    final results = await Future.wait<Resource>([
      orderUseCases.getOrderById.run(event.idOrden),
      orderPaymentUseCases.getPaymentMethods.run(),
      orderPaymentUseCases.getFinancialEntities.run(),
    ]);

    OrderPayment? orderPayment;

    if (event.id.isNotEmpty) {
      final Resource responseOrderPayment = await orderPaymentUseCases
          .getOrderPaymentById
          .run(event.id);

      if (responseOrderPayment is Success) {
        orderPayment = responseOrderPayment.data as OrderPayment;
      }
    }

    emit(
      state.copyWith(
        loading: false,
        idPaymentMethod: orderPayment?.idPaymentMethod ?? '',
        idEntidadFinanciera: orderPayment?.idEntidadFinanciera ?? '',
        monto: orderPayment?.monto ?? 0,
        referencia: orderPayment?.referencia ?? '',
        observaciones: orderPayment?.observaciones ?? '',
        responseOrden: results[0],
        responseMetodoPago: results[1],
        responseEntidadFinanciera: results[2],
        formKey: formKey,
      ),
    );
  }

  Future<void> _onMontoChanged(
    MontoOrderPaymentFormEvent event,
    Emitter<OrderPaymentFormState> emit,
  ) async {}

  Future<void> _onReferenciaChanged(
    ReferenciaOrderPaymentFormEvent event,
    Emitter<OrderPaymentFormState> emit,
  ) async {}

  Future<void> _onEntidadFinancieraChanged(
    EntidadFinancieraOrderPaymentFormEvent event,
    Emitter<OrderPaymentFormState> emit,
  ) async {}

  Future<void> _onMetodoPagoChanged(
    MetodoPagoOrderPaymentFormEvent event,
    Emitter<OrderPaymentFormState> emit,
  ) async {}

  Future<void> _onObservacionesChanged(
    ObservacionesOrderPaymentFormEvent event,
    Emitter<OrderPaymentFormState> emit,
  ) async {}
}
