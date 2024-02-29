module BooksHelper
    def formatted_genres
        Book.genres.keys.map { |key| [key.humanize.capitalize, key] }
    end

    def format_genre(genre)
        Book.genres.invert[genre].humanize.capitalize if genre.is_a?(Integer)
        genre.humanize.capitalize if genre.is_a?(String)
    end
end
