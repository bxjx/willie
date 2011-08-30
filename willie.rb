#!/usr/bin/env ruby
LINES_IN_BLOCK  = 50
line_count = 0
aggregate = []
ARGF.each do |line|
  columns = line.split
  date = columns[0..7].join(' ')
  data = columns[21..-1].map(&:to_i)
  if aggregate.empty?
    aggregate = data
  else
    data.each_with_index do |datum, index|
      aggregate[index] += datum
    end
  end
  line_count += 1
  if line_count == LINES_IN_BLOCK
    puts ([date] + aggregate.map{|a| a.to_f / LINES_IN_BLOCK }).join(',')
    line_count = 0
    aggregate = []
  end
end
