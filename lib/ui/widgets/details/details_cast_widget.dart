import 'package:flutter/material.dart';
import 'package:marvel_app_flutter/ui/constants/bases/base_providers.dart';
import 'package:marvel_app_flutter/ui/constants/bases/bases_ext.dart';
import 'package:marvel_app_flutter/ui/widgets/details/details_view_model.dart';

class DetailsCastWidget extends StatelessWidget {
  const DetailsCastWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              onPressed: () {},
              child: Text("Series Cast",
                  style: BaseTextStyle.baseTitleText(Colors.black)),
            ),
          ),
          const SizedBox(
            height: 250,
            child: Scrollbar(
              child: _CastList(),
            ),
          ),
          TextButton(
              onPressed: () {},
              child: Text("Full Cast & Crew",
                  style: BaseTextStyle.baseTitleText(Colors.black)))
        ],
      ),
    );
  }
}

class _CastList extends StatelessWidget {
  const _CastList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 20,
        itemExtent: 120,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return _CastItem(index: index);
        });
  }
}

class _CastItem extends StatelessWidget {
  const _CastItem({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<DetailsViewModel>(context);
    final cast = model!.movieDetails!.credits!.cast[index];
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.black.withOpacity(0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2))
            ],
          ),
          child: ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  cast.profileImage,
                  fit: BoxFit.fitWidth,
                  width: 120,
                  height: 120,
                ),
                Text(cast.name ?? "",
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black)),
                Text(cast.character ?? "",
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.black))
              ],
            ),
          ),
        ));
  }
}
