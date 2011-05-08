#This customization of the Page class adds cache clearing after the 
#expire_page_cache callback, which is invoked on page adds and 
#deletes.  This customization clears the header & footer caches
#whenever pages are added or removed so that they navigation 
#bar links at the top and bottom of all pages can be regenerated.
class PageCustomizer
  def self.load
    Page.class_eval do
      class << self
        alias orig_expire_page_caching expire_page_caching

        def expire_page_caching
          orig_expire_page_caching
          if File.writable?(Rails.cache.cache_path)
            Pathname.glob(File.join(Rails.cache.cache_path, '**', '*header*')).each(&:delete)
            Pathname.glob(File.join(Rails.cache.cache_path, '**', '*footer*')).each(&:delete)
          end
        end
      end
    end
  end
end
