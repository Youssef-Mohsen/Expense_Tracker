import 'package:expense_tracker/cubit/add_states.dart';
import 'package:expense_tracker/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.fill,
  });

  final double fill;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AddStates>(
      builder: (context, state) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FractionallySizedBox(
              heightFactor: fill, // 0 <> 1
              child: DecoratedBox(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(8)),
                    color: Colors.grey[800]),
              ),
            ),
          ),
        );
      },
    );
  }
}
