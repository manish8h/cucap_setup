module JavaScriptHelpers
  def wait_for_ajax(wait_time = Capybara.default_max_wait_time)
    Timeout.timeout(wait_time) do
      loop do
        active = page.evaluate_script('jQuery.active')
        break if active == 0
        sleep(0.1)
      end
    end
  end

  def scroll_down(x = 0, y = 1300)
    page.execute_script "window.scrollBy(#{x},#{y})"
  end

end