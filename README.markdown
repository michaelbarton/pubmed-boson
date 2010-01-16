# Boson command for searching pubmed

This is a [boson][] command for searching the [PubMed][] database of biomedical articles and abstracts. This library allows articles to be queried more efficiently at the command line as opposed to navigating the PubMed website in a browser. Suggestions and patches are welcome through the [github repository][] or though [github issues][].

## Quick start

    > gem install boson bio
    > boson install http://github.com/michaelbarton/pubmed-boson/raw/master/pubmed.rb
    > boson pubmed query genome --mail="YOUR_EMAIL"

    +----------+--------------+--------------+--------------+------+
    | PMID     | first_author | journal      | title        | year |
    +----------+--------------+--------------+--------------+------+
    | 20077411 | Weiss, M.    | Proteomics   | Shotgun p... | 2010 |
    | 20077410 | van Breuk... | Proteomics   | LysNDeNov... | 2010 |
    | 20077118 | Leocard, S.  | J Math Biol  | Evolution... | 2010 |
    | 20077036 | Collas, P.   | Mol Biote... | The Curre... | 2010 |
    | 20076992 | Kopertekh... | Plant Mol... | Cre-media... | 2010 |
    +----------+--------------+--------------+--------------+------+

## Search options

This command has additional options which allows PubMed to be queried more specifically. Boson lists these options automatically and each option is explained below.

    > boson -hv query
    > query [terms][--authors=A,B,C] [--number=5] [--year=N] [--email=EMAIL]

    LOCAL OPTIONS
    +-----------+-------+---------+
    | Option    | Alias | Type    |
    +-----------+-------+---------+
    | --authors | -a    | array   |
    | --email   | -e    | string  |
    | --journal | -j    | string  |
    | --number  | -n    | numeric |
    | --year    | -y    | numeric |
    +-----------+-------+---------+

### Email address

NCBI requires that all programmatic queries to the API provide an email address so that the author can be contacted if there is a problem. This means an email address must be provided when using this library. Fortunately boson allows default options to be added so that you don't need to add your email address every time you run a command. For example add this to your ~/.boson/config/boson.yml 

    :libraries:
      pubmed:
        :commands:
          query:
            :options:
              :email: YOUR_EMAIL

Which allows

    # This ...
    > boson query genome --email="YOUR_EMAIL"

    # ... to be written more concisely as this.
    > boson query genome

### Number of results

By default the first five results are returned for each query. This can however be changed using the --number option. Be warned though, more results will take longer to return.

    # These commands both return the same result.
    # The second uses the shorter option alias
    > boson query genome --number=3
    > boson query genome -n3

    +----------+-------------------+-------------+-------------------+------+
    | PMID     | first_author      | journal     | title             | year |
    +----------+-------------------+-------------+-------------------+------+
    | 20077411 | Weiss, M.         | Proteomics  | Shotgun proteo... | 2010 |
    | 20077410 | van Breukelen, B. | Proteomics  | LysNDeNovo: an... | 2010 |
    | 20077118 | Leocard, S.       | J Math Biol | Evolution of t... | 2010 |
    +----------+-------------------+-------------+-------------------+------+

### Search by author, journal, and year

These options allow PubMed to be queried using specific article terms such as the names of authors, year published, or the journal in which it was published. Terms can be used individually or combined into larger queries.

    # These two commands are the same
    > boson query genome --journal=bioinformatics --authors=smith --year=2005
    > boson query genome -j=bioinformatics -a=smith -y2005

    +----------+---------------+----------------+--------------------+------+
    | PMID     | first_author  | journal        | title              | year |
    +----------+---------------+----------------+--------------------+------+
    | 16216832 | Goldovsky, L. | Bioinformatics | CoGenT++: an ex... | 2005 |
    | 15961502 | Cheung, K. H. | Bioinformatics | YeastHub: a sem... | 2005 |
    | 15333453 | Sumazin, P.   | Bioinformatics | DWE: discrimina... | 2005 |
    +----------+---------------+----------------+--------------------+------+

## Display options

Boson has tools for sorting and displaying fields already baked in. This allows only only a subset of fields to be displayed, for example:

    > boson query genome --fields=PMID,title
    > boson query genome -f=P,t
    +----------+----------------------------------------------------------------+
    | PMID     | title                                                          |
    +----------+----------------------------------------------------------------+
    | 20077411 | Shotgun proteomics data from multiple organisms reveals rem... |
    | 20077410 | LysNDeNovo: an algorithm enabling de novo sequencing of Lys... |
    | 20077118 | Evolution of the ancestral recombination graph along the ge... |
    | 20077036 | The Current State of Chromatin Immunoprecipitation.            |
    | 20076992 | Cre-mediated seed-specific transgene excision in tobacco.      |
    +----------+----------------------------------------------------------------+

Or for the returned results to be displayed vertically and sorted by first author name:

    boson query genome --fields=PMID,first_author,year --vertical --sort=first_author
    boson query genome -f=P,f,y -V -s=f
    ****************** 1. row ******************
            PMID: 20077036
    first_author: Collas, P.
            year: 2010
    ****************** 2. row ******************
            PMID: 20076992
    first_author: Kopertekh, L.
            year: 2010
    ****************** 3. row ******************
            PMID: 20077118
    first_author: Leocard, S.
            year: 2010

## Credits

This is only a few lines of code that builds upon the excellent [boson] tool by [Gabriel Horner][]. Pubmed is fetched and parsed using the [bioruby][] library.

[boson]: http://github.com/cldwalker/boson
[Gabriel Horner]: http://tagaholic.me/
[bioruby]: http://bioruby.org/
[PubMed]: http://www.ncbi.nlm.nih.gov/pubmed/
[github repository]: http://github.com/michaelbarton/pubmed-boson
[github issues]: http://github.com/michaelbarton/pubmed-boson/issues
