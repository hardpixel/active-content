require 'active_support'
require 'ancestry'
require 'enumerize'
require 'carrierwave'
require 'active_delegate'
require 'cms_basics/models/template'
require 'cms_basics/models/categorization'
require 'cms_basics/models/tagging'
require 'cms_basics/models/attachment'
require 'cms_basics/version'

module CmsBasics
  extend ActiveSupport::Concern

  autoload :Taxonomizable, 'cms_basics/taxonomizable'
  autoload :Templatable,   'cms_basics/templatable'
  autoload :Uploadable,    'cms_basics/uploadable'
  autoload :Attachable,    'cms_basics/attachable'

  included do
    include CmsBasics::Taxonomizable
    include CmsBasics::Templatable
    include CmsBasics::Uploadable
    include CmsBasics::Attachable
  end
end

ActiveSupport.on_load(:active_record) do
  include CmsBasics
end
