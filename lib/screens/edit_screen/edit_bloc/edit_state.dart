abstract class EditState{}


 abstract class EditActionState extends EditState{}
 
 final class EditInitial extends EditState{}

 final class EditSuccessState extends EditActionState{}
 
 final class EditFaildState extends EditActionState{}


 