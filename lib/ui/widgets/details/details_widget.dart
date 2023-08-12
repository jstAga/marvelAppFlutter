import 'package:flutter/material.dart';
import 'package:marvel_app_flutter/ui/widgets/details/details_cast_widget.dart';
import 'package:marvel_app_flutter/ui/widgets/details/details_main_widget.dart';
import 'package:marvel_app_flutter/ui/widgets/details/details_view_model.dart';
import 'package:provider/provider.dart';

class DetailsWidget extends StatefulWidget {
  const DetailsWidget({super.key});

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final locale = Localizations.localeOf(context);
    Future.microtask(() =>
        context.read<DetailsViewModel>().setupLocalization(context, locale));
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
    final isLoading =
        context.select((DetailsViewModel vm) => vm.data.isLoading);
    if (isLoading) {
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
    final title = context.select((DetailsViewModel vm) => vm.data.title);
    return Text(title, maxLines: 1);
  }
}
