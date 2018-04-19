@outfile ||= "new.pdf"
@infile = "form.pdf"

with_tk do |tk|
  comment "Create the new PDF file"
  OpenOutputFile relative_file(@outfile), :assert_equal => 0
  br
  comment "Open the template PDF"
  OpenInputFile relative_file(@infile), :assert_equal => 0
  br
  comment "Get the reference to the XMP object"
  GetXMPManager :object => "oXMP", :class => "APToolkitNET.XMPManager", :release_net => false do
    br
    comment "Set a document property"
    case @language_type
    when :net
      SetDocumentProperty :"APToolkitNET.XMPProperty.Author", "John Doe", :assert_equal => 0, :assert_equal_type => "long"
    when :com
      SetDocumentProperty 2, "John Doe", :assert_equal => 0, :assert_equal_type => "long"
    end
    br
    comment "Set a custom property"
    SetCustomProperty "example", "http://examples.activepdf.com", :assert_equal => 0, :assert_equal_type => "long"
    br
    comment "Set the namespace for the user property"
    SetNamespace("dc", "http://purl.org/dc/elements/1.1/");
    #SetNamespace("svr", "http://purina.org/svr/");
    br
    comment "Set a user property"
    SetUserProperty "contributor", "ActivePDF", :assert_equal => 0, :assert_equal_type => "long"
    br
    comment "Remove a property"
    enum = {:com => 2, :net => "Author", :enum => "XMPProperty"}
    RemoveDocumentProperty enum
  end
  br
  comment "Get the reference to the InitialViewInfo object"
  GetInitialViewInfo :object => "oIVI", :class => "APToolkitNET.InitialViewInfo", :release_net => false do
    br
    comment "Options for viewer window"
    CenterWindow :equals => true
    FullScreen :equals => false
    ResizeWindow :equals => true
    comment :com => "0 = Display the filename"
    comment :com => "1 = Display the document title"
    Show :equals => {:net => "IVShow_DocumentTitle", :com => 1, :enum => "IVShow"}
    br
    comment "Show or hide UI elements of the viewer"
    HideMenuBar :equals => true
    HideToolBars :equals => true
    HideWindowControls :equals => true
    comment :com => "0 = Page only"
    comment :com => "1 = Bookmarks Panel and Page"
    comment :com => "2 = Pages Panel and Page"
    comment :com => "3 = Attachments Panel and Page"
    comment :com => "4 = Layers Panel and Page"
    NavigationTab :equals => {:net => "IVNavigationTab_PageOnly", :com => 0, :enum => "IVNavigationTab"}
    br
    comment "Page settings"
    Magnification :equals => {:net => "IVMagnification_150", :com => 150, :enum => "IVMagnification"}
    OpenToPage :equals => 2
    comment :com => "0 = Default Page Layout"
    comment :com => "1 = Single Page Page Layout"
    comment :com => "2 = Single Page Continoues Page Layout"
    comment :com => "3 = Two-Up (Facing) Page Layout"
    comment :com => "4 = Two-Up Continous (Facing) Page Layout"
    comment :com => "5 = Two-Up (Cover Page) Page Layout"
    comment :com => "6 = Two-Up Continous (Cover Page) Page Layout"
    PageLayout :equals => {:net => "IVPageLayout_SinglePageContinuous", :com => 1, :enum => "IVPageLayout"}
  end
  br
  comment "Populate and flatten the fields, the data will remain in the place"
  comment "of the field and the field data will be added to the XMP data"
  tk.SetFormFieldData "name", "John Doe", -997
  tk.SetFormFieldData "date", "1/1/2000", -997
  tk.SetFormFieldData "amount", "15.00", -997
  br
  comment "Copy the template (with any changes) to the new file"
  CopyForm 0, 0, :assert_equal => 1
  br
  comment "Close the new file to complete PDF creation"
  CloseOutputFile()
end