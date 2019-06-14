import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:spike_bloc_flutter/bloc/loading_bloc.dart';

typedef T Func0<T>();

class LoadingWidget extends StatelessWidget {
  const LoadingWidget();

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<LoadingBloc>(context);
    return StreamBuilder<bool>(
        initialData: false,
        stream: bloc.value,
        builder: (context, snapshot) {
          return (snapshot.data)
              ? Container(
                  decoration: const BoxDecoration(color: Color(0x44000000)),
                  child: Center(child: const CircularProgressIndicator()),
                )
              : Container();
        });
  }
}
