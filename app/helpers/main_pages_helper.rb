module MainPagesHelper
  def tab_active(link_page, current_page)
    # the yield for current page returns a ActiveSupport::SafeBuffer
    return 'active' if link_page == current_page.to_str
    ''
  end
end
