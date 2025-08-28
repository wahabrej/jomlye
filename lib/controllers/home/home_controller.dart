import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flixoo_flutter_app/controllers/common/global_controller.dart';
import 'package:flixoo_flutter_app/controllers/common/sp_controller.dart';
import 'package:flixoo_flutter_app/controllers/video_player/all_video_player_controller.dart';
import 'package:flixoo_flutter_app/helpers/ad_helper.dart';
import 'package:flixoo_flutter_app/models/common/common_data_model.dart';
import 'package:flixoo_flutter_app/models/common/common_error_model.dart';
import 'package:flixoo_flutter_app/models/common/global_search_model.dart';
import 'package:flixoo_flutter_app/models/home/home_data_model.dart';
import 'package:flixoo_flutter_app/models/home/view_all/artist/artist_details_model.dart';
import 'package:flixoo_flutter_app/models/home/view_all/artist/artist_model.dart';
import 'package:flixoo_flutter_app/models/home/view_all/blog/blog_details_model.dart';
import 'package:flixoo_flutter_app/models/home/view_all/blog/filter_blog_model.dart';
import 'package:flixoo_flutter_app/models/home/view_all/blog/blog_model.dart';
import 'package:flixoo_flutter_app/models/home/view_all/movie/filter_movie_list_model.dart';
import 'package:flixoo_flutter_app/models/home/view_all/movie/movie_details_model.dart';
import 'package:flixoo_flutter_app/models/home/view_all/movie/movie_list_model.dart';
import 'package:flixoo_flutter_app/models/home/view_all/tv_channel/tv_channel_details_model.dart';
import 'package:flixoo_flutter_app/models/home/view_all/tv_channel/tv_channel_list_model.dart';
import 'package:flixoo_flutter_app/models/home/view_all/tv_shows/tv_show_filter_model.dart';
import 'package:flixoo_flutter_app/models/home/view_all/tv_shows/tv_shows_details_model.dart';
import 'package:flixoo_flutter_app/models/home/view_all/tv_shows/tv_shows_model.dart';
import 'package:flixoo_flutter_app/models/local_ads_model.dart';
import 'package:flixoo_flutter_app/models/review/review_list_model.dart';
import 'package:flixoo_flutter_app/models/watch_history/watch_history_model.dart';
import 'package:flixoo_flutter_app/services/api_services.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';
import 'package:flixoo_flutter_app/utils/constants/urls.dart';

class HomeController extends GetxController {
  final SpController spController = SpController();
  final ApiServices apiServices = ApiServices();
  var currentIndex = 0.obs;
  final RxString selectedTitle = RxString("");

 //!Ads
  BannerAd? bannerAd;
  RxBool isBannerAdLoaded = false.obs;

  InterstitialAd? interstitialAd;
  RxBool isInterstitialAdLoaded = false.obs;

  @override
  void onInit() async{
    await Get.find<GlobalController>().getConfig();
    super.onInit();
    if(Get.find<GlobalController>().configModelData.value?.bannerAds.toString().toLowerCase()=="admob"){
    loadBannerAd();
    }
    if(Get.find<GlobalController>().configModelData.value?.interstitialAds.toString().toLowerCase()=="admob"){
    loadInterstitialAd();
    }
   
  }
 Future<void> loadBannerAd() async {
    try {
      // Dispose previous ad if exists
      await disposeBannerAd();
      
      bannerAd = BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            isBannerAdLoaded.value = true;
            ll('Banner Ad Loaded successfully');
          },
          onAdFailedToLoad: (ad, error) {
            isBannerAdLoaded.value = false;
            ad.dispose();
            ll('Banner Ad Failed to Load: ${error.message}');
          },
          onAdClosed: (ad) {
            ll('Banner Ad Closed');
          },
          onAdOpened: (ad) {
            ll('Banner Ad Opened');
          },
        ),
      );
      
      // Load the ad
      await bannerAd?.load();
    } catch (e) {
      ll('Error loading banner ad: $e');
      isBannerAdLoaded.value = false;
    }
  }

  // Interstitial Ad Load
  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interestitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
          isInterstitialAdLoaded.value = true;
          ll('Interstitial Ad Loaded');

          interstitialAd!.setImmersiveMode(true); // Optional: For full-screen effect
        },
        onAdFailedToLoad: (LoadAdError error) {
          ll('Interstitial Ad Failed to Load: $error');
          isInterstitialAdLoaded.value = false;
        },
      ),
    );
  }

  // Show Interstitial Ad
  void showInterstitialAd() {
    if (interstitialAd != null) {
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ll('Interstitial Ad Dismissed');
          ad.dispose();
          loadInterstitialAd(); // Load another after dismissal
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ll('Interstitial Ad Failed to Show: $error');
          ad.dispose();
          loadInterstitialAd();
        },
      );

      interstitialAd!.show();
      interstitialAd = null;
      isInterstitialAdLoaded.value = false;
    } else {
      ll("Interstitial Ad is not ready yet.");
    }
  }
    Future<void> disposeBannerAd() async {
    if (bannerAd != null) {
      await bannerAd!.dispose();
      bannerAd = null;
      isBannerAdLoaded.value = false;
    }
  }

  @override
  void onClose() {
    disposeBannerAd();
    interstitialAd?.dispose();
    super.onClose();
  }

   void refreshBannerAd() {
    loadBannerAd();
  }


  //* Top Artist
  final RxBool isViewAllSearchEnable = RxBool(false);
  final TextEditingController viewAllTextEditingController =
      TextEditingController();
  final RxBool isViewAllSearchSuffixShow = RxBool(false);

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
  final TextEditingController addCommentTextEditingController =
      TextEditingController();

  //!Common Search
  final TextEditingController globalSearchTextEditingController =
      TextEditingController();
  final RxBool isSearchSuffixIconShow = RxBool(false);
  //! Cast details screen
  final RxInt castSelectedIndex = RxInt(0); // Default selected index
  final List<String> castDetailsTabs = ["Movies", "Personal Information"];
  final RxInt movietSelectedIndex = RxInt(0); // Default selected index
  final List<String> movieDetailsTabs = ["Cast", "Director", "Writer", "Review & Ratings"];
  final List<String> liveTvDetailsTabs = ["Review & Ratings"];
  final RxInt liveTvSelectedIndex = RxInt(0); // Default selected index

  void actorDetailsChangeTab(int index) {
    castSelectedIndex.value = index;
  }
    void videoDetailsChangeTab(int index) {
    movietSelectedIndex.value = index;
  }


  final RxDouble lowerValue = RxDouble(0);
  final RxDouble upperValue = RxDouble(0);

  //!Home Api implement
  //*Home
  final Rx<HomeDataModel?> homeDataModel = Rx<HomeDataModel?>(null);
  final RxList<FeaturedMovie> sliderList = RxList<FeaturedMovie>([]);
  final RxList<Country> genreList = RxList<Country>([]);
  final RxList<FeaturedMovie> newReleaseMoviesList =
      RxList<FeaturedMovie>([]);
  final RxList<FeaturedMovie> trendingMoviesList =
      RxList<FeaturedMovie>([]);
  final RxList<FeaturedMovie> recommendedMoviesList =
      RxList<FeaturedMovie>([]);
  final RxList<TvShow> popularTvShowsList =
      RxList<TvShow>([]);
  final RxList<FeaturedTvChannel> featuredTvChannelsList =
      RxList<FeaturedTvChannel>([]);
  final RxList<TvShow> tvShowsList = RxList<TvShow>([]);
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
        homeDataModel.value = HomeDataModel.fromJson(response.data);
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
        sliderList.addAll(homeDataModel.value!.sliders!);
        genreList.addAll(homeDataModel.value!.genres!);
        newReleaseMoviesList.addAll(homeDataModel.value!.newReleaseMovies!);
        trendingMoviesList.addAll(homeDataModel.value!.trendingMovies!);
        recommendedMoviesList.addAll(homeDataModel.value!.recommendedMovies!);
        popularTvShowsList.addAll(homeDataModel.value!.popularTvShows!);
        featuredTvChannelsList.addAll(homeDataModel.value!.featuredTvChannels!);
        tvShowsList.addAll(homeDataModel.value!.tvShows!);
        topArtistsList.addAll(homeDataModel.value!.topArtists!);
        latestBlogsList.addAll(homeDataModel.value!.latestBlogs!);
        await spController
            .savePrivacyPolicy(homeDataModel.value!.privacyPolicy);
        await spController
            .savePaymentPolicy(homeDataModel.value!.paymentPolicy);
        await spController
            .saveTermsAndCondition(homeDataModel.value!.termsAndConditions);
        Get.find<GlobalController>().privacyPolicyUrl.value =
            await spController.getPrivacyPolicy() ?? "";
        Get.find<GlobalController>().paymentPolicyUrl.value =
            await spController.getPaymentPolicy() ?? "";
        Get.find<GlobalController>().termsAndConditionUrl.value =
            await spController.getTermsAndCondition() ?? "";
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

  final RxInt selectedMovieServer = RxInt(0);
  //!Movie
  final RxInt selectedCategoryId = RxInt(-1);
  final RxString selectedCategory = RxString("");
  final RxInt selectedCountryId = RxInt(-1);
  final RxString selectedCountry = RxString("");
  final RxInt selectedGenreId = RxInt(-1);
  final RxString selectedGenre = RxString("");
  final RxInt selectedLanguageId = RxInt(-1);
  final RxString selectedLanguage = RxString("");
  final RxInt selectedSortId = RxInt(-1);
  final RxString selectedSort = RxString("");
  final RxString selectedYear = RxString("");
  final RxBool isApplyClicked = RxBool(false);
  // all movie api implement
  final RxBool isMovieListLoading = RxBool(false);
  final Rx<MovieListModel?> movieListModel = Rx<MovieListModel?>(null);
  final RxList<MovieData?> movieList = RxList<MovieData?>([]);
  final RxList<MovieData?> temporaryMovieList = RxList<MovieData?>([]);
  final RxList<Categories?> movieCategoryList = RxList<Categories?>([]);
  final RxList<Countries?> movieCountryList = RxList<Countries?>([]);
  final RxList<Countries?> movieLanguageList = RxList<Countries?>([]);
  final RxList<Countries?> movieGenreList = RxList<Countries?>([]);
  final RxList<int> movieYearList = RxList<int>([]);
  final RxList<String> movieSortList = RxList<String>();
  Future<void> getMovieList({required String movieType}) async {
    try {
      isMovieListLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuMovies?type=$movieType&per_page=15",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        movieList.clear();
        temporaryMovieList.clear();
        movieCategoryList.clear();
        movieCountryList.clear();
        movieLanguageList.clear();
        movieGenreList.clear();
        movieYearList.clear();
        movieSortList.clear();
        movieListModel.value = MovieListModel.fromJson(response.data);
        movieList.addAll(movieListModel.value!.movies!.data!);
        temporaryMovieList.addAll(movieListModel.value!.movies!.data!);
        movieCategoryList.addAll(movieListModel.value!.filter!.categories!);
        movieCountryList.addAll(movieListModel.value!.filter!.country!);
        movieLanguageList.addAll(movieListModel.value!.filter!.languages!);
        movieGenreList.addAll(movieListModel.value!.filter!.genre!);
        movieYearList.addAll(movieListModel.value!.filter!.year!);
        movieSortList.addAll(movieListModel.value!.filter!.sort!);
        movieListSubLink.value = movieListModel.value!.movies!.nextPageUrl;
        if (movieListSubLink.value != null) {
          movieListScrolled.value = false;
        } else {
          movieListScrolled.value = true;
        }
        isMovieListLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isMovieListLoading.value = false;
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
      isMovieListLoading.value = false;
      ll('getMovieList error: $e');
    }
  }

  //! pagination for movie List
   ScrollController movieListScrollController = ScrollController();
  final Rx<String?> movieListSubLink = Rx<String?>(null);
  final RxBool movieListScrolled = RxBool(false);
  Future<void> getMoreMovieList(String? movieType,[take]) async {
    try {
      String? token = await spController.getBearerToken();
      dynamic movieListSub;

      if (movieListSubLink.value == null) {
        return;
      } else {
        movieListSub = movieListSubLink.value!.split('?');
      }

      String movieListSuffixUrl = '';

      movieListSuffixUrl = '&${movieListSub[1]}';

      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuMovies?type=$movieType$movieListSuffixUrl&per_page=15",
      ) as CommonDM;

      if (response.code == 200) {
        movieListModel.value = MovieListModel.fromJson(response.data);
        temporaryMovieList.addAll(movieListModel.value!.movies!.data!);
        movieList.addAll(movieListModel.value!.movies!.data!);
        movieListSubLink.value = movieListModel.value!.movies!.nextPageUrl;
        if (movieListSubLink.value != null) {
          movieListScrolled.value = false;
        } else {
          movieListScrolled.value = true;
        }
        isMovieListLoading.value = false;
      } else {
        isMovieListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          // globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          // globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isMovieListLoading.value = true;
      ll('getMoreMovieList error: $e');
    }
  }

  final RxBool isHomeGenreClicked = RxBool(false);
  final Rx<FilterMovieListModel?> filterMovieListModel =
      Rx<FilterMovieListModel?>(null);
  Future<void> getFilterMovieList() async {
    try {
      isMovieListLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url:
            "$kuMovieFilter?string=${viewAllTextEditingController.text.trim().toString()}&category_id=${selectedCategoryId.value != -1 ? selectedCategoryId.value.toString() : ""}&genre=${selectedGenreId.value != -1 ? selectedGenreId.value.toString() : ""}&country=${selectedCountryId.value != -1 ? selectedCountryId.value.toString() : ""}&year=${selectedYear.value.toString()}&language_id=${selectedLanguageId.value != -1 ? selectedLanguageId.value.toString() : ""}&sort=${selectedSortId.value != -1 ? selectedSortId.value.toString() : ""}",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        movieList.clear();
        movieCategoryList.clear();
        movieCountryList.clear();
        movieLanguageList.clear();
        movieGenreList.clear();
        movieYearList.clear();
        movieSortList.clear();
        filterMovieListModel.value =
            FilterMovieListModel.fromJson(response.data);
        movieList.addAll(filterMovieListModel.value!.movies!.data!);
        movieCategoryList
            .addAll(filterMovieListModel.value!.filter!.categories!);
        movieCountryList.addAll(filterMovieListModel.value!.filter!.country!);
        movieLanguageList
            .addAll(filterMovieListModel.value!.filter!.languages!);
        movieGenreList.addAll(filterMovieListModel.value!.filter!.genre!);
        movieYearList.addAll(filterMovieListModel.value!.filter!.year!);
        movieSortList.addAll(filterMovieListModel.value!.filter!.sort!);
        // Get.back();
        isMovieListLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isMovieListLoading.value = false;
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
      isMovieListLoading.value = false;
      ll('getFilterMovieList error: $e');
    }
  }

  // movie details api implement
  final RxBool isMovieDetailsLoading = RxBool(false);
  final Rx<MovieDetailsModel?> movieDetailsModel = Rx<MovieDetailsModel?>(null);
  final Rx<MovieDetails?> movieDetailsData = Rx<MovieDetails?>(null);
  final Rx<Rental?> rentalVideoData = Rx<Rental?>(null);
  final RxList<Server?> movieServerList = RxList<Server?>([]);
  final RxList<Cast?> movieCastList = RxList<Cast?>([]);
  final RxList<Cast?> movieDirectorList = RxList<Cast?>([]);
  final RxList<Cast?> movieWriterList = RxList<Cast?>([]);
  // final RxList<Review?> movieReviewList = RxList<Review?>([]);
  final RxList<MovieDetails> relatedMovieList = RxList<MovieDetails>([]);
  final RxList<MovieDetails> recommendedMovieList = RxList<MovieDetails>([]);
  final RxList<int> playlistIdsList = RxList<int>([]);
  Future<void> getMovieDetails({required String movieId}) async {
    try {
      isMovieListLoading.value = true;
      String? token = await spController.getBearerToken();
      int? userId = await spController.getUserId();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuMovieDetails?id=$movieId&user_id=${userId==null ? "" : userId.toString()}",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        movieServerList.clear();
        movieCastList.clear();
        movieDirectorList.clear();
        movieWriterList.clear();
        // movieReviewList.clear();
        relatedMovieList.clear();
        recommendedMovieList.clear();
        playlistIdsList.clear();
         movieDetailsModel.value = MovieDetailsModel.fromJson(response.data);
        movieDetailsData.value = movieDetailsModel.value!.details;
        rentalVideoData.value = movieDetailsModel.value!.rental;
        movieServerList.addAll(movieDetailsModel.value!.server!);
        movieCastList.addAll(movieDetailsModel.value!.cast!);
        movieDirectorList.addAll(movieDetailsModel.value!.director!);
        movieWriterList.addAll(movieDetailsModel.value!.writer!);
        // movieReviewList.addAll(movieDetailsModel.value!.reviews!);
        relatedMovieList.addAll(movieDetailsModel.value!.relatedMovie!);
        recommendedMovieList.addAll(movieDetailsModel.value!.recommendedMovie!);
        playlistIdsList.addAll(movieDetailsModel.value!.playlistIds!);
        isMovieListLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isMovieListLoading.value = false;
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
      isMovieListLoading.value = false;
      ll('getMovieDetails error: $e');
    }
  }

  //!Tv Shows
  //tv shows api implement
  final RxBool isTvShowLoading = RxBool(false);
  final Rx<TvShowsModel?> tvShowsModel = Rx<TvShowsModel?>(null);
  final RxList<TvShowData?> temporaryTvShowList = RxList<TvShowData?>([]);
  final RxList<TvShowData?> tvShowList = RxList<TvShowData?>([]);
  final RxList<Categories?> tvShowsCategoryList = RxList<Categories?>([]);
  final RxList<Countries?> tvShowCountryList = RxList<Countries?>([]);
  final RxList<Countries?> tvShowLanguageList = RxList<Countries?>([]);
  final RxList<Countries?> tvShowGenreList = RxList<Countries?>([]);
  final RxList<int> tvShowYearList = RxList<int>([]);
   final RxList<String> tvShowSortList = RxList<String>();
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
        temporaryTvShowList.clear();
        tvShowList.clear();
        tvShowsCategoryList.clear();
        tvShowCountryList.clear();
        tvShowLanguageList.clear();
        tvShowGenreList.clear();
        tvShowYearList.clear();
        tvShowsModel.value = TvShowsModel.fromJson(response.data);
        temporaryTvShowList.addAll(tvShowsModel.value!.shows!.data!);
        tvShowList.addAll(tvShowsModel.value!.shows!.data!);
        tvShowsCategoryList.addAll(tvShowsModel.value!.filter!.categories!);
        tvShowCountryList.addAll(tvShowsModel.value!.filter!.country!);
        tvShowLanguageList.addAll(tvShowsModel.value!.filter!.languages!);
        tvShowGenreList.addAll(tvShowsModel.value!.filter!.genre!);
        tvShowYearList.addAll(tvShowsModel.value!.filter!.year!);
        // tvShowSortList.addAll(tvShowsModel.value!.filter!.sort!);
        isTvShowLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isTvShowLoading.value = false;
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
      isTvShowLoading.value = false;
      ll('getTvShows error: $e');
    }
  }


  //! pagination for Tv show List
   ScrollController tvShowListScrollController = ScrollController();
  final Rx<String?> tvShowListSubLink = Rx<String?>(null);
  final RxBool tvShowListScrolled = RxBool(false);
  Future<void> getMoreTvShowList(String? movieType,[take]) async {
    try {
      String? token = await spController.getBearerToken();
      dynamic tvShowListSub;
      if (tvShowListSubLink.value == null) {
        return;
      } else {
        tvShowListSub = tvShowListSubLink.value!.split('?');
      }

      String tvShowListSuffixUrl = '';

      tvShowListSuffixUrl = '&${tvShowListSub[1]}';

      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuTvShows?per_page=2$tvShowListSuffixUrl",
      ) as CommonDM;
      if (response.code == 200) {
        tvShowsModel.value = TvShowsModel.fromJson(response.data);
        temporaryTvShowList.addAll(tvShowsModel.value!.shows!.data!);
        tvShowList.addAll(tvShowsModel.value!.shows!.data!);
        tvShowListSubLink.value = tvShowsModel.value!.shows!.nextPageUrl;
        if (tvShowListSubLink.value != null) {
          tvShowListScrolled.value = false;
        } else {
          tvShowListScrolled.value = true;
        }
        isTvShowLoading.value = false;
      } else {
        isTvShowLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          // globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          // globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isTvShowLoading.value = true;
      ll('getMoreTvShowList error: $e');
    }
  }

  final RxBool isTvShowDetailsLoading = RxBool(false);
  final Rx<TvShowDetailsModel?> tvShowDetailsModel = Rx<TvShowDetailsModel?>(null);
  final Rx<TvShows?> tvShowDetailsData = Rx<TvShows?>(null);
  final RxList<Season?> tvShowsSeasonList = RxList<Season?>([]);
  final RxList<Episode?> tvShowEpisodeList = RxList<Episode?>([]);
  final RxList<Cast?> tvShowCastList = RxList<Cast?>([]);
  final RxList<Cast?> tvShowDirectorList = RxList<Cast?>([]);
  final RxList<Cast?> tvShowWritterList = RxList<Cast?>([]);
  final RxList<TvShows?> relatedTvShowsList = RxList<TvShows?>([]);
  final RxList<String?> tvShowVideoTagsList = RxList<String?>([]);
  Future<void> getTvShowDetails({required int showId}) async {
    try {
      isTvShowLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuTvShowDetails?id=$showId",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        tvShowsSeasonList.clear();
        tvShowEpisodeList.clear();
        tvShowCastList.clear();
        tvShowDirectorList.clear();
        tvShowWritterList.clear();
        relatedTvShowsList.clear();
        tvShowVideoTagsList.clear();
        tvShowDetailsModel.value = TvShowDetailsModel.fromJson(response.data);
        tvShowDetailsData.value = tvShowDetailsModel.value!.shows;
        tvShowsSeasonList.addAll(tvShowDetailsModel.value!.shows!.seasons!);
        tvShowCastList.addAll(tvShowDetailsModel.value!.cast!);
        tvShowDirectorList.addAll(tvShowDetailsModel.value!.director!);
        tvShowWritterList.addAll(tvShowDetailsModel.value!.writer!);
        relatedTvShowsList.addAll(tvShowDetailsModel.value!.relatedTvShows!);
        ll("the related tv shows list length is ${relatedTvShowsList.length}");
        tvShowVideoTagsList.addAll(tvShowDetailsModel.value!.videoTags!);
        if (tvShowsSeasonList.isNotEmpty) {
          tvShowEpisodeList
              .addAll(tvShowDetailsModel.value!.shows!.seasons![0].episodes!);
        }
        isTvShowLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isTvShowLoading.value = false;
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
      isTvShowLoading.value = false;
      ll('getTvShowDetails error: $e');
    }
  }

  final Rx<TvShowFilterModel?> tvShowFilterModel = Rx<TvShowFilterModel?>(null);
  Future<void> getTvShowFilter() async {
    try {
      isTvShowLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url:
            "$kuTvShowFilter?string=&category_id=${selectedCategoryId.value != -1 ? selectedCategoryId.value.toString() : ""}&genre=${selectedGenreId.value != -1 ? selectedGenreId.value.toString() : ""}&country_id=${selectedCountryId.value != -1 ? selectedCountryId.value.toString() : ""}&year=${selectedYear.value.toString()}&language_id=${selectedLanguageId.value != -1 ? selectedLanguageId.value.toString() : ""}",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        tvShowList.clear();
        tvShowFilterModel.value =
            TvShowFilterModel.fromJson(response.data);
        tvShowList.addAll(tvShowFilterModel.value!.details!.data!);
        Get.back();
        isTvShowLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isTvShowLoading.value = false;
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
      isTvShowLoading.value = false;
      ll('getTvShowFilter error: $e');
    }
  }

  //!Top Artist
  //Artist api implement
  final RxInt selectedMovieIndustryId = RxInt(-1);
  final RxString selectedMovieIndustry = RxString("");
  final RxBool isArtistLoading = RxBool(false);
  final Rx<ArtistModel?> artistModel = Rx<ArtistModel?>(null);
  final RxList<ArtistData> temporaryArtistList = RxList<ArtistData>([]);
  final RxList<ArtistData> artistList = RxList<ArtistData>([]);
  final RxList<ArtistCountry> artistCountryList = RxList<ArtistCountry>([]);
  final RxList<MovieIndustry> artistMovieIndustryList =
      RxList<MovieIndustry>([]);
  Future<void> getArtistList() async {
    try {
      isArtistLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuArtist?name=${viewAllTextEditingController.text.trim().toString()}&country=${selectedCountryId.value == -1 ? "" : selectedCountryId.value.toString()}&movie_industry=${selectedMovieIndustryId.value == -1 ? "" : selectedMovieIndustryId.value.toString()}",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        temporaryArtistList.clear();
        artistList.clear();
        artistCountryList.clear();
        artistMovieIndustryList.clear();
        artistModel.value = ArtistModel.fromJson(response.data);
        temporaryArtistList.addAll(artistModel.value!.artists!.data!);
        artistList.addAll(artistModel.value!.artists!.data!);
        artistCountryList.addAll(artistModel.value!.filter!.countries!);
        artistMovieIndustryList
            .addAll(artistModel.value!.filter!.movieIndustries!);
        artistListSubLink.value = artistModel.value?.artists?.nextPageUrl;
        if (artistListSubLink.value != null) {
          artistListScrolled.value = false;
        } else {
          artistListScrolled.value = true;
        }
        isArtistLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isArtistLoading.value = false;
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
      isArtistLoading.value = false;
      ll('getArtistList error: $e');
    }
  }

//! pagination for Top Artist List
   ScrollController artistListScrollController = ScrollController();
  final Rx<String?> artistListSubLink = Rx<String?>(null);
  final RxBool artistListScrolled = RxBool(false);
  Future<void> getMoreArtistList([take]) async {
    ll("getMoreArtistList is called");
    try {
      String? token = await spController.getBearerToken();
      dynamic artistListSub;

      if (artistListSubLink.value == null) {
        return;
      } else {
        artistListSub = artistListSubLink.value!.split('?');
      }

      String artistListSuffixUrl = '';

      artistListSuffixUrl = '&${artistListSub[1]}';

      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuArtist?name=${viewAllTextEditingController.text.trim().toString()}&country=${selectedCountryId.value == -1 ? "" : selectedCountryId.value.toString()}&movie_industry=${selectedMovieIndustryId.value == -1 ? "" : selectedMovieIndustryId.value.toString()}$artistListSuffixUrl",
      ) as CommonDM;

      if (response.code == 200) {
        artistModel.value = ArtistModel.fromJson(response.data);
        artistList.addAll(artistModel.value!.artists!.data!);
        artistListSubLink.value = artistModel.value!.artists!.nextPageUrl;
        if (artistListSubLink.value != null) {
          artistListScrolled.value = false;
        } else {
          artistListScrolled.value = true;
        }
        isArtistLoading.value = false;
      } else {
        isArtistLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          // globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          // globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isArtistLoading.value = true;
      ll('getMoreArtistList error: $e');
    }
  }


  //Artist details api implement
  final RxBool isArtistDetailsLoading = RxBool(false);
  final Rx<ArtistDetailsModel?> artistDetailsModel =
      Rx<ArtistDetailsModel?>(null);
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
        ArtistDetailsModel artistDetailsModel =
            ArtistDetailsModel.fromJson(response.data);
        artistMovieList.clear();
        artistMovieList.addAll(artistDetailsModel.movies!);
        artistDetailsData.value = artistDetailsModel.details;
        isArtistDetailsLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isArtistDetailsLoading.value = false;
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
  final RxList<BlogData> temporaryBlogList = RxList<BlogData>([]);
  final RxList<int> blogYearList = RxList<int>([]);
  Future<void> getBlogList() async {
    try {
      isBlogLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuBlogs?per_page=15",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        blogModel.value = BlogModel.fromJson(response.data);
        blogCategoryList.clear();
        blogYearList.clear();
        temporaryBlogList.clear();
        blogList.clear();
        blogs.value = blogModel.value!.blogs;
        temporaryBlogList.addAll(blogModel.value!.blogs!.data!);
        blogList.addAll(blogModel.value!.blogs!.data!);
        ll("The blog filter category data is ${blogModel.value!.filter!.categories}");
        ll("The blog filter category data length is ${blogModel.value!.filter!.categories!.length}");
        blogCategoryList.addAll(blogModel.value!.filter!.categories!);
        blogYearList.addAll(blogModel.value!.filter!.year!);
         blogListSubLink.value = blogModel.value!.blogs!.nextPageUrl;
        if (blogListSubLink.value != null) {
          blogListScrolled.value = false;
        } else {
          blogListScrolled.value = true;
        }
        isBlogLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isBlogLoading.value = false;
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
      isBlogLoading.value = false;
      ll('getBlogList error: $e');
    }
  }


  //! pagination for blog List
  ScrollController blogListScrollController = ScrollController();
  final Rx<String?> blogListSubLink = Rx<String?>(null);
  final RxBool blogListScrolled = RxBool(false);
  Future<void> getMoreBlogList([take]) async {
    try {
      String? token = await spController.getBearerToken();
      dynamic blogListSub;

      if (blogListSubLink.value == null) {
        return;
      } else {
        blogListSub = blogListSubLink.value!.split('?');
      }

      String blogListSuffixUrl = '';

      blogListSuffixUrl = '&${blogListSub[1]}';

      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuBlogs$blogListSuffixUrl&per_page=15",
      ) as CommonDM;

      if (response.code == 200) {
      blogModel.value = BlogModel.fromJson(response.data);
        temporaryBlogList.addAll(blogModel.value!.blogs!.data!);
        blogList.addAll(blogModel.value!.blogs!.data!);
        blogListSubLink.value = blogModel.value!.blogs!.nextPageUrl;
        if (blogListSubLink.value != null) {
          blogListScrolled.value = false;
        } else {
          blogListScrolled.value = true;
        }
        isBlogLoading.value = false;
      } else {
        isBlogLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          // globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          // globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isBlogLoading.value = true;
      ll('getMoreBlogList error: $e');
    }
  }

  //!blog api implement
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
        url:
            "$kuBlogFilter?string=&category_id=${selectedCategoryId.value.toString()}&year=${selectedYear.value.toString()}",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        FilterBlogModel filterBlogModel =
            FilterBlogModel.fromJson(response.data);
        blogList.clear();
        blogList.addAll(filterBlogModel.details!.data!);
        isBlogFilterLoading.value = false;
        Get.back();
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isBlogFilterLoading.value = false;
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
        blogDetailsModel.value =
            BlogDetailsModel.fromJson(response.data);
        blogDetails.value = blogDetailsModel.value!.details;
        blogCategories.value = blogDetailsModel.value!.category;
        latestBlogList.addAll(blogDetailsModel.value!.latestBlogs!);
        isBlogDetailsLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isBlogDetailsLoading.value = false;
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
      isBlogDetailsLoading.value = false;
      ll('getBlogDetails error: $e');
    }
  }

  //!Global search
  final RxBool isGlobalSearchLoading = RxBool(false);
  final Rx<GlobalSearchModel?> globalSearchModel = Rx<GlobalSearchModel?>(null);
  final RxList<SearchData?> searchList = RxList<SearchData?>([]);
  final RxList<Categories?> searchCategoryList = RxList<Categories?>([]);
  final RxList<Countries?> searchCountryList = RxList<Countries?>([]);
  final RxList<Countries?> searchGenreList = RxList<Countries?>([]);
  final RxList<int?> searchYearList = RxList<int?>([]);
  Future<void> getGlobalSearch() async {
    try {
      isGlobalSearchLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url:
            "$kuGlobalSearch?search=${globalSearchTextEditingController.text.trim().toString()}&category=${selectedCategoryId.value == -1 ? "" : selectedCategoryId.value.toString()}&country=${selectedCountryId.value == -1 ? "" : selectedCountryId.value.toString()}&genre=${selectedGenreId.value == -1 ? "" : selectedGenreId.value.toString()}&year=${selectedYear.toString()}",
        body: body,
      ) as CommonDM;
      if (response.code == 200) {
        searchList.clear();
        searchCategoryList.clear();
        searchCountryList.clear();
        searchGenreList.clear();
        searchYearList.clear();
        globalSearchModel.value = GlobalSearchModel.fromJson(response.data);
        searchList.addAll(globalSearchModel.value!.searchedData!.data!);
        searchCategoryList.addAll(globalSearchModel.value!.filter!.categories!);
        searchCountryList.addAll(globalSearchModel.value!.filter!.country!);
        searchGenreList.addAll(globalSearchModel.value!.filter!.genre!);
        searchYearList.addAll(globalSearchModel.value!.filter!.year!);
        globalSearchListSubLink.value =
            globalSearchModel.value?.searchedData?.nextPageUrl;
        if (globalSearchListSubLink.value != null) {
          globalSearchListScrolled.value = false;
        } else {
          globalSearchListScrolled.value = true;
        }
        isGlobalSearchLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isGlobalSearchLoading.value = false;
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
      isGlobalSearchLoading.value = false;
      ll('getGlobalSearch error: $e');
    }
  }

  //! pagination for global search
  final ScrollController globalSearchScrollController = ScrollController();
  final Rx<String?> globalSearchListSubLink = Rx<String?>(null);
  final RxBool globalSearchListScrolled = RxBool(false);
  //*Get More global search for pagination
  Future<void> getMoreGlobalSearch([take]) async {
    ll("getLoadMoreGlobalSearch is called");
    try {
      String? token = await spController.getBearerToken();
      dynamic globalSearchListSub;

      if (globalSearchListSubLink.value == null) {
        return;
      } else {
        globalSearchListSub = globalSearchListSubLink.value!.split('?');
      }

      String globalSearchListSuffixUrl = '';

      globalSearchListSuffixUrl = '&${globalSearchListSub[1]}';

      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        // url: kuGlobalSearch + friendListSuffixUrl,
        url:
            "$kuGlobalSearch?search=${globalSearchTextEditingController.text.trim().toString()}&category=${selectedCategoryId.value == -1 ? "" : selectedCategoryId.value.toString()}&country=${selectedCountryId.value == -1 ? "" : selectedCountryId.value.toString()}&genre=${selectedGenreId.value == -1 ? "" : selectedGenreId.value.toString()}&year=${selectedYear.toString()}$globalSearchListSuffixUrl",
      ) as CommonDM;

      if (response.code == 200) {
        globalSearchModel.value = GlobalSearchModel.fromJson(response.data);

        // friendList.addAll(friendListData.value!.friends!.data);
        searchList.addAll(globalSearchModel.value!.searchedData!.data!);
        globalSearchListSubLink.value =
            globalSearchModel.value!.searchedData!.nextPageUrl;
        if (globalSearchListSubLink.value != null) {
          globalSearchListScrolled.value = false;
        } else {
          globalSearchListScrolled.value = true;
        }

        isGlobalSearchLoading.value = false;
      } else {
        isGlobalSearchLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          // globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          // globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isGlobalSearchLoading.value = true;
      ll('getLoadMoreGlobalSearch error: $e');
    }
  }

  //!Tv Channel
  final RxBool isTvChannelListLoading = RxBool(false);
  final Rx<TvChannelListModel?> tvChannelListModel =
      Rx<TvChannelListModel?>(null);
  final Rx<LiveTvs?> tvChannelData = Rx<LiveTvs?>(null);
  final RxList<TvChannelData> allTvChannelList = RxList<TvChannelData>([]);
  final RxList<TvChannelCategory> tvChannelCategoryList =
      RxList<TvChannelCategory>([]);
  final RxList<ArtistCountry> tvChannelCountryList = RxList<ArtistCountry>([]);
  Future<void> getTvChannel() async {
    try {
      isTvChannelListLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url:
            "$kuTvChannel?search=${viewAllTextEditingController.text.trim().toString()}&category_id=${selectedCategoryId.value == -1 ? "" : selectedCategoryId.value.toString()}&country_id=${selectedCountryId.value == -1 ? "" : selectedCountryId.value.toString()}&per_page=1",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        allTvChannelList.clear();
        tvChannelCategoryList.clear();
        tvChannelCountryList.clear();
        tvChannelListModel.value = TvChannelListModel.fromJson(response.data);
        tvChannelData.value = tvChannelListModel.value?.liveTvs;
        allTvChannelList.addAll(tvChannelListModel.value!.liveTvs!.data!);
        tvChannelCategoryList
            .addAll(tvChannelListModel.value!.filter!.categories!);
        tvChannelCountryList.addAll(tvChannelListModel.value!.filter!.country!);
        isTvChannelListLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isTvChannelListLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(
              title: ksError.tr,
              message: response.message.toString(),
              color: cRedColor);
        } else {
          showSnackBar(
              title: ksError.tr,
              message: errorModel.errors[0].message,
              color: cRedColor);
        }
      }
    } catch (e) {
      isTvChannelListLoading.value = false;
      ll('getTvChannels error: $e');
    }
  }


  //! pagination for Tv channel List
   ScrollController tvChannelListScrollController = ScrollController();
  final Rx<String?> tvChannelListSubLink = Rx<String?>(null);
  final RxBool tvChannelListScrolled = RxBool(false);
  Future<void> getMoreTvChannelList([take]) async {
    try {
      String? token = await spController.getBearerToken();
      dynamic tvChannelListSub;
      if (tvChannelListSubLink.value == null) {
        return;
      } else {
        tvChannelListSub = tvChannelListSubLink.value!.split('?');
      }

      String tvChannelListSuffixUrl = '';

      tvChannelListSuffixUrl = '&${tvChannelListSub[1]}';

      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuTvChannel?search=${viewAllTextEditingController.text.trim().toString()}&category_id=${selectedCategoryId.value == -1 ? "" : selectedCategoryId.value.toString()}&country_id=${selectedCountryId.value == -1 ? "" : selectedCountryId.value.toString()}$tvChannelListSuffixUrl&per_page=1",
      ) as CommonDM;
      if (response.code == 200) {
        tvChannelListModel.value = TvChannelListModel.fromJson(response.data);
        tvChannelData.value = tvChannelListModel.value?.liveTvs;
        allTvChannelList.addAll(tvChannelListModel.value!.liveTvs!.data!);
        tvChannelListSubLink.value = tvShowsModel.value!.shows!.nextPageUrl;
        if (tvChannelListSubLink.value != null) {
          tvChannelListScrolled.value = false;
        } else {
          tvChannelListScrolled.value = true;
        }
        isTvChannelListLoading.value = false;
      } else {
        isTvChannelListLoading.value = true;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          // globalController.showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          // globalController.showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isTvChannelListLoading.value = true;
      ll('getMoreTvChannelList error: $e');
    }
  }

  //Tv channel details
  final Rx<String?> liveTvUrl = Rx<String?>(null);
  final RxInt liveTvSelectedServer = RxInt(0);
  final RxBool isTvChannelDetailsLoading = RxBool(false);
  final Rx<TvChannelDetailsModel?> tvChannelDetailsModel =
      Rx<TvChannelDetailsModel?>(null);
  final Rx<LiveTvDetails?> liveTvDetailsData = Rx<LiveTvDetails?>(null);
  final RxList<LiveTvDetails> relatedLiveTvChannelsList = RxList<LiveTvDetails>([]);
  final RxList<Stream> streamList = RxList<Stream>([]);
  Future<void> getTvChannelDetails({int? tvChannelId}) async {
    try {
      isTvChannelDetailsLoading.value = true;
      String? token = await spController.getBearerToken();
      int? userId = await spController.getUserId();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuLiveTvDetails?id=${tvChannelId.toString()}&user_id=${userId.toString()}",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        relatedLiveTvChannelsList.clear();
        streamList.clear();
        tvChannelDetailsModel.value =
            TvChannelDetailsModel.fromJson(response.data);
        liveTvDetailsData.value = tvChannelDetailsModel.value?.liveTvDetails;
        relatedLiveTvChannelsList
            .addAll(tvChannelDetailsModel.value!.relatedLiveTvs!);
        streamList
            .addAll(tvChannelDetailsModel.value!.stream!);
        isTvChannelDetailsLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isTvChannelDetailsLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(
              title: ksError.tr,
              message: response.message.toString(),
              color: cRedColor);
        } else {
          showSnackBar(
              title: ksError.tr,
              message: errorModel.errors[0].message,
              color: cRedColor);
        }
      }
    } catch (e) {
      isTvChannelDetailsLoading.value = false;
      ll('getTvChannelDetails error: $e');
    }
  }

  //! rented video
    // Map of all packages with price and duration
  final packageDetails = {
    'daily': {
      'price': '\$10',
      'duration': '24 hours',
    },
    'weekly': {
      'price': '\$30',
      'duration': '1 week',
    },
    'monthly': {
      'price': '\$50',
      'duration': '1 month',
    },
  };

  // Selected package name
  var selectedPackage = 'monthly'.obs;

  void selectPackage(String packageName) {
    selectedPackage.value = packageName;
  }

  //Local Ads
  final RxBool isLocalAdsLoading = RxBool(false);
  final Rx<LocalAdsModel?> localAdsModel =
      Rx<LocalAdsModel?>(null);
  final RxList<Ads> localAdList = RxList<Ads>([]);
  Future<void> getLocalAds() async {
    try {
      isLocalAdsLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuAds,
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        localAdList.clear();
        localAdsModel.value =
            LocalAdsModel.fromJson(response.data);
        localAdList
            .addAll(localAdsModel.value!.ads);
        isLocalAdsLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isLocalAdsLoading.value = false;
        if (errorModel.errors.isEmpty) {
          // showSnackBar(
          //     title: ksError.tr,
          //     message: response.message.toString(),
          //     color: cRedColor);
        } else {
          // showSnackBar(
          //     title: ksError.tr,
          //     message: errorModel.errors[0].message,
          //     color: cRedColor);
        }
      }
    } catch (e) {
      isLocalAdsLoading.value = false;
      ll('getLocalAds error: $e');
    }
  }
//!Review & Rating
  Future<void> userRating({required int reviewableId,required String reviewableType}) async {
    // final int userId = await spController.getUserId()??-1;
    try {
      String? token = await spController.getBearerToken();
      int? userId = await spController.getUserId();
      Map<String, dynamic> body = {
        "user_id": userId.toString(),
        "review": addCommentTextEditingController.text.trim().toString(),
        "rating": rating.toString(),
        "reviewable_id": reviewableId.toString(),
        "reviewable_type": reviewableType,
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: kuRating,
        body: body,
        token: token,
        requestMethod: kPost,
      ) as CommonDM;

      if (response.code == 200) {
        addCommentTextEditingController.clear();
        rating.value=0;
        await getUserReview(reviewableId: reviewableId,reviewableType: reviewableType);
        showSnackBar(title: "Success", message: response.message??"", color: cGreenColor);
      } else {
        showSnackBar(title: ksError.tr, message: "editPlayList Error!", color: cPrimaryColor2);
      }
    } catch (e) {
      ll('userRating error: $e');
    }
  }


  // get user Review
  final RxBool isUserReviewLoading = RxBool(false);
  final Rx<ReviewListModel?> reviewListModel = Rx<ReviewListModel?>(null);
  final RxList<Review?> movieReviewList = RxList<Review?>([]);
  Future<void> getUserReview({required int reviewableId, required String reviewableType}) async {
    try {
      isUserReviewLoading.value = true;
      String? token = await spController.getBearerToken();
      // int? userId = await spController.getUserId();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuReviewList?reviewable_id=${reviewableId.toString()}&reviewable_type=$reviewableType",
        body: body,
      ) as CommonDM;
      if (response.code == 200) {
        movieReviewList.clear();
        reviewListModel.value =
            ReviewListModel.fromJson(response.data);
        movieReviewList
            .addAll(reviewListModel.value!.reviews!);
        isUserReviewLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isUserReviewLoading.value = false;
        if (errorModel.errors.isEmpty) {

        } else {
        }
      }
    } catch (e) {
      isUserReviewLoading.value = false;
      ll('getUserReview error: $e');
    }
  }
  
    // get user Review
  final RxBool isWatchHistoryLoading = RxBool(false);
  final Rx<WatchHistoryModel?> watchHistoryModel = Rx<WatchHistoryModel?>(null);
  final RxList<WatchHistoryData?> watchHistoryList = RxList<WatchHistoryData?>([]);
  Future<void> getWatchHistory() async {
    try {
      isWatchHistoryLoading.value = true;
      String? token = await spController.getBearerToken();
      int? userId = await spController.getUserId();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuWatchHistory?user_id=${userId.toString()}",
        body: body,
        isVideoPlay: true,
      ) as CommonDM;
      if (response.code == 200) {
        watchHistoryList.clear();
        watchHistoryModel.value =
            WatchHistoryModel.fromJson(response.data);
        watchHistoryList
            .addAll(watchHistoryModel.value!.histories!.data!);
        isWatchHistoryLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isWatchHistoryLoading.value = false;
        if (errorModel.errors.isEmpty) {

        } else {
        }
      }
    } catch (e) {
      isWatchHistoryLoading.value = false;
      ll('getWatchHistory error: $e');
    }
  }

  Future<void> watchHistoryStore({required String watchableType,required int watchableId,required String duration,required String watchedSeconds}) async {
    try {
      String? token = await spController.getBearerToken();
      int? userId = await spController.getUserId();
      Map<String, dynamic> body = {
        "user_id": userId.toString(),
        "watchable_type": watchableType.toString(),
        "watchable_id": watchableId.toString(),
        "duration": duration.toString(),
        "watched_seconds": watchedSeconds.toString(),
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: kuWatchHistoryStore,
        body: body,
        token: token,
        requestMethod: kPost,
        isVideoPlay: true,
      ) as CommonDM;

      if (response.code == 200) {
        addCommentTextEditingController.clear();
        rating.value=0;
       await getWatchHistory();
        // showSnackBar(title: "Success", message: response.message??"", color: cGreenColor);
      } else {
        // showSnackBar(title: ksError.tr, message: "editPlayList Error!", color: cPrimaryColor2);
      }
    } catch (e) {
      ll('watchHistoryStore error: $e');
    }
  }

  //! review like loggle api call
  Future<void> reviewLikeToggle({required int reviewId,}) async {
    // final int userId = await spController.getUserId()??-1;
    try {
      String? token = await spController.getBearerToken();
      int? userId = await spController.getUserId();
      Map<String, dynamic> body = {
        "user_id": userId.toString(),
        "review_id": reviewId.toString(),
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: kuLikeToggle,
        body: body,
        token: token,
        requestMethod: kPost,
      ) as CommonDM;

      if (response.code == 200) {
        showSnackBar(title: "Success", message: response.message??"", color: cGreenColor);
      } else {
        showSnackBar(
            title: ksError.tr, message: "editPlayList Error!", color: cPrimaryColor2);
      }
    } catch (e) {
      ll('userRating error: $e');
    }
  }
  




 final RxInt rating = RxInt(0);

  void updateRating(int newRating) {
    rating.value = newRating;
  }

  final RxInt selectedServer = RxInt(0);
  final RxInt selectedSeason = RxInt(0);
  final RxInt selectedEpisode = RxInt(0);
  final RxBool isTvShowsListExpand = RxBool(true);
  //!reset rating data
  void resetRatingData(){
    addCommentTextEditingController.clear();
    rating.value=0;
  }
  //!reset bottom nav bar data
  void resetBottomSheetData() {
    selectedCategoryId.value = -1;
    selectedCountryId.value = -1;
    selectedGenreId.value = -1;
    selectedLanguageId.value = -1;
    selectedSortId.value = -1;
    selectedYear.value = "";
    selectedMovieIndustryId.value = -1;
    selectedCategory.value = "";
    selectedGenre.value = "";
    selectedCountry.value = "";
    selectedLanguage.value = "";
    selectedSort.value = "";
    isApplyClicked.value = false;
    Get.find<AllVideoPlayerController>().totalSeconds.value = 0;
    Get.find<AllVideoPlayerController>().currentSeconds.value = 0;
  }
}
