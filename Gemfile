source 'https://rubygems.org'

gem 'rake'
gem 'sugarcube'
gem 'motion-kit'
gem 'ProMotion', git: 'git@github.com:clearsightstudio/ProMotion.git'
gem 'motion-weakattr'
gem 'motion-dynamic-type'
gem 'motion-awesome'
gem 'awesome_print_motion'
gem 'newclear'

group :simulator do # rake simulator
  gem 'motion-cocoapods'
end

group :spec do # rake spec
  gem 'motion-redgreen'
  gem 'rspec', '< 3.0.0' # 3.0.0になった瞬間、2014年春に作ったFrankテストが動かなくなる！
end

group :frank do # rake frank
  gem 'i18n', '< 0.7' # 0.7になると、FrankテストでI18n::InvalidLocaleの例外が発生する。
  gem 'motion-frank'
end

