import 'package:expense_tracker/cubit/add_states.dart';
import 'package:expense_tracker/cubit/app_cubit.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseItem extends StatelessWidget {
  ExpenseItem(this.expense, {super.key});

  final Expense expense;
  final AppCubit cubit = AppCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AddStates>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of<AppCubit>(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 4),
          child: SizedBox(
            width: 360,
            height: 90,
            child: Card(
              color: Colors.grey[400],
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        expense.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ]),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '\$${expense.amount.toStringAsFixed(2)}',
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Icon(categoryIcon[expense.category]),
                            const SizedBox(width: 8),
                            Text(cubit.formatDate),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
