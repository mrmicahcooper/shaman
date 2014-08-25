require 'shaman/version'
require 'digest'
require 'oj'
require 'active_support/core_ext/hash/conversions'

class Shaman
  attr_reader :body

  def initialize(body)
    @body = body.to_s
  end

  def sha
    Digest::MD5.hexdigest(prepped_body.to_s)
  end

  def valid_json?
    parsed_json.class == Hash
  end
  alias valid_json_body? valid_json?

  def valid_xml?
    parsed_xml.class == Hash
  end

  def parsed_json
    @parsed_json ||= Oj.load(body)
  rescue Oj::ParseError
    body
  end

  def parsed_xml
    @parsed_xml ||= Hash.from_xml(body)
  rescue REXML::ParseException
    body
  end

  def prepped_body
    sort_body = parsed_json or parsed_xml or body
    sorted_hash(sort_body)
  end

  def sorted_hash(obj)
    return obj unless obj.is_a?(Hash)
    hash = Hash.new
    obj.each { |k, v| hash[k] = sorted_hash(v) }
    sorted = hash.sort { |a, b| a[0].to_s <=> b[0].to_s }
    Hash[sorted]
  end

end
