import 'package:fakeslink/app/presentation/registerable_class/bloc/list_registerable_class_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'list_registerable_class_state.dart';

class ListRegisterableClassBloc extends Bloc<ListRegisterableClassEvent, ListRegisterableClassState> {
  ListRegisterableClassBloc() : super(ListRegisterableClassLoadingState());

  @override
  Stream<ListRegisterableClassState> mapEventToState(ListRegisterableClassEvent event) async* {
    if (event is ListRegisterableClassInitEvent) {
      
    }
  }
}