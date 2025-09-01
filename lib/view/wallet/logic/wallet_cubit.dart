import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_app/services/nobitex_service.dart';
import 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final NobitexService nobitexService;
  final String token;
  Timer? _timer;

  bool _isFetching = false;

  WalletCubit({
    required this.nobitexService,
    required this.token,
  }) : super(const WalletState());

  void startAutoUpdate({Duration interval = const Duration(seconds: 5)}) {
    if (_timer?.isActive ?? false) return;
    _timer = Timer.periodic(interval, (_) {
      fetchWallets(showLoading: false);
    });
  }

  void stopAutoUpdate() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> fetchWallets({bool showLoading = true}) async {
    if (_isFetching) return;
    _isFetching = true;

    if (showLoading && state.wallets.isEmpty) {
      emit(state.copyWith(isLoading: true, error: null));
    } else if (!showLoading && state.wallets.isNotEmpty) {
      emit(state.copyWith(isRefreshing: true, error: null));
    }

    try {
      final response = await nobitexService.getWallets(token);
      final wallets = (response['wallets'] as List)
          .map((e) => Wallet.fromJson(e))
          .toList();

      emit(state.copyWith(
        isLoading: false,
        isRefreshing: false,
        wallets: wallets,
        error: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isRefreshing: false,
        error: e.toString(),
      ));
    } finally {
      _isFetching = false;
    }
  }

  @override
  Future<void> close() {
    stopAutoUpdate();
    return super.close();
  }
}
