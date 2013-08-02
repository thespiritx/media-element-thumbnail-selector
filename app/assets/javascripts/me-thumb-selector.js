(function() {
  (function($) {
    $.extend(mejs.MepDefaults, {
      thumbnailSelectorEnabled: false,
      thumbnailSelectorUpdateURL: ''
    });
    return $.extend(MediaElementPlayer.prototype, {
      thumbnailSelectorConfirmationTemplate: function() {
        return "<div class=\"modal hide fade\">\n    <div class=\"modal-header\">\n        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">×</button>\n        <h3>\n            Update Thumbnail\n        </h3>\n    </div>\n    <div class=\"modal-body\">\n        <p>\n            Clicking update will change the thumbnail and poster image.\n        </p>\n    </div>\n    <div class=\"modal-footer\">\n        <a href=\"#\" data-dismiss=\"modal\" class=\"btn\">Cancel</a> <a href=\"#\" class=\"btn btn-primary\">Update</a>\n    </div>\n</div>";
      },
      thumbnailSelectorUpdateThumbnail: function(url, seconds) {
        return $.ajax({
          url: url,
          type: 'post',
          data: {
            seconds: seconds
          }
        });
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
        return button.click(function(event) {
          var $template, seconds, updateURL;
          seconds = player.getCurrentTime();
          updateURL = player.options.thumbnailSelectorUpdateURL;
          $template = $(player.thumbnailSelectorConfirmationTemplate());
          $template.find('.btn.btn-primary').click(function(event) {
            return player.thumbnailSelectorUpdateThumbnail(updateURL, seconds).complete(function(response) {
              return location.reload();
            });
          });
          return $template.modal('show');
        });
      }
    });
  })(mejs.$);

}).call(this);
