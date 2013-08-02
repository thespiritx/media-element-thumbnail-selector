(($)->

  $.extend mejs.MepDefaults,
    thumbnailSelectorEnabled: false
    thumbnailSelectorUpdateURL: ''

  $.extend MediaElementPlayer::,
    thumbnailSelectorConfirmationTemplate: () ->
      """
        <div class="modal hide fade">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3>
                    Update Thumbnail
                </h3>
            </div>
            <div class="modal-body">
                <p>
                    Clicking update will change the thumbnail and poster image.
                </p>
            </div>
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn">Cancel</a> <a href="#" class="btn btn-primary">Update</a>
            </div>
        </div>
      """
    thumbnailSelectorUpdateThumbnail: (url, seconds) ->
      $.ajax
        url: url
        data:
          seconds: seconds


    buildthumbnailSelector: (player, controls, layers, media, s) ->
      
      # No support for audio tracks yet
      return unless player.isVideo
      return unless player.options.thumbnailSelectorEnabled and player.options.thumbnailSelectorUpdateURL

      button = $("<div class='mejs-button mejs-thumbnail-selector'>
                    <button type='button' aria-controls='mep_0' title='Create thumbnail' aria-label='Create thumbnail'/>
                  </div>")
      button.appendTo(controls)
      button.click (event) ->
        seconds = player.getCurrentTime()
        updateURL = player.options.thumbnailSelectorUpdateURL
        $template = $ player.thumbnailSelectorConfirmationTemplate()
        $template.find('.btn.btn-primary').click (event) ->
          player.thumbnailSelectorUpdateThumbnail( updateURL, seconds ).complete (response) ->
            location.reload()
        $template.modal 'show'
          
)(mejs.$)