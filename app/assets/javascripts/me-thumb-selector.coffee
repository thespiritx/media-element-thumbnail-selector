(($)->

  $.extend mejs.MepDefaults,
    thumbnailSelectorEnabled: false
    thumbnailSelectorUpdateURL: ''
    thumbnailSelectorOnMobile: false

  $.extend MediaElementPlayer::,
    buildthumbnailSelector: (player, controls, layers, media) ->
      
      # No support for audio tracks yet
      return unless player.isVideo
      return unless player.options.thumbnailSelectorEnabled
      return if !player.options.thumbnailSelectorOnMobile && (mejs.Features.isiOS || mejs.Features.isAndroid)

      $offset = 0
      $stillURL = ''
      $confirm_dlg = $ """
        <div class="modal fade">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">
              <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                  <h3>
                      Update Poster Image
                  </h3>
              </div>

                <div class="modal-body">
                  <div class="media">
                      <a href="#">
                        <img class="media-object fit-width" class='img-polaroid' src="data:">
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
          </div>
        </div>
      """
      $confirm_dlg.find('.btn.btn-primary').click (event) ->
        that = this
        $.ajax
          url: $stillURL
          type: 'post'
          data:
            offset: $offset
          complete: (response) ->
            $confirm_dlg.modal 'hide'
            location.reload()

      $('body').append($confirm_dlg)

      button = $("<div class='mejs__button mejs__thumbnail-selector'>
                    <button type='button' aria-controls='mep_0' title='Create thumbnail' aria-label='Create thumbnail'/>
                  </div>")
      button.appendTo(controls)

      button.click (event) ->
        baseURL = $('.mejs__poster.mejs__layer img').attr('src').split('/').slice(0,-1).join('/')
        posterURL = "#{baseURL}/poster"
        $stillURL = "#{baseURL}/still"
        $offset = player.getCurrentTime()
        previewURL = "#{posterURL}?offset=#{$offset}&preview=true"
        
        $confirm_dlg.find('img').attr('src',previewURL)


        $confirm_dlg.modal 'show'
          
)(mejs.$)
