(($)->

  $.extend mejs.MepDefaults,
    thumbnailSelectorEnabled: false
    thumbnailSelectorUpdateURL: ''

  $.extend MediaElementPlayer::,
    thumbTemplate: () ->
      """
        <div class="modal hide fade">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3>
                    Modal header
                </h3>
            </div>
            <div class="modal-body">
                <p>
                    One fine body…
                </p>
            </div>
            <div class="modal-footer">
                <a href="#" class="btn">Close</a> <a href="#" class="btn btn-primary">Save changes</a>
            </div>
        </div>
      """
    buildthumbnailSelector: (player, controls, layers, media, s) ->

      # No support for audio tracks yet
      return unless player.isVideo
      return unless player.options.thumbnailSelectorEnabled and player.options.thumbnailSelectorUpdateURL

      button = $("<div class='mejs-button mejs-thumbnail-selector'>
                    <button type='button' aria-controls='mep_0' title='Create thumbnail' aria-label='Create thumbnail'/>
                  </div>")

      button.appendTo(controls)
      button.bind 'click', (event) ->
        seconds = player.getCurrentTime()
        $.ajax
          url: player.options.thumbnailSelectorUpdateURL
          data: seconds
          complete: (response) ->
            location.reload()
            

        $template = $(player.thumbTemplate())
        


        # $(player.thumbTemplate()).modal()

        # .bind 'click', (event) ->
        #     title: 'hi'
        #   seconds = player.getCurrentTime()
        # if confirm('Are you sure you want to update the thumbnail?')
        #   $.ajax
        #     url: player.options.thumbnailUpdateURL
        #     complete: (response) ->
        #       if response.text?
        #         alert response.text
        #       else
        #         alert 'There was an error.  Please try again'

        # title: 'hiiii'




)(mejs.$)