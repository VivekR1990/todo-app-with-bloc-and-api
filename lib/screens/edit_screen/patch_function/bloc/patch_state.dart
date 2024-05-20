part of 'patch_bloc.dart';

abstract class PatchState {}

abstract class PatchActionState extends PatchState{}

final class PatchInitial extends PatchState {}

final class EditSuccessState extends PatchActionState{}

final class EditFaildState extends PatchActionState{}
