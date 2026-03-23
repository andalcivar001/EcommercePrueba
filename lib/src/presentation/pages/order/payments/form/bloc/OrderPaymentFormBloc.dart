import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/OrderPaymentUseCases.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/form/bloc/OrderPaymentFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/form/bloc/OrderPaymentFormState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPaymentFormBloc
    extends Bloc<OrderPaymentFormEvent, OrderPaymentFormState> {
  OrderPaymentUseCases orderPaymentUseCases;
  OrderPaymentFormBloc(this.orderPaymentUseCases)
    : super(OrderPaymentFormState()) {
    on<InitOrderPaymentFormEvent>(_onInit);
    on<MontoOrderPaymentFormEvent>(_onMontoChanged);
    on<ReferenciaOrderPaymentFormEvent>(_onReferenciaChanged);
    on<EntidadFinancieraOrderPaymentFormEvent>(_onEntidadFinancieraChanged);
    on<MetodoPagoOrderPaymentFormEvent>(_onMetodoPagoChanged);
    on<ObservacionesOrderPaymentFormEvent>(_onObservacionesChanged);
  }

  Future<void> _onInit(
    InitOrderPaymentFormEvent event,
    Emitter<OrderPaymentFormState> emit,
  ) async {}

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
