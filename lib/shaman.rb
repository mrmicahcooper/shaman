require 'shaman/version'
require 'digest'
require 'oj'
require 'rack'
require 'active_support/core_ext/hash/conversions'

class Shaman
  attr_reader :body

  def initialize(body)
    @body = body
  end

  def sha
    Digest::MD5.hexdigest(sorted_hash(prepped_body).to_s)
  end

  def valid_json?
    parsed_json.class == Hash
  end
  alias valid_json_body? valid_json?

  def valid_xml?
    parsed_xml.class == Hash
  end

  def valid_hash?
    body.class == Hash
  end

  def body_hash
    return body if valid_hash?
    false
  end

  def parsed_json
    Oj.load(body)
  rescue Oj::ParseError
    false
  end

  def parsed_xml
    Hash.from_xml(body)
  rescue REXML::ParseException
    false
  end

  def parsed_form
    Rack::Utils.parse_nested_query(body)
  end

  def prepped_body
    body_hash or parsed_json or parsed_xml or parsed_form
  end

  def sorted_hash(obj)
    return obj unless obj.is_a?(Hash)
    hash = Hash.new
    obj.each { |k, v| hash[k] = sorted_hash(v) }
    sorted = hash.sort { |a, b| a[0].to_s <=> b[0].to_s }
    Hash[sorted].stringify_keys
  end

end
