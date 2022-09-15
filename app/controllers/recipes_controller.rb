class RecipesController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :handle_blank_field

    before_action :authorize

    def index
        render json: Recipe.all, status: :created
    end

    def create
        def create
            recipe = Recipe.create!(recipe_params)
            if recipe.valid?
                render json: recipe, status: :created
            else
                render json: [{errors: recipe.errors.full_messages} ], status: :unprocessable_entity
            end
        end
    end


    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete, :user)
    end

    def authorize
        return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :recipe_id
    end

    def handle_blank_field(invalid)
        render json: {error: invalid.record.errors}, status: :unprocessable_entity
    end
end
