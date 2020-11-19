class PersonnagesController < ApplicationController
    require 'json'
    require 'open-uri'
    require 'net/http'
    require 'uri'
    def index
        url = "http://localhost:3000/api/v1/personnages"
        github_answer = open(url).read
        @hash_github = JSON.parse(github_answer)
    end

    def show
        url = "http://localhost:3000/api/v1/personnages/" + params['id']
        github_answer = open(url).read
        @hash_github = JSON.parse(github_answer)
    end

    def edit
        @personnage = params.to_enum.to_h
    end

    def update
        personnage = params.to_enum.to_h
        logger.debug personnage
        redirect_to personnages_path(personnage)
    end

    def destroy
        url = URI.parse("http://localhost")
        url.port = 3000
        http = Net::HTTP.new(url.host, url.port).delete("/api/v1/personnages/" + params['id'])
        redirect_to root_path
    end
end
