import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:olx_clone/code/states/explore_state.dart';
import 'package:olx_clone/code/states/location_state.dart';
import 'package:olx_clone/code/states/sell_state.dart';

final sellStateProvider = ChangeNotifierProvider((_) => SellState());
final locationStateProvider = ChangeNotifierProvider((_) => LocationState());
final exploreStateProvider = ChangeNotifierProvider((_) => ExploreState());
