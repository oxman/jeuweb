module ApplicationHelper
  def prettify_message(content)
    regexp = /(\[code=([^\]]+)\](.+?)\[\/code\])/im
    result = (content ? content.dup : '')
    blocks = {}

    # Replace code blocks by placeholders.
    result.scan(regexp).each_with_index do |(block, syntax, code), index|
      blocks[index] = [ code, syntax ]
      placeholder = "[code=#{index}][/code]"
      result.gsub!(block, placeholder)
    end

    # Then BBCode the content.
    result.bbcode_to_html_with_formatting!

    # Replace placeholders by Pygmentized content.
    blocks.each do |index, (code, syntax)|
      placeholder = "[code=#{index}][/code]"
      result.gsub!(placeholder, Pygments.highlight(code, lexer: syntax.downcase))
    end

    result.html_safe
  end


  def avatar(user, size)
    content_tag :div, class: 'avatar' do
      image_tag(user.avatar_url, size: "#{size}x#{size}")
    end
  end
end
