define("ace/mode/vbnet_highlight_rules",["require","exports","module","ace/lib/oop","ace/mode/text_highlight_rules"], function(require, exports, module) {
"use strict";

var oop = require("../lib/oop");
var TextHighlightRules = require("./text_highlight_rules").TextHighlightRules;

var VBNETHighlightRules = function() {

    this.$rules = {
        start: [{
            include: "#singleLineComment"
        }, {
            include: "#region"
        }, {
            include: "#quotedString"
        }, {
            include: "#compilerOption"
        }, {
            include: "#importDefinition"
        }, {
            include: "#numericConstant"
        }, {
            include: "#characterOperator"
        }, {
            include: "#lineContinuationOperator"
        }, {
            include: "#wordOperator"
        }, {
            include: "#languageContants"
        }, {
            include: "#compilerDirectives"
        }, {
            include: "#supportTypes"
        }, {
            include: "#suportFunctions"
        }, {
            include: "#linqKeywords"
        }, {
            include: "#languageVariable"
        }, {
            include: "#namespaceDefinition"
        }, {
            include: "#moduleDefinition"
        }, {
            include: "#interfaceDefinition"
        }, {
            include: "#classDefinition"
        }, {
            include: "#functionDefinition"
        }, {
            include: "#lambdaDefinition"
        }, {
            include: "#propertyDefinition"
        }, {
            include: "#propertyGetSet"
        }, {
            include: "#definitionEnd"
        }, {
            include: "#storageModifiers"
        }, {
            include: "#inheritanceModifiers"
        }, {
            include: "#controlKeywords"
        }, {
            include: "#modifierKeywords"
        }, {
            include: "#vbFunctions"
        }],
        "#characterOperator": [{
            token: "keyword.operator.vbnet",
            regex: /\.|\+=|\+|\*=|\*|\\=|\\|\/=|\/|=|-=|-|<|<=|>|>=|&=|&|\^|\^=|>>=|>>|<<=|<<|:=/
        }],
        "#classDefinition": [{
            token: [
                "storage.type.class.vbnet",
                "meta.class.vbnet",
                "entity.name.type.class.vbnet",
                "meta.class.vbnet"
            ],
            regex: /\b(class)(\s+)([a-zA-Z_]\w*)(\s*)/,
            caseInsensitive: true
        }],
        "#compilerDirectives": [{
            token: "keyword.directive.vbnet",
            regex: /^\s*(?:#if|#else|#elseif|#endif|#const|#externalsource|#end|#end externalsource)\s+/,
            caseInsensitive: true
        }],
        "#compilerOption": [{
            token: [
                "text",
                "keyword.other.compiler-option.vbnet",
                "text",
                "support.constant.compiler-option.vbnet",
                "text",
                "constant.language.option-value.vbnet"
            ],
            regex: /^(\s*)(option)(\s*)(strict|infer|explicit|compare)(\s*)(on|off|binary|text)/,
            caseInsensitive: true
        }],
        "#controlKeywords": [{
            token: "keyword.control.vbnet",
            regex: /\b(?:If|Then|Else|ElseIf|Else If|End If|While|End While|For|End For|To|Each|Case|Select|End Select|Return|Continue|Do|Until|Loop|Next|End With|With|Exit Do|Exit For|Exit Function|Exit Property|Exit Sub|IIf|Step|GoTo|Try|Catch|Finally|End Try|Using|RaiseEvent|Stop|On Error|Resume|Async|Await|Yield)\b/,
            caseInsensitive: true
        }],
        "#definitionEnd": [{
            token: "keyword.control.end-definition.vbnet",
            regex: /^\s*end\s+(?:function|sub|class|namespace|module|interface|property|addhandler|enum|event|operator|raiseevent|removehandler|select|structure|synclock)/,
            caseInsensitive: true
        }],
        "#functionDefinition": [{
            token: [
                "support.type.function.vbnet",
                "meta.function.vbnet",
                "entity.name.function.vbnet",
                "meta.function.vbnet",
                "meta.parameters.vbnet"
            ],
            regex: /\b(function|sub)(\s+)([a-zA-Z_]\w*)(\s*)((?:\()?)/,
            caseInsensitive: true,
            push: [{
                token: [
                    "punctuation.definition.parameters.vbnet",
                    "meta.function.vbnet"
                ],
                regex: /((?:\))?)(\s*)/,
                next: "pop"
            }, {
                include: "#modifierKeywords"
            }, {
                include: "#supportTypes"
            }, {
                defaultToken: "meta.function.vbnet"
            }]
        }],
        "#importDefinition": [{
            token: [
                "text",
                "keyword.other.vbnet",
                "text",
                "variable.other.namespace-alias.vbnet",
                "text",
                "text"
            ],
            regex: /^(\s*)(imports)(\s*)((?:[a-zA-Z_]\w*\s*=)?)(\s*)((?:[a-zA-Z_]\w*\.?)+)/,
            caseInsensitive: true
        }],
        "#inheritanceModifiers": [{
            token: "storage.modifier.inheritance.vbnet",
            regex: /overloads|overrides|overridable|notoverridable|mustoverride|mustoverride overrides|notoverridable overrides|overloads overrides|mustinherit|notinheritable/,
            caseInsensitive: true
        }],
        "#interfaceDefinition": [{
            token: [
                "storage.type.interface.vbnet",
                "meta.interface.vbnet",
                "entity.name.type.interface.vbnet",
                "meta.interface.vbnet"
            ],
            regex: /\b(interface)(\s+)([a-zA-Z_]\w*)(\s*)/,
            caseInsensitive: true
        }],
        "#lambdaDefinition": [{
            token: "support.type.lambda.vbnet",
            regex: /function|sub/,
            caseInsensitive: true
        }],
        "#languageContants": [{
            token: "constant.language.vbnet",
            regex: /(?:true|false|nothing)/,
            caseInsensitive: true
        }],
        "#languageVariable": [{
            token: "keyword.other.vbnet",
            regex: /\b(?:Me|MyBase|MyClass)\./,
            caseInsensitive: true
        }],
        "#lineContinuationOperator": [{
            token: "keyword.operator.vbnet",
            regex: /\w*\b\_$/
        }],
        "#linqKeywords": [{
            token: "keyword.control.linq.vbnet",
            regex: /\b(?:from|aggregate|select|where|order by|join|groupp by|into|group join|equals|let|distinct|skip|skip while|take|take while)\b/,
            caseInsensitive: true
        }],
        "#modifierKeywords": [{
            token: "keyword.modifier.vbnet",
            regex: /\b(?:As|byval|byref|optional|handles|inherits|implements|withevents|end set|end get|of|alias|declare|widening|narrowing|ansi|assembly|auto|iterator|key|unicode)\s+/,
            caseInsensitive: true
        }],
        "#moduleDefinition": [{
            token: [
                "storage.type.module.vbnet",
                "meta.module.vbnet",
                "entity.name.type.module.vbnet",
                "meta.module.vbnet"
            ],
            regex: /\b(module)(\s+)([a-zA-Z_]\w*)(\s*)/,
            caseInsensitive: true
        }],
        "#namespaceDefinition": [{
            token: [
                "storage.type.namespace.vbnet",
                "meta.namespace.vbnet",
                "entity.name.type.namespace.vbnet",
                "meta.namespace.vbnet"
            ],
            regex: /\b(namespace)(\s+)([a-zA-Z_]\w*)(\s*)/,
            caseInsensitive: true
        }],
        "#numericConstant": [{
            token: "constant.numeric.vbnet",
            regex: /\b-?\d+(?:\.?\d?)*/
        }],
        "#propertyDefinition": [{
            token: [
                "storage.type.property.vbnet",
                "meta.property.vbnet",
                "entity.name.type.property.vbnet",
                "meta.property.vbnet",
                "punctuation.definition.parameters.property.vbnet"
            ],
            regex: /\b(property)(\s+)([a-zA-Z_]\w*)(\s*)((?:\()?)/,
            caseInsensitive: true,
            push: [{
                token: [
                    "punctuation.definition.parameters.property.vbnet",
                    "meta.property.vbnet"
                ],
                regex: /((?:\))?)(\s*)/,
                next: "pop"
            }, {
                include: "#modifierKeywords"
            }, {
                include: "#supportTypes"
            }, {
                defaultToken: "meta.property.vbnet"
            }]
        }],
        "#propertyGetSet": [{
            token: "keyword.other.property.accessor.vbnet",
            regex: /^\s*(?:protected friend|protected|friend|private)?\s+(?:get|set)\s*\(?\b/,
            caseInsensitive: true
        }],
        "#quotedString": [{
            token: "string.quoted.double.vbnet",
            regex: /"(?:[^"]|"")*"/
        }],
        "#region": [{
            todo: {
                token: [
                    "meta.region.source.vbnet",
                    "keyword.directive.vbnet"
                ],
                regex: /^(\s*)(#region)/,
                caseInsensitive: true,
                push: [{
                    token: [
                        "meta.region.source.vbnet",
                        "keyword.directive.vbnet"
                    ],
                    regex: /^(\s*)(#end region)/,
                    caseInsensitive: true,
                    next: "pop"
                }, {
                    include: "$self"
                }, {
                    defaultToken: "meta.region.source.vbnet"
                }]
            }
        }],
        "#singleLineComment": [{
            token: "comment.line.singlequote.vbnet",
            regex: /'.*$/,
            comment: "single quote comment"
        }],
        "#storageModifiers": [{
            token: "storage.modifier.access.vbnet",
            regex: /\b(?:dim|public|private|protected friend|protected|friend|shadows|static|shared|readonly|default|partial|readonly|writeonly|erase|redim|lib)\b/,
            caseInsensitive: true
        }],
        "#suportFunctions": [{
            token: "support.function.vbnet",
            regex: /\b(?:new|addressof|addhandler|removehandler|throw|typeof|like|call|synclock)\b/,
            caseInsensitive: true
        }],
        "#supportTypes": [{
            token: "support.type.vbnet",
            regex: /\b(?:integer|decimal|double|single|date|long|short|char|string|byte|date|boolean|delegate|event|enum|sbyte|uinteger|ulong|ushort|const|object|global|paramarray)\b/,
            caseInsensitive: true
        }],
        "#vbFunctions": [{
            token: ["support.function.vbnet", "text"],
            regex: /\b((?:CBool|CByte|CChar|CDate|CDbl|CDec|Char|CInt|CLng|CObj|CSByte|CShort|CSng|CStr|CType|CUInt|CULng|CUShort|DirectCast|GetType|TryCast|GetXmlNamespace))(\()/,
            caseInsensitive: true
        }],
        "#wordOperator": [{
            token: "keyword.operator.vbnet",
            regex: /\b(?:mod|not|and|andalso|or|orelse|in|is|isnot|xor|out)\b/,
            caseInsensitive: true
        }]
    }
    
    this.normalizeRules();
};

VBNETHighlightRules.metaData = {
    fileTypes: ["vb"],
    name: "VB.NET",
    scopeName: "source.vbnet"
}


oop.inherits(VBNETHighlightRules, TextHighlightRules);

exports.VBNETHighlightRules = VBNETHighlightRules;
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

define("ace/mode/vbnet",["require","exports","module","ace/lib/oop","ace/mode/text","ace/mode/vbnet_highlight_rules","ace/mode/folding/cstyle"], function(require, exports, module) {
"use strict";

var oop = require("../lib/oop");
var TextMode = require("./text").Mode;
var VBNETHighlightRules = require("./vbnet_highlight_rules").VBNETHighlightRules;
var FoldMode = require("./folding/cstyle").FoldMode;

var Mode = function() {
    this.HighlightRules = VBNETHighlightRules;
    this.foldingRules = new FoldMode();
};
oop.inherits(Mode, TextMode);

(function() {
    this.$id = "ace/mode/vbnet"
}).call(Mode.prototype);

exports.Mode = Mode;
});
