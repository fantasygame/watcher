$(function(){
  $('.show-overview').click(function(){
    toggleOverview($(this).parent(), true);
  });

  $('.toggle-seen').on('ajax:success',function(event, data, status, xhr){
    if (status == 'success') {
      episode = $('.season-' + data.season_number + '.episode-' + data.episode_number + '.tv-' + data.tv_number);
      episode.addClass('seen-episode');
      episode.prevAll('.tv-' + data.tv_number).addClass('seen-episode');
      episode.nextAll('.tv-' + data.tv_number).removeClass('seen-episode');
    }
  });

  function toggleOverview(episodes, turnOn) {
    showOverview = episodes.find('.show-overview');
    overview = episodes.find('.overview');
    if (turnOn) {
      showOverview.hide();
      overview.show();
    } else {
      showOverview.show();
      overview.hide();
    }
  }
});
