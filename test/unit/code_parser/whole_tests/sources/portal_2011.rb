with_portal :control_params => '' do |p|

cs =<<END
protected void Page_Load(object sender, EventArgs e)
{
	if (!IsPostBack)
	{
		// Specify the document to open with portal
		this.PdfWebControl1.CreateDocument("filename", System.IO.File.ReadAllBytes(Server.MapPath(@"portal.pdf")));
	}
}

protected void SaveComplete(object sender, SaveCompleteEventArgs e)
{
	// Check the SaveType to determine action to perform
	switch (e.SaveType)
	{
		// Save the file to disk when saving or downloading
		case SaveType.Save:
		case SaveType.Download:

			break;

		// Ignore all other save types
		default:

			break;
	}
}
END

vb =<<END
Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

	If Not IsPostBack Then

		' Specify the document to open with portal
		Me.PdfWebControl1.CreateDocument("filename", System.IO.File.ReadAllBytes(Server.MapPath("portal.pdf")))

	End If
End Sub

Protected Sub SaveComplete(ByVal sender As Object, ByVal e As SaveCompleteEventArgs)

	' Check the SaveType to determine action to perform
	Select Case e.SaveType

		' Save the file to disk when saving or downloading
		Case SaveType.Save, SaveType.Download

			Exit Select

		' Ignore all other save types
		Case Else

			Exit Select
	End Select
End Sub
END
 
custom_aspx <<END
<script type="text/javascript">
	function setEvent() {
		var myApi = new PdfWebControlApi("PdfWebControl1_ctl00");
		myApi.addEventListener("save", function () {
			if (this.save(false) == true) {
				// This will occur on a successful document save
			} else {
				// This will occur if there is an error during the save process
			}
			return false;
		});
	}
</script>
<div>
	<apPortalUI:PdfWebControl ID="PdfWebControl1" runat="server" Height="600px" Width="100%"
		OnSaveComplete="SaveComplete" 
		OnClientLoad="setEvent();" />
</div>
END
 
output_for_language :cs => cs, :vb => vb

end