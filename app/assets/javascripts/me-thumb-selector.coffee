(($)->

  $.extend mejs.MepDefaults,
    thumbnailSelectorEnabled: false
    thumbnailSelectorUpdateURL: ''

  $.extend MediaElementPlayer::,
    thumbnailSelectorConfirmationTemplate: ( context) ->
      """     
        <div class="modal hide fade">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3>
                    Update Poster Image
                </h3>
            </div>

              <div class="modal-body">
                <div class="media">
                    <a class="pull-left" href="#">
                  <img class="media-object" class='img-polaroid' src="#{context.posterURL}?offset=#{context.offset}&preview=true" style="width: 64px; height: 64px;">
                    </a>
                  <div class="media-body">
                    <h4 class="media-heading"></h4> 
                    This will update the poster and thumbnail images for this video.
                  </div>
                </div>
              </div>
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn">Cancel</a> <a href="#" class="btn btn-primary">Update Poster Image</a>
            </div>
        </div>
      """
    buildthumbnailSelector: (player, controls, layers, media) ->
      
      # No support for audio tracks yet
      return unless player.isVideo
      return unless player.options.thumbnailSelectorEnabled

      button = $("<div class='mejs-button mejs-thumbnail-selector'>
                    <button type='button' aria-controls='mep_0' title='Create thumbnail' aria-label='Create thumbnail'/>
                  </div>")
      button.appendTo(controls)

      button.click (event) ->
        baseURL = $('.mejs-poster.mejs-layer img').attr('src').split('/').slice(0,-1).join('/')
        posterURL = "#{baseURL}/poster"
        stillURL = "#{baseURL}/still"
        offset = player.getCurrentTime()

        $template = $ player.thumbnailSelectorConfirmationTemplate offset: offset, posterURL: posterURL
        $template.find('.btn.btn-primary').click (event) ->
          that = this
          $.ajax
            url: stillURL
            type: 'post'
            data:
              offset: offset
            complete: (response) ->
              $template.modal 'hide'
              location.reload()

        $template.modal 'show'
          
)(mejs.$)