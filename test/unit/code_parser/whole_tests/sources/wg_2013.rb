with_wg do |wg|
  if @language_type == :net
    ConvertToPDF :assert_result => "WebGrabber"
  else
    ConvertToPDF "127.0.0.1", 90, :assert_result => "WebGrabber"
  end
end