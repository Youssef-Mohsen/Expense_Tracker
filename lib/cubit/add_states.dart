abstract class AddStates {}

class InitialState extends AddStates {}

class AddExpenses extends AddStates {}

class SelectDate extends AddStates {}

class ChangeCategory extends AddStates {}

class SaveChanges extends AddStates {}

class RemoveExpense extends AddStates {}

class Undo extends AddStates {}

class CreateDataBase extends AddStates {}

class InsertDataBase extends AddStates {}

class GetDataBase extends AddStates {}

class DeleteDataBase extends AddStates {}
