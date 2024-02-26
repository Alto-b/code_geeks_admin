
import 'package:flutter/material.dart';

class textfield extends StatelessWidget {
  const textfield({
    super.key,
    required TextEditingController controller,
    required this.label
  }) : _nameController = controller;

  final TextEditingController _nameController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        label: Text(label),
        border: const OutlineInputBorder(
    
        )
      ),
    );
  }
}