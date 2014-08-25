require 'digest'
require 'shaman/version'
require 'oj'

class Shaman
  attr_reader :body

  def initialize(body)
    @body = body.to_s
  end

  def sha
    Digest::MD5.hexdigest(prepped_body.to_s)
  end

  def valid_json_body?
    parsed_body.class == Hash
  end

  private

  def prepped_body
    if valid_json_body?
      sorted_hash(parsed_body)
    else
      parsed_body
    end
  end

  def parsed_body
    @parsed_body ||= Oj.load(body)
  rescue Oj::ParseError
    body
  end

  def sorted_hash(obj)
    return obj unless obj.is_a?(Hash)
    hash = Hash.new
    obj.each { |k, v| hash[k] = sorted_hash(v) }
    sorted = hash.sort { |a, b| a[0].to_s <=> b[0].to_s }
    Hash[sorted]
  end

end
