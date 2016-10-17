module BooksHelper
    def format_date dt
        dt.strftime('%F')
    end
    def show_status is_active
        is_active == 1 ? :Active : :Inactive
    end
    def get_color book_count
        book_count == 0 ? :red : :green
    end
end
