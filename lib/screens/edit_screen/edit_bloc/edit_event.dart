abstract class EditEvent{}

final class EditNoteEvent extends EditEvent{
  final String id;
  final Map map;
  EditNoteEvent({required this.id, required this.map});
}
final class EditPatchEvent extends EditEvent{
  final String id; 
  final Map map;
  EditPatchEvent({required this.id,required this.map});
  }