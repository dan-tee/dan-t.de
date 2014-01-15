module TableHelper
  def column_content_xpath(column_header, content)
    xpath_count = "count(//table/thead/tr/th[normalize-space()='#{column_header}']/preceding-sibling::th)"
    "//table/tbody/tr/td[#{xpath_count}+1 and normalize-space()='#{content}']"
  end
end