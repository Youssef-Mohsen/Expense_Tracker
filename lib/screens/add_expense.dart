import 'package:expense_tracker/cubit/add_states.dart';
import 'package:expense_tracker/cubit/app_cubit.dart';
import 'package:expense_tracker/widgets/after_change.dart';
import 'package:expense_tracker/widgets/normal_add-expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final AppCubit cubit = AppCubit();
  var formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    cubit.titleController.dispose();
    cubit.amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return BlocBuilder<AppCubit, AddStates>(
      builder: (context, state) {
        return LayoutBuilder(builder: (context,constraints){
          final width = constraints.maxWidth;
          return Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.fromLTRB(16.0, 50, 16,keyboardSpace+ 16),
                child: width>=600?AfterChange(formKey: formKey):NormalExpense(formKey: formKey),
              ),
            ),
          );
        },);

      },
    );
  }
}
