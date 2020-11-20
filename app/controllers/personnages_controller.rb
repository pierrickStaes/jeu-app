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

    def create
        @personnage = params[:pseudo].to_enum.to_h
        url = URI("http://localhost:3000/api/v1/personnages")
        http = Net::HTTP.new(url.host, url.port)
        req = Net::HTTP::Post.new(url.path, 'Content-Type' => 'application/json')
        req.body = @personnage.to_json
        res = http.request(req)
        logger.debug @personnage
        redirect_to root_path
    end

    def new
        
    end

    def show
        url = "http://localhost:3000/api/v1/personnages/" + params['id']
        github_answer = open(url).read
        @hash_github = JSON.parse(github_answer)
    end

    def edit
        url = "http://localhost:3000/api/v1/personnages/" + params['id']
        github_answer = open(url).read
        @personnage = JSON.parse(github_answer).to_enum.to_h
    end

    def update
        @personnage = params[:pseudo].to_enum.to_h
        url = URI("http://localhost:3000/api/v1/personnages/"+ params[:pseudo][:id])
        http = Net::HTTP.new(url.host, url.port)
        req = Net::HTTP::Patch.new(url.path, 'Content-Type' => 'application/json')
        req.body = @personnage.to_json
        res = http.request(req)
        logger.debug @personnage
        redirect_to personnages_path(@personnage)
    end

    def destroy
        url = URI.parse("http://localhost")
        url.port = 3000
        http = Net::HTTP.new(url.host, url.port).delete("/api/v1/personnages/" + params['id'])
        redirect_to root_path
    end
end
