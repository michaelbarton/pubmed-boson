require 'bio'

module PubMed

  # @options :email => :string, :number => 5, :year => :numeric,
  #  :authors => :array, :journal => :string
  # @render_options :fields => {
  #   :default => [:PMID, :first_author, :year, :journal, :title]}
  def query(terms,options={})
    query = String.new
    query << " #{options[:year]} [dp]" if options[:year]
    query << " #{options[:journal]} [ta]" if options[:journal]
    options[:authors].each{|a| query << " #{a} [au]"} if options[:authors]

    results = Bio::PubMed.esearch(query << terms,"email" => options[:email])
    results = results[0..(options[:number]-1)]
    results.map do |result|
      m = Bio::MEDLINE.new(Bio::PubMed.query(result))
      {:title        => m.title,         :year   => m.year,
       :first_author => m.authors.first, :PMID   => m.pmid,
       :journal      => m.journal
      }
    end
  end

end
