import 'package:pet_ai_project/core/locator/locator.dart';
import 'package:pet_ai_project/core/services/local_database/local_database_service.dart';
import 'package:pet_ai_project/data/models/cat.dart';
import 'package:pet_ai_project/layout/common/change_notifier/safe_change_notifier.dart';

enum VaccineStatus { upToDate, dueSoon, optional }

enum MedicationStatus { active, dueSoon, completed }

class VaccineEntry {
  final String name;
  final String dateGiven;
  final String nextDue;
  final VaccineStatus status;

  const VaccineEntry({
    required this.name,
    required this.dateGiven,
    required this.nextDue,
    required this.status,
  });
}

class MedicationEntry {
  final String name;
  final String description;
  final String frequency;
  final MedicationStatus status;
  final String? nextDue;

  const MedicationEntry({
    required this.name,
    required this.description,
    required this.frequency,
    required this.status,
    this.nextDue,
  });
}

class WeightEntry {
  final DateTime date;
  final double weightKg;

  const WeightEntry({required this.date, required this.weightKg});
}

class VetVisitEntry {
  final String type;
  final DateTime date;
  final String notes;
  final String vetName;
  final String clinic;
  final bool isUpcoming;

  const VetVisitEntry({
    required this.type,
    required this.date,
    required this.notes,
    required this.vetName,
    required this.clinic,
    required this.isUpcoming,
  });
}

class ProfileController extends SafeChangeNotifier {
  ProfileController() : cat = locator<LocalDatabaseService>().getCatProfile();

  final Cat? cat;
  final double currentWeightKg = 4.2;
  final String lifestyle = 'Indoor';
  final int checkIns = 47;
  final String lastVetVisit = 'Mar 15';

  int _activeTab = 0;
  String editLifestyle = 'Indoor';

  int get activeTab => _activeTab;

  final List<VaccineEntry> vaccines = const [
    VaccineEntry(
      name: 'FVRCP (4-in-1)',
      dateGiven: 'Jan 15, 2025',
      nextDue: "Jan '26",
      status: VaccineStatus.upToDate,
    ),
    VaccineEntry(
      name: 'Rabies (3-year)',
      dateGiven: 'Feb 10, 2024',
      nextDue: "Feb '27",
      status: VaccineStatus.upToDate,
    ),
    VaccineEntry(
      name: 'FeLV (Feline Leukemia)',
      dateGiven: 'Mar 5, 2024',
      nextDue: "Mar '26",
      status: VaccineStatus.dueSoon,
    ),
    VaccineEntry(
      name: 'FIV',
      dateGiven: '',
      nextDue: '',
      status: VaccineStatus.optional,
    ),
  ];

  final List<MedicationEntry> medications = const [
    MedicationEntry(
      name: 'Revolution Plus',
      description: 'Flea, tick & heartworm · monthly',
      frequency: 'Monthly',
      status: MedicationStatus.dueSoon,
      nextDue: 'Next Jun 1',
    ),
    MedicationEntry(
      name: 'Hairball Supplement',
      description: 'Laxatone · daily with food',
      frequency: 'Daily',
      status: MedicationStatus.active,
    ),
    MedicationEntry(
      name: 'Amoxicillin',
      description: '10-day course · completed Apr 2025',
      frequency: '',
      status: MedicationStatus.completed,
    ),
  ];

  final List<WeightEntry> weightEntries = [
    WeightEntry(date: DateTime(2025, 12, 8), weightKg: 4.0),
    WeightEntry(date: DateTime(2026, 1, 10), weightKg: 4.1),
    WeightEntry(date: DateTime(2026, 2, 2), weightKg: 4.2),
    WeightEntry(date: DateTime(2026, 3, 15), weightKg: 4.3),
    WeightEntry(date: DateTime(2026, 4, 3), weightKg: 4.1),
    WeightEntry(date: DateTime(2026, 5, 5), weightKg: 4.2),
  ];

  final List<VetVisitEntry> vetVisits = [
    VetVisitEntry(
      type: 'Dental Cleaning',
      date: DateTime(2026, 6, 5),
      notes:
          'Under general anaesthesia. Bring vaccine records. Fast for 12h beforehand.',
      vetName: 'Dr. Morales',
      clinic: 'City Cat Clinic',
      isUpcoming: true,
    ),
    VetVisitEntry(
      type: 'Annual Check-up',
      date: DateTime(2026, 3, 15),
      notes:
          'Full wellness exam. Blood panel normal. Weight 4.3 kg. All vaccines reviewed. Dental flagged for follow-up.',
      vetName: 'Dr. Morales',
      clinic: 'City Cat Clinic',
      isUpcoming: false,
    ),
    VetVisitEntry(
      type: 'Skin Concern Follow-up',
      date: DateTime(2025, 9, 20),
      notes:
          'Mild allergic reaction to new food. Switched to hypoallergenic diet. Fully resolved after 3 weeks.',
      vetName: 'Dr. Morales',
      clinic: 'City Cat Clinic',
      isUpcoming: false,
    ),
    VetVisitEntry(
      type: 'Vaccination Booster',
      date: DateTime(2024, 2, 10),
      notes:
          'Rabies 3-year booster. FVRCP updated. Microchip scanned and verified.',
      vetName: 'Dr. Morales',
      clinic: 'City Cat Clinic',
      isUpcoming: false,
    ),
  ];

  void selectTab(int index) {
    _activeTab = index;
    notifyListeners();
  }

  void initEditForm() {
    editLifestyle = lifestyle;
    notifyListeners();
  }

  void setEditLifestyle(String value) {
    editLifestyle = value;
    notifyListeners();
  }
}
