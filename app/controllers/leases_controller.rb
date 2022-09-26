class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid

    def index
        leases = Lease.all 
        render json: leases
    end

    def show
        lease = Lease.find(params[:id])
        render json: lease
    end

    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    end

    private

    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end

    def render_not_found(error)
        render json: {error: error.message}, status: :not_found
    end

    def render_invalid(error)
        render json: {error: error.message}, status: :unprocessable_entity
    end

end
