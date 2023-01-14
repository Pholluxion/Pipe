import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipe/src/data/services/navigation_service.dart';
import 'package:pipe/src/di.dart';
import 'package:pipe/src/presentation/bloc/home/home_cubit.dart';
import 'package:pipe/src/presentation/pages/join_page.dart';
import 'package:pipe/src/presentation/pages/metting_page.dart';
import 'package:pipe/src/presentation/routes.dart' as routes;

import '../../core/utils/colors.dart';
import '../bloc/actions/actions_bloc.dart';
import '../bloc/video/video_sdk_bloc.dart';
import '../widgets/widget.dart';

class StreamPage extends StatefulWidget {
  const StreamPage({
    Key? key,
    required this.token,
  }) : super(key: key);

  final String token;

  @override
  State<StreamPage> createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  @override
  void initState() {
    di<VideoSdkBloc>().add(GetRoomsEvent(widget.token));
    di<ActionsBloc>().add(HandleTokenEvent(widget.token));
    di<ActionsBloc>().add(
      HandleDisplayNameEvent(
        di<HomeCubit>().state.userResponseEntity?.userDto?.name ?? 'NN',
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      backgroundColor: PipeColor.kPipeBlack,
      appBar: PipeAppBar(size: size),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: BlocBuilder<VideoSdkBloc, VideoSdkState>(
          builder: (context, state) {
            if (state is LoadingRoomsState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ErrorRoomsState) {
              return const Center(
                child: Text(
                  'Ocurrio un problema',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            } else if (state is LoadedRoomsState) {
              if (state.rooms.isNotEmpty) {
                final rooms = state.rooms.reversed.toList();
                return SingleChildScrollView(
                  child: Center(
                    child: Wrap(
                      alignment: WrapAlignment.spaceAround,
                      children: rooms
                          .asMap()
                          .entries
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: () {
                                  di<ActionsBloc>().add(
                                    HandleRoomIdEvent(
                                      e.value['roomId'],
                                    ),
                                  );
                                  di<NavigationService>()
                                      .navigateTo(routes.kConferencePage);
                                },
                                child: Container(
                                  width: orientation == Orientation.portrait
                                      ? (size.width).ceil().toDouble()
                                      : (size.height / 2.5).ceil().toDouble(),
                                  height: orientation == Orientation.portrait
                                      ? (size.width / 2).ceil().toDouble()
                                      : (size.height / 2.5).ceil().toDouble(),
                                  decoration: BoxDecoration(
                                    color: PipeColor.kPipeGreen,
                                    borderRadius: BorderRadius.circular(
                                      20.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Sala ${e.key + 1}: ${e.value['roomId']}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Text(
                    'No hay salas disonibles',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }
            } else {
              return const Center(
                child: Text(
                  '404',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            }
          },
        ),
      ),
      drawer: orientation == Orientation.landscape ? const PipeDrawer() : null,
      bottomNavigationBar:
          orientation == Orientation.portrait ? const PipeNavBar() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              heroTag: 'create_room_btn',
              key: const Key('create_room_btn'),
              onPressed: () =>
                  di<NavigationService>().navigatorKey.currentState!.push(
                        MaterialPageRoute(
                          builder: (context) => const NewMettingPage(),
                        ),
                      ),
              child: Icon(
                Icons.video_call,
                color: PipeColor.kPipeBlack,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              heroTag: 'join_room',
              key: const Key('join_room'),
              onPressed: () =>
                  di<NavigationService>().navigatorKey.currentState!.push(
                        MaterialPageRoute(
                          builder: (context) => const JoinPage(),
                        ),
                      ),
              child: Icon(
                Icons.door_front_door_outlined,
                color: PipeColor.kPipeBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//
