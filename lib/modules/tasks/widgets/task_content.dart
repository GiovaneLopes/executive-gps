import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:executive_gps/modules/tasks/widgets/task_card.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/tasks/blocs/task/task_bloc.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';

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
        bloc.getTasks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      bloc: bloc,
      builder: (context, state) {
        return Container(
          color: AppColors.greyBackground,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                decoration: const BoxDecoration(color: AppColors.primary),
                child: Row(
                  children: [
                    Text(
                      'Atividades',
                      style: Styles.bodyMedium.copyWith(color: AppColors.black),
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
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: state.tasks.length + 1,
                    itemBuilder: (context, index) {
                      if (index < state.tasks.length) {
                        return TaskCard(task: state.tasks[index]);
                      } else {
                        return state.hasMore
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
        );
      },
    );
  }
}
