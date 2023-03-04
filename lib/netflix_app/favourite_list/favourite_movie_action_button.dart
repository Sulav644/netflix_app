import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils.dart';
import '../buy_tickets/domain/buy_tickets_cubit.dart';
import '../buy_tickets/presentation/buy_tickets_page.dart';
import '../domain/netflix_data.dart';
import 'action_buttons.dart';
import 'netflix_favorite_list.dart';

typedef WidgetValueGetter = void Function(MovieDetail widget);

class FavouriteMovieActionButtons extends StatelessWidget {
  final MovieDetail e;
  final VoidCallback onClick;
  const FavouriteMovieActionButtons({
    super.key,
    required this.e,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final favouriteMovieListStatus =
        context.watch<FavoriteMovieListCubit>().state;
    return defaultTextStyle(
        Colors.white,
        SizedBox(
          width: getWidth(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActionButtons(
                onClick: () {
                  onClick();

                  context
                      .read<FavoriteMovieListCubit>()
                      .removeFavouriteMovie(e);
                },
                icon: favouriteMovieListStatus.contains(e)
                    ? Icons.favorite
                    : Icons.favorite_border,
                title: 'Remove',
              ),
              horizontalSpace(getWidthRatio(context, 0.1)),
              ActionButtons(
                onClick: () {
                  context.read<BuyTicketsCubit>().resetSitting();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BuyTicketsPage(
                                imgUrl: e.imgUrl!,
                                title: e.title!,
                              )));
                },
                icon: Icons.info_outline,
                title: 'Buy Tickets',
              ),
            ],
          ),
        ));
  }
}

class DeletedMovieCubit extends Cubit<MovieDetail> {
  DeletedMovieCubit() : super(const MovieDetail());
  void addDeletedMovie(MovieDetail movie) {
    emit(movie);
  }

  void resetDeleteMovie() {
    emit(const MovieDetail());
  }
}
