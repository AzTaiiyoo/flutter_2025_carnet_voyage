import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_spacing.dart';
import 'form_card.dart';
import 'section_header.dart';

/// Champ de sélection de date avec DatePicker
class DatePickerField extends StatelessWidget {
  final TextEditingController controller;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;

  const DatePickerField({
    super.key,
    required this.controller,
    required this.selectedDate,
    required this.onDateChanged,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('fr', 'FR'),
    );
    if (picked != null && picked != selectedDate) {
      controller.text = DateFormat('dd/MM/yyyy').format(picked);
      onDateChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            icon: Icons.calendar_today,
            title: 'Date',
          ),
          SizedBox(height: AppSpacing.md),
          TextFormField(
            controller: controller,
            readOnly: true,
            onTap: () => _selectDate(context),
            decoration: const InputDecoration(
              labelText: 'Date de la sortie',
              suffixIcon: Icon(Icons.arrow_drop_down),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez sélectionner une date';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
