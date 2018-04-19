define("ace/mode/asp_highlight_rules",["require","exports","module","ace/lib/oop","ace/mode/text_highlight_rules"], function(require, exports, module) {
"use strict";

var oop = require("../lib/oop");
var TextHighlightRules = require("./text_highlight_rules").TextHighlightRules;

var AspHighlightRules = function() {

    this.$rules = {
        start: [{
            token: [
                "meta.function.asp",
                "storage.type.function.asp",
                "meta.function.asp",
                "entity.name.function.asp",
                "meta.function.asp",
                "punctuation.definition.parameters.asp",
                "variable.parameter.function.asp",
                "punctuation.definition.parameters.asp",
                "meta.function.asp"
            ],
            regex: /^(\s*)((?:function|sub))(\s*)([a-zA-Z_]\w*)(\s*)(\()([^)]*)(\))(.*)/,
            caseInsensitive: true
        }, {
            token: [
                "punctuation.definition.comment.asp",
                "comment.line.apostrophe.asp"
            ],
            regex: /(')(.*$)/
        }, {
            token: [
                "punctuation.definition.comment.asp",
                "comment.line.rem.asp"
            ],
            regex: /(REM )(.*$)/
        }, {
            token: "keyword.control.asp",
            regex: /\b(?:If|Then|Else|ElseIf|End If|While|Wend|For|To|Each|In|Step|Case|Select|End Select|Return|Continue|Do|Until|Loop|Next|With|Exit Do|Exit For|Exit Function|Exit Property|Exit Sub)\b/,
            caseInsensitive: true
        }, {
            token: "keyword.operator.asp",
            regex: /=|>=|<|>|<|<>|\+|-|\*|\^|&|\b(?:Mod|And|Not|Or|Xor|Is)\b/,
            caseInsensitive: true
        }, {
            token: "storage.type.asp",
            regex: /\b(?:Call|Class|Const|Dim|Redim|Function|Sub|Property|End Property|End sub|End Function|Set|Let|Get|New|Randomize|Option Explicit|On Error Resume Next|On Error GoTo)\b/,
            caseInsensitive: true
        }, {
            token: "storage.modifier.asp",
            regex: /\b(?:Private|Public|Default)\b/,
            caseInsensitive: true
        }, {
            token: "constant.language.asp",
            regex: /\b(?:Empty|False|Nothing|Null|True)\b/,
            caseInsensitive: true
        }, {
            token: "punctuation.definition.string.begin.asp",
            regex: /"/,
            push: [{
                token: "punctuation.definition.string.end.asp",
                regex: /"(?!")/,
                next: "pop"
            }, {
                token: "constant.character.escape.apostrophe.asp",
                regex: /""/
            }, {
                defaultToken: "string.quoted.double.asp"
            }]
        }, {
            token: [
                "punctuation.definition.variable.asp",
                "variable.other.asp"
            ],
            regex: /(\$)([a-zA-Z_x7f-xff][a-zA-Z0-9_x7f-xff]*?\b)/
        }, {
            token: "support.class.asp",
            regex: /\b(?:Application|ObjectContext|Request|Response|Server|Session)\b/,
            caseInsensitive: true
        }, {
            token: "support.class.collection.asp",
            regex: /\b(?:Contents|StaticObjects|ClientCertificate|Cookies|Form|QueryString|ServerVariables)\b/,
            caseInsensitive: true
        }, {
            token: "support.constant.asp",
            regex: /\b(?:TotalBytes|Buffer|CacheControl|Charset|ContentType|Expires|ExpiresAbsolute|IsClientConnected|PICS|Status|ScriptTimeout|CodePage|LCID|SessionID|Timeout)\b/,
            caseInsensitive: true
        }, {
            token: "support.function.asp",
            regex: /\b(?:Lock|Unlock|SetAbort|SetComplete|BianryRead|AddHeader|AppendToLog|BinaryWrite|Clear|End|Flush|Redirect|Write|CreateObject|HTMLEncode|MapPath|URLEncode|Abandon)\b/,
            caseInsensitive: true
        }, {
            token: "support.function.event.asp",
            regex: /\b(?:Application_OnEnd|Application_OnStart|OnTransactionAbort|OnTransactionCommit|Session_OnEnd|Session_OnStart|Class_Initialize|Class_Terminate)\b/,
            caseInsensitive: true
        }, {
            token: "support.function.vb.asp",
            regex: /\b(?:Array|Add|Asc|Atn|CBool|CByte|CCur|CDate|CDbl|Chr|CInt|CLng|Conversions|Cos|CreateObject|CSng|CStr|Date|DateAdd|DateDiff|DatePart|DateSerial|DateValue|Day|Derived|Math|Escape|Eval|Exists|Exp|Filter|FormatCurrency|FormatDateTime|FormatNumber|FormatPercent|GetLocale|GetObject|GetRef|Hex|Hour|InputBox|InStr|InStrRev|Int|Fix|IsArray|IsDate|IsEmpty|IsNull|IsNumeric|IsObject|Item|Items|Join|Keys|LBound|LCase|Left|Len|LoadPicture|Log|LTrim|RTrim|Trim|Maths|Mid|Minute|Month|MonthName|MsgBox|Now|Oct|Remove|RemoveAll|Replace|RGB|Right|Rnd|Round|ScriptEngine|ScriptEngineBuildVersion|ScriptEngineMajorVersion|ScriptEngineMinorVersion|Second|SetLocale|Sgn|Sin|Space|Split|Sqr|StrComp|String|StrReverse|Tan|Time|Timer|TimeSerial|TimeValue|TypeName|UBound|UCase|Unescape|VarType|Weekday|WeekdayName|Year)\b/,
            caseInsensitive: true
        }, {
            token: "constant.numeric.asp",
            regex: /\b(?:0(?:x|X)[0-9a-fA-F]*|(?:[0-9]+\.?[0-9]*|\.[0-9]+)(?:(?:e|E)(?:\+|-)?[0-9]+)?)(?:L|l|UL|ul|u|U|F|f)?\b/
        }, {
            token: "support.type.vb.asp",
            regex: /\b(?:vbtrue|fvbalse|vbcr|vbcrlf|vbformfeed|vblf|vbnewline|vbnullchar|vbnullstring|vbtab|vbverticaltab|vbbinarycompare|vbtextcomparevbsunday|vbmonday|vbtuesday|vbwednesday|vbthursday|vbfriday|vbsaturday|vbusesystemdayofweek|vbfirstjan1|vbfirstfourdays|vbfirstfullweek|vbgeneraldate|vblongdate|vbshortdate|vblongtime|vbshorttime|vbobjecterror|vbEmpty|vbNull|vbInteger|vbLong|vbSingle|vbDouble|vbCurrency|vbDate|vbString|vbObject|vbError|vbBoolean|vbVariant|vbDataObject|vbDecimal|vbByte|vbArray)\b/,
            caseInsensitive: true
        }]
    }
    
    this.normalizeRules();
};

AspHighlightRules.metaData = {
    comment: "ASP SCRIPTING DICTIONARY – By Rich Barton: Version 1.0 (based on PHP Scripting Dictionary by Justin French, Sune Foldager and Allan Odgaard) Note: .asp is handled by asp/html",
    fileTypes: ["asa"],
    foldingStartMarker: "(?i)^\\s*(Public|Private)?\\s*(Class|Function|Sub|Property)\\s*([a-zA-Z_]\\w*)\\s*(\\(.*\\)\\s*)?$",
    foldingStopMarker: "(?i)^\\s*End (Class|Function|Sub|Property)\\s*$",
    keyEquivalent: "^~A",
    name: "ASP",
    scopeName: "source.asp"
}


oop.inherits(AspHighlightRules, TextHighlightRules);

exports.AspHighlightRules = AspHighlightRules;
});

define("ace/mode/folding/cstyle",["require","exports","module","ace/lib/oop","ace/range","ace/mode/folding/fold_mode"], function(require, exports, module) {
"use strict";

var oop = require("../../lib/oop");
var Range = require("../../range").Range;
var BaseFoldMode = require("./fold_mode").FoldMode;

var FoldMode = exports.FoldMode = function(commentRegex) {
    if (commentRegex) {
        this.foldingStartMarker = new RegExp(
            this.foldingStartMarker.source.replace(/\|[^|]*?$/, "|" + commentRegex.start)
        );
        this.foldingStopMarker = new RegExp(
            this.foldingStopMarker.source.replace(/\|[^|]*?$/, "|" + commentRegex.end)
        );
    }
};
oop.inherits(FoldMode, BaseFoldMode);

(function() {
    
    this.foldingStartMarker = /(\{|\[)[^\}\]]*$|^\s*(\/\*)/;
    this.foldingStopMarker = /^[^\[\{]*(\}|\])|^[\s\*]*(\*\/)/;
    this.singleLineBlockCommentRe= /^\s*(\/\*).*\*\/\s*$/;
    this.tripleStarBlockCommentRe = /^\s*(\/\*\*\*).*\*\/\s*$/;
    this.startRegionRe = /^\s*(\/\*|\/\/)#?region\b/;
    this._getFoldWidgetBase = this.getFoldWidget;
    this.getFoldWidget = function(session, foldStyle, row) {
        var line = session.getLine(row);
    
        if (this.singleLineBlockCommentRe.test(line)) {
            if (!this.startRegionRe.test(line) && !this.tripleStarBlockCommentRe.test(line))
                return "";
        }
    
        var fw = this._getFoldWidgetBase(session, foldStyle, row);
    
        if (!fw && this.startRegionRe.test(line))
            return "start"; // lineCommentRegionStart
    
        return fw;
    };

    this.getFoldWidgetRange = function(session, foldStyle, row, forceMultiline) {
        var line = session.getLine(row);
        
        if (this.startRegionRe.test(line))
            return this.getCommentRegionBlock(session, line, row);
        
        var match = line.match(this.foldingStartMarker);
        if (match) {
            var i = match.index;

            if (match[1])
                return this.openingBracketBlock(session, match[1], row, i);
                
            var range = session.getCommentFoldRange(row, i + match[0].length, 1);
            
            if (range && !range.isMultiLine()) {
                if (forceMultiline) {
                    range = this.getSectionRange(session, row);
                } else if (foldStyle != "all")
                    range = null;
            }
            
            return range;
        }

        if (foldStyle === "markbegin")
            return;

        var match = line.match(this.foldingStopMarker);
        if (match) {
            var i = match.index + match[0].length;

            if (match[1])
                return this.closingBracketBlock(session, match[1], row, i);

            return session.getCommentFoldRange(row, i, -1);
        }
    };
    
    this.getSectionRange = function(session, row) {
        var line = session.getLine(row);
        var startIndent = line.search(/\S/);
        var startRow = row;
        var startColumn = line.length;
        row = row + 1;
        var endRow = row;
        var maxRow = session.getLength();
        while (++row < maxRow) {
            line = session.getLine(row);
            var indent = line.search(/\S/);
            if (indent === -1)
                continue;
            if  (startIndent > indent)
                break;
            var subRange = this.getFoldWidgetRange(session, "all", row);
            
            if (subRange) {
                if (subRange.start.row <= startRow) {
                    break;
                } else if (subRange.isMultiLine()) {
                    row = subRange.end.row;
                } else if (startIndent == indent) {
                    break;
                }
            }
            endRow = row;
        }
        
        return new Range(startRow, startColumn, endRow, session.getLine(endRow).length);
    };
    this.getCommentRegionBlock = function(session, line, row) {
        var startColumn = line.search(/\s*$/);
        var maxRow = session.getLength();
        var startRow = row;
        
        var re = /^\s*(?:\/\*|\/\/|--)#?(end)?region\b/;
        var depth = 1;
        while (++row < maxRow) {
            line = session.getLine(row);
            var m = re.exec(line);
            if (!m) continue;
            if (m[1]) depth--;
            else depth++;

            if (!depth) break;
        }

        var endRow = row;
        if (endRow > startRow) {
            return new Range(startRow, startColumn, endRow, line.length);
        }
    };

}).call(FoldMode.prototype);

});

define("ace/mode/asp",["require","exports","module","ace/lib/oop","ace/mode/text","ace/mode/asp_highlight_rules","ace/mode/folding/cstyle"], function(require, exports, module) {
"use strict";

var oop = require("../lib/oop");
var TextMode = require("./text").Mode;
var AspHighlightRules = require("./asp_highlight_rules").AspHighlightRules;
var FoldMode = require("./folding/cstyle").FoldMode;

var Mode = function() {
    this.HighlightRules = AspHighlightRules;
    this.foldingRules = new FoldMode();
};
oop.inherits(Mode, TextMode);

(function() {
    this.$id = "ace/mode/asp"
}).call(Mode.prototype);

exports.Mode = Mode;
});
