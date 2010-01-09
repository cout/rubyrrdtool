#!/usr/bin/env ruby 

class Errand
  def initialize(opts={})
    raise ArgumentError unless opts[:filename]
    @filename = opts[:filename]
    @backend = ::ErrandBackend
  end

  def dump(opts={})
    output = opts[:filename] || ""
    @backend.dump(@filename, output)
  end

  def last
    @backend.last(@filename)
  end

  def fetch(opts={})
    start  = (opts[:start] || Time.now.to_i - 3600).to_s
    finish = (opts[:finish] || Time.now.to_i).to_s
    function = opts[:function] ? opts[:function].to_s.upcase : "AVERAGE"

    args = [@filename, "--start", start, "--end", finish, function]

    data = @backend.fetch(*args)
    start  = data[0]
    finish = data[1]
    labels = data[2]
    values = data[3]
    points = {}

    # compose a saner representation of the data
    labels.each_with_index do |label, index|
      points[label] = []
      values.each do |tuple|
        value = tuple[index].nan? ? nil : tuple[index]
        points[label] << value
      end
    end

    {:start => start, :finish => finish, :data => points}
  end

  def create(opts={})
    step  = (opts[:step] || 300).to_s
    start = (opts[:start] || Time.now.to_i - 10).to_s

    options = ["--step", step, "--start", start]

    sources = opts[:sources].map { |source|
      name      = source[:name]
      type      = source[:type].to_s.upcase
      heartbeat = source[:heartbeat]
      min       = source[:min]
      max       = source[:max]

      ds = ["DS", name, type]
      ds += [heartbeat, min, max] if heartbeat && min && max

      ds.join(':')
    }

    archives = opts[:archives].map { |archive|
      function = archive[:function].to_s.upcase
      xff      = archive[:xff]
      steps    = archive[:steps]
      rows     = archive[:rows]

      rra = ["RRA", function]
      rra += [xff, steps, rows] if xff && steps && rows

      rra.join(':')
    }

    args = options + sources + archives
    @backend.create(@filename, *args) # * "flattens" the array
  end

  def update(opts={})
    if opts[:sources].find { |source| source[:time] }
      times = opts[:sources].map {|s| s[:time]}.uniq
      
      if times.size == 1
        sources = opts[:sources].map { |s|
          s[:name]
        }.join(':')

        values = "#{times.first}:" + opts[:sources].map { |s|
          s[:value]
        }.join(':')

        args = ["--template", sources, values]
        @backend.update(@filename, *args)
      end

    else
      sources = opts[:sources].map { |source|
        source[:name]
      }.join(':')

      values = "N:" + opts[:sources].map { |source|
        source[:value]
      }.join(':')

      @backend.update(@filename, values)
    end
    true
  end

  def info
    @backend.info(@filename)
  end

  # ordered array of data sources as defined in rrd
  def data_sources
    self.info.keys.grep(/^ds\[/).map { |ds| ds[3..-1].split(']').first}.uniq                                                                                    
  end

end
