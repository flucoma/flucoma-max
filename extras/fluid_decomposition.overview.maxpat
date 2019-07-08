{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 7,
			"minor" : 3,
			"revision" : 5,
			"architecture" : "x64",
			"modernui" : 1
		}
,
		"rect" : [ 62.0, 88.0, 1005.0, 815.0 ],
		"bglocked" : 1,
		"openinpresentation" : 0,
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
					"id" : "obj-10",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 22.75, 777.0, 961.0, 33.0 ],
					"style" : "helpfile_label",
					"text" : "This toolbox was made possible thanks to the FluCoMa project ( http://www.flucoma.org/ ) funded by the European Research Council ( https://erc.europa.eu/ ) under the European Union’s Horizon 2020 research and innovation programme (grant agreement No 725899)."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-58",
					"linecount" : 4,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 10.0, 90.0, 588.0, 60.0 ],
					"style" : "helpfile_label",
					"text" : "The Fluid Decomposition toolbox provides an open-ended, loosely coupled set of objects to break up and analyse sound in terms of slices (segments in time), layers (superositions in time and frequency) and objects (configurable or discoverable patterns in sound). Almost all objects have audio-rate and buffer-based versions."
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Lato Light",
					"fontsize" : 24.0,
					"id" : "obj-59",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 690.5, 14.5, 234.0, 64.0 ],
					"style" : "",
					"text" : "play with sonic slices, layers and objects"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-56",
					"linecount" : 6,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 859.0, 433.0, 131.0, 87.0 ],
					"style" : "",
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
					"patching_rect" : [ 859.0, 702.0, 125.0, 20.0 ],
					"style" : "",
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
					"patching_rect" : [ 859.0, 631.0, 125.0, 33.0 ],
					"style" : "",
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
					"patching_rect" : [ 534.0, 702.0, 98.0, 47.0 ],
					"style" : "",
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
					"patching_rect" : [ 534.0, 624.0, 124.0, 33.0 ],
					"style" : "",
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
					"patching_rect" : [ 159.0, 710.0, 100.0, 33.0 ],
					"style" : "",
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
					"patching_rect" : [ 159.0, 624.0, 108.0, 60.0 ],
					"style" : "",
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
					"style" : "",
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
					"patching_rect" : [ 17.0, 580.0, 130.0, 35.0 ],
					"style" : "",
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
					"patching_rect" : [ 707.0, 392.0, 76.0, 35.0 ],
					"style" : "",
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
					"patching_rect" : [ 859.0, 274.0, 125.0, 60.0 ],
					"style" : "",
					"text" : "Use Nonnegative Matrix Factorisation to explore and decompose sounds ",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-2",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 509.0, 457.0, 144.0, 47.0 ],
					"style" : "",
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
					"patching_rect" : [ 159.0, 503.0, 108.0, 47.0 ],
					"style" : "",
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
					"patching_rect" : [ 159.0, 440.0, 108.0, 33.0 ],
					"style" : "",
					"text" : "Decompose into sines + residual",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-1",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "" ],
					"patching_rect" : [ 359.0, 244.0, 105.0, 22.0 ],
					"style" : "",
					"text" : "fluid.noveltyslice~"
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
					"patching_rect" : [ 707.0, 205.0, 160.0, 35.0 ],
					"style" : "",
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
					"patching_rect" : [ 509.0, 314.0, 125.0, 33.0 ],
					"style" : "",
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
					"patching_rect" : [ 509.0, 244.0, 128.0, 47.0 ],
					"style" : "",
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
					"patching_rect" : [ 159.0, 314.0, 108.0, 47.0 ],
					"style" : "",
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
					"patching_rect" : [ 159.0, 254.0, 112.0, 33.0 ],
					"style" : "",
					"text" : "Slice by amplitude envelope",
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
					"patching_rect" : [ 17.0, 392.0, 82.0, 35.0 ],
					"style" : "",
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
					"patching_rect" : [ 17.0, 205.0, 72.0, 35.0 ],
					"style" : "",
					"text" : "Slices"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-41",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "" ],
					"patching_rect" : [ 359.0, 314.0, 113.0, 22.0 ],
					"style" : "",
					"text" : "fluid.transientslice~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-40",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "signal", "signal", "" ],
					"patching_rect" : [ 34.0, 503.0, 95.0, 22.0 ],
					"style" : "",
					"text" : "fluid.transients~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-39",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "list", "" ],
					"patching_rect" : [ 724.0, 620.0, 118.0, 22.0 ],
					"style" : "",
					"text" : "fluid.spectralshape~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-38",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "signal", "signal", "" ],
					"patching_rect" : [ 34.0, 433.0, 71.0, 22.0 ],
					"style" : "",
					"text" : "fluid.sines~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-37",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "list", "" ],
					"patching_rect" : [ 34.0, 702.0, 68.0, 22.0 ],
					"style" : "",
					"text" : "fluid.pitch~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-36",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "" ],
					"patching_rect" : [ 34.0, 314.0, 96.0, 22.0 ],
					"style" : "",
					"text" : "fluid.onsetslice~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-35",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "list", "" ],
					"patching_rect" : [ 724.0, 294.0, 96.0, 22.0 ],
					"style" : "",
					"text" : "fluid.nmfmatch~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-34",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "signal", "signal", "" ],
					"patching_rect" : [ 724.0, 324.0, 95.0, 22.0 ],
					"style" : "",
					"text" : "fluid.nmffilter~ 2"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-33",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "list", "" ],
					"patching_rect" : [ 409.0, 704.0, 68.0, 22.0 ],
					"style" : "",
					"text" : "fluid.mfcc~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-32",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "list", "" ],
					"patching_rect" : [ 409.0, 624.0, 95.0, 22.0 ],
					"style" : "",
					"text" : "fluid.melbands~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-31",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "list", "" ],
					"patching_rect" : [ 34.0, 624.0, 91.0, 22.0 ],
					"style" : "",
					"text" : "fluid.loudness~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-30",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 4,
					"outlettype" : [ "signal", "signal", "signal", "" ],
					"patching_rect" : [ 359.0, 457.0, 68.0, 22.0 ],
					"style" : "",
					"text" : "fluid.hpss~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"color" : [ 0.589653, 0.589635, 0.589645, 1.0 ],
					"id" : "obj-29",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 359.0, 344.0, 130.0, 22.0 ],
					"style" : "",
					"text" : "fluid.buftransientslice~",
					"textcolor" : [ 0.862745, 0.870588, 0.878431, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-28",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 34.0, 533.0, 112.0, 22.0 ],
					"style" : "",
					"text" : "fluid.buftransients~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-27",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 724.0, 702.0, 85.0, 22.0 ],
					"style" : "",
					"text" : "fluid.bufstats~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-26",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 724.0, 650.0, 134.0, 22.0 ],
					"style" : "",
					"text" : "fluid.bufspectralshape~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-25",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 34.0, 463.0, 88.0, 22.0 ],
					"style" : "",
					"text" : "fluid.bufsines~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-24",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 34.0, 732.0, 85.0, 22.0 ],
					"style" : "",
					"text" : "fluid.bufpitch~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-23",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 34.0, 344.0, 113.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 176.5, 84.0, 139.0, 22.0 ],
					"style" : "",
					"text" : "fluid.bufonsetslice~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-22",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 359.0, 274.0, 122.0, 22.0 ],
					"style" : "",
					"text" : "fluid.bufnoveltyslice~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-21",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 724.0, 264.0, 80.0, 22.0 ],
					"style" : "",
					"text" : "fluid.bufnmf~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-20",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 409.0, 734.0, 85.0, 22.0 ],
					"style" : "",
					"text" : "fluid.bufmfcc~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-19",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 409.0, 654.0, 112.0, 22.0 ],
					"style" : "",
					"text" : "fluid.bufmelbands~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-18",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 34.0, 654.0, 108.0, 22.0 ],
					"style" : "",
					"text" : "fluid.bufloudness~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-17",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 359.0, 487.0, 85.0, 22.0 ],
					"style" : "",
					"text" : "fluid.bufhpss~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-16",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 724.0, 468.0, 108.0, 22.0 ],
					"style" : "",
					"text" : "fluid.bufcompose~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-15",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 34.0, 274.0, 107.0, 22.0 ],
					"style" : "",
					"text" : "fluid.bufampslice~"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-13",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "" ],
					"patching_rect" : [ 34.0, 244.0, 90.0, 22.0 ],
					"style" : "",
					"text" : "fluid.ampslice~"
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
					"patching_rect" : [ 9.0, 578.0, 985.0, 189.0 ],
					"proportion" : 0.39,
					"style" : ""
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
					"patching_rect" : [ 699.0, 205.0, 295.0, 174.0 ],
					"proportion" : 0.39,
					"style" : ""
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
					"patching_rect" : [ 699.0, 392.0, 295.0, 174.0 ],
					"proportion" : 0.39,
					"style" : ""
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
					"patching_rect" : [ 9.0, 392.0, 676.0, 174.0 ],
					"proportion" : 0.39,
					"style" : ""
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
					"patching_rect" : [ 9.0, 205.0, 676.0, 174.0 ],
					"proportion" : 0.39,
					"style" : ""
				}

			}
 ],
		"lines" : [  ],
		"dependency_cache" : [ 			{
				"name" : "fluid.ampslice~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.bufampslice~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.bufcompose~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.bufhpss~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.bufloudness~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.bufmelbands~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.bufmfcc~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.bufnmf~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.bufnoveltyslice~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.bufonsetslice~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.bufpitch~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.bufsines~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.bufspectralshape~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.bufstats~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.buftransients~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.buftransientslice~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.hpss~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.loudness~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.melbands~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.mfcc~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.nmffilter~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.nmfmatch~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.onsetslice~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.pitch~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.sines~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.spectralshape~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.transients~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.transientslice~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.noveltyslice~.mxo",
				"type" : "iLaX"
			}
 ],
		"autosave" : 0
	}

}
