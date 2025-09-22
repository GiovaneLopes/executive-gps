import 'package:executive_gps/modules/tasks/widgets/task_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:executive_gps/modules/tasks/widgets/task_card.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/tasks/blocs/task/task_bloc.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';

enum FilterType {
  today,
  scheduled,
  completed,
  canceled;

  String get name {
    switch (this) {
      case FilterType.today:
        return 'Hoje';
      case FilterType.completed:
        return 'Completos';
      case FilterType.canceled:
        return 'Cancelados';
      case FilterType.scheduled:
        return 'Agendados';
    }
  }
}

class TasksContent extends StatefulWidget {
  const TasksContent({super.key});

  @override
  State<TasksContent> createState() => _TasksContentState();
}

class _TasksContentState extends State<TasksContent> {
  final bloc = Modular.get<TaskBloc>();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        bloc.state.hasMore && bloc.state.filter == null
            ? bloc.getTasks()
            : null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      bloc: bloc,
      builder: (context, state) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              decoration: const BoxDecoration(color: AppColors.primary),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Atividades',
                      style: Styles.bodyMedium.copyWith(color: AppColors.black),
                    ),
                  ),
                  InkWell(
                    onTap: bloc.toggleView,
                    child: Icon(
                      state.viewMode ? FeatherIcons.grid : FeatherIcons.list,
                      size: 20.w,
                    ),
                  ),
                ],
              ),
            ),
            if (state.status == TaskStatus.loading && state.tasks.isEmpty)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                ),
              )
            else if (state.tasks.isEmpty)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FeatherIcons.list,
                      color: AppColors.black,
                    ),
                    Text(
                      'Nenhuma atividade por aqui.',
                      style: Styles.bodySmall,
                    ),
                  ],
                ),
              )
            else
              Expanded(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: List.generate(
                            FilterType.values.length,
                            (index) => Padding(
                              padding: EdgeInsets.only(right: 12.w),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 6.h),
                                  backgroundColor:
                                      state.filter == FilterType.values[index]
                                          ? AppColors.primary
                                          : Colors.transparent,
                                ),
                                onPressed: () =>
                                    bloc.selectFilter(FilterType.values[index]),
                                child: Text(
                                  FilterType.values[index].name,
                                  style: Styles.bodySmall,
                                ),
                              ),
                            ),
                          ).toList()),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: state.orderTasks.length + 1,
                        itemBuilder: (context, index) {
                          if (index < state.orderTasks.length) {
                            return state.viewMode
                                ? TaskExpansionTile(
                                    task: state.orderTasks[index],
                                  )
                                : TaskCard(
                                    task: state.orderTasks[index],
                                  );
                          } else {
                            return state.hasMore && state.filter == null
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primary,
                                    ),
                                  )
                                : const SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
