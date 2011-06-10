# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )

  inflect.plural(/r$/i,   'res')
  inflect.plural(/al$/i,  'ais')
  inflect.plural(/el$/i,  'eis')
  inflect.plural(/ol$/i,  'ois')
  inflect.plural(/ul$/i,  'uis')
  inflect.plural(/m$/i,   'ns')
  inflect.plural(/ao$/i,  'oes')

  inflect.singular(/res$/i, '\1r')
  inflect.singular(/oes$/i, '\1ao')
  inflect.singular(/ais$/i, '\1al')

end

