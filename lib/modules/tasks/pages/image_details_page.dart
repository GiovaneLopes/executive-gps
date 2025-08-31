// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:executive_gps/modules/tasks/blocs/task_admin/task_bloc.dart';

// class ImageDetailsPage extends StatelessWidget {
//   const ImageDetailsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final bloc = Modular.get<TaskBloc>();
//     return Scaffold(
//       appBar: AppBar(),
//       body: SizedBox(
//         width: double.maxFinite,
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Expanded(
//               child: BlocBuilder<TaskBloc, TaskState>(
//                 bloc: bloc,
//                 builder: (context, state) {
//                   return InteractiveViewer(
//                     child: state.selectedImage?.url == null
//                         ? Center(
//                             child: Image.file(
//                               File(state.selectedImage?.file?.path ?? ''),
//                             ),
//                           )
//                         : Center(
//                             child: CachedNetworkImage(
//                               imageUrl: state.selectedImage?.url ?? '',
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
