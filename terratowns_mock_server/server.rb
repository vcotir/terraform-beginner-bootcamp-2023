require 'sinatra'
require 'json'
require 'pry'
require 'active_model'

# Mock having a state or database for this development server
  # By setting a global variable. 
  # (for production servers you would never utilize a global variable)
$home = {}

# Ruby class that includes validations from ActiveRecord
# This represents our Home resources as a Ruby object
class Home
  # ActiveModel is part of Ruby on Rails
    # it's used as an ORM. It has a module wtihin ActiveModel that provides validations.
    # The production Terratowns server is rails and uses 
    # Very similar and in most cases identitcal validation
    # https://guides.rubyonrails.org/active_model_basics.html
    # https://guides.rubyonrails.org/active_record_validations.html
  include ActiveModel::Validations

  # create some virtual attributes to be stored on this ovject
    # This will set a getter and setter
      # e.g. 
        # home = new Home()
        # home.town = 'hello' # setter
        # home.town() # getter 

  attr_accessor :town, :name, :description, :domain_name, :content_version

  # gamers-groto
  # cookers-crove
  validates :town, presence: true, inclusion: { in: [
    'melomaniac-mansion',
    'cooker-cove',
    'missingo',
    'gamers-grotto',
    'video-valley'
    'the-nomad-pad'
  ]}

  # visible to all users
  validates :name, presence: true

  # visible to all users
  validates :description, presence: true

  # want to lock this donw to only be from cloudfround
  validates :domain_name, 
    format: { with: /\.cloudfront\.net\z/, message: "domain must be from .cloudfront.net" }
    # uniqueness: true, 

  # content version has to be an integer
    # will make sure it's an incremental version in the controller
  validates :content_version, numericality: { only_integer: true }
end

# We are extending a class from Sinatra::Base to turn 
  ## this generic class to utilize the sinatra web-framework
class TerraTownsMockServer < Sinatra::Base

  def error code, message
    halt code, {'Content-Type' => 'application/json'}, {err: message}.to_json
  end

  def error_json json
    halt code, {'Content-Type' => 'application/json'}, json
  end

  def ensure_correct_headings
    unless request.env["CONTENT_TYPE"] == "application/json"
      error 415, "expected Content_type header to be application/json"
    end

    unless request.env["HTTP_ACCEPT"] == "application/json"
      error 406, "expected Accept header to be application/json"
    end
  end

  # returns hardcoded access token
  def x_access_code
    '9b49b3fb-b8e9-483c-b703-97ba88eef8e0'
  end

  def x_user_uuid
    'e328f4ab-b99f-421c-84c9-4ccea042c7d1'
  end

  def find_user_by_bearer_token
    # https://swagger.io/docs/specification/authentication/bearer-authentication/
    auth_header = request.env["HTTP_AUTHORIZATION"]
    # Check if the Authorization header exists
    if auth_header.nil? || !auth_header.start_with?("Bearer ")
      error 401, "a1000 Failed to authenicate, bearer token invalid and/or teacherseat_user_uuid invalid"
    end

    # Checks to see if token matches one in database
    # if we can't find it, return an error or if it doesn't match
    # code = access_code = token
    code = auth_header.split("Bearer ")[1]
    if code != x_access_code
      error 401, "a1001 Failed to authenicate, bearer token invalid and/or teacherseat_user_uuid invalid"
    end

    # checks if user_uuid id exists in params
    if params['user_uuid'].nil?
      error 401, "a1002 Failed to authenicate, bearer token invalid and/or teacherseat_user_uuid invalid"
    end

    # the code and the user_uuid should be matching for user
    # in rails: User.find by access_code: 
    unless code == x_access_code && params['user_uuid'] == x_user_uuid
      error 401, "a1003 Failed to authenicate, bearer token invalid and/or teacherseat_user_uuid invalid"
    end
  end

  # CREATE
  post '/api/u/:user_uuid/homes' do
    ensure_correct_headings
    find_user_by_bearer_token
    # puts will print to the terminal
    puts "# create - POST /api/homes"

    # a begin/rescue is a try, catch
    begin
      # Sinatra doens't automatically parse JSON bodies, so we must manually do it
      payload = JSON.parse(request.body.read)
    rescue JSON::ParserError
      halt 422, "Malformed JSON"
    end

    # assign payload to variable names to make them easier to work with
    name = payload["name"]
    description = payload["description"]
    domain_name = payload["domain_name"]
    content_version = payload["content_version"]
    town = payload["town"]

    # print variables out to console to make it easier
      # to see or debug
    puts "name #{name}"
    puts "description #{description}"
    puts "domain_name #{domain_name}"
    puts "content_version #{content_version}"
    puts "town #{town}"

    # Create a new Home model and set attributes
    home = Home.new
    home.town = town
    home.name = name
    home.description = description
    home.domain_name = domain_name
    home.content_version = content_version
    
    # Ensure that validation checks passotherwise
      # return our errors
    unless home.valid?
      error 422, home.errors.messages.to_json
    end

    # generate a uuid at random
    uuid = SecureRandom.uuid
    puts "uuid #{uuid}"

    # will mock our data to our mock database
      # just a global variable
    $home = {
      uuid: uuid,
      name: name,
      town: town,
      description: description,
      domain_name: domain_name,
      content_version: content_version
    }

    # will just return uuid
    return { uuid: uuid }.to_json
  end

  # READ
  get '/api/u/:user_uuid/homes/:uuid' do
    ensure_correct_headings
    find_user_by_bearer_token
    puts "# read - GET /api/homes/:uuid"

    # checks for house limit

    content_type :json
    # does the uuid for home match one in mock database
    if params[:uuid] == $home[:uuid]
      return $home.to_json
    else
      error 404, "failed to find home with provided uuid and bearer token"
    end
  end

  # UPDATE
    # similar to create action
  put '/api/u/:user_uuid/homes/:uuid' do
    ensure_correct_headings
    find_user_by_bearer_token
    puts "# update - PUT /api/homes/:uuid"
    begin
      # Parse JSON payload from the request body
      payload = JSON.parse(request.body.read)
    rescue JSON::ParserError
      halt 422, "Malformed JSON"
    end

    # Validate payload data
    name = payload["name"]
    description = payload["description"]
    domain_name = payload["domain_name"]
    content_version = payload["content_version"]

    unless params[:uuid] == $home[:uuid]
      error 404, "failed to find home with provided uuid and bearer token"
    end

    home = Home.new
    home.town = $home[:town]
    home.name = name
    home.description = description
    home.domain_name = domain_name
    home.content_version = content_version

    unless home.valid?
      error 422, home.errors.messages.to_json
    end

    return { uuid: params[:uuid] }.to_json
  end

  # DELETE
  delete '/api/u/:user_uuid/homes/:uuid' do
    ensure_correct_headings
    find_user_by_bearer_token
    puts "# delete - DELETE /api/homes/:uuid"
    content_type :json

    if params[:uuid] != $home[:uuid]
      error 404, "failed to find home with provided uuid and bearer token"
    end

    # delete from mock database
    $home = {}
    { message: "House deleted successfully" }.to_json
  end
end

# This is what runs the server
TerraTownsMockServer.run!