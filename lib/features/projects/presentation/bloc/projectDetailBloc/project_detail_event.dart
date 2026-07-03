abstract class ProjectDetailEvent {
  const ProjectDetailEvent();
}

//Fetch single project by Id
class GetSingleProjectEvent extends ProjectDetailEvent{
  final String projectId;

  GetSingleProjectEvent(this.projectId);
}
