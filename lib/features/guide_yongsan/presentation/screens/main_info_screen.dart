import 'package:flutter/material.dart';

import 'package:guide_yongsan/core/params/params.dart';

import 'package:guide_yongsan/features/guide_yongsan/presentation/providers/main_info_provider.dart';
import 'package:guide_yongsan/features/guide_yongsan/presentation/widgets/main_info_widget.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainInfoScreen extends StatefulWidget {
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initLoad();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _initLoad() {
    Future.microtask(() async {
      sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        spInit = true;
      });
    });

    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // if (context.read<MainInfoProvider>().mainInfo.isEmpty) {
      // if (!context.read<MainInfoProvider>().loading &&
      //     context
      //             .read<MainInfoProvider>()
      //             .mainInfoMap[widget.minorId]['list']
      //             .length <
      //         1) {

      context.read<MainInfoProvider>().eitherFailureOrMainInfo(
              mainInfoParams: MainInfoParams(
            majorId: widget.majorId,
            mediumId: widget.mediumId,
            minorId: widget.minorId,
          ));
      // }
    });
  }

  int getItemCount(MainInfoProvider provider) {
    return provider.mainInfoMap[provider.minorId]?['list']?.length +
        (provider.loading ? 1 : 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.subName)),
        body: SafeArea(
          child:
              Consumer<MainInfoProvider>(builder: (context, provider, widget) {
            if (provider.mainInfoMap[provider.minorId]?['list']! != null) {
              return ListView.separated(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                itemCount: getItemCount(provider),
                itemBuilder: (context, index) => buildItem(provider, index),
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

  Widget buildItem(MainInfoProvider provider, int index) {
    if (provider.mainInfoMap[widget.minorId]?['list'] != null &&
        index < provider.mainInfoMap[widget.minorId]?['list']?.length &&
        provider.failure == null) {
      return MainInfoWidget(
        majorId: widget.majorId,
        mediumId: widget.mediumId,
        minorId: widget.minorId,
        subName: widget.subName,
        num: provider.mainInfoMap[widget.minorId]['list'][index].num.toString(),
        companyId:
            provider.mainInfoMap[widget.minorId]['list']?[index].companyId,
        companyName:
            provider.mainInfoMap[widget.minorId]['list']?[index].companyName ??
                '',
        addr: provider.mainInfoMap[widget.minorId]['list']?[index].addr ?? '',
        addrDetail:
            provider.mainInfoMap[widget.minorId]['list']?[index].addrDetail ??
                '',
        keyWord:
            provider.mainInfoMap[widget.minorId]['list']?[index].keyWord ?? '',
        addrId: provider.mainInfoMap[widget.minorId]['list']?[index].addrId,
        phone: provider.mainInfoMap[widget.minorId]['list']?[index].phone ?? '',
        zipCode:
            provider.mainInfoMap[widget.minorId]['list']?[index].zipCode ?? '',
        pointLng: provider.mainInfoMap[widget.minorId]['list']?[index].pointLng,
        pointLat: provider.mainInfoMap[widget.minorId]['list']?[index].pointLat,
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
        provider.mainInfoMap[widget.minorId]?['list']?.length <
            totalDataCount) {
      provider.eitherFailureOrMainInfo(
          mainInfoParams: MainInfoParams(
        majorId: widget.majorId,
        mediumId: widget.mediumId,
        minorId: widget.minorId,
      ));
    }
  }
}
