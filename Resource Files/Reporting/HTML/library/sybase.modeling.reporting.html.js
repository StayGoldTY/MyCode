/*!
* Sybase.Modeling.Reporting.Html Rendering Library ('jReport')
*
* Copyright 2011-2013 (c) SAP SE or an SAP affiliate company.
*
* requires:
*  sybase.modeling.reporting.data.js
*
* defines:
*  jQuery.jreport
*
*  jQuery.listControl
*  jQuery.popupControl
*  jQuery.treeControl
*  jQuery.splitterControl
*
*  jQuery.disableSelection
*  jQuery.hoverClass
*  jQuery.swapClass
*  jQuery.toggleVisibility
*
*/
;
(function ($/*jQuery*/) {

    if ($.jreport)
        return;

    window.document.jdata.contentBase = "content/";

    var oDocument = window.document;

    var sLocationHref = oDocument.location.href;

    var isRtl = oDocument.documentElement.dir == "rtl";

    var sRootNodeId = "root";

    var mCurrentContent = {
        id: null,
        anchor: null,
        page: null
    };

    var CSS$CLASS = {
        listControl: "list-control",
        popupControl: "popup-control",
        treeControl: "tree-control",
        hSplitter: "h-splitter",
        vSplitter: "v-splitter",
        hSplitterButton: "h-splitter-button",
        vSplitterButton: "v-splitter-button",
        virtual: "virtual",
        collapsable: "collapsable",
        expandable: "expandable",
        collapsableHitArea: "collapsable-hit-area",
        expandableHitArea: "expandable-hit-area",
        hovered: "hovered",
        disabled: "disabled",
        enabled: "enabled",
        selected: "selected",
        flipped: "flipped",
        hitArea: "hit-area",
        category: "category",
        label: "label",
        value: "value"
    };

    var jreport$EVENT = {
        contentChange: "contentChange",
        contentReveal: "contentReveal"
    };

    // parameters handler
    (function () {
        var sFullHref;
        // NOTE: use # instead of ? to avoid page reload
        var parameterStart = sLocationHref.indexOf('#');
        if (parameterStart != -1) {
            sLocationHref = sLocationHref.substring(0, parameterStart);
        }
        oDocument.updateHash = function (parameterString) {
            // keep # even in case no parameter string is present to avoid page reload (thus losing treeview expansion state) upon clicking on hyperlink to root
            sFullHref = sLocationHref + (parameterString ? ("#" + parameterString) : "#");
            if (oDocument.location.href !== sFullHref) {
                oDocument.location.href = sFullHref;
            }
        };
        setInterval(function () {
            var sHref = oDocument.location.href;
            if (sHref !== sFullHref) {
                sFullHref = sHref;
                var sObjectId = "", sContentId = "", sAnchorId = "", page = 1;
                var parameterStart = sHref.indexOf('#');
                if (parameterStart != -1) {
                    var aParameters = sHref.substring(parameterStart + 1, sHref.length).split('&');
                    for (var i = 0; i < aParameters.length; i++) {
                        var aParameter = aParameters[i].split('=');
                        if (aParameter.length == 2) {
                            switch (aParameter[0]) {
                                case "o":
                                    sObjectId = aParameter[1];
                                    break;
                                case "n":
                                    sContentId = aParameter[1];
                                    break;
                                case "a":
                                    sAnchorId = aParameter[1];
                                    break;
                                case "p":
                                    page = parseInt(aParameter[1]);
                                    break;
                            }
                        }
                    }
                }
                if (sObjectId) {
                    internal.resolve("#" + sObjectId, function (sContentId, sAnchorId, page) {
                        if (sContentId) {
                            var parameterString = internal.buildParameterString(sContentId, sAnchorId, page);
                            $.jreport.display(sContentId, /* bReveal: */true, sAnchorId, page);
                        }
                    });
                }
                else {
                    $.jreport.display(sContentId, true, sAnchorId, page);
                }
            }
        }, 100);
    })();

    // internals
    var internal = {};

    internal.buildParameterString = function (sNodeId, sAnchorId, page) {
        var result = "";
        if (sNodeId && sNodeId != sRootNodeId) {
            result += "n=" + sNodeId;
        }
        if (sAnchorId) {
            result += (result.length > 0 ? "&a=" : "a=") + sAnchorId;
        }
        if (page > 1) {
            result += (result.length > 0 ? "&p=" : "p=") + page;
        }
        return result;
    };

    /**
    * internal.widget(oWidget)
    */
    internal.widget = (function () {

        // enforce zero margins on body elements => ensure width=100% and height=100% match body width & height
        // (prevent scroll bars from being created)
        $(function () { $("body").css("margin", 0); });

        var CSS$LOGICALCLASS = {
            alternate: "alt",
            browserPane: "browser-pane",
            card: "card",
            cardLabel: "card-label",
            contentPane: "content-pane",
            list: "list",
            listHeader: "list-header"
        };

        // pd report 16.1.x- css-compatibility

        var CSS$COMPATIBILITY = {};
        {
            CSS$COMPATIBILITY[CSS$LOGICALCLASS.alternate] = "TD2";
            CSS$COMPATIBILITY[CSS$LOGICALCLASS.browserPane] = "BROWSERBODY";
            CSS$COMPATIBILITY[CSS$LOGICALCLASS.card] = "Form";
            CSS$COMPATIBILITY[CSS$LOGICALCLASS.cardLabel] = "HEADER";
            CSS$COMPATIBILITY[CSS$LOGICALCLASS.contentPane] = "HOMEBODY";
            CSS$COMPATIBILITY[CSS$LOGICALCLASS.list] = "Grid";
            CSS$COMPATIBILITY[CSS$LOGICALCLASS.listHeader] = "HEADER";

            for (var logicalClass in CSS$COMPATIBILITY) {
                CSS$COMPATIBILITY[CSS$COMPATIBILITY[logicalClass]] = CSS$COMPATIBILITY[logicalClass];
            }
        };

        // prefix used for content browser item ids ( <item-id> := '@' <node-id> )
        var ContentBrowser$ITEMIDPREFIX = "@";

        /**
        * addClasses(oElement, aClasses)
        */
        function addClasses(oElement, aClasses) {
            if (aClasses) {
                var $oElement = $(oElement);
                for (var i = 0; i < aClasses.length; i++) {
                    var sClass = aClasses[i];
                    var sLegacyClass = CSS$COMPATIBILITY[sClass];
                    if (sLegacyClass) {
                        $oElement.addClass(sLegacyClass);
                    }
                    $oElement.addClass(sClass);
                }
            }
        };

        /**
        * getLegacyClasses(aClasses)
        */
        function getLegacyClasses(aClasses) {
            var aResult = [];
            if (aClasses) {
                for (var i = 0; i < aClasses.length; i++) {
                    var sClass = aClasses[i];
                    var sLegacyClass = CSS$COMPATIBILITY[sClass];
                    if (sLegacyClass) {
                        aResult = aResult.concat([sLegacyClass]);
                    }
                }
            }
            return aResult;
        }

        /**
        * getWidgetClasses(oWidget)
        */
        function getWidgetClasses(oWidget) {
            if (oWidget) {
                for (var sComponent in oWidget) {
                    return oWidget[sComponent].classes;
                }
            }
            return undefined;
        }

        /**
        * isHtmlElement(o)
        */
        function isHtmlElement(o) {
            return typeof HTMLElement === "object" ? o instanceof HTMLElement : o && typeof o === "object" && o.nodeType === 1 && typeof o.nodeName === "string";
        }

        var mWidgets = {

            // Anchor { id }
            Anchor: function (owAnchor) {
                var oA = oDocument.createElement('a');
                oA.name = owAnchor.id;
                return oA;
            },

            // ChartView { type : ChartType, title? : string, xAxisLabel? : string, yAxisLabel? : string, dimensions : { name : string, values: object[] }[], measures: { name: string, values: }[] }
            ChartView: function (owChartView) {

                var oDIV = document.createElement("div");
                $(oDIV).css({ height: "300px", width: "100%" });

                var dataSet = new sap.viz.data.CrosstableDataset();
                var analysisAxis = $.map(owChartView.dimensions, function (oDimension, i) {
                    var result = {};
                    result.index = i + 1;
                    result.data = [{ type: "Dimension", name: oDimension.name }];
                    result.data[0].values = oDimension.values;
                    return result;
                });
                var measureValuesGroup = [{ 'index': 1 }];
                measureValuesGroup[0].data = $.map(owChartView.measures, function (oMeasure, i) {
                    var result = { type: "Measure", name: oMeasure.name };
                    if (owChartView.dimensions.length == 1) {
                        result.values = [oMeasure.values];
                    } else {
                        result.values = oMeasure.values;
                    }
                    return result;
                });
                dataSet.setData({'analysisAxis': analysisAxis, 'measureValuesGroup': measureValuesGroup});
                var chartOption = {
                    title : { visible : owChartView.title, text : owChartView.title },
                    xAxis : { title : { visible : owChartView.xAxisLabel, text: owChartView.xAxisLabel } },
                    yAxis : { title : { visible : owChartView.yAxisLabel, text: owChartView.yAxisLabel } }
                };
                var vizType = "viz/column";
                switch (owChartView.type) {
                    case "ColumnChart":
                        var display = undefined;
                        $.each(owChartView.measures, function (i, oMeasure) { if (!display) { display = oMeasure.display; } else if (display !== oMeasure.display) { display = "LineBar" } });
                        switch (display)
                        {
                            case "Line":
                                vizType = "viz/line";
                                break;
                            case "LineBar":
                                vizType = "viz/combination";
                                break;
                            default:
                                vizType = "viz/column";
                                break;
                        }
                        break;
                    case "BarChart":
                        var display = undefined;
                        $.each(owChartView.measures, function (i, oMeasure) { if (!display) { display = oMeasure.display; } else if (display !== oMeasure.display) { display = "LineBar" } });
                        switch (display)
                        {
                            case "Line":
                                vizType = "viz/horizontal_line";
                                break;
                            case "LineBar":
                                vizType = "viz/horizontal_combination";
                                break;
                            default:
                                vizType = "viz/bar";
                                break;
                        }
                        break;
                    case "PieChart":
                        vizType = "viz/pie";
                        break;
                }
                setTimeout(function() {
                    sap.viz.core.createViz({
                        type : vizType,
                        data : dataSet,
                        container : $(oDIV),
                        options : chartOption
                    });
                    // work around viz positioning issue...
                    $(oDIV).find("div").css("position", "static");
                }, 0);

                return oDIV;
            },

            // ColumnPanel { panes : { size? : string, content: Widget }[] }
            ColumnPanel: function (owColumnPanel) {
                var oTABLE = oDocument.createElement("table"), oCOLGROUP = oDocument.createElement("colgroup");
                var oTBODY = oDocument.createElement("tbody"), oTR = oDocument.createElement("tr");
                $(oTABLE).add($(oTBODY)).css({ "border-spacing": "0px", margin: "0px", padding: "0px", border: "0px", width: "100%" });
                oTABLE.appendChild(oCOLGROUP);
                oTABLE.appendChild(oTBODY);
                oTBODY.appendChild(oTR);
                var totalStarWeight = 0;
                $.each(owColumnPanel.panes, function (i, oPane) {
                    var starWeight = oPane.size ? getStarWeight(oPane.size) : 1;
                    if (starWeight) {
                        totalStarWeight += starWeight;
                    }
                });
                $.each(owColumnPanel.panes, function (i, oPane) {
                    var oCOL = oDocument.createElement("col");
                    oCOLGROUP.appendChild(oCOL);
                    var starWeight = oPane.size ? getStarWeight(oPane.size) : 1;
                    if (starWeight) {
                        $(oCOL).css("width", ((100 * starWeight) / totalStarWeight) + "%");
                    } else {
                        $(oCOL).css("width", getPxSizeString(oPane.size));
                    }
                    var oChildTD = oDocument.createElement("td");
                    $(oChildTD).css({ margin: "0px", padding: "0px", border: "0px", "vertical-align": "top" });
                    oTR.appendChild(oChildTD);
                    var owPane = oPane.content;
                    if (owColumnPanel.itemSpacing) {
                        aMargin = [0,0,0,0];
                        if (i > 0) {
                            aMargin[0] = owColumnPanel.itemSpacing / 2;
                        }
                        if (i < (owColumnPanel.panes.length - 1)) {
                            aMargin[2] = owColumnPanel.itemSpacing / 2;
                        }
                        owPane = {Component:{children: [owPane], margin: aMargin}};
                    }
                    internal.widget(owPane, oChildTD);
                });
                return oTABLE;
            },

            // Component { children : Widget[],
            //             type?: string,
            //             classes? : string[] }
            Component: function (owComponent) {
                var oDIV;
                if (owComponent.children && owComponent.children.length > 0) {
                    oDIV = document.createElement("div");
                    if (owComponent.children.length > 1) {
                        var cssFragment = "float:bottom;width:100%;";
                        $.each(owComponent.children, function (i, oChildWidget) {
                            var oChildDIV = oDocument.createElement("div");
                            if (cssFragment !== null) {
                                oChildDIV.style.cssText = cssFragment;
                            }
                            internal.widget(oChildWidget, oChildDIV, { classes: getLegacyClasses(owComponent.classes) });
                            oDIV.appendChild(oChildDIV);
                        });
                    } else {
                        internal.widget(owComponent.children[0], oDIV, { classes: getLegacyClasses(owComponent.classes) });
                    }
                }
                return oDIV;
            },

            // ContentBreadCrumbs
            ContentBreadCrumbs: function (owContentBreadCrumbs) {
                var oDIV = document.createElement("div");
                oDIV.className = "content-breadcrumbs";
                //$(oDIV).css({ overflow: "auto", width: "100%", height: "100%" });
                $(oDocument).bind(jreport$EVENT.contentChange, function (event) {
                    internal.forNode(mCurrentContent.id).forBranch(function (aBranch) {
                        $(oDIV).empty();
                        internal.widget({ StackPanel: {
                            orientation: "Horizontal",
                            // with right-to-left language support
                            children: $.map(aBranch, function (oNode, i) {
                                return { StackPanel: { orientation: "Horizontal", children: [
                                    { Hyperlink: { url: "jreport://" + oNode.id, text: oNode.name || "Untitled"} },
                                    { HTMLPresenter: { html: (i < (aBranch.length - 1)) ? "&nbsp;" + ">" + "&nbsp;" : ""} }
                                ]
                                }
                                };
                            })
                        }
                        }, oDIV);
                    });
                });
                return oDIV;
            },

            // ContentBrowser { roots : string[] }
            ContentBrowser: function (owContentBrowser) {
                var oDIV = document.createElement("div");
                // use scrollbars as necessary
                //$(oDIV).css({ overflow: "auto", width: "100%", height: "100%" });
                var oUL = oDocument.createElement("ul");
                oUL.className = "content-browser";
                oDIV.appendChild(oUL);
                var mTreeProvider;
                mTreeProvider = {
                    getChildren: function (sItemId, yield_return) {
                        // extract node id-from item-id
                        var sNodeId = sItemId === null ? sRootNodeId : sItemId.substring(ContentBrowser$ITEMIDPREFIX.length);
                        internal.forNode(sNodeId, { fnCallback: function (oNode) {
                            var callbackSequence = new internal.CallbackSequence();
                            $.each(sItemId === null ? owContentBrowser.roots : ((oNode && oNode.children) || []), function (i, childNode) {
                                internal.forNode(childNode, { fnCallback: function (oChildNode) {
                                    // use callback sequence to ensure child nodes are returned in proper order.
                                    callbackSequence.invoke(i, function () {
                                        if (oChildNode) {
                                            // Note: item-id should not match content-id so as to avoid automatic scrollIntoView on item click (as content id is used as fragment identifier)
                                            // we thus prepend ContentBrowser$ITEMIDPREFIX to the node-id
                                            var sChildItemid = ContentBrowser$ITEMIDPREFIX + (oChildNode.id ? oChildNode.id : sRootNodeId);
                                            var hasChildren = (oChildNode.children && oChildNode.children.length > 0);
                                            if (oChildNode.hidden) {
                                                //if (hasChildren) {
                                                //    mTreeProvider.getChildren(sChildItemid, yield_return);
                                                //}
                                            } else if (oChildNode.skip) {
                                                if (hasChildren) {
                                                    mTreeProvider.getChildren(sChildItemid, yield_return);
                                                }
                                            }
                                            else {
                                                yield_return({
                                                    id: sChildItemid,
                                                    label: oChildNode.name || "&lt;Untitled&gt;",
                                                    hasChildren: hasChildren
                                                });
                                            }
                                        }
                                    });
                                }
                                });
                            });
                        }
                        });
                    },
                    onClick: function (sItemId) {
                        // extract node-id/content-fragment from item-id
                        var sNodeId = sItemId.substring(ContentBrowser$ITEMIDPREFIX.length);
                        internal.resolve(sNodeId, function (sContentId, sAnchorId, page) {
                            var parameterString = internal.buildParameterString(sContentId, sAnchorId, page);
                            jreport.display(sContentId, /* bReveal: */true, sAnchorId, page);
                        });
                    },
                    isRtl: isRtl
                }
                $(oUL).treeControl(mTreeProvider);

                $(oDocument).bind(jreport$EVENT.contentChange, function (event) {
                    internal.forNode(mCurrentContent.id).forBranch(function (aBranch) {
                        $(oUL).treeControl().selectAndReveal($.map(aBranch, function (oNode) { return ContentBrowser$ITEMIDPREFIX + oNode.id; }), /* bReveal: */false);
                    });
                });
                $(oDocument).bind(jreport$EVENT.contentReveal, function (event) {
                    internal.forNode(mCurrentContent.id).forBranch(function (aBranch) {
                        $(oUL).treeControl().selectAndReveal($.map(aBranch, function (oNode) { return ContentBrowser$ITEMIDPREFIX + oNode.id; }), /* bReveal: */true);
                    });
                });
                return oDIV;
            },

            // ContentHolder
            ContentHolder: function (owContentHolder) {
                var oDIV = document.createElement("div");
                oDIV.className = "content-holder";
                // use scrollbars as necessary
                //$(oRenderedElement).css({ height: "100%", overflow: "auto" });
                if (!mWidgets.StaticInit$ContentHolder) {
                    $(oDocument).bind(jreport$EVENT.contentChange, function (event) {
                        $("div.content-holder").each(function (index, oContentHolderDIV) {
                            jreport.apply((mCurrentContent.id || sRootNodeId) + ".content." + (mCurrentContent.page || 1), oContentHolderDIV);
                            $(oContentHolderDIV).parents().filter(function() { return $(this)[0].style.overflow == "auto"; }).first().scrollTop(0);
                        });
                    });
                    $(oDocument).bind(jreport$EVENT.contentReveal, function (event) {
                        $("div.content-holder").each(function (index, oContentHolderDIV) {
                            var a = mCurrentContent.anchor ? $(oContentHolderDIV).find("a[name='" + mCurrentContent.anchor + "']")[0] : null;
                            $(oContentHolderDIV).parents().filter(function() { return $(this)[0].style.overflow == "auto"; }).first().scrollTop(a && $(a).position().top || 0);
                        });
                    });
                    setTimeout(function() { $(oDocument).trigger(jreport$EVENT.contentChange); }, 0);
                    mWidgets.StaticInit$ContentHolder = true;
                }
                return oDIV;
            },

            // ContentPresenter { id }
            ContentPresenter: function (owContentPresenter) {
                var oDIV = oDocument.createElement("div");
                if (owContentPresenter.id) {
                    jreport.apply(owContentPresenter.id, oDIV);
                }
                return oDIV;
            },

            // DiagramView { (svgdata | imgsrc),
            //               map,
            //               mapname,
            //               size: { width: int, height: int } }
            DiagramView: function (owDiagramView) {
                var oContainerDIV = oDocument.createElement("div");
                var oIMG;
                if (owDiagramView.svgdata) {
                    var hasSVGSupport = true;
                    var oEMBED = null;
                    try {
                        var oOBJECT = oDocument.createElement("object");
                        oOBJECT.type = "image/svg+xml";
                    } catch (e) {
                        hasSVGSupport = false;
                    }
                    if (hasSVGSupport) {
                        oEMBED = oDocument.createElement("embed");
                        oEMBED.src = owDiagramView.svgdata;
                        oEMBED.type = "image/svg+xml";
                        oContainerDIV.appendChild(oEMBED);
                        // h@ck: transparent image overlay to support extra navigation features
                        oIMG = oDocument.createElement("img");
                        $(oIMG).css({ position: "absolute", width: owDiagramView.size.width, height: owDiagramView.size.height });
                        $(oContainerDIV).css({ position: "relative" });
//                    if (owDiagramView.zoom == "fitToPage") {
//                        oOBJECT.style.width = "100%";
//                        oIMG.style.width = "100%";
//                    }
                        oContainerDIV.appendChild(oIMG);
                    } else {
                        $(oContainerDIV).html("SVG content is not supported by your browser.");
                    }
                }
                else if (owDiagramView.imgsrc) {
                    oIMG = oDocument.createElement("img");
//                    if (owDiagramView.zoom == "fitToPage") {
//                        oIMG.style.width = "100%";
//                    }
                    oContainerDIV.appendChild(oIMG);
                }
                if (oIMG && owDiagramView.map && owDiagramView.mapname) {
                    var oDIV = oDocument.createElement("div");
                    oDIV.innerHTML = owDiagramView.map;
                    oContainerDIV.appendChild(oDIV);
                    var aAREAs = oDIV.firstChild.childNodes;
                    for (var i = 0; i < aAREAs.length; i++) {
                        aAREAs[i].onmouseover = function (e) {
                            var oAREA = this;
                            if (oAREA.id) {
                                internal.fetch(owDiagramView.mapname + ".navigation", function (mNavigation) {
                                    var sAnchorId = oAREA.id;
                                    var diagrams = mNavigation && sAnchorId.indexOf("#") == 0 && mNavigation[sAnchorId.substring("#".length)];
                                    if (diagrams && diagrams.length > 0) {
                                        if (diagrams[0].Diagram) {
                                            sAnchorId = "#" + diagrams[0].Diagram.id;
                                        }
                                        allDiagrams = $.map(diagrams, function (diagramOrCategory) {
                                            return diagramOrCategory.Category ? [diagramOrCategory].concat(diagramOrCategory.Category.content) : diagramOrCategory;
                                        });
                                        var hasDiagram = false;
                                        $.each(allDiagrams, function (i, diagramOrCategory) {
                                            if (diagramOrCategory.Diagram) {
                                                oDocument.jdata.resolve("#" + diagramOrCategory.Diagram.id, function (sContentId, sAnchorId, page) {
                                                    if (sContentId != null && !hasDiagram) {
                                                        hasDiagram = true;
                                                        var $popup = $(oIMG).popupControl(owDiagramView.mapname + "-navbutton", oAREA, function (oTarget) {
                                                            var imageOffset = $(oIMG).offset();
                                                            var areaCoords = $.map(oTarget.coords.split(','), function (s) { return parseInt(s); });
                                                            return { left: imageOffset.left + areaCoords[0], top: imageOffset.top + areaCoords[1], right: imageOffset.left + areaCoords[2], bottom: imageOffset.top + areaCoords[3] };
                                                        }, { x: 5, y: 0 }, "NE");
                                                        if ($popup.children().size() == 0) {
                                                            $popup.html('<img src="library/images/navigation_shortcut.png"/>');
                                                        }
                                                        $popup.unbind("mouseover");
                                                        $popup.mouseover(function () {
                                                            $menu = $(oIMG).popupControl(owDiagramView.mapname + "-navmenu", $popup[0], function (oPopup) {
                                                                var position = $popup.position(), width = $popup.width(), height = $popup.height();
                                                                return { left: position.left, top: position.top, right: position.left + width, bottom: position.top + height };
                                                            }, { x: 5, y: 0 }, "NE");
                                                            $menu.html('<ul>');
                                                            $menu.children().listControl({
                                                                getChildren: function (sItemId, yield_return) {
                                                                    var callbackSequence = new internal.CallbackSequence();
                                                                    $.each(allDiagrams, function (i, diagramOrCategory) {
                                                                        if (diagramOrCategory.Category) {
                                                                            callbackSequence.invoke(i, function () {
                                                                                yield_return({ id: "", label: diagramOrCategory.Category.displayName + " :", category: true });
                                                                            });
                                                                        } else if (diagramOrCategory.Diagram) {
                                                                            oDocument.jdata.resolve("#" + diagramOrCategory.Diagram.id, function (sContentId, sAnchorId, page) {
                                                                                if (sContentId != null) {
                                                                                    callbackSequence.invoke(i, function () {
                                                                                        yield_return({ id: diagramOrCategory.Diagram.id, label: diagramOrCategory.Diagram.displayName });
                                                                                    });
                                                                                }
                                                                            });
                                                                        }
                                                                    });
                                                                },
                                                                onClick: function (sItemId) {
                                                                    internal.resolve("#" + sItemId, function (sContentId, sAnchorId, page) {
                                                                        var parameterString = internal.buildParameterString(sContentId, sAnchorId, page);
                                                                        jreport.display(sContentId, true, sAnchorId, page);
                                                                    });
                                                                }
                                                            });
                                                            $menu.show();
                                                        });
                                                        $popup.show();
                                                    }
                                                });
                                            }
                                        });
                                    }
                                    oDocument.jdata.resolve(sAnchorId, function (sContentId, sAnchorId, page) {
                                        if (sContentId != null) {
                                            // keep # even in case no parameter string is present to avoid page reload (thus losing treeview expansion state) upon clicking on hyperlink to root
                                            var parameterString = internal.buildParameterString(sContentId, sAnchorId, page);
                                            oAREA.href = sLocationHref + (parameterString ? ("#" + parameterString) : "#");
                                        }
                                    });
                                }, /*useCache:*/true);
                                //if (!$.browser.msie) {
                                //    oAREA.removeAttribute("id");
                                //}
                            }
                        };
                    }
                    oIMG.useMap = "#" + owDiagramView.mapname;
                    oIMG.border = 0;
                    oIMG.src = owDiagramView.imgsrc || "library/images/blank.gif";
                }
                return oContainerDIV;
            },

            // DockPanel { panes : { size? : int, content: Widget }[3], left|center|right or top|center|bottom
            //             orientation? : { Vertical, Horizontal } }
            DockPanel: function (owDockPanel) {
                var orientation = owDockPanel.orientation || "Vertical";
                var panes = owDockPanel.panes;
                var oDockPanelDIV = oDocument.createElement("div");
                var doFlip = isRtl && orientation == "Horizontal";
                if (doFlip) {
                    panes =  panes.reverse();
                }
                var dockSide1 = orientation == "Vertical" ? "top" : "left";
                var dockSide2 = orientation == "Vertical" ? "bottom" : "right";
                var dimension = orientation == "Vertical" ? "height" : "width";
                var orthogonalDimension = orientation == "Vertical" ? "width" : "height";

                var dockSide = dockSide1;
                $.each(panes, function (i, oPane) {
                    var mChildProps;
                    var oDIV = oDocument.createElement("div");
                    var oDIVStyle = oDIV.style;
                    var cssText = null;
                    oDIVStyle.position = "absolute";
                    oDIVStyle[orthogonalDimension] = "100%";
                    if (oPane && oPane.size) {
                        oDIVStyle[dockSide] = "0px";
                        oDIVStyle[dimension] = getPxSizeString(oPane.size);
                        // BUG FIX: forward dimension hint to child widget (ensure borders are rendered properly)
                        mChildProps = {};
                        mChildProps[dimension] = oPane.size;
                    } else {
                        oDIVStyle[dockSide1] = getPxSizeString((panes[0] && panes[0].size) || 0);
                        oDIVStyle[dockSide2] = getPxSizeString(((panes.length > (i + 1)) && panes[i + 1] ? panes[i + 1].size : 0) || 0);
                    }
                    if (oPane) {
                        if (oPane.overflow) {
                            oDIVStyle.overflow = oPane.overflow;
                        }
                        if (oPane.classes) {
                            addClasses(oDIV, oPane.classes);
                        }
                        internal.widget(oPane.content, oDIV, mChildProps);
                    }
                    dockSide = dockSide2;
                    oDockPanelDIV.appendChild(oDIV);
                });
                return oDockPanelDIV;
            },

            // Hyperlink { url,
            //             content : Widget | text : string }
            Hyperlink: function (owHyperlink) {
                var oDIV = document.createElement("div");
                internal.widget({ TextPresenter: owHyperlink }, oDIV, { htmlElement: oDIV });
                delete owHyperlink.htmlElement;
                var createA = function (href) {
                    $(oDIV).empty();
                    var oA = oDocument.createElement("a");
                    oA.href = href;
                    if (href.indexOf(sLocationHref) == -1 && (href.indexOf("file://") == 0 || href.indexOf("http://") == 0 || href.indexOf("\\\\") == 0)) {
                        oA.target = "_blank";
                    }
                    if (owHyperlink.content) {
                        internal.widget(owHyperlink.content, oA, { classes: owHyperlink.classes });
                    } else if (owHyperlink.text) {
                        internal.widget({ TextPresenter: owHyperlink }, oA);
                    } else {
                        oA.innerHTML = sUrl.indexOf("jreport://") == 0 ? "_" : sUrl;
                    }
                    if (owHyperlink.direction) {
                        oA.dir = owHyperlink.direction;
                    }
                    oDIV.appendChild(oA);
                    return oA;
                }
                var sUrl = owHyperlink.url;
                if (sUrl.indexOf("jreport://") == 0) {
                    var sContentFragment = sUrl.substring("jreport://".length);
                    internal.resolve(sContentFragment, function (sContentId, sAnchorId, page) {
                        if (sContentId) {
                            var parameterString = internal.buildParameterString(sContentId, sAnchorId, page);
                            // keep # even in case no parameter string is present to avoid page reload (thus losing treeview expansion state) upon clicking on hyperlink to root
                            var oA = createA(sLocationHref + (parameterString ? ("#" + parameterString) : "#"));
                            oA.onclick = function () { $.jreport.display(sContentId, /* bReveal: */true, sAnchorId, page); };

                        }
                    });
                } else {
                    // standard url
                    createA(sUrl);
                }
                return oDIV;
            },

            // HTMLPresenter { html,
            //                 head? }
            HTMLPresenter: function (owHTMLPresenter) {
                var oDIV = oDocument.createElement("div");
                if (owHTMLPresenter.html) {
                    if (!$.browser.msie) {
                        // UGLY: special case: rtf checkmark => convert to unicode
                        owHTMLPresenter.html = owHTMLPresenter.html.replace("<span style=\"font-family:\'Wingdings\';font-size:8pt;\">ü</span>", "<span style=\"font-size:8pt;\">&#x2713;</span>");
                    }
                    oDIV.innerHTML = owHTMLPresenter.html;
                }
                if (owHTMLPresenter.head) {
                    var oHead = document.getElementsByTagName("head").item(0);
                    if (oHead) {
                        $(oHead).append(owHTMLPresenter.head);
                    }
                }
                $(oDIV).find("div[class=dynamic]").jreport();
                return oDIV;
            },

            // ImageView { imgsrc: string, width: float, height: float, aspectRatio: float? }
            ImageView: function (owImageView) {
                var oIMG = oDocument.createElement("img");
                oIMG.src = owImageView.source || owImageView.imgsrc;
                oIMG.style.verticalAlign = "bottom";
                if (owImageView.halign)
                {
                    oIMG.style.horizontalAlign = owImageView.halign;
                }
                if (owImageView.width == -1 && owImageView.height == -1)
                {
                    $(oIMG).css({"max-width": "100%"});
                }
                else
                {
                    $(oIMG).css({width: owImageView.width + "px", height: owImageView.height + "px"});
                }
                return oIMG;
            },

            // ItemsPresenter { id: string | items : string[] }
            ItemsPresenter: function (owItemsPresenter) {
                var oDIV = oDocument.createElement("div");
                var callbackSequence = new internal.CallbackSequence();
                var createItemPresenter = function(sNodeId, i) {
                    internal.forNode(sNodeId, { fnCallback: function (oChildNode) {
                        // exclude topic refs
                        if (oChildNode && oChildNode.id && oChildNode.id.indexOf("#") == -1) {
                            // use callback sequence to ensure child nodes are returned in proper order.
                            callbackSequence.invoke(i, function () {
                                for (var page = 1, maxPage = oChildNode.pageCout || 1; page <= maxPage; page++) {
                                    internal.widget({ ContentPresenter: {id: oChildNode.id + ".content." + page} }, oDIV);
                                }
                            }, /*timeout:*/10);
                        }
                    }});
                }
                if (owItemsPresenter.id) {
                    internal.forNode(owItemsPresenter.id, { fnCallback: function (oNode) {
                        $.each((oNode && oNode.children) || [], function (i, childNode) {
                            createItemPresenter(childNode.id, i);
                        });
                    }});
                } else if (owItemsPresenter.items) {
                    for (var i = 0, itemCount = owItemsPresenter.items.length; i < itemCount; i++) {
                        createItemPresenter(owItemsPresenter.items[i], i);
                    }
                }
                return oDIV;
            },

            // ListView { columnCount,
            //            minColumnWidth,
            //            minRowHeight,
            //            columnHeaders : Widget[],
            //            rowHeaders : Widget[],
            //            cells : Widget[],
            //            columnHeadersGridLineHeight?,
            //            rowHeadersGridLineWidth?,
            //            horizontalGridLineHeight?,
            //            verticalGridLineWidth?,
            //            gridLineColor? }
            ListView: function (owListView) {
                var oTABLE = oDocument.createElement("table");
                var oTR, oTD, oTBODY;
                oTABLE.style.cssText += "border-spacing:0px; border-collapse:collapse;";
                oTABLE.border = 0; oTABLE.cellPadding = 0; oTABLE.cellSpacing = 0;
                oTABLE.style.width = "100%";
                addClasses(oTABLE, getLegacyClasses(owListView.classes));
                var columnCount = owListView.columnCount;
                var rowCount = columnCount > 0 ? owListView.cells.length / columnCount : 0;
                var actualColumnCount = columnCount + (owListView.rowHeaders ? 1 : 0);
                if (columnCount > 0) {
                    // column definitions
                    var oCOLGROUP = oDocument.createElement("colgroup");
                    oTABLE.appendChild(oCOLGROUP);
                    var totalPercentWidth = 0;
                    var percentWidthColumnCount = 0;
                    if (owListView.columnWidths) {
                        $.each(owListView.columnWidths, function (i, sColumnWidth) {
                            if (sColumnWidth.indexOf('%', sColumnWidth.length - 1) !== -1) {
                                totalPercentWidth += parseInt(sColumnWidth.substring(0, sColumnWidth.length - 1));
                                percentWidthColumnCount++;
                            }
                        });
                    }
                    for (var column = 0; column < actualColumnCount; column++) {
                        var oCOL = oDocument.createElement("col");
                        if (column == 0 && owListView.rowHeaders) {
                            if (owListView.rowHeadersGridLineWidth) {
                                oCOL.style.cssText = "border: 0px; border-right: " + owListView.rowHeadersGridLineWidth + "px solid " + (owListView.gridLineColor ? owListView.gridLineColor : "") + ";";
                            }
                        } else if (column < (actualColumnCount - 1)) {
                            if (owListView.verticalGridLineWidth) {
                                oCOL.style.cssText = "border: 0px; border-right: " + owListView.verticalGridLineWidth + "px solid " + (owListView.gridLineColor ? owListView.gridLineColor : "") + ";";
                            }
                        }
                        oCOLGROUP.appendChild(oCOL);
                        if (!owListView.rowHeaders || column > 0) {
                            if (!owListView.columnWidths || owListView.columnWidths[column] == "*") {
                                $(oCOL).css("width", ((100 - totalPercentWidth) / (owListView.columnWidths.length - percentWidthColumnCount)) + "%");
                            } else {
                                $(oCOL).css("width", owListView.columnWidths[column]);
                            }
                        }
                    }
                    oTBODY = oDocument.createElement("tbody");
                    oTABLE.appendChild(oTBODY);
                    // column headers
                    if (owListView.columnHeaders) {
                        oTR = oDocument.createElement("tr");
                        oTBODY.appendChild(oTR);
                        oTR.style.cssText = "border-top-width:0px;border-spacing:0px";
                        if (owListView.rowHeaders) {
                            oTD = oDocument.createElement("td");
                            oTR.appendChild(oTD);
                        }
                        $.each(owListView.columnHeaders, function (i, oHeaderWidget) {
                            oTD = oDocument.createElement("td");
                            var oDIV = oDocument.createElement("div");
                            internal.widget(oHeaderWidget, oDIV);
                            var widgetClasses = getWidgetClasses(oHeaderWidget);
                            addClasses(oTD, getLegacyClasses(widgetClasses));
                            oTD.appendChild(oDIV);
                            oTR.appendChild(oTD);
                        });
                        if (owListView.columnHeadersGridLineHeight) {
                            oTR.style.cssText = "border: 0px; border-bottom: " + owListView.columnHeadersGridLineHeight + "px solid " + (owListView.gridLineColor ? owListView.gridLineColor : "") + ";";
                        }
                    }
                    // row headers and cells
                    var currentRow = -1;
                    $.each(owListView.cells, function (i, oCellWidget) {
                        var widgetClasses;
                        if ((i % columnCount) == 0) {
                            oTR = oDocument.createElement("tr");
                            oTR.className = "cell-row";
                            oTBODY.appendChild(oTR);
                            currentRow++;
                            if ((currentRow < (rowCount - 1)) && owListView.horizontalGridLineHeight) {
                                oTR.style.cssText = "border: 0px; border-bottom: " + owListView.horizontalGridLineHeight + "px solid " + (owListView.gridLineColor ? owListView.gridLineColor : "") + ";";
                            }
                            if (owListView.rowHeaders) {
                                // row header
                                var oRowHeaderWidget = owListView.rowHeaders[currentRow];
                                widgetClasses = getWidgetClasses(oRowHeaderWidget);
                                oTD = oDocument.createElement("td");
                                addClasses(oTD, getLegacyClasses(widgetClasses));
                                oDIV = oDocument.createElement("div");
                                oTD.appendChild(oDIV);
                                internal.widget(oRowHeaderWidget, oDIV);
                                oTR.appendChild(oTD);
                            }
                        }
                        // cell
                        oTD = oDocument.createElement("td");
                        widgetClasses = getWidgetClasses(oCellWidget);
                        addClasses(oTD, getLegacyClasses(widgetClasses));
                        if (currentRow % 2 == 1) {
                            addClasses(oTD, [CSS$LOGICALCLASS.alternate]);
                        }
                        oDIV = oDocument.createElement("div");
                        oTD.appendChild(oDIV);
                        internal.widget(oCellWidget, oDIV);
                        oTR.appendChild(oTD);
                    });
                }
                return oTABLE;
            },

            // NavigationBar
            NavigationBar: function (owNavigationBar) {
                var oSPAN = oDocument.createElement("span");
                oSPAN.className = "content-nav-bar";
                oSPAN.pageCount = 1;
                if (isRtl) {
                    $(oSPAN).addClass(CSS$CLASS.flipped);
                }
                var aButtonSPANs = new Array(5);
                for (var i = 0; i < aButtonSPANs.length; i++) {
                    aButtonSPANs[i] = oDocument.createElement("span");
                }
                nextNodeButtonClass = isRtl ? "content-nav-prev-button" : "content-nav-next-button";
                nextPageButtonClass = isRtl ? "content-nav-back-button" : "content-nav-forward-button";
                previousNodeButtonClass = isRtl ? "content-nav-next-button" : "content-nav-prev-button";
                previousPageButtonClass = isRtl ? "content-nav-forward-button" : "content-nav-back-button";

                aButtonSPANs[0].className = previousNodeButtonClass;
                aButtonSPANs[1].className = previousPageButtonClass;
                aButtonSPANs[2].className = "content-nav-text";
                aButtonSPANs[3].className = nextPageButtonClass;
                aButtonSPANs[4].className = nextNodeButtonClass;

                aButtonSPANs[2].dir = "ltr";

                for (i = 0; i < aButtonSPANs.length; i++) {
                    if (aButtonSPANs[i].className.indexOf("button") != -1) {
                        $(aButtonSPANs[i]).addClass("content-nav-bar-button");
                    }
                    oSPAN.appendChild(aButtonSPANs[i]);
                }
                $(oSPAN).disableSelection();

                $(oSPAN).find("span." + previousNodeButtonClass).click(function (event) {
                    if (mCurrentContent.page > 1) {
                        $(oSPAN).find("span." + previousPageButtonClass).trigger("click");
                    } else {
                        internal.forNode(mCurrentContent.id).forPreviousWhere(
                            /*fnCallback: */function (oPrevious) { if (oPrevious) { $.jreport.display(oPrevious.id, true, null, oPrevious.pagecount || 1); } },
                            /*fnPredicate:*/function (oPrevious) { return oPrevious.id.indexOf('#') != 0; }
                        );
                    }
                });
                $(oSPAN).find("span." + nextNodeButtonClass).click(function (event) {
                    if (mCurrentContent.page < oSPAN.pageCount) {
                        $(oSPAN).find("span." + nextPageButtonClass).trigger("click");
                    } else {
                        internal.forNode(mCurrentContent.id).forNextWhere(
                            /*fnCallback: */function (oNext) { if (oNext) { $.jreport.display(oNext.id, true); } },
                            /*fnPredicate:*/function (oNext) { return oNext.id.indexOf('#') != 0; }
                        );
                    }
                });
                $(oSPAN).find("span." + previousPageButtonClass).click(function (event) {
                    if (mCurrentContent.page > 1) {
                        $.jreport.display(mCurrentContent.id, false, null, mCurrentContent.page - 1);
                    }
                });
                $(oSPAN).find("span." + nextPageButtonClass).click(function (event) {
                    if (mCurrentContent.page < oSPAN.pageCount) {
                        $.jreport.display(mCurrentContent.id, false, null, mCurrentContent.page + 1);
                    }
                });
                if (!mWidgets.StaticInit$PageBrowser) {
                    function enable(buttonClassName) {
                        $(oSPAN).find("span." + buttonClassName).removeClass(CSS$CLASS.disabled).addClass(CSS$CLASS.enabled);
                    }
                    function disable(buttonClassName) {
                        $(oSPAN).find("span." + buttonClassName).removeClass(CSS$CLASS.enabled).addClass(CSS$CLASS.disabled);
                    }
                    $(oDocument).bind(jreport$EVENT.contentChange, function (event) {
                        internal.forNode(mCurrentContent.id, { fnCallback: function (oNode) {
                            oSPAN.pageCount = (oNode && oNode.pagecount) || 1;
                            $("span.content-nav-bar").each(function (index, oSPAN) {
                                if (mCurrentContent.page == 1) {
                                    disable(previousPageButtonClass);
                                    internal.forNode(mCurrentContent.id).forPreviousWhere(
                                        /*fnCallback: */function (oPrevious) { if (oPrevious) { enable(previousNodeButtonClass); } else { disable(previousNodeButtonClass); } },
                                        /*fnPredicate:*/function (oPrevious) { return oPrevious.id.indexOf('#') != 0; }
                                    );
                                } else if (mCurrentContent.page > 1) {
                                    enable(previousPageButtonClass);
                                    enable(previousNodeButtonClass);
                                }
                                if (mCurrentContent.page == oSPAN.pageCount) {
                                    disable(nextPageButtonClass);
                                    internal.forNode(mCurrentContent.id).forNextWhere(
                                        /*fnCallback: */function (oNext) { if (!oNext) { disable(nextNodeButtonClass); } else { enable(nextNodeButtonClass); } },
                                        /*fnPredicate:*/function (oNext) { return oNext.id.indexOf('#') != 0; }
                                    );
                                } else if (mCurrentContent.page < oSPAN.pageCount) {
                                    enable(nextPageButtonClass);
                                    enable(nextNodeButtonClass);
                                }
                                $(oSPAN).find("span.content-nav-text").text(mCurrentContent.page + " / " + oSPAN.pageCount);
                            });
                        }
                        });
                    });
                    mWidgets.StaticInit$PageBrowser = true;
                }
                return oSPAN;
            },

            // PropertyGrid??
            PropertyGrid: function (owPropertyGrid) {
                var oTABLE = oDocument.createElement("table");
                var oTR, oTD;
                $.each(owPropertyGrid.children, function (i, oProperty) {
                    oTR = oDocument.createElement("tr");
                    oTD = oDocument.createElement("td");
                    oTD.innerHTML = oProperty[0] + ":";
                    oTD.className = CSS$CLASS.label;
                    oTR.appendChild(oTD);
                    oTD = oDocument.createElement("td");
                    oTD.innerHTML = oProperty[1];
                    oTD.className = CSS$CLASS.value;
                    oTR.appendChild(oTD);
                    oTABLE.appendChild(oTR);
                });
                return oTABLE;
            },

            // SplitPanel { panes : { minSize: int, content: Widget }[2],
            //              ratio? : 0...1 float,
            //              orientation? : { Horizontal, Vertical } }
            SplitPanel: function (owSplitPanel) {
                var panes = owSplitPanel.panes;
                var ratio = owSplitPanel.ratio || 0.5;
                var orientation = (owSplitPanel.orientation || "Horizontal") == "Horizontal" ? "Vertical" : "Horizontal";

                var oDIV = document.createElement("div");
                var doFlip = isRtl && orientation == "Vertical";
                if (doFlip) {
                    ratio = 1 - ratio;
                }
                $.each(doFlip ? panes.reverse() : panes, function (i, oPane) {
                    var oChildDIV = oDocument.createElement("div");
                    if (oPane.classes) {
                        addClasses(oChildDIV, oPane.classes);
                    }
                    internal.widget(oPane.content || {}, oChildDIV);
                    oDIV.appendChild(oChildDIV);
                });
                $(oDIV).splitterControl(orientation, ratio, panes);
                return oDIV;
            },

            // StackPanel { panes : Widget[],
            //              orientation? : { Vertical, Horizontal },
            //              alignment?
            //              itemSpacing? : int }
            StackPanel: function (owStackPanel) {
                // backwards compatibility
                var orientation = owStackPanel.orientation || "Vertical";
                var panes = owStackPanel.panes || /*deprecated*/owStackPanel.children;

                var oDIV = document.createElement("div");
                var doFlip = false;
                var cssFragment = null;
                if (orientation == "Horizontal") {
                    var alignment = owStackPanel.alignment || "left";
                    if (isRtl) {
                        var flipTable = { left: "right", right: "left" };
                        alignment = flipTable[alignment];
                    }
                    cssFragment = "float:" + alignment + ";";
                    if (owStackPanel.itemSpacing) {
                        cssFragment += "margin-" + alignment + ":" + owStackPanel.itemSpacing + "px;";
                    }
                } else {
                    cssFragment = "float:bottom;";
                    if (owStackPanel.itemSpacing) {
                        cssFragment += "margin-bottom:" + owStackPanel.itemSpacing + "px;";
                    }
                }
                $.each(doFlip ? panes.reverse() : panes, function (i, oChildWidget) {
                    var oChildDIV = oDocument.createElement("div");
                    if (cssFragment !== null) {
                        oChildDIV.style.cssText = cssFragment;
                    }
                    internal.widget(oChildWidget, oChildDIV);
                    oDIV.appendChild(oChildDIV);
                });
                return oDIV;
            },

            // TextPresenter { text,
            //                 background:htmlColor,
            //                 direction:{"left", "right"},
            //                 fontFamily,
            //                 fontSize:int,
            //                 fontStyle,
            //                 fontWeight,
            //                 foreground:htmlColor,
            //                 noWrap:boolean,
            //                 textDecoration }
            TextPresenter: function (owTextPresenter) {
                // backwards compatibility
                var fontFamily = owTextPresenter.fontFamily || /*deprecated*/owTextPresenter.fontfamily;
                var fontSize = owTextPresenter.fontSize || /*deprecated*/owTextPresenter.fontsize;
                var fontStyle = owTextPresenter.fontStyle || /*deprecated*/owTextPresenter.fontstyle;
                var fontWeight = owTextPresenter.fontWeight || /*deprecated*/owTextPresenter.fontweight;
                var textDecoration = owTextPresenter.textDecoration || /*deprecated*/owTextPresenter.textdecoration;

                var oDIV = isHtmlElement(owTextPresenter.htmlElement) ? owTextPresenter.htmlElement : document.createElement(owTextPresenter.htmlElement || "div");
                var oDIVStyle = oDIV.style;
                if (owTextPresenter.background) {
                    oDIVStyle.backgroundColor = owTextPresenter.background;
                }
                if (owTextPresenter.direction) {
                    oDIV.dir = owTextPresenter.direction;
                }
                if (fontFamily) {
                    oDIVStyle.fontFamily = fontFamily;
                }
                if (fontSize) {
                    oDIVStyle.fontSize = fontSize + "pt";
                }
                if (fontStyle) {
                    oDIVStyle.fontStyle = fontStyle;
                }
                if (fontWeight) {
                    oDIVStyle.fontWeight = fontWeight;
                }
                if (owTextPresenter.foreground) {
                    oDIVStyle.color = owTextPresenter.foreground;
                }
                if (owTextPresenter.noWrap) {
                    oDIVStyle.whiteSpace = "nowrap";
                    oDIVStyle.textOverflow = "ellipsis";
                    oDIVStyle.overflow = "hidden";
                }
                if (textDecoration) {
                    oDIVStyle.textDecoration = textDecoration;
                }
                if (owTextPresenter.text) {
                    var text2html = {
                        '&': '&amp;',
                        '<': '&lt;',
                        '>': '&gt;',
                        '"': '&quot;',
                        "'": '&#x27;',
                        '/': '&#x2F;',
                        '\n': '<br>',
                        '\t': '    '
                    };
                    $(oDIV).html(owTextPresenter.text.replace(/[&<>"'\/]|\n|\t/g, function (m) { return text2html[m]; }));
                }
                return oDIV;
            }

        };

        function getStarWeight(size) {
            return (typeof size == "string") && (size.length > 0) && (size.charAt(size.length - 1) == '*') ? (parseInt(size.substring(0, size.length - 1), 10) || 1) : 0;
        }

        function getPxSize(size) {
            return (typeof size == "string") && (size.length > 1) && (size.substring(size.length - 2) == "px") ? parseInt(size.substring(0, size.length - 2), 10) : size;
        }

        function getPxSizeString(size) {
            return size + (((typeof size != "string") || (size.length < 3) || (size.substring(size.length - 2) != "px")) ? "px" : "");
        }

        function isPercentageSize(size) {
            return (typeof size == "string") && (size.length > 1) && (size.charAt(size.length - 1) == '%');
        }

        function applyBorder(oStyle, mWidget) {
            if (mWidget.border) {
                oStyle.borderColor = mWidget.border;
                oStyle.borderStyle = mWidget.borderStyle || "solid";
            }
            else if (mWidget.borderStyle) {
                oStyle.borderStyle = mWidget.borderStyle;
            }
            if (mWidget.borderThickness) {
                if (mWidget.borderThickness instanceof Array) {
                    var thickness = $.map(mWidget.borderThickness, function (v) { return v || 0; });
                    oStyle.borderLeftWidth = thickness[0] > 0 ? getPxSizeString(thickness[0]) : 0;
                    oStyle.borderTopWidth = thickness[1] > 0 ? getPxSizeString(thickness[1]) : 0;
                    oStyle.borderRightWidth = thickness[2] > 0 ? getPxSizeString(thickness[2]) : 0;
                    oStyle.borderBottomWidth = thickness[3] > 0 ? getPxSizeString(thickness[3]) : 0;
                } else {
                    oStyle.borderWidth = getPxSizeString(mWidget.borderThickness);
                }
            }
        }

        function applyMargin(oStyle, mWidget) {
            if (mWidget.margin) {
                if (mWidget.margin instanceof Array) {
                    var margin = $.map(mWidget.margin, function (v) { return v || 0; });
                    if (margin[0] > 0) oStyle.marginLeft = getPxSizeString(margin[0]);
                    if (margin[1] > 0) oStyle.marginTop = getPxSizeString(margin[1]);
                    if (margin[2] > 0) oStyle.marginRight = getPxSizeString(margin[2]);
                    if (margin[3] > 0) oStyle.marginBottom = getPxSizeString(margin[3]);
                } else {
                    oStyle.margin = getPxSizeString(mWidget.margin);
                }
            }
        }

        function applyPadding(oStyle, mWidget) {
            if (mWidget.padding) {
                if (mWidget.padding instanceof Array) {
                    var padding = $.map(mWidget.padding, function (v) { return v || 0; });
                    if (padding[0] > 0) oStyle.paddingLeft = getPxSizeString(padding[0]);
                    if (padding[1] > 0) oStyle.paddingTop = getPxSizeString(padding[1]);
                    if (padding[2] > 0) oStyle.paddingRight = getPxSizeString(padding[2]);
                    if (padding[3] > 0) oStyle.paddingBottom = getPxSizeString(padding[3]);
                } else {
                    oStyle.padding = getPxSizeString(mWidget.padding);
                }
            }
        }

        // factory method { oWidget : Widget,
        //                  oParentElement, HTMLElement,
        //                  mAdditionalProps : { classes?, width?, height? } }
        return function (oWidget, oParentElement, mAdditionalProps) {
            if (oWidget) {
                mAdditionalProps = mAdditionalProps || {};
                for (var widgetType in oWidget) {
                    if (mWidgets[widgetType]) {
                        var mWidget = oWidget[widgetType];
                        if (mAdditionalProps.htmlElement) {
                            mWidget.htmlElement = mAdditionalProps.htmlElement;
                        }

                        var width = mWidget.width || mAdditionalProps.width, height = mWidget.height || mAdditionalProps.height;
                        var boxWidth = width && !isPercentageSize(width) ? getPxSizeString(width) : undefined;
                        var boxHeight = height && !isPercentageSize(height) ? getPxSizeString(height) : undefined;

                        // create widget box element to handle margins, paddings... properly on relative-sized elements (typically, width=100% elements)
                        var oWidgetBoxElement;
                        if ((mWidget.margin || mWidget.padding || mWidget.borderThickness || mWidget.boxed || boxWidth || boxHeight || mWidget.overflow)
                            && (!mWidget.htmlElement || mWidget.htmlElement != oParentElement)) {
                            oWidgetBoxElement = oDocument.createElement(mWidget.htmlElement || "div");
                            var oWidgetBoxStyle = oWidgetBoxElement.style;

                            addClasses(oWidgetBoxElement, mWidget.classes);
                            applyMargin(oWidgetBoxStyle, mWidget);
                            applyPadding(oWidgetBoxStyle, mWidget);
                            applyBorder(oWidgetBoxStyle, mWidget);

                            if (boxWidth) {
                                oWidgetBoxStyle.width = boxWidth;
                            }
                            if (boxHeight) {
                                oWidgetBoxStyle.height = boxHeight;
                            }
                            if (mWidget.overflow) {
                                oWidgetBoxStyle.overflow = mWidget.overflow;
                            }
                            if (mWidget.background) {
                                oWidgetBoxStyle.backgroundColor = mWidget.background;
                            }
                            oParentElement.appendChild(oWidgetBoxElement);
                            oParentElement = oWidgetBoxElement;
                        }

                        var widgetClasses = mWidget.classes;
                        mWidget.classes = (widgetClasses || []).concat(mAdditionalProps.classes || []);

                        var oWidgetElement = mWidgets[widgetType](mWidget);
                        if (oWidgetElement && oWidgetElement != oParentElement) {
                            var oWidgetElementStyle = oWidgetElement.style;
                            if (width) {
                                oWidgetElementStyle.width = isPercentageSize(width) ? width : getPxSizeString(width);
                            }
                            if (height) {
                                oWidgetElementStyle.height = isPercentageSize(height) ? height : getPxSizeString(height);
                            }
                            var textAlign = mWidget.textAlign || mWidget.textalign || mWidget.halign;
                            if ((mWidget.direction && mWidget.direction == "rtl") || isRtl) {
                                textAlign = (!textAlign || textAlign.toLowerCase() == "left") ? "right" : "left";
                            }
                            if (textAlign && textAlign.toLowerCase() != (isRtl ? "right" : "left")) {
                                oWidgetElementStyle.textAlign = textAlign;
                            }
                            if (mWidget.background) {
                                oWidgetElementStyle.backgroundColor = mWidget.background;
                            }
                            if (!oWidgetBoxElement) {
                                // apply classes on widget box if any otherwise on widget itself
                                addClasses(oWidgetElement, mWidget.classes);
                            }
                            oParentElement.appendChild(oWidgetElement);
                        }

                        mWidget.classes = widgetClasses;
                        return oWidgetElement;
                    }
                }
            }
        };
    })();

    /**
    * internal.forNode(sNodeId|oNode, mOptions : { bRefresh, fnCallback(oNode) })
    */
    internal.forNode = oDocument.jdata.forNode;

    /**
    * internal.fetch(sResource, fnCallback(json), bUseCache)
    */
    internal.fetch = oDocument.jdata.fetch;

    /**
    * internal.resolve(sContentFragment, fnCallback(sContentId, sAnchorId, page))
    */
    internal.resolve = oDocument.jdata.resolve;

    /**
    * Use to guarantee invocation order in asynchronous code.
    *
    * Sample use:
    * var callbackSequence = new internal.CallbackSequence();
    * ...
    * callbackSequence.invoke(4, function() {});
    * callbackSequence.invoke(1, function() {});
    * callbackSequence.invoke(3, function() {});
    * callbackSequence.invoke(2, function() {});
    *
    */
    internal.CallbackSequence = function () {
        var next = 0;
        var internalInvoke = function(sequence) {
            while (sequence[next]) {
                if (!sequence[next].timeout) {
                    // synchronous
                    sequence[next]();
                    delete sequence[next];
                    next++;
                }
                else {
                    // asynchronous
                    setTimeout(function() {
                        if (sequence[next]) {
                            sequence[next]();
                            delete sequence[next];
                            next++;
                            internalInvoke(sequence);
                        }
                    }, sequence[next].timeout)
                    break;
                }
            }
        }
        return {
            invoke: function (rank, fnCallback, /*optional*/nTimeout) {
                this[rank] = fnCallback;
                if (nTimeout) {
                    fnCallback.timeout = nTimeout;
                }
                if (rank == next) {
                    internalInvoke(this);
                }
            }
        };
    };

    /**
    * jreport() jQuery extension method
    */
    var jreport = function () {
        return this.each(function (index, oWidgetElement) {
            jreport.apply(oWidgetElement.id, oWidgetElement);
        });
    };

    /**
    * Loads the specified resource and renders its content inside the specified HTML element.
    *
    * @param sResource resource id
    * @param oWidgetElement target HTML element
    * @param optional callback invoked on success
    */
    jreport.apply = function (sResource, oWidgetElement, fnCallback) {
        internal.fetch(sResource, function (oWidget) {
            $(oWidgetElement).empty();
            if (oWidget !== null) {
                internal.widget(oWidget, oWidgetElement);
                if (fnCallback) {
                    fnCallback();
                }
            } else {
                // display error widget?
            }
        }, true);
    };

    /**
    * Displays the content with the specified id, optional anchor id and/or page number.
    *
    * @param sContentId
    * @param bReveal?
    * @param sAnchorId?
    * @param page?
    */
    jreport.display = function (sContentId, bReveal, sAnchorId, page) {
        sContentId = sContentId || sRootNodeId;
        oDocument.updateHash(internal.buildParameterString(sContentId, sAnchorId, page));
        page = page || 1;
        if (sContentId != mCurrentContent.id || page != mCurrentContent.page) {
            mCurrentContent.id = sContentId;
            mCurrentContent.page = page;
            $(oDocument).trigger(jreport$EVENT.contentChange);
        }
        mCurrentContent.anchor = sAnchorId;
        if (bReveal) {
            $(oDocument).trigger(jreport$EVENT.contentReveal);
        }
    };

    $.fn.jreport = jreport;

    $.jreport = jreport;

    // Common Helpers
    $.extend($.fn, {
        /**
        * Disables text selection on the elements in the jQuery wrapped set
        */
        disableSelection: function () {
            return this.bind("mousedown.ui-disableSelection selectstart.ui-disableSelection", function (e) { e.preventDefault(); });
        },

        /**
        * Adds the specified CSS class to the elements in the jQuery wrapped set on hover
        *
        * @param sClass CSS hover class name
        * @returns original jQuery wrapped set
        */
        hoverClass: function (sClass) {
            sClass = sClass || CSS$CLASS.hovered;
            return this.hover(function () {
                $(this).addClass(sClass);
            }, function () {
                $(this).removeClass(sClass);
            });
        },

        /**
        * Swaps the CSS classes of elements in the jQuery wrapped set.
        *
        * @param sClassA CSS class name
        * @param sClassB CSS class name
        * @returns original jQuery wrapped set
        */
        swapClass: function (sClassA, sClassB) {
            var aClassAElements = this.filter('.' + sClassA);
            this.filter('.' + sClassB).removeClass(sClassB).addClass(sClassA);
            aClassAElements.removeClass(sClassA).addClass(sClassB);
            return this;
        },

        /**
        * Toggles the visibility of elements in the jQuery wrapped set.
        *
        * @param fnCallback? : $[].function(bShow) Callback invoked for each element in the jQuery wrapped set
        * @returns original jQuery wrapped set
        */
        toggleVisibility: function (fnCallback) {
            return this.each(function () {
                var bShow = $(this).is(":hidden");
                $(this)[bShow ? "show" : "hide"]();
                if (fnCallback) {
                    fnCallback.call(this, bShow);
                }
            });
        }
    });

    // Controls
    $.extend($.fn, {

        /**
        * Creates a basic list control out of a UL element
        *
        * @param mListProvider : {
        *    getChildren : function(sItemId : string, yield_return : function({ id : string, label : string }))
        *    onClick? : function(sItemId : string)
        * }
        * Supplies logic for retrieving children and handling treeitem-related user events
        *
        * @returns original jQuery wrapped set
        */
        listControl: function (mListProvider) {

            var $_listControl = this;
            this.not("." + CSS$CLASS.listControl).addClass(CSS$CLASS.listControl);
            return this.treeControl(mListProvider);
        },

        /**
        * Creates/attaches a popup control to a target element
        *
        * @param sPopupId Popup element id. if an existing popup is found with this id, it will be reused, otherwise a new popup will get created
        * @param oTarget Target element this popup is being attached to.
        * @param fnGetAbsoluteTargetBounds : Return the absolute coordinates of a given target element
        * @param ptOffset optional parameter specifying the popup offset relative to the target
        * @param sPlacement? optional parameter specifying the popup placement relative to the target. Allowed values are "NW", "NE", "SW" and "SE".
        * @returns jQuery wrapped set wrapping the popup element
        */
        popupControl: function (sPopupId, oTarget, fnGetAbsoluteTargetBounds/*(oTarget)*/, ptOffset, sPlacement) {
            ptOffset = ptOffset || { x: 5, y: 0 };
            sPlacement = sPlacement || "NE";
            var $popup = $("#" + sPopupId);
            $.fn.popupControl.activePopupId = sPopupId;
            if ($popup.length == 0) {
                $popup = $('<div id="' + sPopupId + '" class="' + CSS$CLASS.popupControl + '"/>');
                $popup.insertAfter(this[0]);
                // hide popup on click or mouse move outside of (target + popup) bounding rectangle
                $("body").click(function () {
                    $popup.hide();
                });
                $("body").mousemove(function (e) {
                    if ($popup.is(":visible") && $popup[0].id == $.fn.popupControl.activePopupId) {
                        var position = $popup.position(), width = $popup.width(), height = $popup.height();
                        var rectTargetBounds = fnGetAbsoluteTargetBounds($popup[0].target);
                        if ((e.clientX < Math.min(rectTargetBounds.left, position.left))
                            || (e.clientX > Math.max(rectTargetBounds.right, position.left + width))
                            || (e.clientY < Math.min(rectTargetBounds.top, position.top))
                            || (e.clientY > Math.max(rectTargetBounds.bottom, position.top + height))) {
                            $popup.hide();
                            $target = $($popup[0].target);
                            if ($target.hasClass(CSS$CLASS.popupControl)) {
                                $target.hide();
                            }
                        }
                    }
                });
            }
            $popup[0].target = oTarget;
            var rectTargetBounds = fnGetAbsoluteTargetBounds($popup[0].target);
            $popup.css({ position: 'fixed', "z-index": 10 });
            switch (sPlacement) {
                case "NE":
                case "SE":
                    if (ptOffset.x >= 0) {
                        $popup.css({ left: (rectTargetBounds.right + ptOffset.x) + 'px' });
                    } else {
                        $popup.css({ right: (rectTargetBounds.right + ptOffset.x) + 'px' });
                    }
                    break;
                case "NW":
                case "SW":
                    if (ptOffset.x >= 0) {
                        $popup.css({ left: (rectTargetBounds.left + ptOffset.x) + 'px' });
                    } else {
                        $popup.css({ right: (rectTargetBounds.left + ptOffset.x) + 'px' });
                    }
                    break;
            }
            switch (sPlacement) {
                case "NE":
                case "NW":
                    if (ptOffset.y >= 0) {
                        $popup.css({ top: (rectTargetBounds.top + ptOffset.y) + 'px' });
                    } else {
                        $popup.css({ bottom: (rectTargetBounds.top + ptOffset.y) + 'px' });
                    }
                    break;
                case "SE":
                case "SW":
                    if (ptOffset.y >= 0) {
                        $popup.css({ top: (rectTargetBounds.bottom + ptOffset.y) + 'px' });
                    } else {
                        $popup.css({ bottom: (rectTargetBounds.bottom + ptOffset.y) + 'px' });
                    }
                    break;
            }
            return $popup;
        },

        /**
        * Creates a splitter control to allow for interactive resizing of the two children of a DIV element.
        *
        * @param orientation? : { Horizontal, Vertical}
        * @param ratio? : float 0...1
        * @param panes? : { minSize? : int, overflow? }[2]
        * @see based on code by Kristaps Kukurs
        * @returns original jQuery wrapped set
        */
        splitterControl: function (orientation, ratio, panes) {
            var inits = {
                orientation: orientation || "Vertical",
                ratio: ratio || 0.5,
                minPaneSize: panes ? $.map(panes, function (i, oPane) { return oPane.minSize || 0; }) : [0, 0]
            };
            inits.collapsablePane = inits.minPaneSize[0] == 0 ? 0 : (inits.minPaneSize[1] == 0 ? 1 : -1);
            if (inits.orientation == "Vertical") {
                inits.cursor = "e-resize";
                inits.splitSide = "left";
                inits.splitDimension = "width";
                inits.splitOrthogonalDimension = "height";
                inits.mouseEventProperty = "pageX";
                inits.splitterClass = CSS$CLASS.vSplitter;
                inits.splitterButtonClass = CSS$CLASS.vSplitterButton;
                inits.paneCss = [{ "position": "absolute", "height": "100%", "top": "0px" }, { "position": "absolute", "height": "100%", "top": "0px"}];
            } else {
                inits.cursor = "n-resize";
                inits.splitSide = "top";
                inits.splitDimension = "height";
                inits.splitOrthogonalDimension = "width";
                inits.mouseEventProperty = "pageY";
                inits.splitterClass = CSS$CLASS.hSplitter;
                inits.splitterButtonClass = CSS$CLASS.hSplitterButton;
                inits.paneCss = [{ "position": "absolute", "width": "100%" }, { "position": "absolute", "width": "100%"}];
            }

            this.each(function () {
                var $panel = $(this);
                $panel.children()
                    .each(function (i) { if (panes && panes[i]) { if (panes[i].overflow) { this.style.overflow = panes[i].overflow; } } })
                    .css({ "height": "100%", "width": "100%" })
                    .wrap("<div>");
                var $panes = $panel.children().css("overflow", "hidden");
                var $firstPane = $panes.eq(0);
                var $secondPane = $panes.eq(1);
                var $splitter, $virtualSplitter, $toggleButton;

                var toggleButtonOffset = 2;
                var fCurrentRatio = inits.ratio;

                var isCollapsed = function () {
                    return fCurrentRatio == inits.collapsablePane == 0 ? 0 : 1;
                };

                var splitTo = function (mParams/*{ratio, animate}*/) {
                    mParams.animate = mParams.animate || false;
                    fCurrentRatio = mParams.ratio;
                    var panelSize = $panel[inits.splitDimension]();
                    var splitPos = Math.max(0, (panelSize * fCurrentRatio) - ($splitter[inits.splitDimension]() + toggleButtonOffset));
                    if ($toggleButton) {
                        $toggleButton[$splitter[inits.splitOrthogonalDimension]() > 100 ? "show" : "hide"]();
                    }
                    if (mParams.animate) {
                        var animations = [{}, {}, {}];
                        animations[0][inits.splitSide] = splitPos + "px";
                        animations[1][inits.splitDimension] = splitPos + "px";
                        animations[2][inits.splitSide] = splitPos + $splitter[inits.splitDimension]() + toggleButtonOffset + "px";
                        animations[2][inits.splitDimension] = (panelSize - (splitPos + $splitter[inits.splitDimension]() + toggleButtonOffset)) + "px";
                        $splitter.show().animate(animations[0], 250);
                        $firstPane.show().animate(animations[1], 250);
                        $secondPane.show().animate(animations[2], 250);
                    } else {
                        $splitter.css(inits.splitSide, splitPos + "px");
                        $firstPane.css(inits.splitSide, "0px").css(inits.splitDimension, splitPos + "px");
                        $firstPane.css(inits.splitDimension, splitPos + "px");
                        $secondPane.css(inits.splitSide, splitPos + $splitter[inits.splitDimension]() + toggleButtonOffset + "px");
                        $secondPane.css(inits.splitDimension, (panelSize - (splitPos + $splitter[inits.splitDimension]() + toggleButtonOffset)) + "px");
                        $firstPane.add($secondPane).children().trigger("resize");
                    }
                };

                var beginDrag = function (e) {
                    if (e.target != this)
                        return;
                    $virtualSplitter = $virtualSplitter || $splitter.clone(/*copyHandlers: */false).insertAfter($firstPane);
                    if ($.browser.msie) {
                        // hide virtual splitter button in IE (to avoid displaying a clipped button!)
                        $virtualSplitter.find("." + inits.splitterButtonClass).hide();
                    }
                    if (isCollapsed()) {
                        $toggleButton.toggleClass(CSS$CLASS.flipped);
                    }
                    $splitter.initPos = $splitter.position()[inits.splitSide];
                    $virtualSplitter.addClass(CSS$CLASS.virtual)
                        .css(inits.splitSide, $splitter.initPos)
                        .css({ "position": "absolute", "z-index": "250", "-webkit-user-select": "none" })
                        .width($splitter.width())
                        .height($splitter.height());
                    // disable pane text selection (Safari)
                    $panes.css("-webkit-user-select", "none");
                    $firstPane.splitPos = e[inits.mouseEventProperty];
                    $(document).bind("mousemove", doDrag).bind("mouseup", endDrag);
                };

                var doDrag = function (e) {
                    var newPos = $splitter.initPos + e[inits.mouseEventProperty] - $firstPane.splitPos;
                    newPos = Math.max(newPos, inits.minPaneSize[0]);
                    newPos = Math.min(newPos, $panel[inits.splitDimension]() - inits.minPaneSize[1]);
                    $virtualSplitter.css(inits.splitSide, newPos);
                };

                var endDrag = function (e) {
                    var pos = $virtualSplitter.offset()[inits.splitSide];
                    $virtualSplitter.remove();
                    $virtualSplitter = null;
                    // re-enable pane text selection (Safari)
                    $panes.css("-webkit-user-select", "text");
                    $(document).unbind("mousemove", doDrag).unbind("mouseup", endDrag);
                    splitTo({ ratio: (pos - $panel.offset()[inits.splitSide] + ($splitter[inits.splitDimension]() + toggleButtonOffset)) / $panel[inits.splitDimension]() });
                };

                $firstPane.css(inits.paneCss[0]);
                $secondPane.css(inits.paneCss[1]);

                $splitter = $('<div><span></span></div>')
                    .attr({ "class": inits.splitterClass, unselectable: "on", dir: "ltr" })
                    .css({ cursor: inits.cursor, "user-select": "none", "-webkit-user-select": "none", "-khtml-user-select": "none", "-moz-user-select": "none", position: "absolute" })
                    .css((inits.orientation == "Vertical" ? "top" : "left"), "0px")
                    .css(inits.splitOrthogonalDimension, "100%")
                    .bind("mousedown", beginDrag);

                $firstPane.after($splitter);

                if (inits.collapsablePane != -1) {
                    var fOriginalRatio;
                    $toggleButton = $('<div></div>').css({ cursor: "pointer", position: "absolute", "z-index": 999 }).attr({ "class": inits.splitterButtonClass, unselectable: "on" });
                    if (inits.collapsablePane == 1) {
                        $toggleButton.addClass(CSS$CLASS.flipped);
                    }
                    $toggleButton.hoverClass(CSS$CLASS.virtual);
                    $toggleButton.bind("mousedown", function () {
                        $toggleButton.toggleClass(CSS$CLASS.flipped);
                        var fCollapsedRatio = inits.collapsablePane == 0 ? 0 : 1;
                        var isCollapsed = fCurrentRatio == fCollapsedRatio;
                        if (!isCollapsed) {
                            fOriginalRatio = fCurrentRatio;
                        }
                        splitTo({ ratio: isCollapsed ? fOriginalRatio : fCollapsedRatio, animate: true });
                    });
                    $splitter.append($toggleButton);
                    $toggleButton.hide();
                }

                $panel.bind("resize", function (e) { if (e.target == this) { splitTo({ ratio: fCurrentRatio }); } e.stopPropagation(); });
                $(window).bind("resize", function (e) { splitTo({ ratio: fCurrentRatio }); e.stopPropagation(); });
                setTimeout(function () { $(window).trigger("resize"); }, 0);
            });
            return this;
        },

        /**
        * Creates a basic tree control out of a UL element
        *
        * @param mTreeProvider : {
        *    getChildren : function(sItemId : string, yield_return : function({ id : string, label : string, hasChildren : boolean }))
        *    onClick? : function(sItemId : string)
        *    isRtl? : boolean
        * }
        * Supplies logic for retrieving children and handling treeitem-related user events
        *
        * @returns original jQuery wrapped set
        */
        treeControl: function (mTreeProvider) {

            var $_treeControl = this;

            // process UL wrapped set
            this.not("." + CSS$CLASS.treeControl).addClass(CSS$CLASS.treeControl).each(function () {

                // fnCreateItem(this : parentUL)
                var createItem = function (mItem/*{ id : string, label : string, hasChildren : boolean, category : boolean }*/) {
                    // create HTML structure
                    var oLI = ($("<li>").attr("id", mItem.id || "").html("<span class=\"" + CSS$CLASS.hitArea + "\"/><span class=\"" + CSS$CLASS.label + (mItem.category ? (" " + CSS$CLASS.category) : "") + "\">" + mItem.label + "</span>"))[0];
                    if (mItem.hasChildren) {
                        $("<ul>").appendTo(oLI).treeControl(mTreeProvider);
                    }
                    // update CSS style & plug event handlers
                    var $LI = $(oLI);

                    // collapsed on creation
                    $LI.find("ul").hide();

                    // disable text selection & add highlight on hover
                    $LI.find(">span").hoverClass();

                    // hasChildren => expandable
                    $LI.filter(":has(>ul:hidden)").addClass(CSS$CLASS.expandable).find("." + CSS$CLASS.hitArea).addClass(CSS$CLASS.expandableHitArea);

                    // attach click event on hit area
                    var toggleLI = function (fnCallback) {
                        $LI
                            .find(">." + CSS$CLASS.hitArea)
                            .swapClass(CSS$CLASS.collapsableHitArea, CSS$CLASS.expandableHitArea)
                            .end()
                            .swapClass(CSS$CLASS.collapsable, CSS$CLASS.expandable)
                            .find(">ul")
                            .toggleVisibility(function (bShow) {
                                if (bShow) {
                                    // loading... animation???
                                    var _this = this;
                                    $(this).empty();
                                    mTreeProvider.getChildren(oLI.id, function (mItem) {
                                        createItem.call(_this, mItem);
                                        if (fnCallback) {
                                            fnCallback.call(_this, oLI.id);
                                        }
                                    });
                                }
                            });
                    };
                    $LI.find("." + CSS$CLASS.hitArea).click(function (event, fnOptionalCallback) {
                        toggleLI(fnOptionalCallback);
                    });

                    // attach click event on label area
                    $LI.find("." + CSS$CLASS.label).click(function (event) {
                        if (mTreeProvider.onClick) {
                            mTreeProvider.onClick(oLI.id);
                        }
                        $_treeControl.select(oLI.id);
                    });

                    $LI.find("." + CSS$CLASS.label).dblclick(function (event, fnOptionalCallback) {
                        toggleLI(fnOptionalCallback);
                    });

                    // append created LI to UL
                    this.appendChild(oLI);
                };

                // top-level UL, get root content
                if (this.parentNode === null || this.parentNode.nodeName.toLowerCase() !== "li") {
                    var _this = this;
                    mTreeProvider.getChildren(null, function (mItem) {
                        createItem.call(_this, mItem);
                        // select and expand root node
                        $LI = $_treeControl.find("li[id=\'" + mItem.id + "\']");
                        $LI.find("." + CSS$CLASS.expandableHitArea).triggerHandler("click");

                        //$LI.find("." + CSS$CLASS.label).triggerHandler("click");
                    });
                }
            })
            // disable text selection on parent
            .parent().disableSelection();

            // right-to-left language support
            if (mTreeProvider && mTreeProvider.isRtl) {
                this.find("." + CSS$CLASS.treeControl).andSelf().addClass(CSS$CLASS.flipped);
            }

            return $.extend(this, {
                /**
                * Returns the root treeControl
                */
                root: function () {
                    return this.parents("ul").andSelf().not(function () {
                        return this.parentNode.nodeName.toLowerCase() === "li";
                    }).treeControl();
                },
                /**
                * Selects the tree item with the specified id and unselects any previously selected item
                * NOTE: assumes the item exists already!
                */
                select: function (sItemId) {
                    this.root().find("li." + CSS$CLASS.selected).removeClass(CSS$CLASS.selected);
                    this.find("li[id=\'" + sItemId + "\']").addClass(CSS$CLASS.selected);
                    return this;
                },
                /**
                * Selects and reveals the item identified by the given item id path
                * @param aItemIdPath array of item ids
                * @param bReveal true if item should be scrolled into view, false otherwise
                * @param i (internal use only) current index in aItemIdPath array
                */
                selectAndReveal: function (aItemIdPath, bReveal, i/* = 0*/) {
                    if (aItemIdPath) {
                        if (!i) i = 0;
                        while (i < aItemIdPath.length) {
                            var sItemId = aItemIdPath[i];
                            $LI = this.find("li[id=\'" + sItemId + "\']");
                            if ($LI.length > 0) {
                                if (i === (aItemIdPath.length - 1)) {
                                    // found item: select+reveal and return
                                    this.select(sItemId);
                                    if (bReveal) {
                                        var $oScrollPresenter = $LI.parents().filter(function() { return $(this)[0].style.overflow == "auto"; }).first();
                                        var $label = $LI.find("." + CSS$CLASS.label).first();
                                        var labelTop = $label.position().top;
                                        if (labelTop < 0 || (labelTop + $label.height()) > $oScrollPresenter.height()) {
                                            $oScrollPresenter.scrollTop(labelTop + $oScrollPresenter.scrollTop());
                                        }
                                    }
                                } else if ($LI.find("ul").length > 0) {
                                    // node item
                                    if ($LI.hasClass(CSS$CLASS.expandable)) {
                                        // collapsed: expand (by triggering click event) and recurse (by specifying optional callback, see click handler on hitAreas)
                                        $LI.find("." + CSS$CLASS.expandableHitArea).triggerHandler("click", function (sExpandedItemId) {
                                            if (sItemId === sExpandedItemId) {
                                                $(this).treeControl().selectAndReveal(aItemIdPath, bReveal, i + 1);
                                            }
                                        });
                                    } else {
                                        // expanded: move to next item in the branch
                                        i++;
                                        continue;
                                    }
                                }
                            }
                            break;
                        }
                    }
                    return this;
                }
            });
        }
    });

})(jQuery);
