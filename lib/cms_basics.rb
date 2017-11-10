require 'active_support'
require 'ancestry'
require 'enumerize'
require 'carrierwave'
require 'cms_basics/callbacks'
require 'cms_basics/taxonomizable'
require 'cms_basics/templatable'
require 'cms_basics/attachable'
require 'cms_basics/models/template'
require 'cms_basics/models/categorization'
require 'cms_basics/models/tagging'
require 'cms_basics/models/attachment'
require 'cms_basics/version'

module CmsBasics
end

ActiveSupport.on_load(:active_record) do
  include Cms::Callbacks
end
