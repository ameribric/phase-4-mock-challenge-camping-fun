class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

    def index
        signups = Signup.all 
        render json: signups, status: :ok
    end

    def create
        signup = Signup.create!(signup_params)
        render json: signup.activity, status: :created
    end

    private

    def signup_params
        params.permit(:camper_id, :activity_id, :time)
    end

    def unprocessable_entity(exception)
        render json: { errors: exception.record.errors.full_messages}, status: :unprocessable_entity
    end

end
