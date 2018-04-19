# You can output code directly into the example using the output_for_language method like this:
output_for_language :vb => "Echo this in the VB example.", :cs => "Output this in the CS example"

# You can enter any of the following parameters: vb, cs, ruby, cf, vbs, asp, php, ps, and else
# else will output in all languages not explicitly set
output_for_language :vb => "Echo this in the VB example.", :else => "Output this in the every language except vb."

# Some products support options, like Portal
# This will echo the :control_params string into the HTML comment showing a user how to setup their ASPX page.
with_portal :control_params => 'OnSaveComplete="SaveComplete"' do |p|
  # You may customize the aspx output between the form tags by calling the custom_aspx method
  custom_aspx "<p>My custom HTML</p>"
end

# In C# and VB.NET only, you can call the imports method to add custom import strings
# Note that if you are using portal you must put this inside the with_portal block
imports "System.Drawing"