import 'package:expense_tracker/cubit/add_states.dart';
import 'package:expense_tracker/cubit/app_cubit.dart';
import 'package:expense_tracker/widgets/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseList extends StatelessWidget {
  ExpenseList({super.key});

  final AppCubit cubit = AppCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AddStates>(builder: (context, state) {
      AppCubit cubit = BlocProvider.of<AppCubit>(context);
      return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cubit.registeredExpenses.length,
          itemBuilder: (ctx, index) {
            return Dismissible(
                key: ValueKey(cubit.registeredExpenses[index]),
                onDismissed: (direction) {
                  cubit.removeExpense(cubit.registeredExpenses[index], context);
                },
                child: ExpenseItem(cubit.registeredExpenses[index]));
          });
    });
  }
}
