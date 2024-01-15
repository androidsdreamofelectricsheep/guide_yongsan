class ResponseEntity {
  final Header header;
  final Body body;
  final TotalCount totalCount;

  ResponseEntity(
      {required this.header, required this.body, required this.totalCount});
}

class Body<T> {
  final ItemList<T> item;

  Body({required this.item});
}

class Header {
  final String resultCode;
  final String resultMsg;

  Header({required this.resultCode, required this.resultMsg});
}

class ItemList<T> {
  final List<T> itemList;

  ItemList({required this.itemList});
}

class TotalCount {
  final int totalCount;

  TotalCount({required this.totalCount});
}

class NumOfRows {
  final int? numOfRows;

  NumOfRows({this.numOfRows});
}

class PageNo {
  final int? pageNo;

  PageNo({this.pageNo});
}
