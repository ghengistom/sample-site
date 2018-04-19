module AdminHelper
  def version_start_end_js(string)
    output = "
    <script type=\"text/javascript\">
      $(document).ready(function(){
         $('##{string}_product_id').change(function () {

           $('.version_select').hide();

           product_id = $(this).val();
           $('.product_'+product_id+'_versions').show();
         });

         $('form').submit(function () {
           $('select[name=\"#{string}[version_id_start]\"]:hidden').remove();
           $('select[name=\"#{string}[version_id_end]\"]:hidden').remove();
           return true;
         });

         $('##{string}_product_id').change();

       });
    </script>"
  end
end
