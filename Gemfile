source 'https://rubygems.org'

gem 'rake'
gem 'motion-fontawesome'
gem 'awesome_print_motion'
gem 'ProMotion'
gem 'motion-weakattr'
gem 'motion-kit'
gem 'sugarcube'

LOCAL_GNUARD_MOTION = '/Users/yoshi/src/motion/guard-motion'

group :spec, :development, :test do
  gem 'motion-redgreen'
  gem 'guard-motion', path: LOCAL_GNUARD_MOTION if File.exist?(LOCAL_GNUARD_MOTION)
  gem 'rspec', '< 3.0.0' # 3.0.0になった瞬間、2014年春に作ったFrankテストが動かなくなる！
  gem 'motion-frank'
end