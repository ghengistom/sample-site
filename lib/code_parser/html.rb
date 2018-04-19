module HTML
  class Code < Generic::Code
    def language_init
      @language = "html"
      language_class_setup :com
    end

    def method(method, args) end

    def copyright(textArray)
      output = ""
      textArray.each do |line|
        if line.empty?
          output << "\n"
        else
          output << "<!-- #{line} -->"
        end
      end
      return output
    end
  end
end