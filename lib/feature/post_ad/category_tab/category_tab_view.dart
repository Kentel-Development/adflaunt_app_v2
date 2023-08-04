import 'package:adflaunt/core/adapters/profile/profile_adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../core/constants/padding_constants.dart';
import '../../../../generated/l10n.dart';
import '../../../product/widgets/category_tab.dart';
import '../cubit/post_ad_cubit.dart';

class CategoryTabView extends StatelessWidget {
  const CategoryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              S.of(context).hey +
                  " " +
                  Hive.box<ProfileAdapter>('user').get('userData')!.fullName! +
                  ", " +
                  S.of(context).tellUsAboutYourAdSpace,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              S.of(context).theMoreYouShareTheQuickerYouGetBooked,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          BlocBuilder(
            bloc: context.read<PostAdCubit>(),
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: PaddingConstants.mediumPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          context.read<PostAdCubit>().changeCategory(0);
                        },
                        child: CategoryTab(
                            category: 0,
                            isSelected:
                                context.read<PostAdCubit>().selectedCategory ==
                                    0)),
                    GestureDetector(
                      onTap: () {
                        context.read<PostAdCubit>().changeCategory(1);
                      },
                      child: CategoryTab(
                        category: 1,
                        isSelected:
                            context.read<PostAdCubit>().selectedCategory == 1,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<PostAdCubit>().changeCategory(2);
                      },
                      child: CategoryTab(
                        category: 2,
                        isSelected:
                            context.read<PostAdCubit>().selectedCategory == 2,
                      ),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
