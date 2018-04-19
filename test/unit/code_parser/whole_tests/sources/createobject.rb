with_dc do |dc|
  comment "Release object: .NET = Yes, COM = Yes"
  createobject "oOne", :com => "APDocConverter.FromPDFOptions", :class => "APDocConverter.FromPDFOptions", :call => "APDocConverter.FromPDFOptions()", :path => :"C:\\Program Files\\ActivePDF\\DocConverter\\bin\\APDocConverter.Net35.dll" do
    if @language_type == :net
      ToWordHeadersAndFootersMode :equals => :"APDocConverter.ToWordHeadersAndFootersOptions.Detect"
    else
      ToWordHeadersAndFootersMode :equals => 0
    end
    dc.SetFromPDFOptions @object_variable.to_sym
  end
  br
  comment "Release object: .NET = No, COM = Yes"
  createobject "oTwo", :release_net => false, :com => "APDocConverter.FromPDFOptions", :class => "APDocConverter.FromPDFOptions", :call => "APDocConverter.FromPDFOptions()", :path => :"C:\\Program Files\\ActivePDF\\DocConverter\\bin\\APDocConverter.Net35.dll" do
    if @language_type == :net
      ToWordHeadersAndFootersMode :equals => :"APDocConverter.ToWordHeadersAndFootersOptions.Detect"
    else
      ToWordHeadersAndFootersMode :equals => 0
    end
    dc.SetFromPDFOptions @object_variable.to_sym
  end
  br
  comment "Release object: .NET = Yes, COM = Yes"
  createobject "oThree", :release_net => true, :com => "APDocConverter.FromPDFOptions", :class => "APDocConverter.FromPDFOptions", :call => "APDocConverter.FromPDFOptions()", :path => :"C:\\Program Files\\ActivePDF\\DocConverter\\bin\\APDocConverter.Net35.dll" do
    if @language_type == :net
      ToWordHeadersAndFootersMode :equals => :"APDocConverter.ToWordHeadersAndFootersOptions.Detect"
    else
      ToWordHeadersAndFootersMode :equals => 0
    end
    dc.SetFromPDFOptions @object_variable.to_sym
  end
end