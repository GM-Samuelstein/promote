import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promote/presentation/view_model/app_viewmodel.dart';
import 'package:promote/presentation/widgets/custom_dropdown_field.dart';
import 'package:promote/presentation/widgets/custom_search_box.dart';
import 'package:promote/presentation/widgets/details_tile.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    var controller = ref.read(appViewmodel);
    controller.getEmployees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(appViewmodel);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('D A S H B O A R D'),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E1E1E),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdownField(
                        headerText: 'Level',
                        items: vm.levels,
                        value: vm.selectedLevel,
                        onChanged: (value) {
                          vm.selectedLevel = value;
                          vm.filterControlList();
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomDropdownField(
                        headerText: 'Designation',
                        items: vm.designations,
                        value: vm.selectedDesignation,
                        onChanged: (value) {
                          vm.selectedDesignation = value;
                          vm.filterControlList();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CustomSearchBox(vm: vm),
                const SizedBox(height: 16),
                const Text(
                  'Current Employees',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E1E1E),
                  ),
                ),
                const SizedBox(height: 10),
                if (vm.filteredEmployeeList.isEmpty) ...[
                  const Expanded(
                    child: Center(
                      child: Text('No Employee found'),
                    ),
                  ),
                ],
                Expanded(
                  child: ListView.builder(
                    itemCount: vm.filteredEmployeeList.length,
                    itemBuilder: (context, index) {
                      final employee = vm.filteredEmployeeList[index];

                      return GestureDetector(
                        onTap: () {
                          vm.determineEmploymentDetails(
                            productivityScore: employee.productivityScore,
                            oldLevel: employee.level,
                          );
                          vm.goToEmployeeDetailsScreen(context, employee);
                        },
                        child: DetailsTile(
                          header: '${employee.firstName} ${employee.lastName}',
                          detail:
                              '${employee.designation} | Lvl ${employee.level}',
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
