import 'package:vidflix_flutter_app/controllers/common/sp_controller.dart';
import 'package:vidflix_flutter_app/models/common/common_data_model.dart';
import 'package:vidflix_flutter_app/models/common/common_error_model.dart';
import 'package:vidflix_flutter_app/models/home/home_data_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/artist/artist_details_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/artist/artist_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/blog/blog_details_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/blog/blog_filter_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/blog/blog_model.dart';
import 'package:vidflix_flutter_app/services/api_services.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/utils/constants/urls.dart';

class HomeController extends GetxController {
    final SpController spController = SpController();
  final ApiServices apiServices = ApiServices();
  var currentIndex = 0.obs;
  final RxString selectedTitle = RxString(""); 

  // final List<Map<String, dynamic>> sliderImages = [
  //   {
  //     'url':
  //         'https://images.unsplash.com/photo-1485846234645-a62644f84728?q=80&w=2059&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //     'title': 'The Dune Special',
  //     'tags': ['Action', 'Trending', '2024'],
  //   },
  //   {
  //     'url':
  //         'https://images.unsplash.com/photo-1485846234645-a62644f84728?q=80&w=2059&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //     'title': 'Another Movie',
  //     'tags': ['Adventure', 'New', '2025'],
  //   },
  //   {
  //     'url':
  //         'https://images.unsplash.com/photo-1485846234645-a62644f84728?q=80&w=2059&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  //     'title': 'Sci-Fi Saga',
  //     'tags': ['Sci-Fi', 'Blockbuster', '2023'],
  //   },
  // ];

  // final RxList genreList =
  //     RxList(["All", "Action", "War", "Hollywood", "Live", "Movie"]);
      //* blog
  final RxString selectedGenre = RxString("");
  // final RxList blogCategoriesList =
  //     RxList(["News", "Entertainment", "Sport", "Cartoon", "Movie", "Tennis", "Archary"]);
  final RxString selectedBlogCategories = RxString("");
  final RxString selectedBlogCategoryId = RxString("");
  final RxString selectedYear = RxString("");
  final RxList languageList =
      RxList(["Bangla", "Hindi", "English", "Urdu", "Korean", "Tamil", "Arabic"]);
  final RxString selectedLanguage = RxString("");
  final RxList sortList =
      RxList(["Most Popular", "Top Blogs", "Most Read", "Top View", "Top Rated"]);
  final RxString selectedSort = RxString("");

    void blogFilterValueReset(){
    selectedBlogCategories.value ="";
    selectedYear.value = "";
    selectedLanguage.value = "";
    selectedSort.value = "";
  }

 //* top  artists
    final RxList artistsCategoriesList =
      RxList(["Hollywood", "Bollywood", "Dhaliwood", "Taliwood", "Hindi"]);
  final RxString selectedArtistsCategories = RxString("");
    final RxList artistsCountryList =
      RxList(["USA", "Canada", "Turkey", "Pakistan", "Korean","Indian","Bangladeshi"]);
  final RxString selectedArtistsCountry = RxString("");
    final RxList artistsSortList =
      RxList(["Most Popular", "Top Demanded", "Best Actor", "Top Rated", "Top Viewed"]);
  final RxString selectedArtistsSort = RxString("");

      void artistsFilterValueReset(){
    selectedArtistsCategories.value ="";
    selectedArtistsCountry.value = "";
    selectedLanguage.value = "";
    selectedArtistsSort.value = "";
  }

  //* Tv Channel
      final RxList tvChannelCategoriesList =
      RxList(["News", "Drama", "Songs", "Game", "Movies","Sports", "Cricket", "Football"]);
  final RxString selectedTvChannelCategories = RxString("");
    final RxList tvChannelsSortList =
      RxList(["Most Popular", "Top View", "New Add", "Top View", "Top Viewed"]);
  final RxString selectedTvChannelsSort = RxString("");

      void tvChannelsFilterValueReset(){
    selectedArtistsCategories.value ="";
    selectedArtistsCountry.value = "";
    selectedLanguage.value = "";
    selectedArtistsSort.value = "";
  }

  final RxList<Map<String, dynamic>> recentPlayedMovies =
      RxList<Map<String, dynamic>>([
    {
      "imageUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "title": "The Bad Boys",
      "duration": "2 hr 20 mins",
    },
    {
      "imageUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "title": "The Bad Boys",
      "duration": "2 hr 20 mins",
    },
    {
      "imageUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "title": "The Bad Boys",
      "duration": "2 hr 20 mins",
    },
    {
      "imageUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "title": "The Bad Boys",
      "duration": "2 hr 20 mins",
    },
  ]);

    final RxList<Map<String, dynamic>> viewAllMovieList =
      RxList<Map<String, dynamic>>([
    {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": false,
      "isSeason": true,
      "season": "Season 1"
    },
    {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": true,
      "isSeason": true,
      "season": "Season 2"
    },
    {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": true,
      "isSeason": false,
      "season": "Season 3",
    },
    {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": false,
      "isSeason": false,
      "season": "Season 1",
    },
        {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": false,
      "isSeason": true,
      "season": "Season 1"
    },
    {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": true,
      "isSeason": true,
      "season": "Season 2"
    },
    {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": true,
      "isSeason": false,
      "season": "Season 3",
    },
    {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": false,
      "isSeason": false,
      "season": "Season 1",
    },
        {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": false,
      "isSeason": true,
      "season": "Season 1"
    },
    {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": true,
      "isSeason": true,
      "season": "Season 2"
    },
    {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": true,
      "isSeason": false,
      "season": "Season 3",
    },
    {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": false,
      "isSeason": false,
      "season": "Season 1",
    },
        {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": false,
      "isSeason": true,
      "season": "Season 1"
    },
    {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": true,
      "isSeason": true,
      "season": "Season 2"
    },
    {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": true,
      "isSeason": false,
      "season": "Season 3",
    },
    {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": false,
      "isSeason": false,
      "season": "Season 1",
    },
  ]);

  final RxList blogBulletPointList = RxList([
    "Sed mattis risus vel lectus faucibus, lobortis tristique dolor consequat.",
    "Praesent interdum mauris sit amet sapien rutrum, non pellentesque urna fermentum.",
    "Morbi ultricies lectus eget erat lobortis, ut semper sapien porttitor.",
    "Quisque quis purus sit amet augue imperdiet elementum id fringilla augue.",
  ]);

  void updateCurrentIndex(int index) {
    currentIndex.value = index;
  }

  //!blog
  final TextEditingController addCommentTextEditingController = TextEditingController();


  //!Search
  final TextEditingController searchTextEditingController = TextEditingController();
  final RxBool isSearchSuffixIconShow = RxBool(false);
  //! cast details screen
  final RxInt selectedIndex = RxInt(0); // Default selected index
  final List<String> tabs = ["Movies", "Personal Information"];

  void changeTab(int index) {
    selectedIndex.value = index;
  }
  final RxDouble lowerValue = RxDouble(0);
  final RxDouble upperValue = RxDouble(0);

  //*Home page
  final Rx<HomeDataModel?> homeDataModel = Rx<HomeDataModel?>(null);
  final RxList<NewReleaseMovie> sliderList = RxList<NewReleaseMovie>([]);
  final RxList<Genre> genreList = RxList<Genre>([]);
  final RxList<NewReleaseMovie> newReleaseMoviesList = RxList<NewReleaseMovie>([]);
  final RxList<NewReleaseMovie> trendingMoviesList = RxList<NewReleaseMovie>([]);
  final RxList<NewReleaseMovie> popularTvShowsList = RxList<NewReleaseMovie>([]);
  final RxList<FeaturedTvChannel> featuredTvChannelsList = RxList<FeaturedTvChannel>([]);
  final RxList<NewReleaseMovie> tvShowsList = RxList<NewReleaseMovie>([]);
  final RxList<TopArtist> topArtistsList = RxList<TopArtist>([]);
  final RxList<LatestBlog> latestBlogsList = RxList<LatestBlog>([]);
   final RxBool isHomePageLoading = RxBool(false);
  Future<void> getHomePage() async {
    try {
      isHomePageLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuHome,
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        HomeDataModel homeDataModel = HomeDataModel.fromJson(response.data);
        sliderList.clear();
        genreList.clear();
        newReleaseMoviesList.clear();
        trendingMoviesList.clear();
        popularTvShowsList.clear();
        featuredTvChannelsList.clear();
        tvShowsList.clear();
        topArtistsList.clear();
        latestBlogsList.clear();
        sliderList.addAll(homeDataModel.slider!);
        genreList.addAll(homeDataModel.genres!);
        newReleaseMoviesList.addAll(homeDataModel.newReleaseMovies!);
        trendingMoviesList.addAll(homeDataModel.trendingMovies!);
        popularTvShowsList.addAll(homeDataModel.popularTvShows!);
        featuredTvChannelsList.addAll(homeDataModel.featuredTvChannels!);
        tvShowsList.addAll(homeDataModel.tvShows!);
        topArtistsList.addAll(homeDataModel.topArtists!);
        latestBlogsList.addAll(homeDataModel.latestBlogs!);
        isHomePageLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isHomePageLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(
              title: ksError.tr,
              message: response.message.toString(),
              color: cPrimaryColor2);
        } else {
          showSnackBar(
              title: ksError.tr,
              message: errorModel.errors[0].message,
              color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isHomePageLoading.value = false;
      ll('getHomePage error: $e');
    }
  }

 //!Artist
 //Artist api implement
   final RxBool isArtistLoading = RxBool(false);
   final Rx<ArtistModel?> artistModel = Rx<ArtistModel?>(null);
  final RxList<ArtistData> artistList = RxList<ArtistData>([]);
  Future<void> getArtistList() async {
    try {
      isArtistLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuArtist,
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        ArtistModel artistModel = ArtistModel.fromJson(response.data);
        artistList.clear();
        artistList.addAll(artistModel.data!);
        isArtistLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isArtistLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isArtistLoading.value = false;
      ll('getArtistList error: $e');
    }
  }

   //Artist details api implement
   final RxBool isArtistDetailsLoading = RxBool(false);
   final Rx<ArtistDetailsModel?> artistDetailsModel = Rx<ArtistDetailsModel?>(null);
  final Rx<Details?> artistDetailsData = Rx<Details?>(null);
  final RxList<Movie> artistMovieList = RxList<Movie>([]);
  Future<void> getArtistDetails([int? id]) async {
    try {
      isArtistDetailsLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuArtistDetails?id=${id.toString()}",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        ArtistDetailsModel artistDetailsModel = ArtistDetailsModel.fromJson(response.data);
        artistMovieList.clear();
        artistMovieList.addAll(artistDetailsModel.movies!);
        artistDetailsData.value = artistDetailsModel.details;
        isArtistDetailsLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isArtistDetailsLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isArtistDetailsLoading.value = false;
      ll('getArtistDetails error: $e');
    }
  }

   //!Blogs
 //blog api implement
   final RxBool isBlogLoading = RxBool(false);
   final Rx<BlogModel?> blogModel = Rx<BlogModel?>(null);
  final RxList<Blog> blogList = RxList<Blog>([]);
  final RxList<Categories> blogcategoryList = RxList<Categories>([]);
  final RxList<int> blogYearList = RxList<int>([]);
  Future<void> getBlogList() async {
    try {
      isBlogLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuBlogs,
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        BlogModel blogModel = BlogModel.fromJson(response.data);
        blogList.clear();
        blogcategoryList.clear();
        blogYearList.clear();
        blogList.addAll(blogModel.blogs!);
        blogcategoryList.addAll(blogModel.categories!);
        blogYearList.addAll(blogModel.year!);
        isBlogLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isBlogLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isBlogLoading.value = false;
      ll('getBlogList error: $e');
    }
  }


   //blog api implement
  final RxBool isBlogFilterLoading = RxBool(false);
  final Rx<FilterBlogModel?> filterBlogModel = Rx<FilterBlogModel?>(null);
  // final RxList<FilteredBlogDetail> filteredBlogList = RxList<FilteredBlogDetail>([]);
  Future<void> getBlogFilterList() async {
    try {
      isBlogFilterLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuBlogFilter?string=&category_id=${selectedBlogCategoryId.value.toString()}&year=${selectedYear.value.toString()}",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        FilterBlogModel filterBlogModel = FilterBlogModel.fromJson(response.data);
        blogList.clear();
        blogList.addAll(filterBlogModel.details!);
        isBlogFilterLoading.value = false;
        Get.back();
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isBlogFilterLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isBlogFilterLoading.value = false;
      ll('getBlogFilterList error: $e');
    }
  }

  //blog details api implement
   final RxBool isBlogDetailsLoading = RxBool(false);
   final Rx<BlogDetailsModel?> blogDetailsModel = Rx<BlogDetailsModel?>(null);
  final Rx<Detailes?> blogDetails = Rx<Detailes?>(null);
  final Rx<Categories?> blogCategories = Rx<Categories?>(null);
  // final RxList<Categories> categoryList = RxList<Categories>([]);
  final RxList<Detailes> latestBlogList = RxList<Detailes>([]);
  Future<void> getBlogDetails([int? id]) async {
    try {
      isBlogDetailsLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuBlogDetails?id=${id.toString()}",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        latestBlogList.clear();
        BlogDetailsModel blogDetailsModel = BlogDetailsModel.fromJson(response.data);
        blogDetails.value = blogDetailsModel.details;
        blogCategories.value = blogDetailsModel.category;
        latestBlogList.addAll(blogDetailsModel.latestBlogs!);
        isBlogDetailsLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isBlogDetailsLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isBlogDetailsLoading.value = false;
      ll('getArtistList error: $e');
    }
  }
  
}
