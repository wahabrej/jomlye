import 'package:vidflix_flutter_app/controllers/common/sp_controller.dart';
import 'package:vidflix_flutter_app/models/common/common_data_model.dart';
import 'package:vidflix_flutter_app/models/common/common_error_model.dart';
import 'package:vidflix_flutter_app/models/home/home_data_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/artist/artist_details_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/artist/artist_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/blog/blog_details_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/blog/filter_blog_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/blog/blog_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/movie/filter_movie_list_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/movie/movie_list_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/tv_shows/tv_shows_model.dart';
import 'package:vidflix_flutter_app/services/api_services.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/utils/constants/urls.dart';

class HomeController extends GetxController {
    final SpController spController = SpController();
  final ApiServices apiServices = ApiServices();
  var currentIndex = 0.obs;
  final RxString selectedTitle = RxString(""); 

  //* Top Artist
  final RxBool isTopArtistSearchEnable = RxBool(false);
  final TextEditingController topArtistTextEditingController = TextEditingController();
  final RxBool isTopArtistSearchSuffixShow = RxBool(false);
  //* blog
  final RxString selectedGenre = RxString("");
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


  //!Common Search
  final TextEditingController searchTextEditingController = TextEditingController();
  final RxBool isSearchSuffixIconShow = RxBool(false);
  //! Cast details screen
  final RxInt selectedIndex = RxInt(0); // Default selected index
  final List<String> tabs = ["Movies", "Personal Information"];

  void changeTab(int index) {
    selectedIndex.value = index;
  }
  final RxDouble lowerValue = RxDouble(0);
  final RxDouble upperValue = RxDouble(0);

  //!Home Api implement
  //*Home
  final Rx<HomeDataModel?> homeDataModel = Rx<HomeDataModel?>(null);
  final RxList<NewReleaseMovie> sliderList = RxList<NewReleaseMovie>([]);
  final RxList<Genre> genreList = RxList<Genre>([]);
  final RxList<NewReleaseMovie> newReleaseMoviesList = RxList<NewReleaseMovie>([]);
  final RxList<NewReleaseMovie> trendingMoviesList = RxList<NewReleaseMovie>([]);
  final RxList<NewReleaseMovie> recommendedMoviesList = RxList<NewReleaseMovie>([]);
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
        recommendedMoviesList.clear();
        popularTvShowsList.clear();
        featuredTvChannelsList.clear();
        tvShowsList.clear();
        topArtistsList.clear();
        latestBlogsList.clear();
        sliderList.addAll(homeDataModel.slider!);
        genreList.addAll(homeDataModel.genres!);
        newReleaseMoviesList.addAll(homeDataModel.newReleaseMovies!);
        trendingMoviesList.addAll(homeDataModel.trendingMovies!);
        recommendedMoviesList.addAll(homeDataModel.recommendedMovies!);
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


  //!Movie
  final RxInt selectedMovieCategoryId = RxInt(-1);
  final RxInt selectedMovieCountryId = RxInt(-1);
  final RxInt selectedMovieGenreId = RxInt(-1);
  final RxInt selectedMovieLanguageId = RxInt(-1);
  final RxString selectedMovieYear = RxString("");
  // all movie api implement
  final RxBool isMovieListLoading = RxBool(false);
  final Rx<MovieListModel?> movieListModel = Rx<MovieListModel?>(null);
  final RxList<MovieData?> movieList = RxList<MovieData?>([]);
  final RxList<Categories?> movieCategoryList = RxList<Categories?>([]);
  final RxList<Countries?> movieCountryList = RxList<Countries?>([]);
  final RxList<Countries?> movieLanguageList = RxList<Countries?>([]);
  final RxList<Countries?> movieGenreList = RxList<Countries?>([]);
  final RxList<int> movieYearList = RxList<int>([]);
  final RxMap<String, String> movieSort = RxMap<String, String>();
  Future<void> getMovieList({required String movieType}) async {
    try {
      isMovieListLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuMovies?type=$movieType",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        movieList.clear();
        movieCategoryList.clear();
        movieCountryList.clear();
        movieLanguageList.clear();
        movieGenreList.clear();
        movieYearList.clear();
        MovieListModel movieListModel = MovieListModel.fromJson(response.data);
        movieList.addAll(movieListModel.movies!.data!);
        movieCategoryList.addAll(movieListModel.filter!.categories!);
        movieCountryList.addAll(movieListModel.filter!.country!);
        movieLanguageList.addAll(movieListModel.filter!.languages!);
        movieGenreList.addAll(movieListModel.filter!.genre!);
        movieYearList.addAll(movieListModel.filter!.year!);
        isMovieListLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isMovieListLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isMovieListLoading.value = false;
      ll('getMovieList error: $e');
    }
  }
  final Rx<FilterMovieListModel?> filterMovieListModel = Rx<FilterMovieListModel?>(null);
  Future<void> getFilterMovieList() async {
    try {
      isMovieListLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuMovieFilter?string=&category_id=${selectedMovieCategoryId.value!=-1 ? selectedMovieCategoryId.value.toString():""}&genre=${selectedMovieGenreId.value!=-1 ? selectedMovieGenreId.value.toString():""}&country_id=${selectedMovieCountryId.value!=-1 ? selectedMovieCountryId.value.toString():""}&year=${selectedMovieYear.value.toString()}&language_id=${selectedMovieLanguageId.value!=-1 ? selectedMovieLanguageId.value.toString():""}",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        movieList.clear();
        FilterMovieListModel filterMovieListModel = FilterMovieListModel.fromJson(response.data);
        movieList.addAll(filterMovieListModel.movies!.data!);
        Get.back();
        isMovieListLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isMovieListLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isMovieListLoading.value = false;
      ll('getMovieList error: $e');
    }
  }

    //!Tv Shows
    //tv shows api implement
  final RxBool isTvShowLoading = RxBool(false);
  final Rx<TvShowsModel?> tvShowsModel = Rx<TvShowsModel?>(null);
  final RxList<TvShowData?> tvShowList = RxList<TvShowData?>([]);
  final RxList<Categories?> tvShowsCategoryList = RxList<Categories?>([]);
  final RxList<Countries?> tvShowCountryList = RxList<Countries?>([]);
  final RxList<Countries?> tvShowLanguageList = RxList<Countries?>([]);
  final RxList<Countries?> tvShowGenreList = RxList<Countries?>([]);
  final RxList<int> tvShowYearList = RxList<int>([]);
  final RxMap<String, String> tvShowSort = RxMap<String, String>();
  Future<void> getTvShows() async {
    try {
      isTvShowLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuTvShows,
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        tvShowList.clear();
        tvShowsCategoryList.clear();
        tvShowCountryList.clear();
        tvShowLanguageList.clear();
        tvShowGenreList.clear();
        tvShowYearList.clear();
        TvShowsModel tvShowsModel = TvShowsModel.fromJson(response.data);
        // blogDetails.value = blogDetailsModel.details;
        // blogCategories.value = blogDetailsModel.category;
        tvShowList.addAll(tvShowsModel.shows!.data!);
        tvShowsCategoryList.addAll(tvShowsModel.filter!.categories!);
        tvShowCountryList.addAll(tvShowsModel.filter!.country!);
        tvShowLanguageList.addAll(tvShowsModel.filter!.languages!);
        tvShowGenreList.addAll(tvShowsModel.filter!.genre!);
        tvShowYearList.addAll(tvShowsModel.filter!.year!);
        isTvShowLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isTvShowLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isTvShowLoading.value = false;
      ll('getTvShows error: $e');
    }
  }

   //!Top Artist
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
        url: "$kuArtist?name=${topArtistTextEditingController.text}",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        artistList.clear();
        ArtistModel artistModel = ArtistModel.fromJson(response.data);
        artistList.addAll(artistModel.artists!.data!);
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
  final Rx<Blogs?> blogs = Rx<Blogs?>(null);
  final RxList<Categories> blogCategoryList = RxList<Categories>([]);
  final RxList<BlogData> blogList = RxList<BlogData>([]);
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
        blogCategoryList.clear();
        blogYearList.clear();
        blogList.clear();
        blogs.value = blogModel.blogs;
        blogList.addAll(blogModel.blogs!.data!);
        ll("The blog filter category data is ${blogModel.filter!.categories}");
        ll("The blog filter category data length is ${blogModel.filter!.categories!.length}");
        blogCategoryList.addAll(blogModel.filter!.categories!);
        blogYearList.addAll(blogModel.filter!.year!);
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
        blogList.addAll(filterBlogModel.details!.data!);
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
      ll('getBlogDetails error: $e');
    }
  }

}
