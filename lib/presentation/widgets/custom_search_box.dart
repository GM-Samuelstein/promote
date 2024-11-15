import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:promote/presentation/view_model/app_viewmodel.dart';

class CustomSearchBox extends StatelessWidget {
  const CustomSearchBox({
    super.key,
    required this.vm,
  });

  final AppViewmodel vm;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFE9EAEC),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/svg/search.svg'),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              controller: vm.searchController,
              onChanged: (value) {
                vm.filterEmployeeList();
              },
              decoration: const InputDecoration(
                hintText: 'Search Employees...',
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0XFF4B4B4B),
                ),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          ),
          if (vm.searchController.text.isNotEmpty)
            IconButton(
              onPressed: () {
                vm.searchController.text = '';
                vm.filterControlList();
                vm.updateApp();
              },
              icon: const Icon(Icons.close, color: Color(0XFF2C2727)),
            ),
        ],
      ),
    );
  }
}
