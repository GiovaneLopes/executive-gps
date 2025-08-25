import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:executive_gps/modules/shared/resources/styles.dart';
import 'package:executive_gps/modules/shared/resources/app_colors.dart';
import 'package:executive_gps/modules/customers/blocs/customer_bloc.dart';
import 'package:executive_gps/modules/customers/widgets/customer_tile.dart';

class CustomersContent extends StatelessWidget {
  const CustomersContent({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<CustomerBloc>();
    return BlocBuilder<CustomerBloc, CustomerState>(
        bloc: bloc,
        builder: (context, state) {
          return state.status == CustomerStatus.loading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: AppColors.primary,
                ))
              : state.customers.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          FeatherIcons.mapPin,
                          color: AppColors.black,
                        ),
                        Text(
                          'Nenhum cliente por aqui.',
                          style: Styles.bodySmall,
                        ),
                      ],
                    )
                  : ListView.separated(
                      itemCount: state.customers.length,
                      itemBuilder: (context, index) {
                        final customer = state.customers[index];
                        return CustomerTile(customer: customer);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(height: 1);
                      },
                    );
        });
  }
}
