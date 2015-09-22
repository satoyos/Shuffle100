require_relative 'spec_helper'
require 'uri'

TITLE = '百首読み上げ'


def print_inf_for_compare(str)
  ap str
  puts "title[#{str.class}, length=#{str.length}, #{str.encoding}]"
  puts "  inspect => #{str.inspect}"
  puts "  URI-escape => #{URI.escape(str)}"
end

describe "起動テスト" do
  it "アプリのタイトルが正しく表示される" do
    title = find_element(:name, TITLE).text
    print_inf_for_compare(title)
    puts
    print_inf_for_compare(TITLE)
    expect(title).to eq TITLE
  end
end


