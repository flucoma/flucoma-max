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
		"rect" : [ 34.0, 79.0, 779.0, 570.0 ],
		"bglocked" : 0,
		"openinpresentation" : 1,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 1,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 1,
		"objectsnaponopen" : 1,
		"statusbarvisible" : 2,
		"toolbarvisible" : 1,
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
		"boxes" : [ 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-23",
					"linecount" : 4,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 578.0, 485.100000000000023, 161.0, 60.0 ],
					"presentation" : 1,
					"presentation_linecount" : 4,
					"presentation_rect" : [ 578.0, 486.0, 159.0, 60.0 ],
					"text" : "Train supervised learning models using either K nearest neighbours or a simple neural network",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-22",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 579.0, 421.200000000000045, 161.0, 47.0 ],
					"presentation" : 1,
					"presentation_linecount" : 3,
					"presentation_rect" : [ 578.0, 411.100000000000023, 159.0, 47.0 ],
					"text" : "Compress data to fewer dimensions for visualisation / efficiency / preprocessing",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-21",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 577.0, 340.0, 161.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 578.0, 351.200000000000045, 155.0, 20.0 ],
					"text" : "Pre-process data ",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-20",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 579.0, 259.5, 161.0, 33.0 ],
					"presentation" : 1,
					"presentation_linecount" : 2,
					"presentation_rect" : [ 578.0, 262.0, 155.0, 33.0 ],
					"text" : "Perform nearest neighbour searches",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"id" : "obj-18",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 581.0, 193.5, 161.0, 47.0 ],
					"presentation" : 1,
					"presentation_linecount" : 3,
					"presentation_rect" : [ 578.0, 193.5, 154.0, 47.0 ],
					"text" : "Select and filter items from fluid.dataset~ by building queries",
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
					"patching_rect" : [ 66.083343999999997, 216.0, 161.0, 33.0 ],
					"presentation" : 1,
					"presentation_linecount" : 2,
					"presentation_rect" : [ 578.0, 117.5, 153.0, 33.0 ],
					"text" : "Associate labels with data, or with other labels",
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Lato Light",
					"fontsize" : 72.0,
					"id" : "obj-17",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 55.0, 45.0, 621.0, 179.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 15.000031000000035, 8.0, 667.0, 93.0 ],
					"text" : "FluCoMa Data Tools"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"fontname" : "Lato Light",
					"fontsize" : 24.0,
					"id" : "obj-16",
					"linecount" : 4,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 20.0, 373.0, 72.0, 122.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 29.0, 492.0, 222.0, 35.0 ],
					"text" : "Supervised Learning"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"fontname" : "Lato Light",
					"fontsize" : 24.0,
					"id" : "obj-15",
					"linecount" : 4,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 20.0, 283.0, 72.0, 122.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 29.0, 417.600000000000023, 234.000031000000035, 35.0 ],
					"text" : "Dimension Reduction"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"fontname" : "Lato Light",
					"fontsize" : 24.0,
					"id" : "obj-14",
					"linecount" : 4,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 20.0, 194.0, 72.0, 122.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 29.0, 343.700000000000045, 203.0, 35.0 ],
					"text" : "Data Conditioning"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"fontname" : "Lato Light",
					"fontsize" : 24.0,
					"id" : "obj-13",
					"linecount" : 4,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 22.0, 317.0, 72.0, 122.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 29.0, 199.400000000000006, 181.0, 35.0 ],
					"text" : "DataSet Filtering"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"fontname" : "Lato Light",
					"fontsize" : 24.0,
					"id" : "obj-12",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 21.0, 136.0, 72.0, 93.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 29.0, 268.0, 159.0, 35.0 ],
					"text" : "Data Structure"
				}

			}
, 			{
				"box" : 				{
					"annotation" : "",
					"fontname" : "Lato Light",
					"fontsize" : 24.0,
					"id" : "obj-43",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 94.000007999999994, 144.333336000000003, 72.0, 64.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 29.0, 125.0, 120.0, 35.0 ],
					"text" : "Containers"
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-11",
					"maxclass" : "tab",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 61.000031000000035, 198.0, 129.0, 31.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 257.000031000000035, 198.400000000000006, 137.0, 32.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.datasetquery~" ]
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-10",
					"maxclass" : "tab",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 420.000031000000035, 428.0, 129.0, 31.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 396.000031000000035, 418.600000000000023, 137.0, 32.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.mds~" ]
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-9",
					"maxclass" : "tab",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 420.000031000000035, 391.0, 129.0, 31.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 257.000031000000035, 418.600000000000023, 137.0, 32.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.pca~" ]
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-8",
					"maxclass" : "tab",
					"multiline" : 0,
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 429.000031000000035, 346.0, 129.0, 31.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 396.000031000000035, 345.200000000000045, 137.0, 32.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.standardize~" ]
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-7",
					"maxclass" : "tab",
					"multiline" : 0,
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 429.000031000000035, 300.0, 129.0, 31.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 257.000031000000035, 345.200000000000045, 137.0, 32.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.normalize~" ]
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-6",
					"maxclass" : "tab",
					"multiline" : 0,
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 433.000031000000035, 225.0, 129.0, 31.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 396.000031000000035, 511.0, 137.0, 32.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.mlpregressor~" ]
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-5",
					"maxclass" : "tab",
					"multiline" : 0,
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 433.000031000000035, 183.0, 129.0, 31.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 396.000031000000035, 477.0, 137.0, 32.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.mlpclassifier~" ]
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-4",
					"maxclass" : "tab",
					"multiline" : 0,
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 437.000031000000035, 136.0, 129.0, 31.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 257.000031000000035, 478.0, 137.0, 32.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.knnclassifier~" ]
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-3",
					"maxclass" : "tab",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 437.000031000000035, 98.0, 129.0, 31.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 257.000031000000035, 511.0, 137.0, 32.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.knnregressor~" ]
				}

			}
, 			{
				"box" : 				{
					"button" : 1,
					"fontname" : "Lato Regular",
					"htabcolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
					"id" : "obj-2",
					"maxclass" : "tab",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 61.000031000000035, 238.0, 129.0, 31.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 257.000031000000035, 271.800000000000011, 137.0, 32.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.kdtree~" ]
				}

			}
, 			{
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
					"patching_rect" : [ 61.000031000000035, 154.0, 129.0, 31.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 396.000031000000035, 125.0, 137.0, 32.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.labelset~" ]
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
					"patching_rect" : [ 61.000031000000035, 111.0, 129.0, 31.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 257.000031000000035, 125.0, 137.0, 32.0 ],
					"tabcolor" : [ 0.3, 0.3, 0.3, 1.0 ],
					"tabs" : [ "fluid.dataset~" ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-86",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 247.0, 611.0, 50.0, 22.0 ],
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
					"patching_rect" : [ 247.0, 638.0, 53.0, 22.0 ],
					"text" : "pcontrol"
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
					"source" : [ "obj-10", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"source" : [ "obj-11", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"source" : [ "obj-2", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"source" : [ "obj-3", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"source" : [ "obj-4", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"source" : [ "obj-5", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"source" : [ "obj-6", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"source" : [ "obj-7", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"source" : [ "obj-8", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"source" : [ "obj-82", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-84", 0 ],
					"source" : [ "obj-86", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 0 ],
					"source" : [ "obj-9", 1 ]
				}

			}
 ],
		"dependency_cache" : [  ],
		"autosave" : 0
	}

}
