# To set file paths to the path of the script
relative_file("file.ext")

# Example in a method
ImageToPDF relative_file("IMG.jpg"), relative_file("IMG.pdf"), :assert_equal => 1