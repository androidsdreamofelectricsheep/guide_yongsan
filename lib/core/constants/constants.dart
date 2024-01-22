const baseUrl = 'http://apis.data.go.kr/3020000/yongsanLife';

const serviceKey =
    'CGqVq4vrV65NrolvVK2t5jcZyyQ848DFr3aDmZ5ntVXBPLBfEO9vHeCSAhgUPzAg8ErX4vz2NDT6dCFclDeP2w%3D%3D';

const returnType = 'json';

const global = 'en';

const majorCategory = 'majorId';

const mediumCategory = 'mediumId';

const mainInfo = 'mainInfo';

const companyDetailInfo = 'companyDetailInfo';

const minorIdParam = 'minorId';

const necessaryParams =
    'serviceKey=$serviceKey&returnType=$returnType&global=$global';

const companyIdParam = 'companyId';

const numOfRowsParam = 'numOfRows';

const numOfRows = 20;

const pageNo = 1;

const pageNoParam = 'pageNo';

const cachedMajorCategory = 'CACHED_MAJOR_CATEGORY';

const cachedMediumCategory = 'CACHED_MEDIUM_CATEGORY';

const cachedMainInfo = 'CACHED_MAIN_INFO';

const cachedCompanyDetail = 'CACHED_COMPANY_DETAIL';

const serverFailureMsg = 'Server failure occured';

const cacheFailureMsg = 'No local data found';


// http://apis.data.go.kr/3020000/yongsanLife/companyDetailInfo?serviceKey=CGqVq4vrV65NrolvVK2t5jcZyyQ848DFr3aDmZ5ntVXBPLBfEO9vHeCSAhgUPzAg8ErX4vz2NDT6dCFclDeP2w%3D%3D&returnType=json&global=en&companyId=2021ACC91DD931EA4652B20D997E8BF27DE7