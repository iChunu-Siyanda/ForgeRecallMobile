import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_recall/features/projects/domain/usercases/fetch_project_by_id.dart.dart';
import 'package:forge_recall/features/projects/presentation/bloc/projectDetailBloc/project_detail_event.dart';
import 'package:forge_recall/features/projects/presentation/bloc/projectDetailBloc/project_detail_state.dart';

class ProjectDetailBloc extends Bloc<ProjectDetailEvent,ProjectDetailState>{
  final FetchProjectById getSingleProject;

  ProjectDetailBloc(
    this.getSingleProject,
  ):super(ProjectInitialState()){
    on<GetSingleProjectEvent>(_onGetSingleProject);
  }

  Future<void> _onGetSingleProject(
    GetSingleProjectEvent event, 
    Emitter<ProjectDetailState> emit,
  ) async {
    try{
      final project = await getSingleProject(event.projectId);
      emit(ProjectLoadedState(project!));
    } catch (e) {
      emit(ProjectErrorState(e.toString()));
    }
  }
}
