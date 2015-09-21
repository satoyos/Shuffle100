require_relative 'spec_helper'

describe "起動テスト" do
  TITLE = '百首読み上げ'
  it "アプリのタイトルが正しく表示される" do
    title = find_element(:name, TITLE).text
    expect(title).to include TITLE
  end
end