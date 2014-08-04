require "shaman/version"
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
      Hash[parsed_body.sort]
    else
      parsed_body
    end
  end

  def parsed_body
    @parsed_body ||= Oj.load(body)
  rescue Oj::ParseError
    body
  end

end
