import 'package:bloc/bloc.dart';
import 'package:expense_tracker/cubit/add_states.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/screens/add_expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
/*import 'package:sqflite/sqflite.dart';*/

class AppCubit extends Cubit<AddStates> {
  AppCubit() : super(InitialState());

  //Attributes
  var titleController = TextEditingController();
  var amountController = TextEditingController();
  DateTime? presentDate;
  String formatDate = 'No Date Selected';
  String category = 'food';
  /*late Database database;*/

  final List<Expense> registeredExpenses = [];

  /*double get totalExpense {
    double sum = 0;
    for (final task in tasks) {
      sum += task['amount'];
    }
    return sum;
  }

  double get maxExpense {
    double maxTotalExpense = 0;

    for (final bucket in tasks) {
      if (bucket['totalExpense'] > bucket['maxExpense']) {
        bucket['maxExpense'] = bucket['totalExpense'];
      }
    }

    return maxTotalExpense;
  }
*/
/////////////////////////////////////////////////
//Methods

  /////////DataBase
  /*void createDataBase() {
    openDatabase('app_cubit.db', version: 1, onCreate: (db, version) {
      db
          .execute(
              'Create Table tasks(id INTEGER PRIMARY KEY , title TEXT , amount DOUBLE , date TEXT,category TEXT')
          .then((value) {
        print('Table Created');
      }).catchError((e) {
        print(e.toString());
      });
    }, onOpen: (db) {
      print('Data base opened');
      getDataFromDataBase(db);
    }).then((value) {
      database = value;

      emit(CreateDataBase());
    });
  }

  void insertToDataBase(Expense expense) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              "Insert Into tasks (title, amount , date,category) VALUES('${expense.title}','${expense.amount}','${expense.dateTime}','${expense.category}','$totalExpense','$maxExpense')")
          .then((value) {

        getDataFromDataBase(database);
        emit(InsertDataBase());
      }).catchError((e) {
        print(e.toString());
      });
    });
  }

  void insertToDataBaseUndo(List<Map> tasks, int id) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              "Insert Into tasks (title, amount , date,category) VALUES('${tasks[id]['title']}','${tasks[id]['amount']}','${tasks[id]['date']}','${tasks[id]['category']}')")
          .then((value) {
        print('Data Inserted');
        getDataFromDataBase(database);
        emit(InsertDataBase());
      }).catchError((e) {
        print(e.toString());
      });
    });
  }

  List<Map> tasks = [];

  void getDataFromDataBase(Database database) {
    database.rawQuery('Select * from tasks').then((value) async {
      tasks = value;
      emit(GetDataBase());
      print(tasks);
    }).catchError((e) {
      print(e.toString());
    });
  }

  void deleteFromDataBase(List<Map> tasks, BuildContext context, int id) {
    database.rawDelete("Delete From tasks WHERE id =?", [id]).then((value) {
      getDataFromDataBase(database);
      emit(DeleteDataBase());
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              insertToDataBaseUndo(tasks, id);
              emit(Undo());
            }),
        content: const Text(
          'Expense deleted',
          style: TextStyle(fontWeight: FontWeight.bold),
        )));
    emit(RemoveExpense());
  }
*/
/////////////////////////////////////////////////
  void selectExpense(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.grey[400],
        isScrollControlled: MediaQuery.of(context).size.width<600?false:true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        builder: (ctx) => const AddExpense());
    emit(AddExpenses());
  }

  void datePicker(BuildContext context) async {
    var now = DateTime.now();
    var firstDate = DateTime(now.year - 6, DateTime.january, 1);
    var lastDate = DateTime(now.year, DateTime.december, 31);
    presentDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);
    formatDate = DateFormat.yMd().format(presentDate!);
    emit(SelectDate());
  }

  void showErrorMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text(
                'Invalid Input',
                textAlign: TextAlign.center,
              ),
              content: const Text(
                'Please make sure you insert title,amount,category and date',
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Okay'))
              ],
            ));
  }

  void changeCategory(var value) {
    category = value;
    emit(ChangeCategory());
  }

  void saveChanges(BuildContext context, Expense expense) {
    registeredExpenses.add(expense);
    Navigator.pop(context);
    emit(SaveChanges());
  }

  void removeExpense(Expense expense, BuildContext context) {
    final expenseIndex = registeredExpenses.indexOf(expense);
    registeredExpenses.remove(expense);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              registeredExpenses.insert(expenseIndex, expense);
              emit(Undo());
            }),
        content: const Text(
          'Expense deleted',
          style: TextStyle(fontWeight: FontWeight.bold),
        )));
    emit(RemoveExpense());
  }
}
