class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid

    def index
        apartments = Apartment.all 
        render json: apartments, status: 200
    end

    def show
        apartment = Apartment.find(params[:id])
        render json: apartment, status: 200
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    end

    def update
        apartment = Apartment.find(params[:id])
        apartment.update(apartment_params)
        render json: apartment, status: :ok
    end

    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy
        head :no_content
    end

    private

    def apartment_params
        params.permit(:id, :number)
    end

    def render_not_found(error)
        render json: {error: error.message}, status: :not_found
    end

    def render_invalid(error)
        render json: {error: error.message}, status: :unprocessable_entity
    end

end
