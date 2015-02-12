module ControlHelper
  def select_random_option(select)
    options = select.all("option")
    options[rand(options.length)].select_option
  end

  def toggle_switch(switch_id)
    page.execute_script("$('#{switch_id}').bootstrapSwitch('toggleState')")
  end

  def toggle_all_switches
    page.execute_script("$('input[type=checkbox]').bootstrapSwitch('toggleState')")
  end

  def random_area
    (rand() + rand(100)).round(1)
  end
end

RSpec.configure do |config|
  config.include ControlHelper, type: :feature
end