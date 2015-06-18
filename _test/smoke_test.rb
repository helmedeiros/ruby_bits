#!/usr/bin/env ruby
# Smoke + content validation for the RubyBits GitHub Pages portal.
#
# Walks _data/tracks.yml, hits every URL, asserts 200, verifies lesson
# pages contain their title + at least one activity form, and parses every
# `data-spec` as Ruby with `ruby -c`. Exits non-zero on any failure.
#
# Usage:
#   ruby _test/smoke_test.rb                                  # live
#   BASE=http://localhost:4000/ruby_bits ruby _test/smoke...  # local jekyll
#
require 'net/http'
require 'uri'
require 'yaml'
require 'tempfile'

BASE   = ENV.fetch('BASE', 'https://helmedeiros.github.io/ruby_bits').chomp('/')
TRACKS = YAML.load_file(File.expand_path('../../_data/tracks.yml', __FILE__))

@failures = []
@checks   = 0

def get(path)
  uri = URI("#{BASE}#{path}")
  res = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https',
                       open_timeout: 5, read_timeout: 10) do |h|
    h.get(uri.request_uri)
  end
  [res.code.to_i, res.body.to_s.force_encoding('UTF-8')]
end

def check(desc)
  @checks += 1
  ok, msg = yield
  if ok
    puts "  \e[32m✓\e[0m #{desc}"
  else
    puts "  \e[31m✗\e[0m #{desc}#{msg ? " — #{msg}" : ''}"
    @failures << "#{desc}#{msg ? " — #{msg}" : ''}"
  end
end

def decode_attr(s)
  s.gsub('&amp;', '&').gsub('&lt;', '<').gsub('&gt;', '>')
   .gsub('&quot;', '"').gsub('&#39;', "'")
end

def parses_as_ruby?(src)
  Tempfile.create(['spec', '.rb']) do |f|
    f.write(src); f.flush
    out = `ruby -c #{f.path} 2>&1`
    return [$?.success?, out.strip]
  end
end

puts "smoke: #{BASE}"
puts

# 1. Landing pages
['/', '/about/', '/tracks/'].each do |path|
  check("GET #{path}") do
    code, _ = get(path)
    [code == 200, "HTTP #{code}"]
  end
end

# 2. Each track index
TRACKS.each do |t|
  tpath = "/tracks/#{t['slug']}/"
  body  = nil

  check("GET #{tpath}") do
    code, body = get(tpath)
    Thread.current[:body] = body
    [code == 200, "HTTP #{code}"]
  end
  body = Thread.current[:body]

  check("#{tpath} mentions track name '#{t['name']}'") do
    [body.to_s.include?(t['name']), nil]
  end

  t['lessons'].each do |l|
    lpath = "/tracks/#{t['slug']}/#{l['slug']}/"
    lbody = nil

    check("GET #{lpath}") do
      code, lbody = get(lpath)
      Thread.current[:lbody] = lbody
      [code == 200, "HTTP #{code}"]
    end
    lbody = Thread.current[:lbody].to_s

    check("#{lpath} renders title '#{l['title']}'") do
      [lbody.include?(l['title']), nil]
    end

    forms = lbody.scan(/<form class="activity-form" data-kind="(code|choice)"/)
    check("#{lpath} has ≥ 1 activity form") do
      [!forms.empty?, "found #{forms.size}"]
    end

    # parse each code-activity's data-spec
    specs = lbody.scan(/<form class="activity-form" data-kind="code" data-spec="([^"]*)"/m)
    specs.each_with_index do |(raw), i|
      spec = decode_attr(raw)
      check("#{lpath} activity ##{i + 1} spec_code parses as ruby") do
        ok, err = parses_as_ruby?(spec)
        [ok, ok ? nil : err]
      end
    end

    # parse each starter as well — a syntax error in starter trips users
    starters = lbody.scan(%r{<textarea class="code-editor"[^>]*>(.*?)</textarea>}m)
    starters.each_with_index do |(raw), i|
      starter = decode_attr(raw)
      check("#{lpath} starter ##{i + 1} parses as ruby") do
        ok, err = parses_as_ruby?(starter)
        [ok, ok ? nil : err]
      end
    end
  end
end

puts
if @failures.empty?
  puts "\e[32mPASS\e[0m  #{@checks} checks"
  exit 0
else
  puts "\e[31mFAIL\e[0m  #{@failures.size}/#{@checks} failed"
  exit 1
end
