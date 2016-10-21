jQuery ->
  if $('#infinite-scrolling').size() > 0
			$(window).on 'scroll', ->
				more_posts_url = $('.pagination a.next_page').attr('href')
        
				if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
            $('.pagination').html('<img width="100" src="/assets/progress.gif" alt="Loading..." title="Loading..." />').delay(2000)

            $.getScript more_posts_url
        return
      return