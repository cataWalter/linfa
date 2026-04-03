import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/constants/enums.dart';
import '../../core/theme/typography.dart';
import '../../data/models/reminder.dart';
import '../../shared/providers/reminder_provider.dart';
import '../../shared/providers/plant_provider.dart';
import '../../shared/widgets/reminder_picker.dart';

/// Add reminder screen
class AddReminderScreen extends ConsumerStatefulWidget {
  const AddReminderScreen({super.key, this.plantId});

  final int? plantId;

  @override
  ConsumerState<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends ConsumerState<AddReminderScreen> {
  final _formKey = GlobalKey<FormState>();

  ReminderType _selectedType = ReminderType.watering;
  ReminderFrequency _selectedFrequency = ReminderFrequency.weekly;
  TimeOfDay _selectedTime = TimeOfDay(hour: 9, minute: 0);
  bool _isEnabled = true;
  bool _isLoading = false;

  Future<void> _saveReminder() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final reminder = Reminder()
        ..type = _selectedType.name
        ..frequencyDays = _selectedFrequency.days
        ..time = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          _selectedTime.hour,
          _selectedTime.minute,
        )
        ..isEnabled = _isEnabled
        ..nextScheduled =
            DateTime.now().add(Duration(days: _selectedFrequency.days));

      if (widget.plantId != null) {
        // Get plant data if available
        final plantAsync = ref.read(plantProvider(widget.plantId!));
        final plant = plantAsync.value;
        if (plant != null) {
          reminder.plant.value = plant;
        }
      }

      await ref.read(remindersProvider.notifier).addReminder(reminder);

      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Errore: $e'),
            backgroundColor: LinfaColors.danger,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.addReminder),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveReminder,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    AppStrings.save,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Reminder type
            Text(
              AppStrings.reminderType,
              style: LinfaTypography.getTitleMedium(),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ReminderType.values.map((type) {
                return ChoiceChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(type.icon, size: 16),
                      const SizedBox(width: 4),
                      Text(type.displayName),
                    ],
                  ),
                  selected: _selectedType == type,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _selectedType = type);
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Frequency
            Text(
              AppStrings.reminderFrequency,
              style: LinfaTypography.getTitleMedium(),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ReminderFrequency.values.map((freq) {
                return ChoiceChip(
                  label: Text(freq.displayName),
                  selected: _selectedFrequency == freq,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _selectedFrequency = freq);
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Time
            Text(
              AppStrings.reminderTime,
              style: LinfaTypography.getTitleMedium(),
            ),
            const SizedBox(height: 12),
            ReminderPicker(
              initialTime: _selectedTime,
              onTimeSelected: (time) {
                setState(() => _selectedTime = time);
              },
            ),
            const SizedBox(height: 24),

            // Enabled switch
            SwitchListTile(
              title: Text(AppStrings.reminderEnabled),
              value: _isEnabled,
              onChanged: (value) {
                setState(() => _isEnabled = value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
