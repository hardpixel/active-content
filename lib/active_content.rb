require 'active_support'
require 'ancestry'
require 'enumerize'
require 'carrierwave'
require 'active_delegate'
require 'active_content/version'

module ActiveContent
  extend ActiveSupport::Concern

  autoload :Taxonomizable,  'active_content/taxonomizable'
  autoload :Templatable,    'active_content/templatable'
  autoload :Uploadable,     'active_content/uploadable'
  autoload :Attachable,     'active_content/attachable'
  autoload :Relatable,      'active_content/relatable'
  autoload :Metable,        'active_content/metable'
  autoload :Profileable,    'active_content/profileable'

  autoload :Attachment,     'active_content/models/attachment'
  autoload :Content,        'active_content/models/content'
  autoload :Metum,          'active_content/models/metum'
  autoload :Profile,        'active_content/models/profile'
  autoload :Relation,       'active_content/models/relation'
  autoload :Taxonomization, 'active_content/models/taxonomization'
  autoload :Taxonomy,       'active_content/models/taxonomy'
  autoload :Template,       'active_content/models/template'
  autoload :Upload,         'active_content/models/upload'

  included do
    include ActiveContent::Taxonomizable
    include ActiveContent::Templatable
    include ActiveContent::Uploadable
    include ActiveContent::Attachable
    include ActiveContent::Relatable
    include ActiveContent::Metable
    include ActiveContent::Profileable
  end
end

ActiveSupport.on_load(:active_record) do
  include ActiveContent
end
