module SessionFormats
  def self.included(base)
    base.instance_eval 'def self.format_options; %w(keynote workshop free\ workshop elc fpw talk lightning undefined unsession strange\ passions panel miscellaneous); end'
  end
end
