class StoryPolicy < ApplicationPolicy
	def story_params?
		record.user.id == user.id
	end

	def update_story_params?
		record.user.id == user.id
	end

	def show?
		if record.story_privacy.present?
			if record.story_privacy.user_private == "public" || record.story_privacy.user_private == "public and searchable"
				true
			elsif record.story_privacy.user_private == "private" 
				if record.user.id == user.id
					true 
				else 
					false 
				end
			end 
		else
			true
		end
	end

	def update?
		record.user.id == user.id
	end

	def destroy?
		record.user.id == user.id
	end

	def create?
		true 
	end
end