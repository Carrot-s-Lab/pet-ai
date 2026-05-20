import 'package:flutter/material.dart';
import 'package:pet_ai_project/data/models/cat.dart';
import 'package:pet_ai_project/data/models/task.dart';
import 'package:pet_ai_project/layout/common/app_font/app_font.dart';
import 'package:pet_ai_project/layout/common/color/app_color.dart';
import 'package:pet_ai_project/router/route_paths.dart';
import 'package:pet_ai_project/router/router.dart';
import 'package:provider/provider.dart';

import '../controller/home_controller.dart';
import 'widgets/cat_profile_banner.dart';
import 'widgets/task_list.dart';
import 'widgets/task_sheet.dart';
import 'widgets/tip_banner.dart';
import 'widgets/weekly_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeController>().load();
    });
  }

  void _openCatDetail(Cat cat) {
    appRouter.push(context, RoutePaths.catDetail, extra: cat);
  }

  void _openCreateTaskSheet(HomeController controller) {
    final day = controller.selectedDate ?? controller.today;
    showTaskSheet(
      context,
      selectedDate: day,
      onSubmit: (result) => controller.createTask(
        title: result.title,
        type: result.type,
      ),
    );
  }

  void _openEditTaskSheet(HomeController controller, Task task) {
    final day = controller.selectedDate ?? controller.today;
    showTaskSheet(
      context,
      selectedDate: day,
      existingTask: task,
      onSubmit: (result) async {
        await controller.updateTask(
          task,
          title: result.title,
          type: result.type,
          date: result.date,
        );
        await controller.setTaskCompletion(task, result.completed);
      },
      onDelete: () => controller.deleteTask(task),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lavenderLight,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.lavenderWash, AppColors.lavenderLight],
          ),
        ),
        child: SafeArea(
          child: Consumer<HomeController>(
            builder: (_, controller, _) {
              final cat = controller.cat;
              final tip = controller.currentTip;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _GreetingHeader(
                    catName: cat?.name,
                    loading: controller.loading && cat == null,
                  ),
                  if (cat != null)
                    CatProfileBanner(
                      cat: cat,
                      onTap: () => _openCatDetail(cat),
                    )
                  else if (controller.loading)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: _ProfileSkeleton(),
                    ),
                  if (tip != null) TipBanner(tip: tip),
                  WeeklyCalendar(
                    weekDays: controller.currentWeekDays,
                    today: controller.today,
                    selectedDate: controller.selectedDate,
                    onDaySelected: controller.selectDate,
                  ),
                  Expanded(
                    child: TaskList(
                      tasks: controller.tasksForSelectedDate,
                      day: controller.selectedDate ?? controller.today,
                      loading: controller.loadingTasks,
                      onToggle: controller.toggleTaskCompletion,
                      onLongPressTask: (task) => _openEditTaskSheet(controller, task),
                      onAddTask: () => _openCreateTaskSheet(controller),
                      onAddPreset: (title) => controller.createTask(
                        title: title,
                        type: TaskType.daily,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _GreetingHeader extends StatelessWidget {
  const _GreetingHeader({required this.catName, required this.loading});

  final String? catName;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loading || catName == null ? 'Hey there! 👋' : 'Hey, $catName! 👋',
            style: AppFonts.h1.apply(color: AppColors.ink),
          ),
          const SizedBox(height: 2),
          Text(
            "Here's your daily summary",
            style: AppFonts.bodyS.apply(color: AppColors.stone),
          ),
        ],
      ),
    );
  }
}

class _ProfileSkeleton extends StatelessWidget {
  const _ProfileSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      decoration: BoxDecoration(
        color: AppColors.cloud,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
