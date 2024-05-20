part of 'patch_bloc.dart';

@immutable
sealed class PatchEvent {}
final class EditPatchEvent extends PatchEvent{
  final String id; 
  final Map map;
  EditPatchEvent({required this.id,required this.map});
}
