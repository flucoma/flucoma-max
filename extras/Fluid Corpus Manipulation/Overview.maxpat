{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 8,
			"minor" : 1,
			"revision" : 3,
			"architecture" : "x64",
			"modernui" : 1
		}
,
		"classnamespace" : "box",
		"rect" : [ 116.0, 45.0, 1003.0, 780.0 ],
		"bglocked" : 0,
		"openinpresentation" : 1,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 1,
		"gridsize" : [ 25.0, 10.0 ],
		"gridsnaponopen" : 1,
		"objectsnaponopen" : 1,
		"statusbarvisible" : 2,
		"toolbarvisible" : 0,
		"lefttoolbarpinned" : 0,
		"toptoolbarpinned" : 0,
		"righttoolbarpinned" : 0,
		"bottomtoolbarpinned" : 0,
		"toolbars_unpinned_last_save" : 0,
		"tallnewobj" : 0,
		"boxanimatetime" : 200,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"description" : "",
		"digest" : "",
		"tags" : "",
		"style" : "",
		"subpatcher_template" : "",
		"showontab" : 0,
		"boxes" : [ 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-1",
					"maxclass" : "tab",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 335.75, 125.0, 137.0, 54.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 353.25, 204.0, 137.0, 54.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.ampgate~", "fluid.bufampgate~" ]
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-15",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 436.0, 213.5, 161.0, 47.0 ],
					"presentation" : 1,
					"presentation_linecount" : 4,
					"presentation_rect" : [ 505.0, 204.0, 113.0, 60.0 ],
					"text" : "Slice by amplitude envelope threshold with lookahead / lookback",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Lato Regular",
					"fontsize" : 14.0,
					"id" : "obj-13",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 707.0, 117.0, 156.0, 40.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 669.0, 55.0, 287.0, 23.0 ],
					"text" : "click on an object name to open its help file",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-86",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 411.0, 712.666625999999951, 50.0, 22.0 ],
					"text" : "help $1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-84",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 411.0, 739.666625999999951, 53.0, 22.0 ],
					"text" : "pcontrol"
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-83",
					"maxclass" : "tab",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 501.000030999999979, 383.0, 137.0, 54.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 707.0, 590.0, 137.0, 54.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.spectralshape~", "fluid.bufspectralshape~" ]
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-82",
					"maxclass" : "tab",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 501.000030999999979, 445.0, 137.0, 54.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 707.0, 658.0, 137.0, 54.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.bufstats~" ]
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-80",
					"maxclass" : "tab",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 501.000030999999979, 198.000014999999991, 137.0, 54.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 359.0, 658.0, 137.0, 54.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.mfcc~", "fluid.bufmfcc~" ]
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-79",
					"maxclass" : "tab",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 501.000030999999979, 132.0, 137.0, 54.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 359.0, 590.0, 137.0, 54.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.melbands~", "fluid.bufmelbands~" ]
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-78",
					"maxclass" : "tab",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 501.000030999999979, 319.0, 137.0, 54.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 22.75, 658.0, 137.0, 54.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.pitch~", "fluid.bufpitch~" ]
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-77",
					"maxclass" : "tab",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 501.000030999999979, 259.0, 137.0, 54.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 22.75, 590.0, 137.0, 54.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.loudness~", "fluid.bufloudness~" ]
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-76",
					"maxclass" : "tab",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 180.083344000000011, 566.5, 137.0, 54.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 22.75, 457.0, 137.0, 54.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.transients~", "fluid.buftransients~" ]
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-75",
					"maxclass" : "tab",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 180.083344000000011, 504.5, 137.0, 54.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 22.75, 392.5, 137.0, 54.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.sines~", "fluid.bufsines~" ]
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-74",
					"maxclass" : "tab",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 180.083344000000011, 631.0, 137.0, 54.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 359.0, 419.5, 137.0, 54.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.hpss~", "fluid.bufhpss~" ]
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-73",
					"maxclass" : "tab",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 180.083344000000011, 402.0, 137.0, 71.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 707.0, 418.5, 137.0, 71.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.bufnmf~", "fluid.nmfmatch~", "fluid.nmffilter~" ]
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-72",
					"maxclass" : "tab",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 180.083344000000011, 318.0, 137.0, 54.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 355.0, 270.0, 137.0, 54.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.transientslice~", "fluid.buftransientslice~" ]
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-71",
					"maxclass" : "tab",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 180.083344000000011, 256.0, 137.0, 54.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 707.0, 270.0, 137.0, 54.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.noveltyslice~", "fluid.bufnoveltyslice~" ]
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-70",
					"maxclass" : "tab",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 180.083344000000011, 192.0, 137.0, 54.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 22.75, 270.0, 137.0, 54.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.onsetslice~", "fluid.bufonsetslice~" ]
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-69",
					"maxclass" : "tab",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 180.083344000000011, 132.0, 137.0, 54.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 22.75, 204.0, 137.0, 54.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.ampslice~", "fluid.bufampslice~" ]
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-68",
					"maxclass" : "tab",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 501.000030999999979, 533.333374000000049, 137.0, 54.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 707.0, 214.5, 137.0, 31.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.bufcompose~" ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-10",
					"linecount" : 5,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 524.666687000000024, 675.0, 330.0, 74.0 ],
					"presentation" : 1,
					"presentation_linecount" : 2,
					"presentation_rect" : [ 10.0, 735.0, 961.0, 33.0 ],
					"style" : "helpfile_label",
					"text" : "This toolbox was made possible thanks to the FluCoMa project ( http://www.flucoma.org/ ) funded by the European Research Council ( https://erc.europa.eu/ ) under the European Union’s Horizon 2020 research and innovation programme (grant agreement No 725899)."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-58",
					"linecount" : 5,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 634.5, 39.0, 436.0, 74.0 ],
					"presentation" : 1,
					"presentation_linecount" : 4,
					"presentation_rect" : [ 9.0, 100.0, 591.0, 60.0 ],
					"style" : "helpfile_label",
					"text" : "The Fluid Decomposition toolbox provides an open-ended, loosely coupled set of objects to break up and analyse sound in terms of slices (segments in time), layers (superositions in time and frequency) and objects (configurable or discoverable patterns in sound). Almost all objects have audio-rate and buffer-based versions."
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Lato Light",
					"fontsize" : 20.0,
					"id" : "obj-59",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 634.5, 0.0, 365.0, 30.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 631.0, 23.0, 363.0, 30.0 ],
					"text" : "play with sonic slices, layers and objects",
					"textcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"textjustification" : 1
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-56",
					"linecount" : 4,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 664.666625999999951, 552.666625999999951, 215.0, 60.0 ],
					"presentation" : 1,
					"presentation_linecount" : 6,
					"presentation_rect" : [ 850.0, 171.0, 131.0, 87.0 ],
					"text" : "Copy, slice, stack, mix concatenate. \n\nAll the things you've wanted to do with buffers...",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-54",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 664.666625999999951, 456.333252000000016, 125.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 850.0, 673.0, 125.0, 20.0 ],
					"text" : "Statistics of buffers",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-55",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 670.333312999999976, 393.5, 125.0, 33.0 ],
					"presentation" : 1,
					"presentation_linecount" : 2,
					"presentation_rect" : [ 850.0, 600.5, 125.0, 33.0 ],
					"text" : "Summary measures of spectral shape",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-42",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 670.333312999999976, 198.000014999999991, 98.0, 47.0 ],
					"presentation" : 1,
					"presentation_linecount" : 3,
					"presentation_rect" : [ 501.0, 661.5, 98.0, 47.0 ],
					"text" : "Mel Frequency Ceptstral Coefficients",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-45",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 670.333312999999976, 156.0, 124.0, 33.0 ],
					"presentation" : 1,
					"presentation_linecount" : 2,
					"presentation_rect" : [ 501.0, 600.5, 124.0, 33.0 ],
					"text" : "Energy across Mel bands ",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-12",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 670.333312999999976, 340.0, 100.0, 33.0 ],
					"presentation" : 1,
					"presentation_linecount" : 2,
					"presentation_rect" : [ 170.0, 668.5, 100.0, 33.0 ],
					"text" : "A suite of pitch estimators",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-14",
					"linecount" : 4,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 670.333312999999976, 262.5, 108.0, 60.0 ],
					"presentation" : 1,
					"presentation_linecount" : 4,
					"presentation_rect" : [ 170.0, 590.0, 108.0, 60.0 ],
					"text" : "Report amplitude and peak, or r128 loudness and true peak",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Lato Light",
					"fontsize" : 72.0,
					"id" : "obj-11",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 10.0, 0.0, 621.0, 93.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 9.0, 5.0, 621.0, 93.0 ],
					"text" : "fluid decomposition"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"fontname" : "Lato Light",
					"fontsize" : 24.0,
					"id" : "obj-8",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 670.333312999999976, 124.0, 130.0, 35.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 17.0, 543.0, 130.0, 35.0 ],
					"text" : "Descriptors"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"fontname" : "Lato Light",
					"fontsize" : 24.0,
					"id" : "obj-6",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 670.333312999999976, 518.166625999999951, 76.0, 35.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 707.0, 168.0, 76.0, 35.0 ],
					"text" : "Utility"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-5",
					"linecount" : 4,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 37.500008000000001, 407.0, 125.0, 60.0 ],
					"presentation" : 1,
					"presentation_linecount" : 4,
					"presentation_rect" : [ 850.0, 424.0, 125.0, 60.0 ],
					"text" : "Use Nonnegative Matrix Factorisation to explore and decompose sounds ",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-2",
					"linecount" : 4,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 61.500008000000001, 628.0, 101.0, 60.0 ],
					"presentation" : 1,
					"presentation_linecount" : 3,
					"presentation_rect" : [ 501.0, 423.0, 144.0, 47.0 ],
					"text" : "Decompose into 'harmonic' and 'percussive' layers",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-3",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 61.500008000000001, 565.166625999999951, 108.0, 47.0 ],
					"presentation" : 1,
					"presentation_linecount" : 3,
					"presentation_rect" : [ 170.0, 460.5, 108.0, 47.0 ],
					"text" : "Decompose into transients  + residual ",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-4",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 61.500008000000001, 514.166625999999951, 108.0, 33.0 ],
					"presentation" : 1,
					"presentation_linecount" : 2,
					"presentation_rect" : [ 170.0, 403.0, 108.0, 33.0 ],
					"text" : "Decompose into sines + residual",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"fontname" : "Lato Light",
					"fontsize" : 24.0,
					"id" : "obj-53",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 64.000007999999994, 373.0, 90.0, 35.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 707.0, 355.0, 160.0, 35.0 ],
					"text" : "Objects"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-48",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 36.000008000000001, 322.666655999999989, 125.0, 33.0 ],
					"presentation" : 1,
					"presentation_linecount" : 2,
					"presentation_rect" : [ 505.0, 280.5, 125.0, 33.0 ],
					"text" : "Slice by transient modelling",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-49",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 36.000008000000001, 262.5, 128.0, 47.0 ],
					"presentation" : 1,
					"presentation_linecount" : 3,
					"presentation_rect" : [ 857.0, 273.5, 128.0, 47.0 ],
					"text" : "Slice by estimated novelty on a choice of features",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-47",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 55.000008000000001, 192.0, 108.0, 47.0 ],
					"presentation" : 1,
					"presentation_linecount" : 3,
					"presentation_rect" : [ 170.0, 273.5, 108.0, 47.0 ],
					"text" : "Slice by onsets in the spectral domain",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-46",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 6.083344, 156.0, 161.0, 33.0 ],
					"presentation" : 1,
					"presentation_linecount" : 3,
					"presentation_rect" : [ 172.0, 210.5, 112.0, 47.0 ],
					"text" : "Slice by amplitude envelope onsets with detrending",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"fontname" : "Lato Light",
					"fontsize" : 24.0,
					"id" : "obj-44",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 61.500008000000001, 481.666687000000024, 77.0, 35.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 17.0, 355.0, 82.0, 35.0 ],
					"text" : "Layers"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"fontname" : "Lato Light",
					"fontsize" : 24.0,
					"id" : "obj-43",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 64.000007999999994, 114.333336000000003, 72.0, 35.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 17.0, 168.0, 72.0, 35.0 ],
					"text" : "Slices"
				}

			}
, 			{
				"box" : 				{
					"angle" : 270.0,
					"background" : 1,
					"border" : 2,
					"bordercolor" : [ 0.5, 0.5, 0.5, 1.0 ],
					"grad1" : [ 0.376471, 0.384314, 0.4, 0.0 ],
					"grad2" : [ 0.290196, 0.309804, 0.301961, 0.0 ],
					"id" : "obj-9",
					"maxclass" : "panel",
					"mode" : 1,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 493.0, 124.0, 160.333327999999995, 385.666655999999989 ],
					"presentation" : 1,
					"presentation_rect" : [ 9.0, 541.0, 985.0, 189.0 ],
					"proportion" : 0.39
				}

			}
, 			{
				"box" : 				{
					"angle" : 270.0,
					"background" : 1,
					"border" : 2,
					"bordercolor" : [ 0.5, 0.5, 0.5, 1.0 ],
					"grad1" : [ 0.376471, 0.384314, 0.4, 0.0 ],
					"grad2" : [ 0.290196, 0.309804, 0.301961, 0.0 ],
					"id" : "obj-52",
					"maxclass" : "panel",
					"mode" : 1,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 168.083344000000011, 385.0, 159.999985000000009, 103.666656000000003 ],
					"presentation" : 1,
					"presentation_rect" : [ 699.0, 355.0, 295.0, 174.0 ],
					"proportion" : 0.39
				}

			}
, 			{
				"box" : 				{
					"angle" : 270.0,
					"background" : 1,
					"border" : 2,
					"bordercolor" : [ 0.5, 0.5, 0.5, 1.0 ],
					"grad1" : [ 0.376471, 0.384314, 0.4, 0.0 ],
					"grad2" : [ 0.290196, 0.309804, 0.301961, 0.0 ],
					"id" : "obj-7",
					"maxclass" : "panel",
					"mode" : 1,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 493.0, 518.166625999999951, 160.333327999999995, 94.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 699.0, 168.0, 295.0, 94.0 ],
					"proportion" : 0.39
				}

			}
, 			{
				"box" : 				{
					"angle" : 270.0,
					"background" : 1,
					"border" : 2,
					"bordercolor" : [ 0.5, 0.5, 0.5, 1.0 ],
					"grad1" : [ 0.376471, 0.384314, 0.4, 0.0 ],
					"grad2" : [ 0.290196, 0.309804, 0.301961, 0.0 ],
					"id" : "obj-51",
					"maxclass" : "panel",
					"mode" : 1,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 168.083344000000011, 499.833312999999976, 159.999985000000009, 192.666672000000005 ],
					"presentation" : 1,
					"presentation_rect" : [ 9.0, 355.0, 676.0, 174.0 ],
					"proportion" : 0.39
				}

			}
, 			{
				"box" : 				{
					"angle" : 270.0,
					"background" : 1,
					"border" : 2,
					"bordercolor" : [ 0.5, 0.5, 0.5, 1.0 ],
					"grad1" : [ 0.376471, 0.384314, 0.4, 0.0 ],
					"grad2" : [ 0.290196, 0.309804, 0.301961, 0.0 ],
					"id" : "obj-50",
					"maxclass" : "panel",
					"mode" : 1,
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 168.083344000000011, 124.999992000000006, 159.999985000000009, 255.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 9.0, 168.0, 985.0, 174.0 ],
					"proportion" : 0.39
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"source" : [ "obj-1", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"midpoints" : [ 569.500031000000035, 596.166687000000024, 420.5, 596.166687000000024 ],
					"source" : [ "obj-68", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"midpoints" : [ 248.583344000000011, 190.166640999999998, 420.5, 190.166640999999998 ],
					"source" : [ "obj-69", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"midpoints" : [ 248.583344000000011, 253.499968999999993, 420.5, 253.499968999999993 ],
					"source" : [ "obj-70", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"midpoints" : [ 248.583344000000011, 312.166626000000008, 420.5, 312.166626000000008 ],
					"source" : [ "obj-71", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"midpoints" : [ 248.583344000000011, 375.166655999999989, 420.5, 375.166655999999989 ],
					"source" : [ "obj-72", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"midpoints" : [ 248.583344000000011, 482.999969000000021, 420.5, 482.999969000000021 ],
					"source" : [ "obj-73", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"midpoints" : [ 248.583344000000011, 687.666625999999951, 420.5, 687.666625999999951 ],
					"source" : [ "obj-74", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"midpoints" : [ 248.583344000000011, 561.75, 420.5, 561.75 ],
					"source" : [ "obj-75", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"midpoints" : [ 248.583344000000011, 627.416625999999951, 420.5, 627.416625999999951 ],
					"source" : [ "obj-76", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"midpoints" : [ 569.500031000000035, 313.666626000000008, 420.5, 313.666626000000008 ],
					"source" : [ "obj-77", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"midpoints" : [ 569.500031000000035, 375.666626000000008, 420.5, 375.666626000000008 ],
					"source" : [ "obj-78", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"midpoints" : [ 569.500031000000035, 192.833313000000004, 420.5, 192.833313000000004 ],
					"source" : [ "obj-79", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"midpoints" : [ 569.500031000000035, 253.833298000000013, 420.5, 253.833298000000013 ],
					"source" : [ "obj-80", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"midpoints" : [ 569.500031000000035, 503.999969000000021, 420.5, 503.999969000000021 ],
					"source" : [ "obj-82", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"midpoints" : [ 569.500031000000035, 440.999969000000021, 420.5, 440.999969000000021 ],
					"source" : [ "obj-83", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-84", 0 ],
					"source" : [ "obj-86", 0 ]
				}

			}
 ],
		"dependency_cache" : [  ],
		"autosave" : 0
	}

}
