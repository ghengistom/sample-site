<%%@ Page Language="C#" CodeFile="Portal_2011_Test_Sample.aspx.cs" Inherits="Example" %>
<%%@ Register Assembly="APPortalUI" Namespace="APPortalUI.Web.UI" TagPrefix="apPortalUI" %>

<!DOCTYPE html>
<html>
<head runat="server">
  <title>activePDF Portal Sample</title>
</head>
<body>
  <form id="form1" runat="server">
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
  </form>
</body>
</html>
