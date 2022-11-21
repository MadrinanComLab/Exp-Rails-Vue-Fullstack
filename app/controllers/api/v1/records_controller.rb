module Api
    module V1
        class RecordsController < ApplicationController
            before_action :authorize_access_request! # USER MUST BE SIGNED IN TO BE ABLE TO MAKE ACTIONS IN THIS CONTROLLER
            before_action :set_record, only: [:show, :update, :destroy]
        
            # GET /records
            def index
                # current_user CAN BE USE BECAUSE OF before_action :authorize_access_request!
                @records = current_user.records.all
        
                render json: @records
            end
        
            # GET /records/1
            def show
                render json: @record
            end
        
            # POST /records
            def create
                # current_user CAN BE USE BECAUSE OF before_action :authorize_access_request!
                @record = current_user.records.build(record_params)
        
                if @record.save
                    render json: @record, status: :created
                else
                    render json: @record.errors, status: :unprocessable_entity
                end
            end
        
            # PATCH/PUT /records/1
            def update
                if @record.update(record_params)
                    render json: @record
                else
                    render json: @record.errors, status: :unprocessable_entity
                end
            end
        
            # DELETE /records/1
            def destroy
                @record.destroy
            end
        
            private
            # Use callbacks to share common setup or constraints between actions.
            def set_record
                # current_user CAN BE USE BECAUSE OF before_action :authorize_access_request!
                @record = current_user.records.find(params[:id])
            end
        
            # Only allow a list of trusted parameters through.
            def record_params
                params.require(:record).permit(:title, :year, :artist_id)
            end
        end
    end
end
