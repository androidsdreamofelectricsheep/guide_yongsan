import 'package:flutter/material.dart';

import 'package:guide_yongsan/core/params/params.dart';

import 'package:guide_yongsan/features/guide_yongsan/presentation/providers/main_info_provider.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/widgets/main_info_widget.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainInfoScreen extends StatefulWidget {
  static const routeUrl = '/main_info';
  static const routeName = 'mainInfo';

  final String majorId;
  final String mediumId;
  final String minorId;
  final String subName;

  const MainInfoScreen({
    super.key,
    required this.majorId,
    required this.mediumId,
    required this.minorId,
    required this.subName,
  });

  @override
  State<MainInfoScreen> createState() => _MainInfoScreenState();
}

class _MainInfoScreenState extends State<MainInfoScreen> {
  late SharedPreferences sharedPreferences;
  bool spInit = false;
  bool endCall = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void initLoad() {
    Future.microtask(() async {
      sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        spInit = true;
      });
    });

    _scrollController.addListener(_scrollListener);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<MainInfoProvider>().eitherFailureOrMainInfo(
            mainInfoParams: MainInfoParams(
              majorId: widget.majorId,
              mediumId: widget.mediumId,
              minorId: widget.minorId,
            ),
          );
    });
  }

  int getItemCount(MainInfoProvider provider) {
    return provider.mainInfoMap[provider.keyName]?['list']?.length +
        (provider.loading ? 1 : 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.subName), centerTitle: true),
        body: SafeArea(
          child:
              Consumer<MainInfoProvider>(builder: (context, provider, widget) {
            if (provider.mainInfoMap[provider.keyName]?['list']! != null) {
              return ListView.separated(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                itemCount: getItemCount(provider),
                itemBuilder: (context, index) => makeList(provider, index),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ));
  }

  Widget makeList(MainInfoProvider provider, int index) {
    if (provider.mainInfoMap[provider.keyName]?['list'] != null &&
        index < provider.mainInfoMap[provider.keyName]?['list']?.length &&
        provider.failure == null) {
      return MainInfoWidget(
        majorId: widget.majorId,
        mediumId: widget.mediumId,
        minorId: widget.minorId,
        subName: widget.subName,
        num: provider.mainInfoMap[provider.keyName]['list'][index].num
            .toString(),
        companyId:
            provider.mainInfoMap[provider.keyName]['list']?[index].companyId,
        companyName: provider
                .mainInfoMap[provider.keyName]['list']?[index].companyName ??
            '',
        addr: provider.mainInfoMap[provider.keyName]['list']?[index].addr ?? '',
        addrDetail:
            provider.mainInfoMap[provider.keyName]['list']?[index].addrDetail ??
                '',
        keyWord:
            provider.mainInfoMap[provider.keyName]['list']?[index].keyWord ??
                '',
        addrId: provider.mainInfoMap[provider.keyName]['list']?[index].addrId,
        phone:
            provider.mainInfoMap[provider.keyName]['list']?[index].phone ?? '',
        zipCode:
            provider.mainInfoMap[provider.keyName]['list']?[index].zipCode ??
                '',
        pointLng:
            provider.mainInfoMap[provider.keyName]['list']?[index].pointLng,
        pointLat:
            provider.mainInfoMap[provider.keyName]['list']?[index].pointLat,
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  void _scrollListener() async {
    if (!context.mounted) return;

    final provider = context.read<MainInfoProvider>();
    final totalDataCount =
        int.parse(sharedPreferences.getString('mainInfoTotalCount') ?? '0');

    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        provider.mainInfoMap[provider.keyName]?['list']?.length <
            totalDataCount) {
      provider.eitherFailureOrMainInfo(
        mainInfoParams: MainInfoParams(
          majorId: widget.majorId,
          mediumId: widget.mediumId,
          minorId: widget.minorId,
        ),
      );
    }
  }
}
