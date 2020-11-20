class ObjetsController < ApplicationController
    def new
        @personnage = params.to_enum.to_h
    end

    def create
        @item = params[:item].to_enum.to_h
        @id = params[:id]
        url = URI("http://localhost:3000/api/v1/personnages/"+@id+"/objets")
        http = Net::HTTP.new(url.host, url.port)
        req = Net::HTTP::Post.new(url.path, 'Content-Type' => 'application/json')
        req.body = @item.to_json
        res = http.request(req)
        logger.debug @item
        logger.debug @id
        redirect_to personnages_path("id"=>@id)
    end

    def edit
        @item = params[:item].to_enum.to_h
        @persoID = params[:persoID]
    end

    def update
        @item = params[:item].to_enum.to_h
        @idPerso = params[:idPerso]
        @idItem = params[:id]
        logger.debug @item
        logger.debug @idPerso
        url = URI("http://localhost:3000/api/v1/personnages/"+@idPerso+"/objets/"+@idItem)
        http = Net::HTTP.new(url.host, url.port)
        req = Net::HTTP::Patch.new(url.path, 'Content-Type' => 'application/json')
        req.body = @item.to_json
        res = http.request(req)
        redirect_to personnages_path("id"=>@idPerso)
    end

    def destroy
        url = URI("http://localhost:3000/api/v1/personnages/"+params['persoID']+"/objets/"+params['id'])
        http = Net::HTTP.new(url.host, url.port)
        req = Net::HTTP::Delete.new(url.path)
        res = http.request(req)
        redirect_to personnages_path("id"=>params['persoID'])
    end
end
