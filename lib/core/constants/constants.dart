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

const likedPlaces = 'likedPlaces';

// http://apis.data.go.kr/3020000/yongsanLife/companyDetailInfo?serviceKey=CGqVq4vrV65NrolvVK2t5jcZyyQ848DFr3aDmZ5ntVXBPLBfEO9vHeCSAhgUPzAg8ErX4vz2NDT6dCFclDeP2w%3D%3D&returnType=json&global=en&companyId=2021ACC91DD931EA4652B20D997E8BF27DE7

const subCategory = {
  'Public institutions': [
    {'subId': '001', 'subName': 'Yongsan Gu Office'},
    {'subId': '002', 'subName': 'Community Service Center'},
    {'subId': '003', 'subName': 'Embassy'},
    {'subId': '004', 'subName': 'Police Station'},
    {'subId': '005', 'subName': 'Police Precinct'},
    {'subId': '006', 'subName': 'Police Substation'},
    {'subId': '007', 'subName': 'Police Box'},
    {'subId': '008', 'subName': 'Library'},
    {'subId': '009', 'subName': 'Fire Station'},
    {'subId': '010', 'subName': 'Fire Safety Center'},
    {'subId': '011', 'subName': 'Post Office'},
    {'subId': '012', 'subName': 'Immigration Office'},
    {'subId': '015', 'subName': 'Public Health Center'},
    {'subId': '016', 'subName': 'Community Health Center'},
    {'subId': '017', 'subName': 'Global Village Center(Itaewon, Ichon)'},
    {'subId': '018', 'subName': 'National Health Insurance Service Center'},
    {'subId': '019', 'subName': 'Tax Office'},
    {'subId': '020', 'subName': 'Pension Insurance Corporation'},
    {'subId': '022', 'subName': 'Yongsan Youth Training Center'},
    {'subId': '023', 'subName': 'Yongsan Family Support Center'},
  ],
  'Public Facility': [
    {'subId': '001', 'subName': 'Public Restroom'},
    {'subId': '002', 'subName': 'Bicycle Parking'},
    {'subId': '003', 'subName': 'Civil Service Issuing Machine'},
  ],
  'Restaurant': [
    {'subId': '001', 'subName': 'Korean food'},
    {'subId': '002', 'subName': 'Western food'},
    {'subId': '003', 'subName': 'Chinese food'},
    {'subId': '004', 'subName': 'Japanese food'},
    {'subId': '005', 'subName': 'Southeast Asian food'},
    {'subId': '006', 'subName': 'ASEAN food'},
    {'subId': '007', 'subName': 'Halal food'},
  ],
  'Pub': [
    {'subId': '001', 'subName': 'Draft-beer bar'},
    {'subId': '002', 'subName': 'Bar'},
    {'subId': '003', 'subName': 'Karaoke'},
  ],
  'Cafe': [
    {'subId': '001', 'subName': 'Cafe'},
    {'subId': '002', 'subName': 'Brunch'},
    {'subId': '003', 'subName': 'Dessert'},
    {'subId': '004', 'subName': 'Bakery'},
    {'subId': '005', 'subName': 'Kids Cafe'},
  ],
  'Accommodation': [
    {'subId': '001', 'subName': 'Guest house'},
    {'subId': '002', 'subName': 'Motel'},
    {'subId': '003', 'subName': 'Hotel'},
  ],
  'Mart': [
    {'subId': '001', 'subName': 'Mono Mart'},
    {'subId': '002', 'subName': 'Supermarket'},
    {'subId': '003', 'subName': 'Grocery Store'},
    {'subId': '004', 'subName': 'Corner Shop'},
    {'subId': '005', 'subName': 'Convenience Store'},
  ],
  'Traffic': [
    {'subId': '001', 'subName': 'Subway'},
    {'subId': '002', 'subName': 'KTX'},
  ],
  'Jewelry': [
    {'subId': '001', 'subName': 'Precious metal'},
    {'subId': '002', 'subName': 'Accessories'},
  ],
  'Residence': [
    {'subId': '001', 'subName': 'Moving Company'},
    {'subId': '002', 'subName': 'Floor Heater'},
    {'subId': '003', 'subName': 'Plumbing/Air Conditioner'},
    {'subId': '004', 'subName': 'Gas Service/Water Supply'},
    {'subId': '005', 'subName': 'Real Estate Agency'},
    {'subId': '006', 'subName': 'Furniture'},
    {'subId': '007', 'subName': 'Interior'},
  ],
  'Beauty': [
    {'subId': '001', 'subName': 'Beauty Parlor'},
    {'subId': '002', 'subName': 'Barber Shop'},
    {'subId': '003', 'subName': 'Nail Art'},
    {'subId': '004', 'subName': 'Spa'},
    {'subId': '005', 'subName': 'Waxing'},
  ],
  'Photography': [
    {'subId': '001', 'subName': 'Photo Studio'},
  ],
  'Shopping': [
    {'subId': '001', 'subName': 'Alterations & Tailoring'},
    {'subId': '002', 'subName': 'Shoe Repair'},
    {'subId': '003', 'subName': 'Shoes'},
    {'subId': '004', 'subName': 'Clothing'},
    {'subId': '005', 'subName': 'Optical Eyewear'},
    {'subId': '006', 'subName': 'Sunglasses'},
  ],
  'Legal Service/Administration': [
    {'subId': '001', 'subName': 'Administrator'},
    {'subId': '002', 'subName': 'Translation'},
    {'subId': '003', 'subName': 'Notarization'},
    {'subId': '004', 'subName': 'Law Firm'},
  ],
  'Mobile Phone/Cable TV': [
    {'subId': '001', 'subName': 'Mobile phone store'},
    {'subId': '002', 'subName': 'Mobile phone accessories'},
    {'subId': '003', 'subName': 'Mobile phone repair'},
    {'subId': '004', 'subName': 'Used phone'},
    {'subId': '005', 'subName': 'Cable TV'},
  ],
  'Living facilities': [
    {'subId': '001', 'subName': 'Household goods store'},
    {'subId': '002', 'subName': 'General Merchant store'},
    {'subId': '003', 'subName': 'Dry Cleaning/Laundromat'},
    {'subId': '004', 'subName': 'Baths'},
  ],
  'Hospital': [
    {'subId': '001', 'subName': 'General hospital'},
    {'subId': '002', 'subName': 'Korean medical Clinic'},
    {'subId': '003', 'subName': 'Internal medicine'},
    {'subId': '004', 'subName': 'ENT Clinic'},
    {'subId': '005', 'subName': 'Dentist'},
    {'subId': '006', 'subName': 'Pediatrics and adolescents'},
    {'subId': '007', 'subName': 'Family medicine'},
    {'subId': '008', 'subName': 'Eye Clinic'},
    {'subId': '009', 'subName': 'OB-GYNs'},
    {'subId': '010', 'subName': 'Dermatology'},
    {'subId': '011', 'subName': 'General Surgery'},
    {'subId': '012', 'subName': 'Urology'},
    {'subId': '013', 'subName': 'Preveitive Medicine'},
    {'subId': '014', 'subName': 'Rehabilitation'},
    {'subId': '015', 'subName': 'Anesthesia and Pain Medicine'},
    {'subId': '016', 'subName': 'Mental Clinic'},
  ],
  'Pharmacy': [
    {'subId': '001', 'subName': 'Pharmacy'},
  ],
  'School': [
    {'subId': '001', 'subName': 'Foreigners\'s School'},
    {'subId': '004', 'subName': 'Elementary school'},
    {'subId': '005', 'subName': 'Middle School'},
    {'subId': '006', 'subName': 'High School'},
    {'subId': '007', 'subName': 'Kindergarten'},
  ],
  'Academy': [
    {'subId': '001', 'subName': 'Language School'},
    {'subId': '003', 'subName': 'English Academy'},
    {'subId': '004', 'subName': 'Dance Ballet'},
    {'subId': '005', 'subName': 'Art academy'},
    {'subId': '006', 'subName': 'Baduk'},
    {'subId': '007', 'subName': 'Sports'},
    {'subId': '008', 'subName': 'Yoga'},
    {'subId': '009', 'subName': 'Driving School'},
    {'subId': '010', 'subName': 'Practical Music Academy'},
    {'subId': '011', 'subName': 'Car Maintenance'},
    {'subId': '012', 'subName': 'Confectionery Baking'},
    {'subId': '013', 'subName': 'Vocational Technical Academy'},
    {'subId': '014', 'subName': 'Gymnastics Class'},
    {'subId': '015', 'subName': 'Piano'},
    {'subId': '016', 'subName': 'Guitar'},
  ],
  'Tour': [
    {'subId': '001', 'subName': 'Park'},
    {'subId': '002', 'subName': 'Historic site'},
    {'subId': '003', 'subName': 'Tourist Attraction'},
    {'subId': '004', 'subName': 'Tourist Information Center'},
    {'subId': '005', 'subName': 'Museum'},
    {'subId': '006', 'subName': 'Memorial Hall'},
    {'subId': '007', 'subName': 'Sale Promotion/Souvenir'},
    {'subId': '008', 'subName': 'Regional Specialties/Folk Art Crafts'},
  ],
  'Sports': [
    {'subId': '001', 'subName': 'Golf'},
    {'subId': '002', 'subName': 'Billiards'},
    {'subId': '003', 'subName': 'Boxing'},
    {'subId': '004', 'subName': 'Kendo'},
    {'subId': '005', 'subName': 'Judo'},
    {'subId': '006', 'subName': 'Taekwondo'},
    {'subId': '007', 'subName': 'Aikido'},
    {'subId': '008', 'subName': 'Gym'},
    {'subId': '009', 'subName': 'Swimming'},
  ],
  'Culture': [
    {'subId': '001', 'subName': 'Bookstore'},
    {'subId': '002', 'subName': 'Arcade Game'},
    {'subId': '003', 'subName': 'Concert hall'},
    {'subId': '005', 'subName': 'Karaoke'},
    {'subId': '006', 'subName': 'Internet Cafe'},
  ],
  'Yongsan Electronics Market': [
    {'subId': '001', 'subName': 'Home Appliances'},
    {'subId': '002', 'subName': 'Cameras'},
    {'subId': '003', 'subName': 'Imported Audio'},
    {'subId': '004', 'subName': 'Electronic Parts'},
    {'subId': '005', 'subName': 'Computers'},
    {'subId': '006', 'subName': 'Audio/Video'},
    {'subId': '007', 'subName': 'External Device'},
    {'subId': '008', 'subName': 'Communication Device'},
    {'subId': '009', 'subName': 'Game Device'},
    {'subId': '010', 'subName': 'Entertainment/Life'},
    {'subId': '011', 'subName': 'Music Record'},
    {'subId': '012', 'subName': '4th industry'},
    {'subId': '013', 'subName': 'F&B'},
    {'subId': '014', 'subName': 'Hospital'},
    {'subId': '015', 'subName': 'Office'},
    {'subId': '016', 'subName': 'etc'},
  ],
  'Seonin Shopping Center': [
    {'subId': '001', 'subName': 'Home Appliances'},
    {'subId': '003', 'subName': 'Imported Audio'},
    {'subId': '004', 'subName': 'Electronic Parts'},
    {'subId': '005', 'subName': 'Computers'},
    {'subId': '006', 'subName': 'Audio/Video'},
    {'subId': '007', 'subName': 'External Device'},
    {'subId': '008', 'subName': 'Communication Device'},
    {'subId': '013', 'subName': 'F&B'},
    {'subId': '015', 'subName': 'Office'},
    {'subId': '016', 'subName': 'etc'},
  ],
  'Wonhyo Shopping Center': [
    {'subId': '001', 'subName': 'Home Appliances'},
    {'subId': '002', 'subName': 'Cameras'},
    {'subId': '003', 'subName': 'Imported Audio'},
    {'subId': '004', 'subName': 'Electronic Parts'},
    {'subId': '005', 'subName': 'Computers'},
    {'subId': '006', 'subName': 'Audio/Video'},
    {'subId': '007', 'subName': 'External Device'},
    {'subId': '008', 'subName': 'Communication Device'},
    {'subId': '009', 'subName': 'Game Device'},
    {'subId': '010', 'subName': 'Entertainment/Life'},
    {'subId': '011', 'subName': 'Music Record'},
    {'subId': '013', 'subName': 'F&B'},
    {'subId': '015', 'subName': 'Office'},
    {'subId': '016', 'subName': 'etc'},
  ],
  'Najin Shopping Center': [
    {'subId': '001', 'subName': 'Home Appliances'},
    {'subId': '004', 'subName': 'Electronic Parts'},
    {'subId': '005', 'subName': 'Computers'},
    {'subId': '006', 'subName': 'Audio/Video'},
    {'subId': '007', 'subName': 'External Device'},
    {'subId': '008', 'subName': 'Communication Device'},
    {'subId': '010', 'subName': 'Entertainment/Life'},
    {'subId': '013', 'subName': 'F&B'},
    {'subId': '016', 'subName': 'etc'},
  ],
  'Yongmun Market': [
    {'subId': '001', 'subName': 'Restaurant/Food'},
    {'subId': '002', 'subName': 'Seafood'},
    {'subId': '003', 'subName': 'Clothing/General Merchandise'},
    {'subId': '004', 'subName': 'Daily Necessities'},
    {'subId': '005', 'subName': 'Agricultural Products/Fruits'},
    {'subId': '006', 'subName': 'Mart/Food'},
    {'subId': '008', 'subName': 'Meat Shop'},
    {'subId': '011', 'subName': 'Living Services'},
    {'subId': '012', 'subName': 'etc'},
  ],
  'Huam Market': [
    {'subId': '001', 'subName': 'Restaurant/Food'},
    {'subId': '002', 'subName': 'Seafood'},
    {'subId': '003', 'subName': 'Clothing/General Merchandise'},
    {'subId': '004', 'subName': 'Daily Necessities'},
    {'subId': '005', 'subName': 'Agricultural Products/Fruits'},
    {'subId': '006', 'subName': 'Mart/Food'},
    {'subId': '007', 'subName': 'Electricity/Home appliance'},
    {'subId': '008', 'subName': 'Meat Shop'},
    {'subId': '009', 'subName': 'Bedclothes'},
    {'subId': '011', 'subName': 'Living Services'},
    {'subId': '012', 'subName': 'etc'},
  ],
  'Manri Market': [
    {'subId': '001', 'subName': 'Restaurant/Food'},
    {'subId': '002', 'subName': 'Seafood'},
    {'subId': '003', 'subName': 'Clothing/General Merchandise'},
    {'subId': '004', 'subName': 'Daily Necessities'},
    {'subId': '005', 'subName': 'Agricultural Products/Fruits'},
    {'subId': '006', 'subName': 'Mart/Food'},
    {'subId': '008', 'subName': 'Meat Shop'},
    {'subId': '009', 'subName': 'Bedclothes'},
    {'subId': '011', 'subName': 'Living Services'},
    {'subId': '012', 'subName': 'etc'},
  ],
  'Ichon Market': [
    {'subId': '001', 'subName': 'Restaurant/Food'},
    {'subId': '003', 'subName': 'Clothing/General Merchandise'},
    {'subId': '004', 'subName': 'Daily Necessities'},
    {'subId': '005', 'subName': 'Agricultural Products/Fruits'},
    {'subId': '006', 'subName': 'Mart/Food'},
    {'subId': '007', 'subName': 'Electricity/Home appliance'},
    {'subId': '008', 'subName': 'Meat Shop'},
    {'subId': '011', 'subName': 'Living Services'},
    {'subId': '012', 'subName': 'etc'},
  ],
  'Shin Heung Market': [
    {'subId': '001', 'subName': 'Restaurant/Food'},
    {'subId': '002', 'subName': 'Seafood'},
    {'subId': '003', 'subName': 'Clothing/General Merchandise'},
    {'subId': '004', 'subName': 'Daily Necessities'},
    {'subId': '005', 'subName': 'Agricultural Products/Fruits'},
    {'subId': '006', 'subName': 'Mart/Food'},
    {'subId': '008', 'subName': 'Meat Shop'},
    {'subId': '009', 'subName': 'Bedclothes'},
    {'subId': '011', 'subName': 'Living Services'},
    {'subId': '012', 'subName': 'etc'},
  ],
  'Bokwang Market': [
    {'subId': '001', 'subName': 'Restaurant/Food'},
    {'subId': '003', 'subName': 'Clothing/General Merchandise'},
    {'subId': '005', 'subName': 'Agricultural Products/Fruits'},
    {'subId': '006', 'subName': 'Mart/Food'},
    {'subId': '009', 'subName': 'Bedclothes'},
    {'subId': '010', 'subName': 'Entertainment/Life'},
    {'subId': '011', 'subName': 'Living Services'},
    {'subId': '012', 'subName': 'etc'},
  ],
  'I\'Park Mall': [
    {'subId': '001', 'subName': 'Fashion Clothing'},
    {'subId': '002', 'subName': 'Fashion Accessories'},
    {'subId': '003', 'subName': 'Beauty/Hair'},
    {'subId': '004', 'subName': 'Lifestyle'},
    {'subId': '005', 'subName': 'Culture/Leisure'},
    {'subId': '006', 'subName': 'Cafe/Restaurant'},
    {'subId': '007', 'subName': 'Life Amenities'},
    {'subId': '008', 'subName': 'Service'},
  ],
  'Lotte Outlet Seoul Station': [
    {'subId': '001', 'subName': 'Fashion Accessories'},
    {'subId': '002', 'subName': 'Women\'s Fashion'},
    {'subId': '003', 'subName': 'Men\'s Fashion'},
    {'subId': '004', 'subName': 'Overseas Brand'},
    {'subId': '005', 'subName': 'Young Fashion'},
    {'subId': '006', 'subName': 'Cosmetics'},
    {'subId': '007', 'subName': 'Outdoor/Sports'},
    {'subId': '008', 'subName': 'Living'},
    {'subId': '009', 'subName': 'Kids/Baby'},
  ],
};
