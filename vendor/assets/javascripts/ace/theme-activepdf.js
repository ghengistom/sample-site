define("ace/theme/activepdf",["require","exports","module","ace/lib/dom"], function(require, exports, module) {

exports.isDark = true;
exports.cssClass = "ace-activepdf";
exports.cssText = ".ace-activepdf .ace_gutter {\
background: #1D3348;\
color: #666666\
}\
.ace-activepdf .ace_print-margin {\
width: 1px;\
background: #555651\
}\
.ace-activepdf {\
background-color: #263C51;\
color: #F8F8F2\
}\
.ace-activepdf .ace_cursor {\
color: #F8F8F0\
}\
.ace-activepdf .ace_marker-layer .ace_selection {\
background: #49483E\
}\
.ace-activepdf.ace_multiselect .ace_selection.ace_start {\
box-shadow: 0 0 3px 0px #272822;\
}\
.ace-activepdf .ace_marker-layer .ace_step {\
background: rgb(102, 82, 0)\
}\
.ace-activepdf .ace_marker-layer .ace_bracket {\
margin: -1px 0 0 -1px;\
border: 1px solid #49483E\
}\
.ace-activepdf .ace_marker-layer .ace_active-line {\
background: #1D3348\
}\
.ace-activepdf .ace_gutter-active-line {\
background-color: #142A3F\
}\
.ace-activepdf .ace_marker-layer .ace_selected-word {\
border: 1px solid #49483E\
}\
.ace-activepdf .ace_invisible {\
color: #555555\
}\
.ace-activepdf .ace_entity.ace_name.ace_tag,\
.ace-activepdf .ace_keyword,\
.ace-activepdf .ace_meta.ace_tag,\
.ace-activepdf .ace_storage {\
color: #F92672\
}\
.ace-activepdf .ace_punctuation,\
.ace-activepdf .ace_punctuation.ace_tag {\
color: #fff\
}\
.ace-activepdf .ace_constant.ace_character,\
.ace-activepdf .ace_constant.ace_language,\
.ace-activepdf .ace_constant.ace_numeric,\
.ace-activepdf .ace_constant.ace_other {\
color: #AE81FF\
}\
.ace-activepdf .ace_invalid {\
color: #F8F8F0;\
background-color: #F92672\
}\
.ace-activepdf .ace_invalid.ace_deprecated {\
color: #F8F8F0;\
background-color: #AE81FF\
}\
.ace-activepdf .ace_support.ace_constant,\
.ace-activepdf .ace_support.ace_function {\
color: #66D9EF\
}\
.ace-activepdf .ace_fold {\
background-color: #A6E22E;\
border-color: #F8F8F2\
}\
.ace-activepdf .ace_storage.ace_type,\
.ace-activepdf .ace_support.ace_class,\
.ace-activepdf .ace_support.ace_type {\
font-style: italic;\
color: #66D9EF\
}\
.ace-activepdf .ace_entity.ace_name.ace_function,\
.ace-activepdf .ace_entity.ace_other,\
.ace-activepdf .ace_entity.ace_other.ace_attribute-name,\
.ace-activepdf .ace_variable {\
color: #A6E22E\
}\
.ace-activepdf .ace_variable.ace_parameter {\
font-style: italic;\
color: #FD971F\
}\
.ace-activepdf .ace_string {\
color: #E6DB74\
}\
.ace-activepdf .ace_comment {\
color: #999999\
}\
.ace-activepdf .ace_indent-guide {\
background: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAACCAYAAACZgbYnAAAAEklEQVQImWPQ0FD0ZXBzd/wPAAjVAoxeSgNeAAAAAElFTkSuQmCC) right repeat-y\
}";

var dom = require("../lib/dom");
dom.importCssString(exports.cssText, exports.cssClass);
});
