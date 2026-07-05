import 'package:forge_recall/features/recall/presentation/bloc/recall_lab_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void registerRecallModule() {
  getIt.registerFactory(
    () => RecallLabBloc(),
  );
}
