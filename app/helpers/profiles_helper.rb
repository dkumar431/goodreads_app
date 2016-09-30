module ProfilesHelper
    def get_timeframe user
        time_ago_in_words(user.created_at)
    end
end
