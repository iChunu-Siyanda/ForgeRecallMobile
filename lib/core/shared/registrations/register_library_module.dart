import 'package:forge_recall/features/library/presentation/bloc/library_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void registerLibraryModule() {
  getIt.registerFactory(
    () => LibraryBloc(getIt(),),
  );
}
