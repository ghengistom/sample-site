module Shell
  class Code < Generic::Code
    def language_init
      @comment_symbol = "# "

      @language = "shell"
      language_class_setup :com
    end

    def method(method, args) end

    def write_results_method
    end

    def write_out(output, options = Hash.new)
    end
  end
end