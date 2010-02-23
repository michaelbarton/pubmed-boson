# Originally from http://github.com/michaelbarton/pubmed-boson/raw/master/pubmed.rb
module PubMed

  def self.included(mod)
    require 'bio'
  end

  # @options :email => :string, :number => 5, :year => :numeric,
  #  :authors => :array, :journal => :string, :terms => :string
  # @render_options :fields => {
  #   :default => [:first_author, :year, :title],
  #   :values  => [:PMID, :first_author, :year, :journal, :title, :url],
  #   }
  # @config :menu => {:command => 'browser', :default_field => :url}
  # @desc Queries pubmed by term, author, journal and year
  def query(options={})
    query = String.new
    query << " #{options[:year]} [dp]" if options[:year]
    query << " #{options[:journal]} [ta]" if options[:journal]
    options[:authors].each{|a| query << " #{a} [au]"} if options[:authors]
    query << " #{options[:terms]}" if options[:terms]

    results = Bio::PubMed.esearch(query, "email" => options[:email])
    results = results[0..(options[:number]-1)]
    results.map do |result|
      m = Bio::MEDLINE.new(Bio::PubMed.query(result))
      {:title        => m.title,         :year   => m.year,
       :first_author => m.authors.first, :PMID   => m.pmid,
       :journal      => m.journal,
       :url          => 'http://www.ncbi.nlm.nih.gov/pubmed/' + m.pmid
      }
    end
  end

end
