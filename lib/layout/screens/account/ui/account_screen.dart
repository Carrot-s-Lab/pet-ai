import 'package:flutter/material.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';
import 'package:provider/provider.dart';

import '../controller/profile_controller.dart';
import 'widgets/profile_add_sheet.dart';
import 'widgets/profile_edit_sheet.dart';
import 'widgets/profile_hero.dart';
import 'widgets/profile_medications_tab.dart';
import 'widgets/profile_stats_row.dart';
import 'widgets/profile_tab_bar.dart';
import 'widgets/profile_vaccines_tab.dart';
import 'widgets/profile_vet_visits_tab.dart';
import 'widgets/profile_weight_tab.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  void _showEditSheet(BuildContext context, ProfileController controller) {
    controller.initEditForm();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (_) => ChangeNotifierProvider.value(
        value: controller,
        child: const ProfileEditSheet(),
      ),
    );
  }

  void _showAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const ProfileAddSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(
      builder: (context, controller, _) {
        return Scaffold(
          backgroundColor: AppColors.lavenderWash,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: FloatingActionButton(
              onPressed: () => _showAddSheet(context),
              backgroundColor: AppColors.caramel,
              elevation: 6,
              shape: const CircleBorder(),
              child: const Icon(Icons.add, color: Colors.white, size: 24),
            ),
          ),
          body: Column(
            children: [
              _ProfileHeader(
                controller: controller,
                onEditTap: () => _showEditSheet(context, controller),
              ),
              ProfileTabBar(
                activeIndex: controller.activeTab,
                onTabChanged: controller.selectTab,
              ),
              Expanded(
                child: IndexedStack(
                  index: controller.activeTab,
                  children: [
                    ProfileVaccinesTab(vaccines: controller.vaccines),
                    ProfileMedicationsTab(medications: controller.medications),
                    ProfileWeightTab(
                      entries: controller.weightEntries,
                      currentWeightKg: controller.currentWeightKg,
                    ),
                    ProfileVetVisitsTab(visits: controller.vetVisits),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.controller, required this.onEditTap});

  final ProfileController controller;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 0.8],
          colors: [AppColors.lavenderLight, AppColors.lavenderWash],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Row(
                children: [
                  const Spacer(),
                  Text(
                    "${controller.cat?.name ?? 'My Cat'}'s Profile",
                    style: AppFonts.h3.apply(color: AppColors.ink),
                  ),
                  const Spacer(),
                  _CircleButton(
                    onTap: () {},
                    child: const Icon(
                      Icons.ios_share_outlined,
                      size: 18,
                      color: AppColors.ink,
                    ),
                  ),
                ],
              ),
            ),
            if (controller.cat != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: ProfileHero(
                  cat: controller.cat!,
                  lifestyle: controller.lifestyle,
                  onEditTap: onEditTap,
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: ProfileStatsRow(
                weightKg: controller.currentWeightKg,
                checkIns: controller.checkIns,
                lastVetVisit: controller.lastVetVisit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: AppColors.cloud,
          shape: BoxShape.circle,
        ),
        child: Center(child: child),
      ),
    );
  }
}
