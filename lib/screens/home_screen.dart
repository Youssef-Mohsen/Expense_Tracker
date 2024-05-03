import 'package:expense_tracker/cubit/add_states.dart';
import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/app_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AppCubit cubit = AppCubit();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<AppCubit, AddStates>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of<AppCubit>(context);
        Widget mainContent = const Center(
          child: Text(
            'No Expenses found. Start adding some!',
            style: TextStyle(color: Colors.white),
          ),
        );
        if (cubit.registeredExpenses.isNotEmpty) {
          mainContent = ExpenseList();
        }
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Expense Tracker',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black,
              actions: [
                IconButton(
                    onPressed: () {
                      cubit.selectExpense(context);
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
            backgroundColor: Colors.black,
            body: width < 600
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Chart(expenses: cubit.registeredExpenses),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                          child: SingleChildScrollView(child: mainContent)),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                          child: Chart(expenses: cubit.registeredExpenses)),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                          child: SingleChildScrollView(child: mainContent)),
                    ],
                  ));
      },
    );
  }
}
