require 'active_support'
require 'ancestry'
require 'enumerize'
require 'carrierwave'
require 'active_delegate'
require 'cms_basics/version'

module CmsBasics
  extend ActiveSupport::Concern

  autoload :Taxonomizable, 'cms_basics/taxonomizable'
  autoload :Templatable,   'cms_basics/templatable'
  autoload :Uploadable,    'cms_basics/uploadable'
  autoload :Attachable,    'cms_basics/attachable'
  autoload :Relatable,     'cms_basics/relatable'
  autoload :Metable,       'cms_basics/metable'
  autoload :Profileable,   'cms_basics/profileable'

  included do
    include CmsBasics::Taxonomizable
    include CmsBasics::Templatable
    include CmsBasics::Uploadable
    include CmsBasics::Attachable
    include CmsBasics::Relatable
    include CmsBasics::Metable
    include CmsBasics::Profileable
  end
end

module Cms
  extend ActiveSupport::Concern

  autoload :Attachment,     'cms_basics/models/attachment'
  autoload :Content,        'cms_basics/models/content'
  autoload :Metum,          'cms_basics/models/metum'
  autoload :Profile,        'cms_basics/models/profile'
  autoload :Relation,       'cms_basics/models/relation'
  autoload :Taxonomization, 'cms_basics/models/taxonomization'
  autoload :Taxonomy,       'cms_basics/models/taxonomy'
  autoload :Template,       'cms_basics/models/template'
  autoload :Upload,         'cms_basics/models/upload'
end

ActiveSupport.on_load(:active_record) do
  include CmsBasics
  include Cms
end
