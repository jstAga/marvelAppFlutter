import 'package:flutter/material.dart';
import 'package:marvel_app_flutter/app/app_view_model.dart';
import 'package:marvel_app_flutter/ui/constants/bases/base_providers.dart';
import 'package:marvel_app_flutter/ui/widgets/details/details_cast_widget.dart';
import 'package:marvel_app_flutter/ui/widgets/details/details_main_widget.dart';
import 'package:marvel_app_flutter/ui/widgets/details/details_view_model.dart';

class DetailsWidget extends StatefulWidget {
  const DetailsWidget({super.key});

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  @override
  void initState() {
    super.initState();
    final model = NotifierProvider.read<DetailsViewModel>(context);
    final appModel = InheritedProvider.read<AppViewModel>(context);
    model?.onSessionExpired = () => appModel?.resetSession(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    NotifierProvider.read<DetailsViewModel>(context)
        ?.setupLocalization(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _Title(),
      ),
      body: const ColoredBox(
        color: Color.fromRGBO(24, 22, 27, 1),
        child: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final movieDetails =
        NotifierProvider.watch<DetailsViewModel>(context)?.movieDetails;
    if (movieDetails == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView(
        children: const [
          DetailsMainWidget(),
          SizedBox(height: 20),
          DetailsCastWidget()
        ],
      );
    }
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    final model =
        NotifierProvider.watch<DetailsViewModel>(context)?.movieDetails;
    return Text(model?.title ?? "Loading", maxLines: 1);
  }
}
