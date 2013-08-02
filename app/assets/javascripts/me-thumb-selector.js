(function() {
  (function($) {
    $.extend(mejs.MepDefaults, {
      thumbnailSelectorEnabled: false,
      thumbnailSelectorUpdateURL: ''
    });
    return $.extend(MediaElementPlayer.prototype, {
      thumbTemplate: function() {
        return "<div class=\"modal hide fade\">\n    <div class=\"modal-header\">\n        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">×</button>\n        <h3>\n            Modal header\n        </h3>\n    </div>\n    <div class=\"modal-body\">\n        <p>\n            One fine body…\n        </p>\n    </div>\n    <div class=\"modal-footer\">\n        <a href=\"#\" class=\"btn\">Close</a> <a href=\"#\" class=\"btn btn-primary\">Save changes</a>\n    </div>\n</div>";
      },
      buildthumbnailSelector: function(player, controls, layers, media, s) {
        var button;
        if (!player.isVideo) {
          return;
        }
        if (!(player.options.thumbnailSelectorEnabled && player.options.thumbnailSelectorUpdateURL)) {
          return;
        }
        button = $("<div class='mejs-button mejs-thumbnail-selector'>                    <button type='button' aria-controls='mep_0' title='Create thumbnail' aria-label='Create thumbnail'/>                  </div>");
        button.appendTo(controls);
        return button.bind('click', function(event) {
          var $template, seconds;
          seconds = player.getCurrentTime();
          $.ajax({
            url: player.options.thumbnailSelectorUpdateURL,
            data: seconds,
            complete: function(response) {
              return location.reload();
            }
          });
          return $template = $(player.thumbTemplate());
        });
      }
    });
  })(mejs.$);

}).call(this);
