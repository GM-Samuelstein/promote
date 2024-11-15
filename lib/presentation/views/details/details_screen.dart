import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promote/common/models/employee.dart';
import 'package:promote/presentation/view_model/app_viewmodel.dart';
import 'package:promote/presentation/widgets/details_tile.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  const DetailsScreen({
    super.key,
    required this.employee,
  });

  final Employee employee;

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(appViewmodel);

    return Scaffold(
      appBar: AppBar(
        title: const Text('D E T A I L S'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              '${widget.employee.firstName} ${widget.employee.lastName}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              widget.employee.designation,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Level ${widget.employee.level}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),
            DetailsTile(
              header: 'Productivity Score',
              detail: widget.employee.productivityScore.toString(),
            ),
            DetailsTile(
              header: 'Employment Status',
              detail: vm.employmentStatus,
            ),
            DetailsTile(
              header: 'Current Salary',
              detail: widget.employee.currentSalary,
            ),
            DetailsTile(
              header: 'New Salary',
              detail: vm.employeeSalary,
            ),
          ],
        ),
      ),
    );
  }
}
