import 'package:expense_tracker/cubit/add_states.dart';
import 'package:expense_tracker/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/expense_model.dart';

class NormalExpense extends StatelessWidget {
   NormalExpense({super.key,required this.formKey});
  final AppCubit cubit = AppCubit();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AddStates>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of<AppCubit>(context);
        return Column(
          children: [
            TextFormField(
              maxLength: 12,
              controller: cubit.titleController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Must insert Title';
                } else if (cubit.titleController.text.length < 3) {
                  return 'Title Must be At Least 3 Character';
                }
                return null;
              },
              decoration: const InputDecoration(
                label: Text('Title', style: TextStyle(color: Colors.black)),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: cubit.amountController,
                    maxLength: 9,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Must insert amount';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixText: '\$ ',
                      label: Text(
                        'Amount',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(cubit.formatDate.toString()),
                      IconButton(
                          onPressed: () {
                            cubit.datePicker(context);
                          },
                          icon: const Icon(Icons.calendar_month))
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DropdownButton(
                    value: cubit.category,
                    iconDisabledColor: Colors.grey[800],
                    iconEnabledColor: Colors.grey[800],
                    hint: const Padding(
                      padding: EdgeInsets.only(left: 9),
                      child: Text(
                        'LEISURE',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    items: category
                        .map((category) =>
                        DropdownMenuItem(
                            value: category,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 9),
                              child: Text(
                                category.toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      cubit.changeCategory(value);
                    }),
                const Spacer(),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    child: const Text('Cancel')),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate() &&
                          cubit.formatDate != 'No Date Selected') {
                        cubit.saveChanges(
                            context,
                            Expense(
                                title: cubit.titleController.text,
                                amount: double.parse(
                                    cubit.amountController.text),
                                dateTime: cubit.formatDate,
                                category: cubit.category));
                      } else {
                        cubit.showErrorMessage(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    child: const Text('Save Changes')),
              ],
            )
          ],
        );
      },
    );
  }
}
