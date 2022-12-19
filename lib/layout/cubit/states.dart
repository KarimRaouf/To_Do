abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavStates extends NewsStates {}

class NewsGetBusinessLoadingState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  final error;

  NewsGetBusinessErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsStates {}

class NewsGetSportsSuccessState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates {
  final error;

  NewsGetSportsErrorState(this.error);
}

class NewsGetScienceLoadingState extends NewsStates {}

class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetScienceErrorState extends NewsStates {
  final error;

  NewsGetScienceErrorState(this.error);
}

class NewsToggleModeState extends NewsStates {}

class NewsSearchLoadingState extends NewsStates {}

class NewsSearchSuccessState extends NewsStates {}

class NewsSearchErrorState extends NewsStates {
  final error;

  NewsSearchErrorState(this.error);
}
