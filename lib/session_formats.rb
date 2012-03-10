module SessionFormats
  def self.included(base)
    base.instance_eval 'def self.format_options; %w(keynote workshop elc talk lightning undefined strange\ passions panel miscellaneous); end'
  end
end
