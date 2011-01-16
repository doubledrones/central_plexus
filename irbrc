
begin
  require 'wirble'
rescue LoadError
end

begin
  require 'hirb'
rescue LoadError
end

# Awesome Print
# https://github.com/michaeldv/awesome_print
begin
  require "ap"
  ap object, options = {}
rescue LoadError
end

if Object.const_defined?('Wirble')
  Wirble.init
  Wirble.colorize
end

# hirb (active record output format in table)
if Object.const_defined?('Hirb')
  Hirb::View.enable
end

# IRB Options
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:EVAL_HISTORY] = 200

# Log to STDOUT if in Rails
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
  #IRB.conf[:USE_READLINE] = true

  # Display the RAILS ENV in the prompt
  # ie : [Development]>>
  IRB.conf[:PROMPT][:CUSTOM] = {
   :PROMPT_N => "\033[0;32m[#{ENV["RAILS_ENV"].capitalize}] \033[0;34m> \033[0;0m",
   :PROMPT_I => "\033[0;32m[#{ENV["RAILS_ENV"].capitalize}] \033[0;34m> \033[0;0m",
   :PROMPT_S => nil,
   :PROMPT_C => "\033[0;34m?> \033[0;0m",
   :RETURN => "=> %s\n"
   }
  # Set default prompt
  IRB.conf[:PROMPT_MODE] = :CUSTOM
end
