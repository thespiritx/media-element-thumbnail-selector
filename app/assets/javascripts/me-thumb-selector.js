(function() {
  (function($) {
    $.extend(mejs.MepDefaults, {
      thumbnailSelectorEnabled: false,
      thumbnailSelectorUpdateURL: ''
    });
    return $.extend(MediaElementPlayer.prototype, {
      thumbnailSelectorConfirmationTemplate: function(context) {
        return "     \n<div class=\"modal hide fade\">\n    <div class=\"modal-header\">\n        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">×</button>\n        <h3>\n            Update Poster Image\n        </h3>\n    </div>\n\n      <div class=\"modal-body\">\n        <div class=\"media\">\n            <a class=\"pull-left\" href=\"#\">\n          <img class=\"media-object\" class='img-polaroid' src=\"" + context.posterURL + "?offset=" + context.offset + "&preview=true\" style=\"width: 64px; height: 64px;\">\n            </a>\n          <div class=\"media-body\">\n            <h4 class=\"media-heading\"></h4> \n            This will update the poster and thumbnail images for this video.\n          </div>\n        </div>\n      </div>\n    <div class=\"modal-footer\">\n        <a href=\"#\" data-dismiss=\"modal\" class=\"btn\">Cancel</a> <a href=\"#\" class=\"btn btn-primary\">Update Poster Image</a>\n    </div>\n</div>";
      },
      buildthumbnailSelector: function(player, controls, layers, media) {
        var button;
        if (!player.isVideo) {
          return;
        }
        if (!player.options.thumbnailSelectorEnabled) {
          return;
        }
        button = $("<div class='mejs-button mejs-thumbnail-selector'>                    <button type='button' aria-controls='mep_0' title='Create thumbnail' aria-label='Create thumbnail'/>                  </div>");
        button.appendTo(controls);
        return button.click(function(event) {
          var $template, baseURL, offset, posterURL;
          baseURL = $('.mejs-poster.mejs-layer img').attr('src').split('/').slice(0, -1).join('/');
          posterURL = "" + baseURL + "/poster";
          offset = player.getCurrentTime();
          $template = $(player.thumbnailSelectorConfirmationTemplate({
            offset: offset,
            posterURL: posterURL
          }));
          $template.find('.btn.btn-primary').click(function(event) {
            var that;
            that = this;
            return $.ajax({
              url: posterURL,
              type: 'post',
              data: {
                offset: offset
              },
              complete: function(response) {
                $template.modal('hide');
                return location.reload();
              }
            });
          });
          return $template.modal('show');
        });
      }
    });
  })(mejs.$);

}).call(this);
