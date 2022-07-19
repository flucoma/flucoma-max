{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 8,
			"minor" : 3,
			"revision" : 2,
			"architecture" : "x64",
			"modernui" : 1
		}
,
		"classnamespace" : "box",
		"rect" : [ 35.0, 88.0, 996.0, 777.0 ],
		"bglocked" : 0,
		"openinpresentation" : 1,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 2,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 2,
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
		"showrootpatcherontab" : 0,
		"showontab" : 0,
		"assistshowspatchername" : 0,
		"boxes" : [ 			{
				"box" : 				{
					"id" : "obj-6",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 8,
							"minor" : 3,
							"revision" : 2,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"classnamespace" : "box",
						"rect" : [ 35.0, 114.0, 996.0, 751.0 ],
						"bglocked" : 0,
						"openinpresentation" : 1,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 2,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 2,
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
						"showontab" : 1,
						"assistshowspatchername" : 0,
						"boxes" : [ 							{
								"box" : 								{
									"bgmode" : 0,
									"border" : 0,
									"clickthrough" : 0,
									"embed" : 1,
									"enablehscroll" : 0,
									"enablevscroll" : 0,
									"id" : "obj-23",
									"lockeddragscroll" : 0,
									"lockedsize" : 0,
									"maxclass" : "bpatcher",
									"numinlets" : 1,
									"numoutlets" : 0,
									"offset" : [ -2475.0, 0.0 ],
									"patcher" : 									{
										"fileversion" : 1,
										"appversion" : 										{
											"major" : 8,
											"minor" : 3,
											"revision" : 2,
											"architecture" : "x64",
											"modernui" : 1
										}
,
										"classnamespace" : "box",
										"rect" : [ -154.0, -1112.0, 1850.0, 1077.0 ],
										"bglocked" : 0,
										"openinpresentation" : 1,
										"default_fontsize" : 12.0,
										"default_fontface" : 0,
										"default_fontname" : "Arial",
										"gridonopen" : 2,
										"gridsize" : [ 15.0, 15.0 ],
										"gridsnaponopen" : 2,
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
										"assistshowspatchername" : 0,
										"boxes" : [ 											{
												"box" : 												{
													"id" : "obj-52",
													"linecount" : 3,
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"patching_rect" : [ 2700.0, 705.0, 195.0, 49.0 ],
													"text" : "combine https://learn.flucoma.org/explore/ link @triggers 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-51",
													"justification" : 1,
													"linecolor" : [ 0.647058823529412, 0.647058823529412, 0.647058823529412, 1.0 ],
													"maxclass" : "live.line",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 270.0, 480.0, 5.0, 100.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 15.0, 128.0, 405.0, 5.0 ],
													"saved_attribute_attributes" : 													{
														"linecolor" : 														{
															"expression" : "themecolor.live_assignment_text_bg"
														}

													}

												}

											}
, 											{
												"box" : 												{
													"id" : "obj-31",
													"maxclass" : "newobj",
													"numinlets" : 3,
													"numoutlets" : 3,
													"outlettype" : [ "bang", "bang", "" ],
													"patching_rect" : [ 2490.0, 452.0, 44.0, 22.0 ],
													"text" : "sel 0 1"
												}

											}
, 											{
												"box" : 												{
													"activebgcolor" : [ 0.352941176470588, 0.352941176470588, 0.352941176470588, 1.0 ],
													"activebgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
													"bgcolor" : [ 0.352941176470588, 0.352941176470588, 0.352941176470588, 1.0 ],
													"button" : 1,
													"fontname" : "Lato",
													"fontsize" : 11.0,
													"id" : "obj-32",
													"maxclass" : "live.tab",
													"multiline" : 0,
													"num_lines_patching" : 1,
													"num_lines_presentation" : 1,
													"numinlets" : 1,
													"numoutlets" : 3,
													"outlettype" : [ "", "", "float" ],
													"parameter_enable" : 1,
													"patching_rect" : [ 2490.0, 405.0, 255.0, 32.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 2490.0, 300.0, 255.0, 32.0 ],
													"saved_attribute_attributes" : 													{
														"activebgcolor" : 														{
															"expression" : "themecolor.live_led_bg"
														}
,
														"activebgoncolor" : 														{
															"expression" : "themecolor.live_value_arc"
														}
,
														"bgcolor" : 														{
															"expression" : "themecolor.live_led_bg"
														}
,
														"textcolor" : 														{
															"expression" : "themecolor.theme_color"
														}
,
														"textoncolor" : 														{
															"expression" : "themecolor.theme_editing_bgcolor"
														}
,
														"valueof" : 														{
															"parameter_enum" : [ "YouTube Video", "Learn Article" ],
															"parameter_longname" : "live.tab[5]",
															"parameter_mmax" : 1,
															"parameter_shortname" : "live.tab[3]",
															"parameter_type" : 2,
															"parameter_unitstyle" : 9
														}

													}
,
													"textcolor" : [ 0.807843, 0.898039, 0.909804, 1.0 ],
													"textoncolor" : [ 0.898039, 0.898039, 0.898039, 1.0 ],
													"varname" : "live.tab[5]"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-34",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"patching_rect" : [ 2700.0, 647.0, 77.0, 22.0 ],
													"text" : "route symbol"
												}

											}
, 											{
												"box" : 												{
													"coll_data" : 													{
														"count" : 9,
														"data" : [ 															{
																"key" : 0,
																"value" : [ "eldridge-kiefer" ]
															}
, 															{
																"key" : 1,
																"value" : [ "hayes" ]
															}
, 															{
																"key" : 2,
																"value" : [ "burton" ]
															}
, 															{
																"key" : 3,
																"value" : [ "harker" ]
															}
, 															{
																"key" : 4,
																"value" : [ "pluta" ]
															}
, 															{
																"key" : 5,
																"value" : [ "pasquet" ]
															}
, 															{
																"key" : 6,
																"value" : [ "constanzo" ]
															}
, 															{
																"key" : 7,
																"value" : [ "devine" ]
															}
, 															{
																"key" : 8,
																"value" : [ "tutschku" ]
															}
 ]
													}
,
													"id" : "obj-36",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 4,
													"outlettype" : [ "", "", "", "" ],
													"patching_rect" : [ 2700.0, 602.0, 210.0, 22.0 ],
													"saved_object_attributes" : 													{
														"embed" : 1,
														"precision" : 6
													}
,
													"text" : "coll fluid-composer-learns @embed 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-39",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"patching_rect" : [ 2490.0, 647.0, 77.0, 22.0 ],
													"text" : "route symbol"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-40",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "bang" ],
													"patching_rect" : [ 2700.0, 510.0, 22.0, 22.0 ],
													"text" : "t b"
												}

											}
, 											{
												"box" : 												{
													"coll_data" : 													{
														"count" : 9,
														"data" : [ 															{
																"key" : 0,
																"value" : [ "https://youtu.be/c03_84_P7PQ" ]
															}
, 															{
																"key" : 1,
																"value" : [ "https://youtu.be/BzSRs_7S9cg" ]
															}
, 															{
																"key" : 2,
																"value" : [ "https://youtu.be/hYaZq1JCTQo" ]
															}
, 															{
																"key" : 3,
																"value" : [ "https://youtu.be/lHEWsysupaA" ]
															}
, 															{
																"key" : 4,
																"value" : [ "https://youtu.be/jWwJd9UmixQ" ]
															}
, 															{
																"key" : 5,
																"value" : [ "https://youtu.be/qqR_gORRwRA" ]
															}
, 															{
																"key" : 6,
																"value" : [ "https://www.youtube.com/watch?v=MTWklm1oXWQ" ]
															}
, 															{
																"key" : 7,
																"value" : [ "https://youtu.be/F0iCU_uqJHg" ]
															}
, 															{
																"key" : 8,
																"value" : [ "https://youtu.be/xPqT-atQIik" ]
															}
 ]
													}
,
													"id" : "obj-42",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 4,
													"outlettype" : [ "", "", "", "" ],
													"patching_rect" : [ 2490.0, 602.0, 199.0, 22.0 ],
													"saved_object_attributes" : 													{
														"embed" : 1,
														"precision" : 6
													}
,
													"text" : "coll fluid-composer-links @embed 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-43",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"patching_rect" : [ 2700.0, 557.0, 48.0, 22.0 ],
													"text" : "zl.reg 0"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-44",
													"linecount" : 2,
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 2490.0, 795.0, 129.0, 35.0 ],
													"presentation_linecount" : 2,
													"text" : ";\rmax launchbrowser $1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-45",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"patching_rect" : [ 2490.0, 557.0, 48.0, 22.0 ],
													"text" : "zl.reg 0"
												}

											}
, 											{
												"box" : 												{
													"fontface" : 2,
													"fontname" : "Lato",
													"id" : "obj-22",
													"maxclass" : "comment",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 2490.0, 105.0, 139.0, 21.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 2490.0, 14.0, 139.0, 21.0 ],
													"text" : "Select a composer(s)...",
													"textcolor" : [ 0.501960784313725, 0.501960784313725, 0.501960784313725, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"activebgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
													"fontname" : "Lato",
													"fontsize" : 12.0,
													"id" : "obj-25",
													"maxclass" : "live.tab",
													"num_lines_patching" : 9,
													"num_lines_presentation" : 9,
													"numinlets" : 1,
													"numoutlets" : 3,
													"outlettype" : [ "", "", "float" ],
													"parameter_enable" : 1,
													"patching_rect" : [ 2490.0, 131.0, 255.0, 259.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 2490.0, 37.0, 255.0, 259.0 ],
													"saved_attribute_attributes" : 													{
														"activebgoncolor" : 														{
															"expression" : "themecolor.live_value_bar"
														}
,
														"valueof" : 														{
															"parameter_enum" : [ "Alice Eldridge & Chris Kiefer", "Lauren Sarah Hayes", "Leafcutter John", "Alex Harker", "Sam Pluta", "Olivier Pasquet", "Rodrigo Constanzo", "Richard Devine", "Hans Tutschku" ],
															"parameter_longname" : "live.tab[4]",
															"parameter_mmax" : 8,
															"parameter_shortname" : "live.tab",
															"parameter_type" : 2,
															"parameter_unitstyle" : 9
														}

													}
,
													"varname" : "live.tab[4]"
												}

											}
, 											{
												"box" : 												{
													"fontface" : 2,
													"fontname" : "Lato",
													"id" : "obj-19",
													"linecount" : 5,
													"maxclass" : "comment",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 1560.0, 270.0, 179.0, 78.0 ],
													"presentation" : 1,
													"presentation_linecount" : 4,
													"presentation_rect" : [ 1665.0, 165.0, 198.0, 64.0 ],
													"text" : "These examples serve as intermediate and advanced applications achieved by combining several FluCoMa objects together.",
													"textcolor" : [ 0.501960784313725, 0.501960784313725, 0.501960784313725, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"fontface" : 2,
													"fontname" : "Lato",
													"id" : "obj-17",
													"maxclass" : "comment",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 1560.0, 105.0, 139.0, 21.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 1665.0, 15.0, 139.0, 21.0 ],
													"text" : "Select an example...",
													"textcolor" : [ 0.501960784313725, 0.501960784313725, 0.501960784313725, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-14",
													"maxclass" : "newobj",
													"numinlets" : 3,
													"numoutlets" : 3,
													"outlettype" : [ "bang", "bang", "" ],
													"patching_rect" : [ 870.0, 405.0, 44.0, 22.0 ],
													"text" : "sel 0 1"
												}

											}
, 											{
												"box" : 												{
													"activebgcolor" : [ 0.352941176470588, 0.352941176470588, 0.352941176470588, 1.0 ],
													"activebgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
													"bgcolor" : [ 0.352941176470588, 0.352941176470588, 0.352941176470588, 1.0 ],
													"button" : 1,
													"fontname" : "Lato",
													"fontsize" : 11.0,
													"id" : "obj-13",
													"maxclass" : "live.tab",
													"multiline" : 0,
													"num_lines_patching" : 1,
													"num_lines_presentation" : 1,
													"numinlets" : 1,
													"numoutlets" : 3,
													"outlettype" : [ "", "", "float" ],
													"parameter_enable" : 1,
													"patching_rect" : [ 870.0, 358.0, 255.0, 32.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 840.0, 225.0, 255.0, 30.0 ],
													"saved_attribute_attributes" : 													{
														"activebgcolor" : 														{
															"expression" : "themecolor.live_led_bg"
														}
,
														"activebgoncolor" : 														{
															"expression" : "themecolor.live_value_arc"
														}
,
														"bgcolor" : 														{
															"expression" : "themecolor.live_led_bg"
														}
,
														"textcolor" : 														{
															"expression" : "themecolor.theme_color"
														}
,
														"textoncolor" : 														{
															"expression" : "themecolor.theme_editing_bgcolor"
														}
,
														"valueof" : 														{
															"parameter_enum" : [ "YouTube Video", "Open Patch" ],
															"parameter_longname" : "live.tab[3]",
															"parameter_mmax" : 1,
															"parameter_shortname" : "live.tab[3]",
															"parameter_type" : 2,
															"parameter_unitstyle" : 9
														}

													}
,
													"textcolor" : [ 0.807843, 0.898039, 0.909804, 1.0 ],
													"textoncolor" : [ 0.898039, 0.898039, 0.898039, 1.0 ],
													"varname" : "live.tab[3]"
												}

											}
, 											{
												"box" : 												{
													"fontface" : 2,
													"fontname" : "Lato",
													"id" : "obj-8",
													"linecount" : 5,
													"maxclass" : "comment",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 1140.0, 390.0, 139.0, 78.0 ],
													"presentation" : 1,
													"presentation_linecount" : 3,
													"presentation_rect" : [ 840.0, 165.0, 255.0, 50.0 ],
													"text" : "Be aware, some of the patches you can open from within the package will differ slightly from the tutorial video's final result.",
													"textcolor" : [ 0.501960784313725, 0.501960784313725, 0.501960784313725, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-7",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 1035.0, 645.0, 79.0, 22.0 ],
													"text" : "prepend load"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-6",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"patching_rect" : [ 1035.0, 600.0, 77.0, 22.0 ],
													"text" : "route symbol"
												}

											}
, 											{
												"box" : 												{
													"coll_data" : 													{
														"count" : 3,
														"data" : [ 															{
																"key" : 0,
																"value" : [ "corpus-explorer.maxpat" ]
															}
, 															{
																"key" : 1,
																"value" : [ "classification.maxpat" ]
															}
, 															{
																"key" : 2,
																"value" : [ "regression.maxpat" ]
															}
 ]
													}
,
													"id" : "obj-5",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 4,
													"outlettype" : [ "", "", "", "" ],
													"patching_rect" : [ 1035.0, 555.0, 204.0, 22.0 ],
													"saved_object_attributes" : 													{
														"embed" : 1,
														"precision" : 6
													}
,
													"text" : "coll fluid-tutorial-patchers @embed 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-62",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 1035.0, 690.0, 51.0, 22.0 ],
													"text" : "pcontrol"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-61",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"patching_rect" : [ 870.0, 600.0, 77.0, 22.0 ],
													"text" : "route symbol"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-60",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "bang" ],
													"patching_rect" : [ 1035.0, 465.0, 22.0, 22.0 ],
													"text" : "t b"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-59",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "bang" ],
													"patching_rect" : [ 870.0, 465.0, 22.0, 22.0 ],
													"text" : "t b"
												}

											}
, 											{
												"box" : 												{
													"coll_data" : 													{
														"count" : 3,
														"data" : [ 															{
																"key" : 0,
																"value" : [ "https://youtu.be/4dsX5uRips8" ]
															}
, 															{
																"key" : 1,
																"value" : [ "https://youtu.be/cjk9oHw7PQg" ]
															}
, 															{
																"key" : 2,
																"value" : [ "https://youtu.be/XfNZzQPdPG0" ]
															}
 ]
													}
,
													"id" : "obj-54",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 4,
													"outlettype" : [ "", "", "", "" ],
													"patching_rect" : [ 870.0, 555.0, 142.0, 22.0 ],
													"saved_object_attributes" : 													{
														"embed" : 1,
														"precision" : 6
													}
,
													"text" : "coll fluid-links @embed 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-49",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"patching_rect" : [ 1035.0, 510.0, 48.0, 22.0 ],
													"text" : "zl.reg 0"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-47",
													"linecount" : 2,
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 870.0, 645.0, 129.0, 35.0 ],
													"text" : ";\rmax launchbrowser $1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-41",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patcher" : 													{
														"fileversion" : 1,
														"appversion" : 														{
															"major" : 8,
															"minor" : 3,
															"revision" : 2,
															"architecture" : "x64",
															"modernui" : 1
														}
,
														"classnamespace" : "box",
														"rect" : [ 0.0, 0.0, 640.0, 480.0 ],
														"bglocked" : 0,
														"openinpresentation" : 0,
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
														"assistshowspatchername" : 0,
														"boxes" : [ 															{
																"box" : 																{
																	"id" : "obj-37",
																	"maxclass" : "newobj",
																	"numinlets" : 1,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"patching_rect" : [ 97.333333333333371, 198.0, 72.0, 22.0 ],
																	"text" : "prepend set"
																}

															}
, 															{
																"box" : 																{
																	"id" : "obj-31",
																	"maxclass" : "newobj",
																	"numinlets" : 1,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"patching_rect" : [ 63.0, 100.0, 73.0, 22.0 ],
																	"text" : "prepend get"
																}

															}
, 															{
																"box" : 																{
																	"data" : 																	{
																		"Building a 2D Corpus Explorer" : "Imagine you have a large corpus of sounds that you've collected from a studio session, some outside sound walks or experimenting with a synthesiser on a rainy afternoon. This tutorial teaches you how to build a '2D Corpus Explorer', a patch that will enable you to interrogate and listen to those sounds in a structured manner. The end result is similar to CataRT and AudioStellar in that small segments of your corpus sounds are analysed and mapped to a two-dimensional space that can be explored using your mouse. It will cover topics such as segmentation, analysis, data processing and visualisation.",
																		"Classifying Sounds with a Neural Network" : "The multilayer perceptron is a really powerful neural network that can be used for a variety of applications including classification. In this tutorial, you'll build a fluid.dataset~ of audio analysis and provide a bunch of human-readable labels to teach a neural network to classify different sound archetypes. This might let you build a 'content-aware' audio-reactive patch for example.",
																		"Controlling a Synth with a Neural Network" : "The multilayer perceptron is a really powerful neural network that can be used for a variety of applications, including regression. Regression is formally known as 'a measure of the relation between the mean value of one variable (e.g. output) and corresponding values of other variables (e.g. time and cost)'. In this example you'll learn how to 'regress' different combinations of data against each other; in this case a two-dimensional 'chaos-pad' like space, to a multi-dimensional set of synthesiser parameters. By providing coupled examples of positions on the 'chaos-pad' and combinations of parameters in the multi-dimensional synthesiser space you can construct a rich bespoke space to explore."
																	}
,
																	"id" : "obj-29",
																	"maxclass" : "newobj",
																	"numinlets" : 2,
																	"numoutlets" : 4,
																	"outlettype" : [ "dictionary", "", "", "" ],
																	"patching_rect" : [ 50.0, 153.0, 161.0, 22.0 ],
																	"saved_object_attributes" : 																	{
																		"embed" : 1,
																		"parameter_enable" : 0,
																		"parameter_mappable" : 0
																	}
,
																	"text" : "dict fluid-tutorials @embed 1"
																}

															}
, 															{
																"box" : 																{
																	"comment" : "",
																	"id" : "obj-39",
																	"index" : 1,
																	"maxclass" : "inlet",
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"patching_rect" : [ 63.0, 40.0, 30.0, 30.0 ]
																}

															}
, 															{
																"box" : 																{
																	"comment" : "",
																	"id" : "obj-40",
																	"index" : 1,
																	"maxclass" : "outlet",
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"patching_rect" : [ 97.333312999999976, 280.0, 30.0, 30.0 ]
																}

															}
 ],
														"lines" : [ 															{
																"patchline" : 																{
																	"destination" : [ "obj-37", 0 ],
																	"source" : [ "obj-29", 1 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-29", 0 ],
																	"midpoints" : [ 72.5, 123.0, 59.5, 123.0 ],
																	"source" : [ "obj-31", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-40", 0 ],
																	"source" : [ "obj-37", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-31", 0 ],
																	"source" : [ "obj-39", 0 ]
																}

															}
 ]
													}
,
													"patching_rect" : [ 988.0, 307.0, 105.0, 22.0 ],
													"saved_object_attributes" : 													{
														"description" : "",
														"digest" : "",
														"globalpatchername" : "",
														"tags" : ""
													}
,
													"text" : "p \"get description\""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-38",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"patching_rect" : [ 870.0, 510.0, 48.0, 22.0 ],
													"text" : "zl.reg 0"
												}

											}
, 											{
												"box" : 												{
													"bgmode" : 0,
													"border" : 0,
													"clickthrough" : 0,
													"embed" : 1,
													"enablehscroll" : 0,
													"enablevscroll" : 0,
													"id" : "obj-35",
													"lockeddragscroll" : 0,
													"lockedsize" : 0,
													"maxclass" : "bpatcher",
													"numinlets" : 1,
													"numoutlets" : 0,
													"offset" : [ 0.0, 0.0 ],
													"patcher" : 													{
														"fileversion" : 1,
														"appversion" : 														{
															"major" : 8,
															"minor" : 3,
															"revision" : 2,
															"architecture" : "x64",
															"modernui" : 1
														}
,
														"classnamespace" : "box",
														"rect" : [ 35.0, 88.0, 996.0, 777.0 ],
														"bglocked" : 0,
														"openinpresentation" : 1,
														"default_fontsize" : 12.0,
														"default_fontface" : 0,
														"default_fontname" : "Arial",
														"gridonopen" : 2,
														"gridsize" : [ 5.0, 5.0 ],
														"gridsnaponopen" : 2,
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
														"assistshowspatchername" : 0,
														"boxes" : [ 															{
																"box" : 																{
																	"id" : "obj-20",
																	"maxclass" : "message",
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"patching_rect" : [ 71.0, 85.0, 55.0, 22.0 ],
																	"text" : "0, 1. 300"
																}

															}
, 															{
																"box" : 																{
																	"id" : "obj-18",
																	"maxclass" : "newobj",
																	"numinlets" : 3,
																	"numoutlets" : 2,
																	"outlettype" : [ "", "bang" ],
																	"patching_rect" : [ 71.0, 120.0, 41.0, 22.0 ],
																	"text" : "line 0."
																}

															}
, 															{
																"box" : 																{
																	"id" : "obj-15",
																	"maxclass" : "newobj",
																	"numinlets" : 1,
																	"numoutlets" : 2,
																	"outlettype" : [ "", "bang" ],
																	"patching_rect" : [ 5.0, 50.0, 85.0, 22.0 ],
																	"text" : "t l b"
																}

															}
, 															{
																"box" : 																{
																	"id" : "obj-4",
																	"maxclass" : "message",
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"patching_rect" : [ 71.0, 155.0, 101.0, 22.0 ],
																	"text" : "textcolor 0 0 0 $1"
																}

															}
, 															{
																"box" : 																{
																	"comment" : "",
																	"id" : "obj-1",
																	"index" : 1,
																	"maxclass" : "inlet",
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"patching_rect" : [ 5.0, 5.0, 30.0, 30.0 ]
																}

															}
, 															{
																"box" : 																{
																	"fontface" : 2,
																	"fontname" : "Lato",
																	"fontsize" : 14.0,
																	"id" : "obj-90",
																	"linecount" : 14,
																	"maxclass" : "comment",
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"patching_rect" : [ 5.0, 195.0, 352.0, 242.0 ],
																	"presentation" : 1,
																	"presentation_linecount" : 14,
																	"presentation_rect" : [ 5.0, 5.0, 352.0, 242.0 ],
																	"text" : "Controlling a Synth with a Neural Network The multilayer perceptron is a really powerful neural network that can be used for a variety of applications, including regression. Regression is formally known as 'a measure of the relation between the mean value of one variable (e.g. output) and corresponding values of other variables (e.g. time and cost)'. In this example you'll learn how to 'regress' different combinations of data against each other; in this case a two-dimensional 'chaos-pad' like space, to a multi-dimensional set of synthesiser parameters. By providing coupled examples of positions on the 'chaos-pad' and combinations of parameters in the multi-dimensional synthesiser space you can construct a rich bespoke space to explore.",
																	"textcolor" : [ 0.0, 0.0, 0.0, 1.0 ]
																}

															}
 ],
														"lines" : [ 															{
																"patchline" : 																{
																	"destination" : [ "obj-15", 0 ],
																	"source" : [ "obj-1", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-20", 0 ],
																	"source" : [ "obj-15", 1 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-90", 0 ],
																	"source" : [ "obj-15", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-4", 0 ],
																	"source" : [ "obj-18", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-18", 0 ],
																	"source" : [ "obj-20", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-90", 0 ],
																	"midpoints" : [ 80.5, 185.5, 14.5, 185.5 ],
																	"source" : [ "obj-4", 0 ]
																}

															}
 ]
													}
,
													"patching_rect" : [ 1140.0, 131.0, 360.0, 252.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 1097.0, 30.0, 404.0, 255.0 ],
													"viewvisibility" : 1
												}

											}
, 											{
												"box" : 												{
													"fontface" : 2,
													"fontname" : "Lato",
													"id" : "obj-27",
													"maxclass" : "comment",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 870.0, 108.0, 139.0, 21.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 840.0, 15.0, 139.0, 21.0 ],
													"text" : "Select a tutorial...",
													"textcolor" : [ 0.501960784313725, 0.501960784313725, 0.501960784313725, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"fontface" : 2,
													"fontname" : "Lato",
													"id" : "obj-26",
													"maxclass" : "comment",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 90.0, 101.0, 139.0, 21.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 15.0, 15.0, 139.0, 21.0 ],
													"text" : "Select a category...",
													"textcolor" : [ 0.501960784313725, 0.501960784313725, 0.501960784313725, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"activebgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
													"fontname" : "Lato",
													"fontsize" : 12.0,
													"id" : "obj-24",
													"maxclass" : "live.tab",
													"num_lines_patching" : 6,
													"num_lines_presentation" : 6,
													"numinlets" : 1,
													"numoutlets" : 3,
													"outlettype" : [ "", "", "float" ],
													"parameter_enable" : 1,
													"patching_rect" : [ 1560.0, 131.0, 179.0, 122.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 1665.0, 37.0, 375.0, 122.0 ],
													"saved_attribute_attributes" : 													{
														"activebgoncolor" : 														{
															"expression" : "themecolor.live_value_bar"
														}
,
														"valueof" : 														{
															"parameter_enum" : [ "Analysing Pitch", "Audio-Reactive", "Autoencoder", "Composing Buffers", "Lightweight MFCC Classifier", "NMF Classifier", "JIT NMF", "NMF Object Finder", "Piano Classifier", "Finding Specific Sounds", " Intelligent Slicing" ],
															"parameter_longname" : "live.tab[1]",
															"parameter_mmax" : 10,
															"parameter_shortname" : "live.tab",
															"parameter_type" : 2,
															"parameter_unitstyle" : 9
														}

													}
,
													"varname" : "live.tab[2]"
												}

											}
, 											{
												"box" : 												{
													"activebgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
													"fontname" : "Lato",
													"fontsize" : 12.0,
													"id" : "obj-23",
													"maxclass" : "live.tab",
													"num_lines_patching" : 3,
													"num_lines_presentation" : 3,
													"numinlets" : 1,
													"numoutlets" : 3,
													"outlettype" : [ "", "", "float" ],
													"parameter_enable" : 1,
													"patching_rect" : [ 870.0, 131.0, 255.0, 169.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 840.0, 37.0, 255.0, 122.0 ],
													"saved_attribute_attributes" : 													{
														"activebgoncolor" : 														{
															"expression" : "themecolor.live_value_bar"
														}
,
														"valueof" : 														{
															"parameter_enum" : [ "Building a 2D Corpus Explorer", "Classifying Sounds with a Neural Network", "Controlling a Synth with a Neural Network" ],
															"parameter_longname" : "live.tab[19]",
															"parameter_mmax" : 2,
															"parameter_shortname" : "live.tab",
															"parameter_type" : 2,
															"parameter_unitstyle" : 9
														}

													}
,
													"varname" : "live.tab[1]"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-16",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patcher" : 													{
														"fileversion" : 1,
														"appversion" : 														{
															"major" : 8,
															"minor" : 3,
															"revision" : 2,
															"architecture" : "x64",
															"modernui" : 1
														}
,
														"classnamespace" : "box",
														"rect" : [ 59.0, 106.0, 382.0, 355.0 ],
														"bglocked" : 0,
														"openinpresentation" : 0,
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
														"assistshowspatchername" : 0,
														"boxes" : [ 															{
																"box" : 																{
																	"id" : "obj-2",
																	"maxclass" : "message",
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"patching_rect" : [ 140.0, 123.0, 39.0, 22.0 ],
																	"text" : "-2475"
																}

															}
, 															{
																"box" : 																{
																	"id" : "obj-3",
																	"maxclass" : "newobj",
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"patching_rect" : [ 11.0, 167.0, 63.0, 22.0 ],
																	"text" : "pack i 225"
																}

															}
, 															{
																"box" : 																{
																	"id" : "obj-1",
																	"maxclass" : "message",
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"patching_rect" : [ 97.0, 123.0, 39.0, 22.0 ],
																	"text" : "-1650"
																}

															}
, 															{
																"box" : 																{
																	"id" : "obj-13",
																	"maxclass" : "message",
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"patching_rect" : [ 11.0, 123.0, 29.5, 22.0 ],
																	"text" : "0"
																}

															}
, 															{
																"box" : 																{
																	"id" : "obj-12",
																	"maxclass" : "message",
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"patching_rect" : [ 54.0, 123.0, 33.0, 22.0 ],
																	"text" : "-825"
																}

															}
, 															{
																"box" : 																{
																	"id" : "obj-8",
																	"maxclass" : "newobj",
																	"numinlets" : 3,
																	"numoutlets" : 2,
																	"outlettype" : [ "", "bang" ],
																	"patching_rect" : [ 11.0, 204.0, 41.0, 22.0 ],
																	"text" : "line 0."
																}

															}
, 															{
																"box" : 																{
																	"id" : "obj-6",
																	"maxclass" : "message",
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"patching_rect" : [ 11.0, 249.0, 64.0, 22.0 ],
																	"text" : "offset $1 0"
																}

															}
, 															{
																"box" : 																{
																	"id" : "obj-4",
																	"maxclass" : "newobj",
																	"numinlets" : 5,
																	"numoutlets" : 5,
																	"outlettype" : [ "bang", "bang", "bang", "bang", "" ],
																	"patching_rect" : [ 11.0, 77.0, 191.0, 22.0 ],
																	"text" : "sel 0 1 2 3"
																}

															}
, 															{
																"box" : 																{
																	"comment" : "",
																	"id" : "obj-14",
																	"index" : 1,
																	"maxclass" : "inlet",
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"outlettype" : [ "int" ],
																	"patching_rect" : [ 11.0, 17.0, 30.0, 30.0 ]
																}

															}
, 															{
																"box" : 																{
																	"comment" : "",
																	"id" : "obj-15",
																	"index" : 1,
																	"maxclass" : "outlet",
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"patching_rect" : [ 11.0, 293.0, 30.0, 30.0 ]
																}

															}
 ],
														"lines" : [ 															{
																"patchline" : 																{
																	"destination" : [ "obj-3", 0 ],
																	"midpoints" : [ 106.5, 155.5, 20.5, 155.5 ],
																	"source" : [ "obj-1", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-3", 0 ],
																	"midpoints" : [ 63.5, 155.5, 20.5, 155.5 ],
																	"source" : [ "obj-12", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-3", 0 ],
																	"midpoints" : [ 20.5, 155.5, 20.5, 155.5 ],
																	"source" : [ "obj-13", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-4", 0 ],
																	"source" : [ "obj-14", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-3", 0 ],
																	"midpoints" : [ 149.5, 162.0, 20.5, 162.0 ],
																	"source" : [ "obj-2", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-8", 0 ],
																	"source" : [ "obj-3", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-1", 0 ],
																	"source" : [ "obj-4", 2 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-12", 0 ],
																	"source" : [ "obj-4", 1 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-13", 0 ],
																	"source" : [ "obj-4", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-2", 0 ],
																	"source" : [ "obj-4", 3 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-15", 0 ],
																	"source" : [ "obj-6", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-6", 0 ],
																	"source" : [ "obj-8", 0 ]
																}

															}
 ]
													}
,
													"patching_rect" : [ 12.5, 990.0, 52.0, 22.0 ],
													"saved_object_attributes" : 													{
														"description" : "",
														"digest" : "",
														"globalpatchername" : "",
														"tags" : ""
													}
,
													"text" : "p slide"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-3",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"patching_rect" : [ 12.5, 1035.0, 67.0, 22.0 ],
													"save" : [ "#N", "thispatcher", ";", "#Q", "end", ";" ],
													"text" : "thispatcher"
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-1",
													"index" : 1,
													"maxclass" : "inlet",
													"numinlets" : 0,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"patching_rect" : [ 12.5, 945.0, 30.0, 30.0 ]
												}

											}
, 											{
												"box" : 												{
													"bgmode" : 0,
													"border" : 0,
													"clickthrough" : 0,
													"embed" : 1,
													"enablehscroll" : 0,
													"enablevscroll" : 0,
													"id" : "obj-68",
													"lockeddragscroll" : 0,
													"lockedsize" : 0,
													"maxclass" : "bpatcher",
													"numinlets" : 1,
													"numoutlets" : 0,
													"offset" : [ 0.0, 0.0 ],
													"patcher" : 													{
														"fileversion" : 1,
														"appversion" : 														{
															"major" : 8,
															"minor" : 3,
															"revision" : 2,
															"architecture" : "x64",
															"modernui" : 1
														}
,
														"classnamespace" : "box",
														"rect" : [ 35.0, 88.0, 996.0, 777.0 ],
														"bglocked" : 0,
														"openinpresentation" : 1,
														"default_fontsize" : 12.0,
														"default_fontface" : 0,
														"default_fontname" : "Arial",
														"gridonopen" : 2,
														"gridsize" : [ 5.0, 5.0 ],
														"gridsnaponopen" : 2,
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
														"assistshowspatchername" : 0,
														"boxes" : [ 															{
																"box" : 																{
																	"id" : "obj-20",
																	"maxclass" : "message",
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"patching_rect" : [ 71.0, 85.0, 55.0, 22.0 ],
																	"text" : "0, 1. 300"
																}

															}
, 															{
																"box" : 																{
																	"id" : "obj-18",
																	"maxclass" : "newobj",
																	"numinlets" : 3,
																	"numoutlets" : 2,
																	"outlettype" : [ "", "bang" ],
																	"patching_rect" : [ 71.0, 120.0, 41.0, 22.0 ],
																	"text" : "line 0."
																}

															}
, 															{
																"box" : 																{
																	"id" : "obj-15",
																	"maxclass" : "newobj",
																	"numinlets" : 1,
																	"numoutlets" : 2,
																	"outlettype" : [ "", "bang" ],
																	"patching_rect" : [ 5.0, 50.0, 85.0, 22.0 ],
																	"text" : "t l b"
																}

															}
, 															{
																"box" : 																{
																	"id" : "obj-4",
																	"maxclass" : "message",
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"patching_rect" : [ 71.0, 155.0, 101.0, 22.0 ],
																	"text" : "textcolor 0 0 0 $1"
																}

															}
, 															{
																"box" : 																{
																	"comment" : "",
																	"id" : "obj-1",
																	"index" : 1,
																	"maxclass" : "inlet",
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"patching_rect" : [ 5.0, 5.0, 30.0, 30.0 ]
																}

															}
, 															{
																"box" : 																{
																	"fontface" : 2,
																	"fontname" : "Lato",
																	"fontsize" : 14.0,
																	"id" : "obj-90",
																	"linecount" : 2,
																	"maxclass" : "comment",
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"patching_rect" : [ 5.0, 195.0, 352.0, 40.0 ],
																	"presentation" : 1,
																	"presentation_linecount" : 2,
																	"presentation_rect" : [ 5.0, 5.0, 352.0, 40.0 ],
																	"text" : "A selection of patches, abstractions and objects that assist in building and working with corpora.",
																	"textcolor" : [ 0.0, 0.0, 0.0, 1.0 ]
																}

															}
 ],
														"lines" : [ 															{
																"patchline" : 																{
																	"destination" : [ "obj-15", 0 ],
																	"source" : [ "obj-1", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-20", 0 ],
																	"source" : [ "obj-15", 1 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-90", 0 ],
																	"source" : [ "obj-15", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-4", 0 ],
																	"source" : [ "obj-18", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-18", 0 ],
																	"source" : [ "obj-20", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-90", 0 ],
																	"midpoints" : [ 80.5, 185.5, 14.5, 185.5 ],
																	"source" : [ "obj-4", 0 ]
																}

															}
 ]
													}
,
													"patching_rect" : [ 436.0, 131.0, 402.0, 289.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 422.0, 30.0, 405.0, 150.0 ],
													"viewvisibility" : 1
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-21",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 12.5, 516.0, 79.0, 22.0 ],
													"text" : "prepend help"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-18",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 12.5, 549.0, 51.0, 22.0 ],
													"text" : "pcontrol"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-10",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"patching_rect" : [ 12.5, 71.0, 41.0, 22.0 ],
													"text" : "* -410"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-2",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 12.5, 101.0, 64.0, 22.0 ],
													"text" : "offset $1 0"
												}

											}
, 											{
												"box" : 												{
													"bgmode" : 0,
													"border" : 0,
													"clickthrough" : 0,
													"embed" : 1,
													"enablehscroll" : 0,
													"enablevscroll" : 0,
													"id" : "obj-9",
													"lockeddragscroll" : 0,
													"lockedsize" : 0,
													"maxclass" : "bpatcher",
													"numinlets" : 1,
													"numoutlets" : 1,
													"offset" : [ -2050.0, 0.0 ],
													"outlettype" : [ "" ],
													"patcher" : 													{
														"fileversion" : 1,
														"appversion" : 														{
															"major" : 8,
															"minor" : 3,
															"revision" : 2,
															"architecture" : "x64",
															"modernui" : 1
														}
,
														"classnamespace" : "box",
														"rect" : [ 35.0, 88.0, 1370.0, 777.0 ],
														"bglocked" : 0,
														"openinpresentation" : 0,
														"default_fontsize" : 12.0,
														"default_fontface" : 0,
														"default_fontname" : "Arial",
														"gridonopen" : 2,
														"gridsize" : [ 5.0, 5.0 ],
														"gridsnaponopen" : 2,
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
														"assistshowspatchername" : 0,
														"boxes" : [ 															{
																"box" : 																{
																	"comment" : "",
																	"hidden" : 1,
																	"id" : "obj-1",
																	"index" : 1,
																	"maxclass" : "outlet",
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"patching_rect" : [ 0.0, 310.0, 30.0, 30.0 ]
																}

															}
, 															{
																"box" : 																{
																	"hidden" : 1,
																	"id" : "obj-3",
																	"maxclass" : "newobj",
																	"numinlets" : 1,
																	"numoutlets" : 2,
																	"outlettype" : [ "", "" ],
																	"patching_rect" : [ 40.0, 715.0, 67.0, 22.0 ],
																	"save" : [ "#N", "thispatcher", ";", "#Q", "end", ";" ],
																	"text" : "thispatcher"
																}

															}
, 															{
																"box" : 																{
																	"comment" : "",
																	"hidden" : 1,
																	"id" : "obj-2",
																	"index" : 1,
																	"maxclass" : "inlet",
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"patching_rect" : [ 40.0, 675.0, 30.0, 30.0 ]
																}

															}
, 															{
																"box" : 																{
																	"bgmode" : 0,
																	"border" : 0,
																	"clickthrough" : 0,
																	"embed" : 1,
																	"enablehscroll" : 0,
																	"enablevscroll" : 0,
																	"id" : "obj-73",
																	"lockeddragscroll" : 0,
																	"lockedsize" : 0,
																	"maxclass" : "bpatcher",
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"offset" : [ 0.0, 0.0 ],
																	"outlettype" : [ "" ],
																	"patcher" : 																	{
																		"fileversion" : 1,
																		"appversion" : 																		{
																			"major" : 8,
																			"minor" : 3,
																			"revision" : 2,
																			"architecture" : "x64",
																			"modernui" : 1
																		}
,
																		"classnamespace" : "box",
																		"rect" : [ 59.0, 106.0, 640.0, 480.0 ],
																		"bglocked" : 0,
																		"openinpresentation" : 1,
																		"default_fontsize" : 12.0,
																		"default_fontface" : 0,
																		"default_fontname" : "Arial",
																		"gridonopen" : 2,
																		"gridsize" : [ 5.0, 5.0 ],
																		"gridsnaponopen" : 2,
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
																		"assistshowspatchername" : 0,
																		"boxes" : [ 																			{
																				"box" : 																				{
																					"comment" : "",
																					"id" : "obj-2",
																					"index" : 1,
																					"maxclass" : "outlet",
																					"numinlets" : 1,
																					"numoutlets" : 0,
																					"patching_rect" : [ 92.0, 175.0, 30.0, 30.0 ]
																				}

																			}
, 																			{
																				"box" : 																				{
																					"fontname" : "Lato",
																					"id" : "obj-1",
																					"maxclass" : "comment",
																					"numinlets" : 1,
																					"numoutlets" : 0,
																					"patching_rect" : [ 231.5, 7.0, 130.0, 21.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 234.0, 6.0, 130.0, 21.0 ],
																					"text" : "Non-Realtime (buffer~)",
																					"textjustification" : 1
																				}

																			}
, 																			{
																				"box" : 																				{
																					"fontname" : "Lato",
																					"id" : "obj-13",
																					"maxclass" : "comment",
																					"numinlets" : 1,
																					"numoutlets" : 0,
																					"patching_rect" : [ 74.5, 7.0, 54.0, 21.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 72.0, 6.0, 54.0, 21.0 ],
																					"text" : "Realtime",
																					"textjustification" : 1
																				}

																			}
, 																			{
																				"box" : 																				{
																					"activebgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
																					"fontname" : "Lato",
																					"fontsize" : 12.0,
																					"id" : "obj-56",
																					"maxclass" : "live.tab",
																					"num_lines_patching" : 4,
																					"num_lines_presentation" : 4,
																					"numinlets" : 1,
																					"numoutlets" : 3,
																					"outlettype" : [ "", "", "float" ],
																					"parameter_enable" : 1,
																					"patching_rect" : [ 200.0, 30.0, 193.0, 91.5 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 200.0, 29.0, 198.0, 91.5 ],
																					"saved_attribute_attributes" : 																					{
																						"activebgoncolor" : 																						{
																							"expression" : "themecolor.live_value_bar"
																						}
,
																						"valueof" : 																						{
																							"parameter_enum" : [ "fluid.bufsines~", "fluid.buftransients~", "fluid.bufhpss~", "fluid.bufnmf~" ],
																							"parameter_longname" : "live.tab[20]",
																							"parameter_mmax" : 3,
																							"parameter_shortname" : "live.tab",
																							"parameter_type" : 2,
																							"parameter_unitstyle" : 9
																						}

																					}
,
																					"varname" : "live.tab[12]"
																				}

																			}
, 																			{
																				"box" : 																				{
																					"activebgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
																					"fontname" : "Lato",
																					"fontsize" : 12.0,
																					"id" : "obj-57",
																					"maxclass" : "live.tab",
																					"num_lines_patching" : 3,
																					"num_lines_presentation" : 3,
																					"numinlets" : 1,
																					"numoutlets" : 3,
																					"outlettype" : [ "", "", "float" ],
																					"parameter_enable" : 1,
																					"patching_rect" : [ 5.0, 30.0, 193.0, 68.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 0.0, 29.0, 198.0, 68.0 ],
																					"saved_attribute_attributes" : 																					{
																						"activebgoncolor" : 																						{
																							"expression" : "themecolor.live_value_bar"
																						}
,
																						"valueof" : 																						{
																							"parameter_enum" : [ "fluid.sines~", "fluid.transients~", "fluid.hpss~" ],
																							"parameter_longname" : "live.tab[30]",
																							"parameter_mmax" : 2,
																							"parameter_shortname" : "live.tab",
																							"parameter_type" : 2,
																							"parameter_unitstyle" : 9
																						}

																					}
,
																					"varname" : "live.tab[13]"
																				}

																			}
 ],
																		"lines" : [ 																			{
																				"patchline" : 																				{
																					"destination" : [ "obj-2", 0 ],
																					"source" : [ "obj-56", 1 ]
																				}

																			}
, 																			{
																				"patchline" : 																				{
																					"destination" : [ "obj-2", 0 ],
																					"source" : [ "obj-57", 1 ]
																				}

																			}
 ]
																	}
,
																	"patching_rect" : [ 1640.0, 0.0, 405.0, 125.0 ],
																	"viewvisibility" : 1
																}

															}
, 															{
																"box" : 																{
																	"bgmode" : 0,
																	"border" : 0,
																	"clickthrough" : 0,
																	"embed" : 1,
																	"enablehscroll" : 0,
																	"enablevscroll" : 0,
																	"id" : "obj-72",
																	"lockeddragscroll" : 0,
																	"lockedsize" : 0,
																	"maxclass" : "bpatcher",
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"offset" : [ 0.0, 0.0 ],
																	"outlettype" : [ "" ],
																	"patcher" : 																	{
																		"fileversion" : 1,
																		"appversion" : 																		{
																			"major" : 8,
																			"minor" : 3,
																			"revision" : 2,
																			"architecture" : "x64",
																			"modernui" : 1
																		}
,
																		"classnamespace" : "box",
																		"rect" : [ 35.0, 88.0, 996.0, 777.0 ],
																		"bglocked" : 0,
																		"openinpresentation" : 1,
																		"default_fontsize" : 12.0,
																		"default_fontface" : 0,
																		"default_fontname" : "Arial",
																		"gridonopen" : 2,
																		"gridsize" : [ 5.0, 5.0 ],
																		"gridsnaponopen" : 2,
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
																		"assistshowspatchername" : 0,
																		"boxes" : [ 																			{
																				"box" : 																				{
																					"comment" : "",
																					"id" : "obj-2",
																					"index" : 1,
																					"maxclass" : "outlet",
																					"numinlets" : 1,
																					"numoutlets" : 0,
																					"patching_rect" : [ 220.0, 330.0, 30.0, 30.0 ]
																				}

																			}
, 																			{
																				"box" : 																				{
																					"fontname" : "Lato",
																					"id" : "obj-64",
																					"maxclass" : "comment",
																					"numinlets" : 1,
																					"numoutlets" : 0,
																					"patching_rect" : [ 5.0, 5.0, 85.0, 21.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 56.5, 5.0, 85.0, 21.0 ],
																					"text" : "Buffer Utilities",
																					"textjustification" : 1
																				}

																			}
, 																			{
																				"box" : 																				{
																					"fontname" : "Lato",
																					"id" : "obj-63",
																					"maxclass" : "comment",
																					"numinlets" : 1,
																					"numoutlets" : 0,
																					"patching_rect" : [ 200.0, 101.0, 92.0, 21.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 253.0, 100.0, 92.0, 21.0 ],
																					"text" : "Corpus Building",
																					"textjustification" : 1
																				}

																			}
, 																			{
																				"box" : 																				{
																					"fontname" : "Lato",
																					"id" : "obj-62",
																					"maxclass" : "comment",
																					"numinlets" : 1,
																					"numoutlets" : 0,
																					"patching_rect" : [ 200.0, 5.0, 75.0, 21.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 261.5, 5.0, 75.0, 21.0 ],
																					"text" : "Visualisation",
																					"textjustification" : 1
																				}

																			}
, 																			{
																				"box" : 																				{
																					"activebgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
																					"fontname" : "Lato",
																					"fontsize" : 12.0,
																					"id" : "obj-60",
																					"maxclass" : "live.tab",
																					"num_lines_patching" : 2,
																					"num_lines_presentation" : 2,
																					"numinlets" : 1,
																					"numoutlets" : 3,
																					"outlettype" : [ "", "", "float" ],
																					"parameter_enable" : 1,
																					"patching_rect" : [ 200.0, 27.0, 197.5, 48.5 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 200.0, 27.0, 198.0, 48.5 ],
																					"saved_attribute_attributes" : 																					{
																						"activebgoncolor" : 																						{
																							"expression" : "themecolor.live_value_bar"
																						}
,
																						"valueof" : 																						{
																							"parameter_enum" : [ "fluid.bufaudiotransport~", "fluid.bufnmfcross~" ],
																							"parameter_longname" : "live.tab[35]",
																							"parameter_mmax" : 1,
																							"parameter_shortname" : "live.tab",
																							"parameter_type" : 2,
																							"parameter_unitstyle" : 9
																						}

																					}
,
																					"varname" : "live.tab[16]"
																				}

																			}
, 																			{
																				"box" : 																				{
																					"activebgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
																					"fontname" : "Lato",
																					"fontsize" : 12.0,
																					"id" : "obj-59",
																					"maxclass" : "live.tab",
																					"num_lines_patching" : 9,
																					"num_lines_presentation" : 9,
																					"numinlets" : 1,
																					"numoutlets" : 3,
																					"outlettype" : [ "", "", "float" ],
																					"parameter_enable" : 1,
																					"patching_rect" : [ 5.0, 27.0, 193.0, 216.333333194255829 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 0.0, 27.0, 198.0, 216.333333194255829 ],
																					"saved_attribute_attributes" : 																					{
																						"activebgoncolor" : 																						{
																							"expression" : "themecolor.live_value_bar"
																						}
,
																						"valueof" : 																						{
																							"parameter_enum" : [ "fluid.bufcompose~", "fluid.bufscale~", "fluid.bufthresh~", "fluid.bufselect~", "fluid.bufselectevery~", "fluid.bufflatten~", "fluid.buf2list", "fluid.list2buf", "fluid.bufresize" ],
																							"parameter_longname" : "live.tab[36]",
																							"parameter_mmax" : 8,
																							"parameter_shortname" : "live.tab",
																							"parameter_type" : 2,
																							"parameter_unitstyle" : 9
																						}

																					}
,
																					"varname" : "live.tab[15]"
																				}

																			}
, 																			{
																				"box" : 																				{
																					"activebgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
																					"fontname" : "Lato",
																					"fontsize" : 12.0,
																					"id" : "obj-58",
																					"maxclass" : "live.tab",
																					"num_lines_patching" : 2,
																					"num_lines_presentation" : 2,
																					"numinlets" : 1,
																					"numoutlets" : 3,
																					"outlettype" : [ "", "", "float" ],
																					"parameter_enable" : 1,
																					"patching_rect" : [ 200.0, 123.0, 197.5, 48.5 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 200.0, 123.0, 198.0, 48.5 ],
																					"saved_attribute_attributes" : 																					{
																						"activebgoncolor" : 																						{
																							"expression" : "themecolor.live_value_bar"
																						}
,
																						"valueof" : 																						{
																							"parameter_enum" : [ "fluid.audiofilesin", "fluid.concataudiofiles" ],
																							"parameter_longname" : "live.tab[21]",
																							"parameter_mmax" : 1,
																							"parameter_shortname" : "live.tab",
																							"parameter_type" : 2,
																							"parameter_unitstyle" : 9
																						}

																					}
,
																					"varname" : "live.tab[14]"
																				}

																			}
 ],
																		"lines" : [ 																			{
																				"patchline" : 																				{
																					"destination" : [ "obj-2", 0 ],
																					"source" : [ "obj-58", 1 ]
																				}

																			}
, 																			{
																				"patchline" : 																				{
																					"destination" : [ "obj-2", 0 ],
																					"source" : [ "obj-59", 1 ]
																				}

																			}
, 																			{
																				"patchline" : 																				{
																					"destination" : [ "obj-2", 0 ],
																					"source" : [ "obj-60", 1 ]
																				}

																			}
 ]
																	}
,
																	"patching_rect" : [ 2050.0, 0.0, 405.0, 245.5 ],
																	"viewvisibility" : 1
																}

															}
, 															{
																"box" : 																{
																	"bgmode" : 0,
																	"border" : 0,
																	"clickthrough" : 0,
																	"embed" : 1,
																	"enablehscroll" : 0,
																	"enablevscroll" : 0,
																	"id" : "obj-71",
																	"lockeddragscroll" : 0,
																	"lockedsize" : 0,
																	"maxclass" : "bpatcher",
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"offset" : [ 0.0, 0.0 ],
																	"outlettype" : [ "" ],
																	"patcher" : 																	{
																		"fileversion" : 1,
																		"appversion" : 																		{
																			"major" : 8,
																			"minor" : 3,
																			"revision" : 2,
																			"architecture" : "x64",
																			"modernui" : 1
																		}
,
																		"classnamespace" : "box",
																		"rect" : [ 59.0, 106.0, 640.0, 480.0 ],
																		"bglocked" : 0,
																		"openinpresentation" : 1,
																		"default_fontsize" : 12.0,
																		"default_fontface" : 0,
																		"default_fontname" : "Arial",
																		"gridonopen" : 2,
																		"gridsize" : [ 5.0, 5.0 ],
																		"gridsnaponopen" : 2,
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
																		"assistshowspatchername" : 0,
																		"boxes" : [ 																			{
																				"box" : 																				{
																					"comment" : "",
																					"id" : "obj-2",
																					"index" : 1,
																					"maxclass" : "outlet",
																					"numinlets" : 1,
																					"numoutlets" : 0,
																					"patching_rect" : [ 85.0, 150.0, 30.0, 30.0 ]
																				}

																			}
, 																			{
																				"box" : 																				{
																					"fontname" : "Lato",
																					"id" : "obj-1",
																					"maxclass" : "comment",
																					"numinlets" : 1,
																					"numoutlets" : 0,
																					"patching_rect" : [ 210.5, 4.0, 130.0, 21.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 234.0, 5.0, 130.0, 21.0 ],
																					"text" : "Non-Realtime (buffer~)",
																					"textjustification" : 1
																				}

																			}
, 																			{
																				"box" : 																				{
																					"fontname" : "Lato",
																					"id" : "obj-13",
																					"maxclass" : "comment",
																					"numinlets" : 1,
																					"numoutlets" : 0,
																					"patching_rect" : [ 67.5, 4.0, 54.0, 21.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 72.0, 5.0, 54.0, 21.0 ],
																					"text" : "Realtime",
																					"textjustification" : 1
																				}

																			}
, 																			{
																				"box" : 																				{
																					"activebgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
																					"fontname" : "Lato",
																					"fontsize" : 12.0,
																					"id" : "obj-9",
																					"maxclass" : "live.tab",
																					"num_lines_patching" : 2,
																					"num_lines_presentation" : 2,
																					"numinlets" : 1,
																					"numoutlets" : 3,
																					"outlettype" : [ "", "", "float" ],
																					"parameter_enable" : 1,
																					"patching_rect" : [ 186.0, 27.0, 179.0, 48.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 200.0, 28.0, 198.0, 48.0 ],
																					"saved_attribute_attributes" : 																					{
																						"activebgoncolor" : 																						{
																							"expression" : "themecolor.live_value_bar"
																						}
,
																						"valueof" : 																						{
																							"parameter_enum" : [ "fluid.bufaudiotransport~", "fluid.bufnmfcross~" ],
																							"parameter_longname" : "live.tab[31]",
																							"parameter_mmax" : 1,
																							"parameter_shortname" : "live.tab",
																							"parameter_type" : 2,
																							"parameter_unitstyle" : 9
																						}

																					}
,
																					"varname" : "live.tab[2]"
																				}

																			}
, 																			{
																				"box" : 																				{
																					"activebgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
																					"fontname" : "Lato",
																					"fontsize" : 12.0,
																					"id" : "obj-10",
																					"maxclass" : "live.tab",
																					"num_lines_patching" : 3,
																					"num_lines_presentation" : 3,
																					"numinlets" : 1,
																					"numoutlets" : 3,
																					"outlettype" : [ "", "", "float" ],
																					"parameter_enable" : 1,
																					"patching_rect" : [ 5.0, 27.0, 179.0, 74.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 0.0, 28.0, 198.0, 74.0 ],
																					"saved_attribute_attributes" : 																					{
																						"activebgoncolor" : 																						{
																							"expression" : "themecolor.live_value_bar"
																						}
,
																						"valueof" : 																						{
																							"parameter_enum" : [ "fluid.audiotransport~", "fluid.nmffilter~", "fluid.nmfmorph~" ],
																							"parameter_longname" : "live.tab[37]",
																							"parameter_mmax" : 2,
																							"parameter_shortname" : "live.tab",
																							"parameter_type" : 2,
																							"parameter_unitstyle" : 9
																						}

																					}
,
																					"varname" : "live.tab[3]"
																				}

																			}
 ],
																		"lines" : [ 																			{
																				"patchline" : 																				{
																					"destination" : [ "obj-2", 0 ],
																					"midpoints" : [ 94.5, 102.0, 94.5, 102.0 ],
																					"source" : [ "obj-10", 1 ]
																				}

																			}
, 																			{
																				"patchline" : 																				{
																					"destination" : [ "obj-2", 0 ],
																					"midpoints" : [ 275.5, 135.0, 94.5, 135.0 ],
																					"source" : [ "obj-9", 1 ]
																				}

																			}
 ]
																	}
,
																	"patching_rect" : [ 410.0, 0.0, 405.0, 105.0 ],
																	"viewvisibility" : 1
																}

															}
, 															{
																"box" : 																{
																	"bgmode" : 0,
																	"border" : 0,
																	"clickthrough" : 0,
																	"embed" : 1,
																	"enablehscroll" : 0,
																	"enablevscroll" : 0,
																	"id" : "obj-70",
																	"lockeddragscroll" : 0,
																	"lockedsize" : 0,
																	"maxclass" : "bpatcher",
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"offset" : [ 0.0, 0.0 ],
																	"outlettype" : [ "" ],
																	"patcher" : 																	{
																		"fileversion" : 1,
																		"appversion" : 																		{
																			"major" : 8,
																			"minor" : 3,
																			"revision" : 2,
																			"architecture" : "x64",
																			"modernui" : 1
																		}
,
																		"classnamespace" : "box",
																		"rect" : [ 59.0, 106.0, 640.0, 480.0 ],
																		"bglocked" : 0,
																		"openinpresentation" : 1,
																		"default_fontsize" : 12.0,
																		"default_fontface" : 0,
																		"default_fontname" : "Arial",
																		"gridonopen" : 2,
																		"gridsize" : [ 5.0, 5.0 ],
																		"gridsnaponopen" : 2,
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
																		"assistshowspatchername" : 0,
																		"boxes" : [ 																			{
																				"box" : 																				{
																					"comment" : "",
																					"id" : "obj-1",
																					"index" : 1,
																					"maxclass" : "outlet",
																					"numinlets" : 1,
																					"numoutlets" : 0,
																					"patching_rect" : [ 92.0, 400.0, 30.0, 30.0 ]
																				}

																			}
, 																			{
																				"box" : 																				{
																					"fontname" : "Lato",
																					"id" : "obj-54",
																					"maxclass" : "comment",
																					"numinlets" : 1,
																					"numoutlets" : 0,
																					"patching_rect" : [ 209.0, 195.0, 177.0, 21.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 210.5, 195.0, 177.0, 21.0 ],
																					"text" : "Supervised Machine Learning",
																					"textjustification" : 1
																				}

																			}
, 																			{
																				"box" : 																				{
																					"fontname" : "Lato",
																					"id" : "obj-53",
																					"maxclass" : "comment",
																					"numinlets" : 1,
																					"numoutlets" : 0,
																					"patching_rect" : [ 13.0, 195.0, 177.0, 21.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 8.0, 195.0, 177.0, 21.0 ],
																					"text" : "Unsupervised Machine Learning",
																					"textjustification" : 1
																				}

																			}
, 																			{
																				"box" : 																				{
																					"fontname" : "Lato",
																					"id" : "obj-52",
																					"maxclass" : "comment",
																					"numinlets" : 1,
																					"numoutlets" : 0,
																					"patching_rect" : [ 29.5, 83.0, 144.0, 21.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 24.5, 83.0, 144.0, 21.0 ],
																					"text" : "Scaling and Preprocessing",
																					"textjustification" : 1
																				}

																			}
, 																			{
																				"box" : 																				{
																					"fontname" : "Lato",
																					"id" : "obj-51",
																					"maxclass" : "comment",
																					"numinlets" : 1,
																					"numoutlets" : 0,
																					"patching_rect" : [ 222.5, 83.0, 134.0, 21.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 229.5, 83.0, 134.0, 21.0 ],
																					"text" : "Searching and Querying",
																					"textjustification" : 1
																				}

																			}
, 																			{
																				"box" : 																				{
																					"fontname" : "Lato",
																					"id" : "obj-50",
																					"maxclass" : "comment",
																					"numinlets" : 1,
																					"numoutlets" : 0,
																					"patching_rect" : [ 237.0, 5.0, 105.0, 21.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 244.0, 5.0, 105.0, 21.0 ],
																					"text" : "Statistical Analysis",
																					"textjustification" : 1
																				}

																			}
, 																			{
																				"box" : 																				{
																					"fontname" : "Lato",
																					"id" : "obj-49",
																					"maxclass" : "comment",
																					"numinlets" : 1,
																					"numoutlets" : 0,
																					"patching_rect" : [ 68.5, 5.0, 66.0, 21.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 63.5, 5.0, 66.0, 21.0 ],
																					"text" : "Containers",
																					"textjustification" : 1
																				}

																			}
, 																			{
																				"box" : 																				{
																					"activebgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
																					"fontname" : "Lato",
																					"fontsize" : 12.0,
																					"id" : "obj-47",
																					"maxclass" : "live.tab",
																					"num_lines_patching" : 6,
																					"num_lines_presentation" : 6,
																					"numinlets" : 1,
																					"numoutlets" : 3,
																					"outlettype" : [ "", "", "float" ],
																					"parameter_enable" : 1,
																					"patching_rect" : [ 5.0, 217.0, 193.0, 139.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 0.0, 217.0, 198.0, 139.0 ],
																					"saved_attribute_attributes" : 																					{
																						"activebgoncolor" : 																						{
																							"expression" : "themecolor.live_value_bar"
																						}
,
																						"valueof" : 																						{
																							"parameter_enum" : [ "fluid.pca~", "fluid.kmeans~", "fluid.skmeans~", "fluid.mds~", "fluid.umap~", "fluid.grid~" ],
																							"parameter_longname" : "live.tab[32]",
																							"parameter_mmax" : 5,
																							"parameter_shortname" : "live.tab",
																							"parameter_type" : 2,
																							"parameter_unitstyle" : 9
																						}

																					}
,
																					"varname" : "live.tab[11]"
																				}

																			}
, 																			{
																				"box" : 																				{
																					"activebgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
																					"fontname" : "Lato",
																					"fontsize" : 12.0,
																					"id" : "obj-46",
																					"maxclass" : "live.tab",
																					"num_lines_patching" : 4,
																					"num_lines_presentation" : 4,
																					"numinlets" : 1,
																					"numoutlets" : 3,
																					"outlettype" : [ "", "", "float" ],
																					"parameter_enable" : 1,
																					"patching_rect" : [ 201.0, 217.0, 193.0, 93.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 200.0, 217.0, 198.0, 93.0 ],
																					"saved_attribute_attributes" : 																					{
																						"activebgoncolor" : 																						{
																							"expression" : "themecolor.live_value_bar"
																						}
,
																						"valueof" : 																						{
																							"parameter_enum" : [ "fluid.knnregressor~", "fluid.knnclassifier~", "fluid.mlpregressor~", "fluid.mlpclassifier~" ],
																							"parameter_longname" : "live.tab[38]",
																							"parameter_mmax" : 3,
																							"parameter_shortname" : "live.tab",
																							"parameter_type" : 2,
																							"parameter_unitstyle" : 9
																						}

																					}
,
																					"varname" : "live.tab[10]"
																				}

																			}
, 																			{
																				"box" : 																				{
																					"activebgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
																					"fontname" : "Lato",
																					"fontsize" : 12.0,
																					"id" : "obj-45",
																					"maxclass" : "live.tab",
																					"num_lines_patching" : 3,
																					"num_lines_presentation" : 3,
																					"numinlets" : 1,
																					"numoutlets" : 3,
																					"outlettype" : [ "", "", "float" ],
																					"parameter_enable" : 1,
																					"patching_rect" : [ 5.0, 105.0, 193.0, 77.33333346247673 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 0.0, 105.0, 198.0, 77.33333346247673 ],
																					"saved_attribute_attributes" : 																					{
																						"activebgoncolor" : 																						{
																							"expression" : "themecolor.live_value_bar"
																						}
,
																						"valueof" : 																						{
																							"parameter_enum" : [ "fluid.normalize~", "fluid.standardize~", "fluid.robustscale~" ],
																							"parameter_longname" : "live.tab[22]",
																							"parameter_mmax" : 2,
																							"parameter_shortname" : "live.tab",
																							"parameter_type" : 2,
																							"parameter_unitstyle" : 9
																						}

																					}
,
																					"varname" : "live.tab[9]"
																				}

																			}
, 																			{
																				"box" : 																				{
																					"activebgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
																					"fontname" : "Lato",
																					"fontsize" : 12.0,
																					"id" : "obj-44",
																					"maxclass" : "live.tab",
																					"num_lines_patching" : 2,
																					"num_lines_presentation" : 2,
																					"numinlets" : 1,
																					"numoutlets" : 3,
																					"outlettype" : [ "", "", "float" ],
																					"parameter_enable" : 1,
																					"patching_rect" : [ 200.0, 105.0, 193.0, 51.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 199.0, 105.0, 199.0, 51.0 ],
																					"saved_attribute_attributes" : 																					{
																						"activebgoncolor" : 																						{
																							"expression" : "themecolor.live_value_bar"
																						}
,
																						"valueof" : 																						{
																							"parameter_enum" : [ "fluid.kdtree~", "fluid.datasetquery~" ],
																							"parameter_longname" : "live.tab[33]",
																							"parameter_mmax" : 1,
																							"parameter_shortname" : "live.tab",
																							"parameter_type" : 2,
																							"parameter_unitstyle" : 9
																						}

																					}
,
																					"varname" : "live.tab[8]"
																				}

																			}
, 																			{
																				"box" : 																				{
																					"activebgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
																					"fontname" : "Lato",
																					"fontsize" : 12.0,
																					"id" : "obj-43",
																					"maxclass" : "live.tab",
																					"num_lines_patching" : 2,
																					"num_lines_presentation" : 2,
																					"numinlets" : 1,
																					"numoutlets" : 3,
																					"outlettype" : [ "", "", "float" ],
																					"parameter_enable" : 1,
																					"patching_rect" : [ 201.0, 27.0, 193.0, 48.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 200.0, 27.0, 198.0, 48.0 ],
																					"saved_attribute_attributes" : 																					{
																						"activebgoncolor" : 																						{
																							"expression" : "themecolor.live_value_bar"
																						}
,
																						"valueof" : 																						{
																							"parameter_enum" : [ "fluid.bufstats~", "fluid.stats" ],
																							"parameter_longname" : "live.tab[39]",
																							"parameter_mmax" : 1,
																							"parameter_shortname" : "live.tab",
																							"parameter_type" : 2,
																							"parameter_unitstyle" : 9
																						}

																					}
,
																					"varname" : "live.tab[7]"
																				}

																			}
, 																			{
																				"box" : 																				{
																					"activebgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
																					"fontname" : "Lato",
																					"fontsize" : 12.0,
																					"id" : "obj-42",
																					"maxclass" : "live.tab",
																					"num_lines_patching" : 2,
																					"num_lines_presentation" : 2,
																					"numinlets" : 1,
																					"numoutlets" : 3,
																					"outlettype" : [ "", "", "float" ],
																					"parameter_enable" : 1,
																					"patching_rect" : [ 5.0, 27.0, 193.0, 48.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 0.0, 27.0, 198.0, 48.0 ],
																					"saved_attribute_attributes" : 																					{
																						"activebgoncolor" : 																						{
																							"expression" : "themecolor.live_value_bar"
																						}
,
																						"valueof" : 																						{
																							"parameter_enum" : [ "fluid.dataset~", "fluid.labelset~" ],
																							"parameter_longname" : "live.tab[40]",
																							"parameter_mmax" : 1,
																							"parameter_shortname" : "live.tab",
																							"parameter_type" : 2,
																							"parameter_unitstyle" : 9
																						}

																					}
,
																					"varname" : "live.tab[6]"
																				}

																			}
 ],
																		"lines" : [ 																			{
																				"patchline" : 																				{
																					"destination" : [ "obj-1", 0 ],
																					"midpoints" : [ 101.5, 78.0, 15.0, 78.0, 15.0, 90.0, 0.0, 90.0, 0.0, 387.0, 101.5, 387.0 ],
																					"source" : [ "obj-42", 1 ]
																				}

																			}
, 																			{
																				"patchline" : 																				{
																					"destination" : [ "obj-1", 0 ],
																					"midpoints" : [ 297.5, 78.0, 366.0, 78.0, 366.0, 90.0, 405.0, 90.0, 405.0, 387.0, 101.5, 387.0 ],
																					"source" : [ "obj-43", 1 ]
																				}

																			}
, 																			{
																				"patchline" : 																				{
																					"destination" : [ "obj-1", 0 ],
																					"midpoints" : [ 296.5, 180.0, 198.0, 180.0, 198.0, 387.0, 101.5, 387.0 ],
																					"source" : [ "obj-44", 1 ]
																				}

																			}
, 																			{
																				"patchline" : 																				{
																					"destination" : [ "obj-1", 0 ],
																					"midpoints" : [ 101.5, 192.0, 0.0, 192.0, 0.0, 387.0, 101.5, 387.0 ],
																					"source" : [ "obj-45", 1 ]
																				}

																			}
, 																			{
																				"patchline" : 																				{
																					"destination" : [ "obj-1", 0 ],
																					"midpoints" : [ 297.5, 387.0, 101.5, 387.0 ],
																					"source" : [ "obj-46", 1 ]
																				}

																			}
, 																			{
																				"patchline" : 																				{
																					"destination" : [ "obj-1", 0 ],
																					"midpoints" : [ 101.5, 357.0, 101.5, 357.0 ],
																					"source" : [ "obj-47", 1 ]
																				}

																			}
 ]
																	}
,
																	"patching_rect" : [ 1230.0, 0.0, 405.0, 360.0 ],
																	"viewvisibility" : 1
																}

															}
, 															{
																"box" : 																{
																	"bgmode" : 0,
																	"border" : 0,
																	"clickthrough" : 0,
																	"embed" : 1,
																	"enablehscroll" : 0,
																	"enablevscroll" : 0,
																	"id" : "obj-69",
																	"lockeddragscroll" : 0,
																	"lockedsize" : 0,
																	"maxclass" : "bpatcher",
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"offset" : [ 0.0, 0.0 ],
																	"outlettype" : [ "" ],
																	"patcher" : 																	{
																		"fileversion" : 1,
																		"appversion" : 																		{
																			"major" : 8,
																			"minor" : 3,
																			"revision" : 2,
																			"architecture" : "x64",
																			"modernui" : 1
																		}
,
																		"classnamespace" : "box",
																		"rect" : [ 35.0, 88.0, 1370.0, 777.0 ],
																		"bglocked" : 0,
																		"openinpresentation" : 1,
																		"default_fontsize" : 12.0,
																		"default_fontface" : 0,
																		"default_fontname" : "Arial",
																		"gridonopen" : 2,
																		"gridsize" : [ 5.0, 5.0 ],
																		"gridsnaponopen" : 2,
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
																		"assistshowspatchername" : 0,
																		"boxes" : [ 																			{
																				"box" : 																				{
																					"comment" : "",
																					"id" : "obj-1",
																					"index" : 1,
																					"maxclass" : "outlet",
																					"numinlets" : 1,
																					"numoutlets" : 0,
																					"patching_rect" : [ 84.0, 325.0, 30.0, 30.0 ]
																				}

																			}
, 																			{
																				"box" : 																				{
																					"fontname" : "Lato",
																					"id" : "obj-6",
																					"maxclass" : "comment",
																					"numinlets" : 1,
																					"numoutlets" : 0,
																					"patching_rect" : [ 208.5, 5.0, 130.0, 21.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 234.0, 5.0, 130.0, 21.0 ],
																					"text" : "Non-Realtime (buffer~)",
																					"textjustification" : 1
																				}

																			}
, 																			{
																				"box" : 																				{
																					"fontname" : "Lato",
																					"id" : "obj-12",
																					"maxclass" : "comment",
																					"numinlets" : 1,
																					"numoutlets" : 0,
																					"patching_rect" : [ 66.5, 5.0, 54.0, 21.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 72.0, 5.0, 54.0, 21.0 ],
																					"text" : "Realtime",
																					"textjustification" : 1
																				}

																			}
, 																			{
																				"box" : 																				{
																					"activebgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
																					"fontname" : "Lato",
																					"fontsize" : 12.0,
																					"id" : "obj-41",
																					"maxclass" : "live.tab",
																					"num_lines_patching" : 11,
																					"num_lines_presentation" : 11,
																					"numinlets" : 1,
																					"numoutlets" : 3,
																					"outlettype" : [ "", "", "float" ],
																					"parameter_enable" : 1,
																					"patching_rect" : [ 185.0, 28.0, 177.0, 270.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 200.0, 28.0, 198.0, 252.5 ],
																					"saved_attribute_attributes" : 																					{
																						"activebgoncolor" : 																						{
																							"expression" : "themecolor.live_value_bar"
																						}
,
																						"valueof" : 																						{
																							"parameter_enum" : [ "fluid.bufpitch~", "fluid.bufloudness~", "fluid.bufmelbands~", "fluid.bufmfcc~", "fluid.bufspectralshape~", "fluid.bufchroma~", "fluid.bufnmfseed~", "fluid.bufstft~", "fluid.bufampfeature~", "fluid.bufonsetfeature~", "fluid.bufnoveltyfeature~" ],
																							"parameter_longname" : "live.tab[23]",
																							"parameter_mmax" : 10,
																							"parameter_shortname" : "live.tab",
																							"parameter_type" : 2,
																							"parameter_unitstyle" : 9
																						}

																					}
,
																					"varname" : "live.tab[5]"
																				}

																			}
, 																			{
																				"box" : 																				{
																					"activebgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
																					"fontname" : "Lato",
																					"fontsize" : 12.0,
																					"id" : "obj-40",
																					"maxclass" : "live.tab",
																					"num_lines_patching" : 10,
																					"num_lines_presentation" : 10,
																					"numinlets" : 1,
																					"numoutlets" : 3,
																					"outlettype" : [ "", "", "float" ],
																					"parameter_enable" : 1,
																					"patching_rect" : [ 4.0, 28.0, 179.0, 245.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 0.0, 28.0, 198.0, 229.0 ],
																					"saved_attribute_attributes" : 																					{
																						"activebgoncolor" : 																						{
																							"expression" : "themecolor.live_value_bar"
																						}
,
																						"valueof" : 																						{
																							"parameter_enum" : [ "fluid.pitch~", "fluid.loudness~", "fluid.melbands~", "fluid.mfcc~", "fluid.spectralshape~", "fluid.chroma~", "fluid.nmfmatch~", "fluid.ampfeature~", "fluid.onsetfeature~", "fluid.noveltyfeature~" ],
																							"parameter_longname" : "live.tab[34]",
																							"parameter_mmax" : 9,
																							"parameter_shortname" : "live.tab",
																							"parameter_type" : 2,
																							"parameter_unitstyle" : 9
																						}

																					}
,
																					"varname" : "live.tab[4]"
																				}

																			}
 ],
																		"lines" : [ 																			{
																				"patchline" : 																				{
																					"destination" : [ "obj-1", 0 ],
																					"source" : [ "obj-40", 1 ]
																				}

																			}
, 																			{
																				"patchline" : 																				{
																					"destination" : [ "obj-1", 0 ],
																					"midpoints" : [ 273.5, 311.0, 93.5, 311.0 ],
																					"source" : [ "obj-41", 1 ]
																				}

																			}
 ]
																	}
,
																	"patching_rect" : [ 820.0, 0.0, 405.0, 285.0 ],
																	"viewvisibility" : 1
																}

															}
, 															{
																"box" : 																{
																	"bgmode" : 0,
																	"border" : 0,
																	"clickthrough" : 0,
																	"embed" : 1,
																	"enablehscroll" : 0,
																	"enablevscroll" : 0,
																	"id" : "obj-68",
																	"lockeddragscroll" : 0,
																	"lockedsize" : 0,
																	"maxclass" : "bpatcher",
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"offset" : [ 0.0, 0.0 ],
																	"outlettype" : [ "" ],
																	"patcher" : 																	{
																		"fileversion" : 1,
																		"appversion" : 																		{
																			"major" : 8,
																			"minor" : 3,
																			"revision" : 2,
																			"architecture" : "x64",
																			"modernui" : 1
																		}
,
																		"classnamespace" : "box",
																		"rect" : [ 59.0, 106.0, 640.0, 480.0 ],
																		"bglocked" : 0,
																		"openinpresentation" : 1,
																		"default_fontsize" : 12.0,
																		"default_fontface" : 0,
																		"default_fontname" : "Arial",
																		"gridonopen" : 2,
																		"gridsize" : [ 5.0, 5.0 ],
																		"gridsnaponopen" : 2,
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
																		"assistshowspatchername" : 0,
																		"boxes" : [ 																			{
																				"box" : 																				{
																					"fontname" : "Lato",
																					"id" : "obj-6",
																					"maxclass" : "comment",
																					"numinlets" : 1,
																					"numoutlets" : 0,
																					"patching_rect" : [ 209.5, 5.0, 130.0, 21.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 234.0, 5.0, 130.0, 21.0 ],
																					"text" : "Non-Realtime (buffer~)",
																					"textjustification" : 1
																				}

																			}
, 																			{
																				"box" : 																				{
																					"comment" : "",
																					"id" : "obj-5",
																					"index" : 1,
																					"maxclass" : "outlet",
																					"numinlets" : 1,
																					"numoutlets" : 0,
																					"patching_rect" : [ 85.0, 195.0, 30.0, 30.0 ]
																				}

																			}
, 																			{
																				"box" : 																				{
																					"fontname" : "Lato",
																					"id" : "obj-12",
																					"maxclass" : "comment",
																					"numinlets" : 1,
																					"numoutlets" : 0,
																					"patching_rect" : [ 66.5, 5.0, 54.0, 21.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 72.0, 5.0, 54.0, 21.0 ],
																					"text" : "Realtime",
																					"textjustification" : 1
																				}

																			}
, 																			{
																				"box" : 																				{
																					"activebgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
																					"fontname" : "Lato",
																					"fontsize" : 12.0,
																					"id" : "obj-1",
																					"maxclass" : "live.tab",
																					"num_lines_patching" : 5,
																					"num_lines_presentation" : 5,
																					"numinlets" : 1,
																					"numoutlets" : 3,
																					"outlettype" : [ "", "", "float" ],
																					"parameter_enable" : 1,
																					"patching_rect" : [ 186.0, 27.0, 177.0, 122.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 200.0, 28.0, 198.0, 122.0 ],
																					"saved_attribute_attributes" : 																					{
																						"activebgoncolor" : 																						{
																							"expression" : "themecolor.live_value_bar"
																						}
,
																						"valueof" : 																						{
																							"parameter_enum" : [ "fluid.bufonsetslice~", "fluid.bufnoveltyslice~", "fluid.buftransientslice~", "fluid.bufampslice~", "fluid.bufampgate~" ],
																							"parameter_longname" : "live.tab[41]",
																							"parameter_mmax" : 4,
																							"parameter_shortname" : "live.tab",
																							"parameter_type" : 2,
																							"parameter_unitstyle" : 9
																						}

																					}
,
																					"varname" : "live.tab[1]"
																				}

																			}
, 																			{
																				"box" : 																				{
																					"activebgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
																					"fontname" : "Lato",
																					"fontsize" : 12.0,
																					"id" : "obj-3",
																					"maxclass" : "live.tab",
																					"num_lines_patching" : 5,
																					"num_lines_presentation" : 5,
																					"numinlets" : 1,
																					"numoutlets" : 3,
																					"outlettype" : [ "", "", "float" ],
																					"parameter_enable" : 1,
																					"patching_rect" : [ 5.0, 27.0, 179.0, 122.0 ],
																					"presentation" : 1,
																					"presentation_rect" : [ 0.0, 28.0, 198.0, 122.0 ],
																					"saved_attribute_attributes" : 																					{
																						"activebgoncolor" : 																						{
																							"expression" : "themecolor.live_value_bar"
																						}
,
																						"valueof" : 																						{
																							"parameter_enum" : [ "fluid.onsetslice~", "fluid.noveltyslice~", "fluid.transientslice~", "fluid.ampslice~", "fluid.ampgate~" ],
																							"parameter_longname" : "live.tab[42]",
																							"parameter_mmax" : 4,
																							"parameter_shortname" : "live.tab",
																							"parameter_type" : 2,
																							"parameter_unitstyle" : 9
																						}

																					}
,
																					"varname" : "live.tab"
																				}

																			}
 ],
																		"lines" : [ 																			{
																				"patchline" : 																				{
																					"destination" : [ "obj-5", 0 ],
																					"midpoints" : [ 274.5, 180.0, 94.5, 180.0 ],
																					"source" : [ "obj-1", 1 ]
																				}

																			}
, 																			{
																				"patchline" : 																				{
																					"destination" : [ "obj-5", 0 ],
																					"midpoints" : [ 94.5, 150.0, 94.5, 150.0 ],
																					"source" : [ "obj-3", 1 ]
																				}

																			}
 ]
																	}
,
																	"patching_rect" : [ 0.0, 0.0, 405.0, 155.0 ],
																	"viewvisibility" : 1
																}

															}
 ],
														"lines" : [ 															{
																"patchline" : 																{
																	"destination" : [ "obj-3", 0 ],
																	"hidden" : 1,
																	"source" : [ "obj-2", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-1", 0 ],
																	"hidden" : 1,
																	"midpoints" : [ 9.5, 156.0, 9.5, 156.0 ],
																	"source" : [ "obj-68", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-1", 0 ],
																	"hidden" : 1,
																	"midpoints" : [ 829.5, 297.0, 9.5, 297.0 ],
																	"source" : [ "obj-69", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-1", 0 ],
																	"hidden" : 1,
																	"midpoints" : [ 1239.5, 363.0, 42.0, 363.0, 42.0, 297.0, 9.5, 297.0 ],
																	"source" : [ "obj-70", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-1", 0 ],
																	"hidden" : 1,
																	"midpoints" : [ 419.5, 297.0, 9.5, 297.0 ],
																	"source" : [ "obj-71", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-1", 0 ],
																	"hidden" : 1,
																	"midpoints" : [ 2059.5, 372.0, 42.0, 372.0, 42.0, 297.0, 9.5, 297.0 ],
																	"source" : [ "obj-72", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-1", 0 ],
																	"hidden" : 1,
																	"midpoints" : [ 1649.5, 372.0, 42.0, 372.0, 42.0, 297.0, 9.5, 297.0 ],
																	"source" : [ "obj-73", 0 ]
																}

															}
 ]
													}
,
													"patching_rect" : [ 12.5, 131.0, 410.0, 374.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 15.0, 135.0, 405.0, 373.0 ],
													"viewvisibility" : 1
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-96",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patcher" : 													{
														"fileversion" : 1,
														"appversion" : 														{
															"major" : 8,
															"minor" : 3,
															"revision" : 2,
															"architecture" : "x64",
															"modernui" : 1
														}
,
														"classnamespace" : "box",
														"rect" : [ 59.0, 106.0, 640.0, 480.0 ],
														"bglocked" : 0,
														"openinpresentation" : 0,
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
														"assistshowspatchername" : 0,
														"boxes" : [ 															{
																"box" : 																{
																	"id" : "obj-85",
																	"maxclass" : "newobj",
																	"numinlets" : 1,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"patching_rect" : [ 137.5, 180.0, 72.0, 22.0 ],
																	"text" : "prepend set"
																}

															}
, 															{
																"box" : 																{
																	"id" : "obj-84",
																	"maxclass" : "newobj",
																	"numinlets" : 2,
																	"numoutlets" : 2,
																	"outlettype" : [ "", "" ],
																	"patching_rect" : [ 101.666666666666657, 144.0, 55.0, 22.0 ],
																	"text" : "zl.slice 1"
																}

															}
, 															{
																"box" : 																{
																	"id" : "obj-83",
																	"maxclass" : "newobj",
																	"numinlets" : 1,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"patching_rect" : [ 50.0, 75.0, 73.0, 22.0 ],
																	"text" : "prepend get"
																}

															}
, 															{
																"box" : 																{
																	"data" : 																	{
																		"Slice Audio" : "Slicing, segmenting, chopping, or dividing. These words all refer to the same type of process in which a sound is separated into 'chunks' or 'slices' across time. Each of these objects embodies a different model of listening for identifying 'slice points'. In other words, different types of change can be measured and used to determine how to segment a sound.",
																		"Transform Audio" : "These objects offer some strategies for hybridising and transforming sounds using both unsupervised and semi-supervised machine learning.",
																		"Analyse Audio" : "The foundation of many sound corpora workflows is to first analyse the corpus using audio-descriptors. This collection of objects encapsulate several useful algorithms for doing this in realtime and in non-realtime using buffers~.",
																		"Analyse Data" : "If you have some corpus data, you'll probably want to analyse, manipulate and transform it. A variety of objects fall under this category and help you to make different manoeuvres around your data.",
																		"Decompose Audio" : "What is 'inside' a sound? Can they be unmixed? What components might exist unheard to the human ear? This suite of objects all help to answer these questions by deconstructing sounds.",
																		"Helpers and Utilites" : "A selection of patches, abstractions and objects that assist in building and working with corpora."
																	}
,
																	"id" : "obj-80",
																	"maxclass" : "newobj",
																	"numinlets" : 2,
																	"numoutlets" : 4,
																	"outlettype" : [ "dictionary", "", "", "" ],
																	"patching_rect" : [ 50.0, 112.0, 174.0, 22.0 ],
																	"saved_object_attributes" : 																	{
																		"embed" : 1,
																		"parameter_enable" : 0,
																		"parameter_mappable" : 0
																	}
,
																	"text" : "dict fluid-categories @embed 1"
																}

															}
, 															{
																"box" : 																{
																	"comment" : "",
																	"id" : "obj-94",
																	"index" : 1,
																	"maxclass" : "inlet",
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"patching_rect" : [ 50.0, 30.0, 30.0, 30.0 ]
																}

															}
, 															{
																"box" : 																{
																	"comment" : "",
																	"id" : "obj-95",
																	"index" : 1,
																	"maxclass" : "outlet",
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"patching_rect" : [ 137.5, 211.0, 30.0, 30.0 ]
																}

															}
 ],
														"lines" : [ 															{
																"patchline" : 																{
																	"destination" : [ "obj-84", 0 ],
																	"source" : [ "obj-80", 1 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-80", 0 ],
																	"source" : [ "obj-83", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-85", 0 ],
																	"source" : [ "obj-84", 1 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-95", 0 ],
																	"source" : [ "obj-85", 0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"destination" : [ "obj-83", 0 ],
																	"source" : [ "obj-94", 0 ]
																}

															}
 ]
													}
,
													"patching_rect" : [ 436.0, 92.0, 154.0, 22.0 ],
													"saved_object_attributes" : 													{
														"description" : "",
														"digest" : "",
														"globalpatchername" : "",
														"tags" : ""
													}
,
													"text" : "p \"get category description\""
												}

											}
, 											{
												"box" : 												{
													"activebgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
													"bgoncolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
													"fontname" : "Lato",
													"fontsize" : 14.0,
													"id" : "obj-75",
													"maxclass" : "live.tab",
													"num_lines_patching" : 2,
													"num_lines_presentation" : 3,
													"numinlets" : 1,
													"numoutlets" : 3,
													"outlettype" : [ "", "", "float" ],
													"parameter_enable" : 1,
													"patching_rect" : [ 12.5, 17.0, 528.5, 46.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 15.0, 37.0, 405.0, 76.0 ],
													"saved_attribute_attributes" : 													{
														"activebgoncolor" : 														{
															"expression" : "themecolor.live_value_arc"
														}
,
														"bgoncolor" : 														{
															"expression" : "themecolor.live_value_arc"
														}
,
														"valueof" : 														{
															"parameter_enum" : [ "Slice Audio", "Transform Audio", "Analyse Audio", "Analyse Data", "Decompose Audio", "Helpers and Utilites" ],
															"parameter_longname" : "live.tab[24]",
															"parameter_mmax" : 5,
															"parameter_shortname" : "live.tab[17]",
															"parameter_type" : 2,
															"parameter_unitstyle" : 9
														}

													}
,
													"varname" : "live.tab"
												}

											}
 ],
										"lines" : [ 											{
												"patchline" : 												{
													"destination" : [ "obj-16", 0 ],
													"source" : [ "obj-1", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-2", 0 ],
													"source" : [ "obj-10", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-14", 0 ],
													"midpoints" : [ 879.5, 393.0, 879.5, 393.0 ],
													"source" : [ "obj-13", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-59", 0 ],
													"midpoints" : [ 879.5, 429.0, 879.5, 429.0 ],
													"source" : [ "obj-14", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-60", 0 ],
													"midpoints" : [ 892.0, 450.0, 1044.5, 450.0 ],
													"source" : [ "obj-14", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-3", 0 ],
													"source" : [ "obj-16", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-9", 0 ],
													"source" : [ "obj-2", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-18", 0 ],
													"source" : [ "obj-21", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-38", 1 ],
													"midpoints" : [ 879.5, 345.0, 855.0, 345.0, 855.0, 450.0, 908.5, 450.0 ],
													"order" : 1,
													"source" : [ "obj-23", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-41", 0 ],
													"source" : [ "obj-23", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-49", 1 ],
													"midpoints" : [ 879.5, 345.0, 855.0, 345.0, 855.0, 450.0, 1073.5, 450.0 ],
													"order" : 0,
													"source" : [ "obj-23", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-43", 1 ],
													"midpoints" : [ 2499.5, 393.0, 2475.0, 393.0, 2475.0, 543.0, 2738.5, 543.0 ],
													"order" : 0,
													"source" : [ "obj-25", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-45", 1 ],
													"midpoints" : [ 2499.5, 393.0, 2475.0, 393.0, 2475.0, 543.0, 2528.5, 543.0 ],
													"order" : 1,
													"source" : [ "obj-25", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-40", 0 ],
													"midpoints" : [ 2512.0, 497.0, 2709.5, 497.0 ],
													"source" : [ "obj-31", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-45", 0 ],
													"midpoints" : [ 2499.5, 477.0, 2499.5, 477.0 ],
													"source" : [ "obj-31", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-31", 0 ],
													"midpoints" : [ 2499.5, 440.0, 2499.5, 440.0 ],
													"source" : [ "obj-32", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-52", 1 ],
													"midpoints" : [ 2709.5, 690.0, 2885.5, 690.0 ],
													"source" : [ "obj-34", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-34", 0 ],
													"source" : [ "obj-36", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-54", 0 ],
													"source" : [ "obj-38", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-44", 0 ],
													"source" : [ "obj-39", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-43", 0 ],
													"midpoints" : [ 2709.5, 534.0, 2709.5, 534.0 ],
													"source" : [ "obj-40", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-35", 0 ],
													"midpoints" : [ 997.5, 339.0, 1130.0, 339.0, 1130.0, 126.0, 1149.5, 126.0 ],
													"source" : [ "obj-41", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-39", 0 ],
													"source" : [ "obj-42", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-36", 0 ],
													"source" : [ "obj-43", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-42", 0 ],
													"source" : [ "obj-45", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-5", 0 ],
													"source" : [ "obj-49", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-6", 0 ],
													"source" : [ "obj-5", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-44", 0 ],
													"midpoints" : [ 2709.5, 780.0, 2499.5, 780.0 ],
													"source" : [ "obj-52", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-61", 0 ],
													"source" : [ "obj-54", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-38", 0 ],
													"source" : [ "obj-59", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-7", 0 ],
													"source" : [ "obj-6", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-49", 0 ],
													"source" : [ "obj-60", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-47", 0 ],
													"source" : [ "obj-61", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-62", 0 ],
													"source" : [ "obj-7", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-10", 0 ],
													"source" : [ "obj-75", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-96", 0 ],
													"midpoints" : [ 276.75, 77.0, 445.5, 77.0 ],
													"source" : [ "obj-75", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-21", 0 ],
													"source" : [ "obj-9", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-68", 0 ],
													"source" : [ "obj-96", 0 ]
												}

											}
 ]
									}
,
									"patching_rect" : [ 15.0, 225.0, 795.0, 450.0 ],
									"presentation" : 1,
									"presentation_rect" : [ 15.0, 232.0, 795.0, 502.0 ],
									"viewvisibility" : 1
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-22",
									"justification" : 1,
									"maxclass" : "live.line",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 420.0, 95.0, 5.0, 100.0 ],
									"presentation" : 1,
									"presentation_rect" : [ 15.0, 225.0, 795.0, 5.0 ]
								}

							}
, 							{
								"box" : 								{
									"contrastactivetab" : 0,
									"fontface" : 0,
									"fontname" : "Lato",
									"fontsize" : 20.0,
									"htabcolor" : [ 0.427450980392157, 0.843137254901961, 1.0, 1.0 ],
									"id" : "obj-11",
									"maxclass" : "tab",
									"multiline" : 0,
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "int", "", "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 15.0, 135.0, 393.5, 60.0 ],
									"presentation" : 1,
									"presentation_rect" : [ 15.0, 165.0, 795.0, 45.0 ],
									"rounded" : 2.0,
									"saved_attribute_attributes" : 									{
										"htabcolor" : 										{
											"expression" : "themecolor.live_value_arc"
										}
,
										"tabcolor" : 										{
											"expression" : "themecolor.live_control_bg"
										}

									}
,
									"spacing_y" : 0.0,
									"tabcolor" : [ 0.647058823529412, 0.647058823529412, 0.647058823529412, 1.0 ],
									"tabs" : [ "Objects", "Tutorials", "Examples", "Musical Inspiration" ],
									"textcolor" : [ 0.0, 0.0, 0.0, 1.0 ],
									"valign" : 2
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-4",
									"linecount" : 2,
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 194.000000000000114, 925.0, 129.0, 35.0 ],
									"text" : ";\rmax launchbrowser $1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-5",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "https://learn.flucoma.org" ],
									"patching_rect" : [ 194.000000000000114, 899.0, 144.0, 22.0 ],
									"text" : "t https://learn.flucoma.org"
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 0.301961, 0.301961, 0.301961, 1.0 ],
									"bgcolor2" : [ 0.301961, 0.301961, 0.301961, 1.0 ],
									"bgfillcolor_angle" : 270.0,
									"bgfillcolor_autogradient" : 0.0,
									"bgfillcolor_color" : [ 0.2, 0.2, 0.2, 0.0 ],
									"bgfillcolor_color1" : [ 0.301961, 0.301961, 0.301961, 1.0 ],
									"bgfillcolor_color2" : [ 0.2, 0.2, 0.2, 1.0 ],
									"bgfillcolor_proportion" : 0.5,
									"bgfillcolor_type" : "color",
									"fontname" : "Lato",
									"fontsize" : 16.0,
									"gradient" : 1,
									"id" : "obj-1",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 194.000000000000114, 851.0, 107.0, 28.0 ],
									"presentation" : 1,
									"presentation_rect" : [ 538.0, 87.0, 107.0, 28.0 ],
									"text" : "learn platform",
									"textcolor" : [ 0.321569, 0.54902, 0.792157, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"fontname" : "Lato",
									"fontsize" : 16.0,
									"id" : "obj-3",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 15.0, 810.0, 192.0, 26.0 ],
									"presentation" : 1,
									"presentation_rect" : [ 435.0, 88.0, 107.0, 26.0 ],
									"text" : "Check out the"
								}

							}
, 							{
								"box" : 								{
									"autofit" : 1,
									"data" : [ 17921, "png", "IBkSG0fBZn....PCIgDQRA..B7C....xHX....vAjB3u....DLmPIQEBHf.B7g.YHB..f.PRDEDU3wY68tGdbUceu2e+slQVWrIRFYrwfERFHxbWiCMgiTRiEUjlPK9HklDng1mJol1xAROGjOzSoMusGDOouog1Ps3smFZtz5woMzfOIEQwgFBwfbvXykDrLXRvl.R1VAvFD1BaqKVZ1q2+XM6Y1yn8L60Lydl8dOyuOOO1RZV6YuWyZFo028uqDXp34N2irEfEZA.cRRz.HJB..QzFz8bHMj6CDNAA43F.iCfQ.BO98zNMdQXJyvvvvvj2Pd8DfozyWXWyEwPDpS.zIfrSRHpuXcsjFFSAPi.fQDFwF4K8Qpdzh00hgggggQGXwOUHnD7H5CD5gHQyd07PJMNDjXXggQTVHDCCCCiW.K9oLl65IkMLW0w5Cjb.uTvSlPIDhFp54BE8tuV5Dd87gggggox.V7SYH20SJaX1ZVX.RhAJltzxsPZXLkjvP0La3gXQPLLLLLEaXwOkY7ms6EF.PNXPPzS5vhfXXXXXJEvheJS3tdRYCyUSrgykLzxuhTZbHIPe2S6UMhWOWXXXXXJ+fE+TFvWXWyEwHjXX+Xb8THHMLtupmK7frUfXXXXXbSXwOAbty8HagjKLZPzMW5fzPtOgQr93LCiggggwsP30S.lBCRFa3xUgO..jfZyPHF4Krq4h30yEFFFFlxCXwOAXty8rPejfZyqmGEaHgndY3v68N2yB840yEFFFFlfOr3m.LjDC30ygRIBh1BK.hggggoPgE+DfoRvpOoCK.hggggoPgE+vD3fE.wvvvvTHvheXBjnD.Memd87fggggI3AK9I.izPtOudN3kPRLLmEXLLLLL4Jr3m.LRBC40yAuDRHp2HjX365IkM30yEFFFFlfCr3m.L2S6giVwa8GRz7b0DaXuddvvvvvDbfE+DvQXDqOogwTd87vKgHZC24dlePuddvvvvvDLfauEkA7E10bQLDhQJmqzy5.svBqmaCFLLLLLNAa4mx.9RejpGUXXzYktEf33+gggggQGXwOkI7k9HUOZ0yEtEoTtSudt3UPjn44pdgA854ACCCCi+F1sWkg7ms6EF.PNXkpavX2ewvvvvjMXK+TFxWtivCU8bgaARis50yEu.iPgpnKA.LLLLLYG1xOk4bm6Q1h.KLHHQud8boThgT1+8zd3nd87fggggw+AK9oBgJMQPRowg9xsWUKd87fggggw+AK9oBi65IkMLW0w5Cjb.hDM60ymhIRC4l9xcDlcAFCCCCSJvheJ.1+DiEA.QN1jm3ZdrmZuW6yL5Auvm6kN.Vw66rdhi73eqOgWO+bh6bOy2o.nOoD8TNFbzRCio9xcTEm56LLLLLo.K9QS16Xi0PnPnS.zIQHBQzFdhmc+3Id18iGdGOGfTBHM.jRHkKrdruGMPksQ+4O878.A5obSHDG6OLLLLLoCK9ICr2wFqEHPmDQcR.cRBpY.IN0omE+qe+cgG9I9o3MN1jwE8jT3CLhcH4n+Gs30y+BgxIgPbr+vvvvvjNr3m3nD6H5zfjcR.cJHJQ7vP.3Md6Sf+w+uOA9O14OEvPB.iTE8D+6kxXaBuvCW1DmIkEBghY7I+q+vUwM+TFFFFF.TgK944GarNAQ8PD0IQTalKFTh+Sh27sOA9G+difGYmiB.ijBexf.H47yuVruGdbO4ETQlfpPHog7g+xcDtGuddvvvvv3OnhS7yyL1g6QPnGIPOgDT8.R.j5BAAfSN8r3q+P+X7.+fmMUANYS.jgwgj+juaKk7WTkXtqmT1vr0DqGRhdHA0sWOezACoXs2S6z3d87fggggw6IrWOAJErmwNRmDI6C.8HHpd.UosVJAHh.fDRXJ5YN7u8Ced7.O1ygSM8r.jorHATBcD.BC.CKekLTiSxJBWqb2WKcB.DE.Quy8Hagjw5wum57jLVO.nrwcjLLLLL4OksV94IGarFpFg6ifZSYJtar.VrUd.TZb19Sue70e3cg27clJM2YYr3.a1FK.IkF8im8AiVBeY5qvL048iERQNvmYXXXXLorS7ytFahHDLFfHQuYRjS5hfdgCNA9FOxdvK7JGAJq6XiXGMD.IkKbs3YevQJMuR8u3WKjhrquXXXXX.JiD+7TicjNgAMnPPav7UE4fkdN4Lyhg11Sgu+d9YKVLSdH.Rd5PKG6aqmnj8hN.fexZPbEelggggAnLP7yNGah9fAFHjfZy7wRlsVYV.zC9juH9lO5yhSM8bY1ZN4n.H4t+VA90yhE24djs.rPejDC3UYJlTJ24Wt8vc5EWaFFFFF+CA1MqexW8HcRDMnHjXC.YwJOoIB5W7KmDewu8H3WLwaqm6rxAAPxcs0.65YohDYJFjC5EtDaIyHVd7.1lggggoBk.2l0O4qdjNAQCJDJQO.5YomSM6Yv19w6G+y+feZtGOOZJ.RtqsD3VO8Rty8rPekbQPbAOjgggohm.Spt+jiMVCFFKYHPhdIKolNfJ7ko3OfDDRe7W30dK7k9N6Bu06dR.JdJqCfDouNr4wrlR6Dz64vjSDumaEUIBB8QDsAmdNEJFBDA.r3GFFFlJXBDVp3G8K9kCPRZPRP0SVlw53pq++djeJ9tO0OawV0IexnKGdNxEle8X2aMP0PS8STJrDDG2OLLLLL9ZK+7XGXhHhPhnDQsorpCLyRcPwsxihjhfLOlW6MON9q+tOC9Euw6ZwZOVrpitVyIWr.DEtA2dMnRhTsDTQRDjTFw0OmLLLLLAJB40SfLwi8pu4fBQn+Mhny0zTN1YlJJgodRN52a2GD+EOvSi28TyZ8HW7WS4Dl931brRmdNxCgCu2Qx9qLFm3oOQUMr6mdWcBfycUq5bQ3vtmFchnZ9vet6dqO8+zcyA8LCCCSEJ9NK+7XGXhHPD2ZOvrET.f3QxSJw4SJiCbxYW.2yC873o+4+xE2VJR46KNV.hDFcJcyEiJM5dyMPUO6PjA5Ev.O8SuK7Sd9mCc000gq7Jay4mu1rPK.XbW7DxvvvvDfP30S.q7CN3aM.BU0dAITBeL+W7vrQI.xLReRc7W8MmB+g+iOAd5C7VJgOjH9Wyz2G+qPj8wS+XEY44HBuArgdYWekObS+scJpY9QIJTuPjbMctybF78ezsiG3A9V3XG6ntxkhjD65KFFFlJX7EhednwNdCO5AeygAQa1L5cxjHG6DA8C12Qvez23GiiN0rNKfoXK.B0zSIcwqL.wMu49DgB+jPDtY05X7033qoDIvgOxQv+7+7WG6ZW6rfudGchCwheXXXXpfwyc601OvQiPyO2vDIZ1Z.MqByFSANxjAyrkigHB2yi7h3G9hGAfHHgHdJua00UYJkzKNt.iDx9jpNdNiFP+t+ehBH6ERCjb8NNlqwv.DDPBfcsqeLd0C9J327F5FqbkmadcMWXgyvheXXXXpfwSs7y1OvQ6iDzdSH7INlhfR9XDRe7SM2B3+4294wOb++xTr7hjDPYUFOxBPhPa.a3VZonu3UF.86c+QIgn2DV6Ik0a6s.DHAN5wNFdfu8VwO44el755tr5W9xb4WJLLLLLAH7LwO+GG3nCAh1hoHGoct5xrj5..qt55Tys.tiuyOAu3DG2VgIds.HJTnAK8qnAKD8+0GHovmzD7ng.nYm6L3G8idL7829vXt4l04KnEVR00bphzKKFFFFl..k7hb3CM1waHzYlOJQn6LWbBArVEerN9q+1mB+udveJN8rymghNXxumLckhSExP6Fu.KDhRxX83w+pbAOzN9C1RDgzXuPZ.XX26OF1+yFVZkHVd7UsxUga92sOTc00n0ke5Scx8ceWWCrquXXXXpPojZ4mGZri2fXt4GAD0sctxx7ARZomTG+0N1ov+q+uihSeFCsrliWZAHxfFp3uhFLQ.Z3jV0wt2ez2BPJ2fcTb++CCgicz2RuqeHwBE4WhLLLLL9XJYhednwNdCzryOBLqeOHyt5xNWg85u8owe526kvomKcgO9TAPBwFv084GnTs9FTPbKeq9fPzbphZJbAPyN2b3A91Q0R.T00TG61KFFFlJXJIhednCbzHX14GAhjEtPoEq73jHnW6clF+o+66WYwmDBL7+BfHhFDeraicuRJDZP6E0TZE.wvvvvT4RQW7yCs+iFQZPi.gnMSANID4ngHnW6smF+YOzOCmddoMBL76BfBUOICEEa314BeH.BcqemdfHTyYVTi6I.Zpo3tWACCCCi8TTE+7P683MXDhFFjndyGSlHblShzxOXMdeN8YhgM+jikT3isBL74BfDh1nphEsXtNGTvfDc5rnF2Q.z+9286jyYAFCCCCSkAEMwOOzdOdCwpdgQP7Z3SpV4IoEdxlUf9ydjChwd2YxrXj.i.nPcSW2ebzh0ZcfAhhnmnlBW.zQO1QwtdpQrcZHgz9AXXXXXpHnnH94g16waXgpikvUW.10hJxtHng14gwXu6rNKFI3H.p2JcAPDIhnunlBW.zy+7OKN7gG2qeYyvvvv3ynnH94LUGKJHpsjwtCgbQDzybn2COwu33XwBTXAPAZBEp9EuVUbE.sieziY2LYjR7qbFFFFFeDtt3muyK+1QIh5dwsnhTKagVszi0wO1olG22S+KQlE0TlH.pRLHnSHnozI.5nG6X3Ue0Cj1DI73dwKeFFFFF+Atp3m+se96zGIB0aJV4IkVTgyVA5910afoOizhXgxTAPUYLRkl.HIj6zKD.8Ruz9RNGjFG5dZmF26VEXXXXX7ZbMwO+q6+3QHoXKYTjiFhfdlCeJ7xGaVaDKTNJ.RzFsjXiWQUGfnPimX8nDJ.5fu5qlbJvt7hgggohGWQ7yV16waPfXCqkqtxv3m9LF3ueOGMKhEJCE.QgpmPn8ht97C5FuO32gnPijxZSIT.zgOxgA.fAnQ71UAFFFFFulvtwIYIUYDEhPMCHSoGcABfPRANTVF+A2+wwzKHUaXACnzkY.HE.BC.CKekrLNfku2lmSJGqcOmjeuDBPRjSOmTtlDx73VerTle.j.2E55y2obgE5C67qMdts5WbYuiMVKgCiVLLPKBAZI9CGgHiDtrirb7IUSKAn3BMLLFolEBO5ZGZ7gEglYHPh5Sr1jX4I80bSR6mEP0LT05XiuFCC7dSMEPS.0Langy8UAFFFFlxIHmOjry+xO63CH.1r0Sj0VRJE++x13u8zKfa6QNrycYciz9pNclcaOV+Z2f2XJoAFDOw+PIuont2IFKBhgH.nEBTmDPCTHpMq1tK02CM+F8GWJM12tFelY27td6q4mezYRcswH8N4t4WyTGdO25F7+lW+0i089uji8U9n0rphw5GCCCCSvgBxxO+q6+3QfDaVBjX2Ncszi0wev8OURWBoi0bJSs.D.pmDxMiesaqOYrXCfc90Fww2DxCd1wFKRHgnSRJi.hhHDTaPJUFcyBRI.ABRB.oIXMwaox3RYImGmHQa+pqco3it1khmehowe+S+134N7oPovBPqbkqBm7Tm7qo4RDCCCCSYL4ske1xdOdCgBiQEBzbhSlEAPIu.Y2JPuyomGe9+y2H+rlSYqEfhOtgwVkFFCVHtBauiMVCKfvQfvnSHkcRBwFryBMTh+SZqEbra7B0RPD.1wu3j3O+Q+k38lcghpEf9ctwaZt+kOUy0jqqeLLLLLkej2V9QTEFDD0bRi5HSVydxAq.ssW4jPcm+4g0bJas.T7wEhdIB8hq8O59jFyMH14V0pac9Lic3dHBcBH6bdRzFE+Zorri58gDthBIsTi50p5cJcF2tyCjDjj9i20EeVX39tH74enCie9Qmo3XAHobpSe5Y+KzYsiggggo7m7xxOa4EOdOBA8Pjkmcx6l2hkdbvRPSOuA9ba+sPAaMmxcK.orvwTRowP.mYnzEAsqwlHBAYOBfNIh1.YwMU1ZEGmFOw+U5rBzoly.+4+mSfezAeO20BPFwlxfnNwCroQACCCCCCxCwOaYuGuADFiKHJQmZOeEA8e9ZSiu0KMk6HloRP.jxUXSs5y9r99a6uaSOtLofm5yKQN9PQP+2G9vtm.HiE1mgznOV3iizX7+cPudhjmzH.h.f5.vj.XT.LsmNiRkVgZdMoWOQXXXTjyt8xHLEMDQ0mhqQjIE3jzMITBAPlimpaPHryiDuwk5Ftypb2EXPfZqNzja7it9E9LW2G5lIP2LQIWMs0UVR.0wjmiihuqv.RMnn+RW+ZvDSMFdkBzEXR4B2mLrwfXqaRKWEVjnN.rlR70bBn+F+MAft.P6.X6HXJ94Fg50P5O11.vtK8SmTnCnVaaE.2KXwOLL9FxIwOeiW53cJL6aWoHiAIh2GSQNvxwXW7.8NSGCG5jwPJY4EK.ZQyupqN7aeMWZKuSua7ibou+lVYilKgR0Ru56oTkSXMaqhqpH96K4w3ItNIy5KmF2DqGWlxJLymgoHokUs.eqe60ht9ZGDmb1ExYAPRH2oDFCh+k+3Qf2yZ.vcThul2KbVDSq.Xiw+ZPF6D9..TK.5EJQfkZq9UGTVg5FfxhTLLL9PzV7yV16wavPRQiuWokM1xOQPi+dwRZ0G.vBfrXgmZBM4GbcWvw9c9DevlV2Er5yA.mSpBNRSjRYfHHqiurkDBeiOcSm529aO9xfVoAerojRZXIIFBQ+brKtxLVsDQPmFg8BerxFQoS7ScPMe5BJwWLLL9XzV7yBBw.BJdZsKAjT524dZtFwAWgcn2KMq9.fJYAPKqtZl5ibEW37+VansUbwq4bZD.MZlgbZKxoLRDzUs5ksrevu+E+Eu9u4q9BFfh.hh.IZH4QZLBAbBiXXD7M6kE73L2F.ZyqmDtH5XUkRoKGuUTdHpjgoh.sD+b+683sPB5trZ4ARlXex7xJPu8rRrnVYA.pjD.sh2WMK7QupKL7G+CtNbQm+JRInkMWEsJ.BvZb1T.iifQ7.slkW8+iex.WYKqesq01VRgztGjISvVifgggINZI9ILQCkhEHrJxIOEAoD+X0xOUFBftvUuB7qe0WL9vW9Efy8rOqvlqSI++jeCQHMYEUVVAhHp9kD1XH.zGXXRkYboigggoBDGE+b+68jcJExtStSk6HBZE0FBfVH93k2BfZ+ROezwk1Dtp0tRbtKeYIVaStdjHu3rQ7QksHHgPz69mXrgth0rV10VLV4HPkYaYy0V6nDMWXXXBX3n3GhLFTsYtLgqLxZ79nY7.cN0FB1FvykABfVY80fqp4yAseImO53RVSBAgH9pnctXRsVyhf.rSDjwP.nSvvjJQgJa5rykdS.V7CCCSFHqhe9Gdw2qGBzFL2lKQDf3BVA5CbNgwC8Z1G7uAQAPWwErRz95NWbkMuBbQqpAjxF+ordYu.mjwYi5mxjHojAQdkS7.IHwF94u4XsboqdsiixOb6ZqSkjqdNB.9BPkx6shjEpwQAK7gggIKjUwOjAFRJh+8HoHF2PDTSmk.qnNAdmoMenfk.nU99VJ9ubwqDW4Eb13pZpQrzZpZQqSIVGLeLMDAkzJOrUf.RZEnXKDaPTdF6O2qWOAB3LMTV.hgggQaxn3m+O6cp9HRzrLgOYR9E2RDzevkUC9xuvLvtpYreS.z4bV0gqbMMfq37WNtxlVNVU8Iszt45vhEWj15fkwStdwhfzQDjfB06dGarAV+ZWqWVwlYXXXXJCHyV9gD8ob+P7s1kHQ1Zkd77jv8GRjSwCz5VdH7GbY0fu4OaVem.nVVQsXsMtTbEme83JN+FvpdeUqVVLeskhKnR60o4ikvESYd7jqGN4pK+uqvJ1hfBGF8Afg.CSoCyVTRSw+d.fC.tWcwvDnwVwO+868jcRDsAfzrxSQvJPe3UGFMVSs3a9ylES5Qt.qtkTEZ4rqEWwpOKbEq9rPKMVGVZ0gSLqSsNEYYicY5iauUdpTrBjVhj.x63ARJw.fE+3kbiPIBHSrMnhCG23bsG3bu4xMNGYhNfpZMaW1jcCw+5AAviffYOQigohlLY4mAjV14ZQhbbYQPWxxCguxGdoXWu473GdnyfibxEPwR.TyMTGNmkUEV6xqFsb10hVN6ZwJW1RRLOShDZKtfEAkaim35jaVAhDTy6ehwhvo8tmQSH6Uw3boPJ5z4RGAEtw4vtyYePupCcqPksYaMOtNLLLdHKR7yl26LsPTrtAfyt5xkcE1GY0UgOxpqBSNiAdg2ddb32aA7NyDCuxjyCcE.UWnvn4FpBPJQyMrDrzpHbYqrVrzpDnkkWyhD4X5lmEKViRcbKGCKBx5CUZEAIMPe.X.vv39zATVSJWqF18hJqrrigIvyhD+HvB8IgJEurqarWrsBDAfFqUfO1ETMHTMrt886LSL7NyXj7LDeW5yotP3bpKj5wrLOLIoDA6DiQ413.NGmMoLdZh8rbc.k8wKmhGHWzUX8.V7Ci6SqPIhIegaeHLLAHrysW8k7Nusr0qGHBJ8wWQsgTUFZjbScqWqLOOSyJNNYkG1JP413IdnRfUfHQy6crwZY8qsrrl+v3MzHTM9UFFlJDRQ7yl26o6A.Ma8NtU3uDAYu3BclmrHnxBQPBzCJeB74MlGOmGw0mEU1zGXK2vvTQQJhedioE+IqoNCfTb4hU2OXYqWIJowCjsiaYdjayybzUWNM9hlGIcQDrLN.KBxUDAQTmn7Q7yM37grHXwOtGshrGzzLLLkgjh3mkWUrNRDuORoMVeI9C.1JP5ZEHNdfPwHdf5DLLtC5Z4sIgpsYLQ7etQ.DA5kUXLLL9LRH9o6e3rCTaUFV5m1w2ZkEAkaia4XXWgY8gbQq.Qn98NwXQVOmx6LEFMB8r5y1g8Va6QfR.TefcaFCSfBg42rpkfeaoEMHxD+iTaLJUaZmwwQ7wkIGCVNF.x4wS6bfztFla1l0wsbNxs4okwscdjiiun4Qx4Xlmmo85H9w.Y1GO47vlwS453z3YXdlx7HOGOw0wx60453ItNDPLQDvvTXnymgxjvGSFEp9yFmp6LLAHRH9owkXbI.HwFslXcycsFGotgdpGGo23Y75jbiaGG2x0I2lmTpOmEccxwwWz7fRYL6mmzhesIcd7jOlMimx0wowScd5GEAYHkcBFlBi04v3SB8hupi.8qr0LLL9.BC.r48d7FhIo5M2jwQWcwtBK2F2xwDDcEleLdfj.s.FlBCmhWG1spLLkoH..9YmntOAf06rVSWc4z3.IboxhuCd1UXrqvLuN4tUfHgXCfgovnQGFmE+vvTlRX.fpBYzis24so8CjH6o9tSiCy6h2xlWH4lyrkfBVVBJk4YJyi7b7DOTtETzO6XiE4ZVafOnm2tWOApPIaMDUS3FVJCSYJgA.VBgHRKpexKWckCtBiqOPVtloLO3VkQt3JLAPCH3CWyd7F3ryhgoBFA.PLfUobAEkAWPo1vhcEVZia67fcElZdTBbElPzIXXXXXXxQBC.rl5nFL2fghK9.PVxrDzhuNrqvXWgY9MY1UXRIUNX4GFFFFlRLB.qa3m5l+YNkzsromr.GGHKWGRuwy30o3kZ7VGmsDTFlmoLOJFVBRx05GFFFFlbFw5+dKjn3Fl9lNrqvx77zbbj3bYQjj40pPFGoKFiRYrEONvhDyY4IjswS9X1LdJWGmFOCyyTlG443ItNKdbFeCNU2b7SLoFGiSYCFCCS.kvmccFWbRq7Hs0UWrqvzcdxtBqT5JLh3zcO.Scd70WGwOMo4wwvvDvPbx4nKNo0TxtkdXKAo67jcEVFmmoLObCWgw3iPmzGGPI7wOzPPcRXC6VUFlxTDFV9gD2ccBK8X8wze7J83AB1MtsWGuwUXkShfX7UzFzyhNcUrmHZxDNLd6fc8ECSYIhSt.Ew9MUXq.UtZEHyGGVNlfZ7.sqwlfu67RG5z+pbRXSSZbLkJNfFGysAmEz0Azq6vyvv3SPksWV1vlEAU4HBx7b.Y1G2OaEnPPxo6doCc5b42..1HrWvPG.3Nf+o.CpS0AeMPMmsSbSi.nO.zqKNmXXXJAD9vmlBAP.RYhp.rDVCKVKg4qTZa0WVMJGTz5MO4fh1MCJ5XVV4YJ5b.nD23D2P7+Ys8PzD7OhdLYRnb8kSwejo.nIQx3DxuD2RLLL4AgmQJtBIhA.J9F9IEu.jp.jLIvI9i3nHIyMuo3hOby9EVpGWbINNMN.2pLRSFRPoUYj1GSKmvTjP5oM9Q.vzva62TGDJq+nqHlffqf1Az2xMMBNFfXXJKHL.vwmmvxqJYMzMeEAwVAhsBToxJPVmFkADAIiaDcDVbP.rGnbayzEw4kcrCnm0eBJranBr4ffPMFFFWBk3my.zPUpGHEwArHHXcqVVDzhGO47v6DAEv4Kgb2ZBsF+e2HThQJkMG0c.U.K62bgUgv1f+JVjXXXJxH..F+zoFjpHkuWs6XlGWcLA8TimCJ5L75vbMSl8w8pfhtLfBwMJ0BkUX9Kg90XmBkoAPzRz0pTwQfR.DCCSEBB.f2bVAPZYrU5arm8wATBbBtYEFPx4Yhu2VwVV1z0owQxMzSNtNh0nTeNK55jiiun4AkxX1OOCNoFOSVyHohAiBfsB8x9K6XOvaicI6X2.39Q98ZZFvUBZFl.EJK+Ls4cY6jHmxeQPoLdZmCj10HwF9YabKmibadxVAJiySKyiE.SbpEJAPkp5dztAvWD4lHlYfxBKQKFSHWfQg50z9xgmyL.3dAK9ggIPQX.fYiA7Jmjv5NKysWbJde33ARZ8I.Ndfra7jyihX7.4uU+LI.1d7uuVTZJte8A0lwoWPBcxZK5Tv+RmIiesZEICXa6bi2AgRXwdPx.z1MlOEqWSeUndczETtSzNKpMATB.MeM4zbgEGwv3ifPT0VcQZv.cedFwePX4qxDajZcL8GWcLlwpZ9LdBaCPE33.Y45H0a7Ldcr3DFmF2x0I2lmoIYJsqiNGyhFeQykTk6X+bUt3Wejyimx62oOdJWGmFO47TFK10dsu+lFA9etMnZ+CkBlD.+UnzmIXLLLLABBa9MuxIE3iaXfZDVsJA.aEnfiUfLO64a8AxPJ2I.f.Flm+QLmYBAvOZGOUOS9tGuM.fUsRfu25U...H.jDQAQ0FwpV4J..vRqao3BaoI.x7bV5pOPADZE4tvmzshPtDOOlVsnTlEXLLLLAFRH9Y1X.ux6IPaMjz5OrHnrLtOVDjciKkFGBDMNIkiJIbBx.iJE3DgmM7nex0u7S.8XP5pt9n.Tu1M3RWZc3Ba4BvpV4JvEt1K.W0keoXssrlju1KJtBKwGg8yzmlG2LPkJ46.1a0lNfJ810Ikr6JKmGFFFlJZRYmic91BzV8R.RZceJVDT1F2mIBxPZLEALJ.MBDxwAji+YuzyYD3RHokL.YblHfnEYIiSe5owK8xuBdoWF.OI.HAV5xVFZ+CsdbUW95v0sg1ceQPt0KrhGc.8Rmcy.mMaMOzcCUrybGv4VqvnPIRhE+vvvvjFIh4GS9uddFns5iusJk51zV+d0Wko3xkEebNMt5X33AJ+hGHHkSIkxQIBiHLLFY1EBOZ+5aEm7mK+i2IEJzSl0igDw+Go7YFIvRW5RwGaCsidt9NwJWwYa65UtFOPhEhs9qccqQmFToWgNoftNBerRcvdAPy.knmGAb.1xvvvjQVj3mFpB3O7BigZDlG.XQPVecny3Y75TXhfjFxCAXLBHwHBfQ+cuhk6Ya5SW40OBHZC1O3hE9j3mi+887I5D+N+VebrzZqwl0K8E.00EsZ+rweZDpJ3rSb+PuNLtUZBIqJwN4trbg5fJc4i.k3J6rZkYCAcTT3sXCmrL1tie85.JW4ktfuzy5pzow3O2rgYrQ0ATutsK9rl.prGaOPeQpoiSuVO.zuzAzJVb+eKeOWlTpeumgwyHLjFSARTu4Cbh4Ad12kvGcEVzDIi6hGKhfXWgkkwcIWgYXHmB.iHHL7BgvH8e4Keb3SPBJJArXwOZH7Aj.C+CeJ73O8Kf+22du3JW2El2tBymiN0bGyz.OWwZUId24wyOcpCJwE5z5JLavmsgjsXi7U3kS8UqC.fMF+3ri0DeNrQnpePouV1HbtWjsanxFur4Jw0D+ecA06YQQtacMc5gX5JXYcv4WW5dtx2266EJwfrkFYBbDFp+XQJah8ieaAV2xLvppIY2zVB.RRvLdfRtMskwAAHkIxpmEebNMN..gr0U3cZ7DYAjshKPxyhOUDjggbeRRNrfvv8ekdmkcbDQrQfLTpOllBeL+4SO6b3N+a9l3+4m6SiqqiOPdEOP9bbxhC.EVFY4Fhd.TVQ5VQ90pMLawFsCkErxWqhjItI3b7MYNOtUnbeXtZwi+Rja80qVi+b9p4w0xuQSPEP95rFaGsCkH+sA26yiLLEcxXpxrsIDIb+UJ2ecPxJPlhfHqxMrQjT1FGHQJVaqXt3hjx53.1jx4latKAjxGFFxQHCL7u+58OV2IqruGabbkW+TfHkUCyQgOIOFB+ca4g.HAtt1UFJYwqW1m56wLToluOk5fyanLI79MO6.p6fuPoQnbCmauIXttob9XAh7oglZVQsyGWV5WvpqSKDpEpOC0J7uUuaFlTHL.FG139holG3QdCA9zqICo9dPRDjOzUXPZ7vFRZ3pLLFtjDjxEGTVMr.D9XN1eWzGFqrwyFWYqWPx0NGrBjO2oW5rosWuoYqvcD9XRsP4Bpi.22BP5Ro18K8gbKX08SzGb2NYuoqIi5hmSFlhBBnD+XKG3jDdj2HdSOEI2rQZ8eRJ6ii3iKS8wg1iC.TdzuvjR49hIkaZgEhs1+vqpgd9iZq9nAXgOJbAgOl+7l+V+G3TybFna+BifzqEOjMxVvnZhWZ0m5fJNWbaLsHRcEgysS3Eqm0B8qiS9I5.4uqtxFdskLYXzBAfHqa99hSQ34NtRfBPp2ss0MnbbbSwEoMl9iqNF66B55MdBGmHKvwAxx0gRY74VvXNXH2JEiV+szV8Q9u0V8CcqAEWa4DtnvGPBbz288vC7nOUJBNylHHCP9Ygi5bG0dYPhpawRLevLNfJ0jucY9Bk0.8huK+D5Vwvm.JAMN8Y0Yfpkpvw8CSf.y.dNq73GkvTyCbcqDY2UWrqvR753TyiSIMLtykTkwCbKQB3V2IS3hBeLOlGdjeJ5tyODVYiuu3V2IasJCxOa4mlz3X7JWkzHxb1SYGVuadc2zzrBSWLD3MAr2pEtw54jH4bVm31xja.AqM9cJ312FVb4CnNn9bSWo87m.pf+ly3Kl.Clw7ii7buKgYiAbCqV5rHmJXQPG9zzILj3N+a+vK8qixcDhM3lBeLeru8OX2Xfa9SD+yP.vhzmTiGHY4onxhO51c42ATck9z2.rKnmkc5BISG+Bk8AUlwYUfSiHYJe2HJLwOGDp4Z5miFgyoAu4w0TANGJkjMQrS.068oyzwe78.kkCaO92uMv06Gl.FgQ+z3Hpz4iDJWfch4A9zqQpJBhrHnDiejowId8SE5t+t+50LzhV3JGostaoXH7Aj.Oy9eM.jTjSlDAc8u+UOhG7J2svKuKYcp+PaE1aIioQx55RuZbcbCwO6A1GDsSB0bb2PIzJeWSyz427ZbuPuVJR6H3H9YRjYq+TKThbyjflogZ8Z2fiwGl.Jp53rzXe59DN7zD9pul.GJ9uVnU79TFGOPGZZ5D67Xg1zeSGKc4ULBe..BgNKFBeT0+m4wyr+WeQw6i4ZuDjYAfLHiWI9oI3rKO1Gb1ENlUU4rgo0PJDlA5IfZGH+EdD0gwmFJ253DE5q0RIY6yelks.m9bBK7gIvhH9WyoXmX1X.e6CKvieLByZXt4jCY8UYVVgc3SSm3IOVnM8U5ntJKQOwgDg5oXH7w7melW90ArDvy.Vc2Efz6SS7BEuZiRchYmGTyykNEnQciQnLgeoEJLIbVrWg9ZsThSBEWCTslk9PvRTGCiVXVjCGOedxO+6R3fmjvu5Jj3Jq2bWoxaWg8RmPbziOO9xOTEnfmDzV2M.JT2EKgOfD3kds2LoU+.vhi2GecvNqCEqLsxIbJEzm.5aUJyhzX11zOepZzVwOYcgcCmCT7FQvHve2AzK1uZO9+r1OuBJt1igIiDW7iXD.bW4yIXp4A19aR3EmB3WcERzbcp8lbrUXTfsJiRoHnSLGvKbbZpiNW3+a+jdB+cxm0oxJBGdfhovGPBbroNUJUN6zEAEK3a4GfrGWEEKbx5D455pSheJTqF7NE3y2MQGgXAEwOSB8E.Ajr2lcCHY.QGjxtMFlTvzxOE7FIGdZBe6CS3BpShqpdfqpdYQ0JP.5IRJQNYki8KrYiAr+2KDd4Sfoeo2qp+eP+TkqkdrRac2.EJz.ESgOPH.QDd4wdSb4qc0I5l6lueKgDg7+hezYCv0.+kkM.xcwXAgM5cSxTZ1GDY6Pksb45qm0.UvteCwOGrHHl.GJwO8Sm.aI19.IZqPOgGdZBGdZfm5cHbU0KwUUuD0WUvvUXyr.vK+dB7xum.6+8BAHM1JfX.zuutX5UZYIKY.Ph5K1Be.IRFyUw+FqVAZiqakkCheZB9OwO4pKM7SVloTfeH9ibKlFpLY6Ff9V.xJMBkHntfJnwY2gwDXvZiMcT.TvheLYp4UBfdp2gvppQYInVWFPCU4uDA8lyR30OkRvyqe53w+sz3P.nOzenQJ7UhxHtlapEBXfRgvGPBr+wdKb4qc0.H96glgUlzXmd2hf1nyFAqC1WOUXXJULMTYS2nPEby4SLZsFTbZpsLLEMrH9QLBb2lbXBN5r.O9rDd7iRn9p.V2YIQy0IwppQhFpRcLtY7.kowmMlRryXmVfW+zDdiYEX1XoMYkF2MfXH1ZOKFRhnPDp9RgvGywSs1Nqdej7+t7BPOK+zF7l39Ia3E8jKFumCBfu.Tsoi1Qtm4Zlc182A9OqYxvrHrZ4mQJEWvolWUsnet2UsoVMg.VU0Rz7RUBgpuJfkWkFtJKKV4YrSq1h7slkvLFpe9DyS33mgPFQZbH.AasmLwG5FG.hPavaD9nByYUz9.HgbDOacPeNBT0nFmxpq1Q9a8mhQv01DxMwk5z.WKmnbOsuMKZjMA0mM6.4VlI1GThnXX70jT7S+z3XKwNDHQykxIvrw.NzzDNzz1KL4bqId0jNK5V..dqYoEaEGcgismry0bScRTnMWJE9.R8ldpw6S7ODTc0i3UKE4HiBmSMZydfU9vsA0FSiB86iVNcL45l6N4ljxo.htQ3rPfRUyUsXWSgNR7+sMnpT2co40rQnDLwt+hwWS3z94gAvs6ESjLwaMqCpdJDjFSoD8DJZw6hDv4C9YhPPLbIW3SBq+DmjQ+799sVafoQwpi3mFAvFgdELPqbiHYV5zU7+cPnJDeYqv.5jXjVQt4JNmZUFkShezwJWERP+lKBZJz5mTtfY88oQ.bSv4XCsUvheX74HR6GGwSlEdAJ2b0I5mh5wyD+KevOSDRDdDUb9TpE9Hvk0x4lvZOIpx1xRi6YcIFE5YIfa.4lEW5.1mcNsBUbWXVYdsaCxC3v4t1Lbtyz7vIKgTNkAPN0LWmvgwcZsvT3oSnSKJoXvjP0lObpcH4EyMFlbhTE+zOMrGMOJsHM1IfHB5OvWkfKd3wBefHdnMCjZr+DrD+.nuKstCn2c92EbNwDpEJKNYmvKm1f17Z3jXrFgx5SNQPH3W0cc2oM0cRXoNBgcxRg.5stmKTGThk0MX2ePT5buGCSQAwhdDowC6AyiRGRish9C0IGeOYgq4l5yyE9PBrh5Wpk9qlJ.nCclvi3kKM4A6.5sQQsPI.pOX+lrsFebc23a6vdWWMMb9N2MmKYRTPSwG2Iq9ruLLG7abaH6tuqK3NB8zYsXiHyq6lhTby38oInrTX6.3u.5YAxIQ4k6LYp.I8X9A.hgAP2k7YRo.I1D5ODWolyDs0cCT00LDnP85Mw3SRgOID+jr.MAHk67St9.S79XxzPI.xIWlXhYuTx5FLMgbKialAY2hS6FNG2FlBfNX7+cj3yilz34ZRPwxp0BfaEI6eUSC0ZuYFOoiablDN+5UGW.Z25diHYfD6l8DtNfRTm44rQnD.sGnhAsLIvoCT9TkqYpPwFwOXX.rkR8DoniD8yw2SV3p+TcRgBGEhPM6GD9bYMetIlZpZ+DfThfpaY2AzeSTSL2vKeHJxtUFFEpM1z472JxOKMLIBdA8pY+qJeoUjcq+bPnW4Ov7bULynqrYMqzalolTKTVHyoO2Trhyq5fZdGD+rUlvLgGh5BmCy2WLWeBBtb1yXwheTs5hGFjn7w5OrvmLy0bSsPR4ffD8tHQIdjvGPBbNMrrDw5iY88IFEJnI9w7t0ATajTJBDTyr8BP8GDyDGFE24Szh341ORiHoEa1Fxr..cx.vhM2HzKn1yWwft8ltlhd5BJAXa2kO+dAshTcwYz777DAJWgltf51AvVQ4iHQWG6r7CJab8kJU16jCr4LvU+oFjjxRVu5RWgOfHz7pVtkp5MACow99rW1xG2iWwxUZD56tK2fIPx+HZGZbsykt5ctvNPk6cc1JTaF8Eyv3OB7dwO5Dz6Ex41s96slVzvqWubSRWzSgfYLfkIKIxUb6rf8he5mhhsDaHPh5KwyGWFAK7wNt5OUmDQCAgnMaEk3wBe.Ivk1zJSIdenJOKIjqbP.b+V9YcDcsMn9Cnt4lK6I94sRl0.U7BYm0elDp0G2NisxELsFfa2NilAtyumVNJ5IeaaHYi1gytP85.K9wVDYYrflKFREkqtXgOVostaft5O0PjP7j9YgO0UyRvErRktaydPqL34xqRI6.ptysYb9zJz2kVQgRvhavd.KR0jrsI2NPgslOCbNi8bhcC0mYbqr1Zl3mO2HdeLEJTNQuv8igKcJMAtY.xWVQVD+HBtYEEGiOKlOX2QnvgGEBwsmQQK9.gOfHboWvpRjZ6.P4xqKMv4xqRAGDpMbR2RKYKVerinPY0n7civIi+7ilmOeulsVDNmNsVFM90MWqWNS.kK0bCQFGD.+UPECMERc64ft3bhgojPFh4G.zOMJ1Rr8ARnaZs5OPZb2b6pHM9.cO.ICuYkvE+svGPBb0u+yOs38ohn7DLIT2ImS2olYJUuGX+lMMg76NLMagAc.UPTpyu2uu3OmBInJcZCyRQwza2PUfBcp0MLQ7iccNbb.5IDX2Ps90EbNa.m.JKFYtVOIxt6LzUH6zPEGR6.p220889YPx26Y2p3Mny6wrfzLPlE+.f3V+I3j16pBX3fd8zv2Pac2.ERDEBQ2YUzhOR3CHA9.WzpUw6S7B677yGvcAq9L.RME2WGTaNY9Gvl.NWn7Jz.X1rqdCjrcKXsv2cj3yA2ZCO+R7AY15FpCpX1wZe75.H05tznH6BD1CxcwGOBR11JZxxXGA1WTAs99javzocNMqsTVWGlDp.nkKxg9C1MT+9dlxHOmp2WUzjcwOAo.eVZrO.w.d8zv2PacGgBSCCRzbPR3yUewmOpq5p..hGvyFas+02XPqvFlOzHT20sYM3AH2EXzHb2Xkv75WIE6blB6bxpJaE1Gvv6C4ufNyNoteX81TvMaUG+MQgJiuRW.jYLXwhTy.NX4G..LD.tqh8DofH17SCQU8vsrh3zV2cpD9Dp9fjvGPBr9K97Rs99XHh5sKlkT5BE1Fec37gv3RX5prHHYfmd.vhEXJsbDnh2pHHoECMcMdPn0x3Yng3GwPPZLfu15OGehMg+jKbbudZ3Knst6iBK1RFEg3iE9.hvUewmah94kgD6q2qb4i3kKmkXZEYNEocByBAGSoiIA6VAF+AlwrGilHb7HTVSw+FyE+7m.3O4B+5d8zvWP.W3yG3hOOTSUUk3kCor5XkF4q.Fcp4GLLLLLPO2dA.wfv8KHVENmZRPit8DVJnhl.tvGHD3CeYW..Tw5izPdn9tpkG0aWT8DZGYuoRlI7Bq9XZoJqAoa5bP3MlgOBTyu04zAF.vLdvVGRUf6jHYLBww1g9X1fdM+bqc2zfYfla1bYqjw72irasx7yfdw5j4uWX9doUNHbvMz5I9oeZbrkXaEjvWI.hdpn.moTjIr9bJCD9rh5WFhrVSWdIgjBr0LF2fNfR.Ttb7kh9FVcH2RGZfjoceuPELv+HjewEyWygwuk3eciHYOfpXwFQ1qf1l0eoB8bb+PUInyVPr2d7i4fP8YlhwZ68lCm26.YuTKjKmK2jlf5yE5V.Ps9ZXRnxfuc.8Dv6z6s1Q1dO3VxxXt46cVI89oV1v7ymoWNFxUbZca6P8Y7FgJHuy1myZM94Zx3OuEMmzzxO.9Nq+bn8B7VG.PDxqmIdKs0cOAcgOfD35Z6BAfphNKkXJZgJRWdYRWP++Pq4wWLIW9CgYi1h+uCBUVp3lVqnQ.baH+ZDmN0M18BpCJgD595o03G+Nf+o7A3GvM5kVl8nutf5ysk6wVSGPInNW+c80.kFAy0ohgkf5.4lNjFie7sC0MSj3uoJz9TzOMNjF2cNbQKpPOy2I4OrgauAual3gnRm8nAcgO0US03CeIqIg6KkPNT+qe4UxYtWsPYcEcnUjea3qKQ.vWBp+3uaYMkVAveIbWqUkKBEr6452xTt7sip2ET2UbkNMB06qNYIpbgZAvsB+2mUbS5CJwBExuquFnV208ugoKQP9a.FyaNHQKAQewOpCeHUmR2i4EFF3TuSxeN7Bt8hr+m15tAJDEMHlN6VE9.RfNtjlPMKILfDvvPNknx1pOlnqYyy0VYQtRDTbbgTsPYoF2hBUH0M5BmC+BsCV.Tiv86kVlTL5SW9A5CtWcByTnnatNUn2j2ZfZNAfbU7iJyu71MlNyzfdoeXpOlz0UX56gBKFBhPsEzE9.hPWWUKI5kWFxJdq9XhYv74zwTr+ivtYUDNcVC7O2Ecsn7RvP6v8uy6fDlAZewhh8McTpwrEq31bavecSEsh3+dQNZ4G.zenAgz3Pt8LRaNvSAblTCEBBnSuYx3Qb0c2IHQukCBe53RZBm8YoLrfgTNUXC1pOVvoX4oT7GfK1ah3mpMQ5FLrAE5C504uKWoXVClLyzwxAZDEu+Vhe7lJ5BHeD+...Qet3DImfdoefMOH5tRJteHDNZ4fvGPBbC+JWLfLQfNO.a0mTHa+AV2tUVjM1SVFyLCO1NTAT38F+62CzqojtF3uDbTNYsjZQo6yH9QxVfIOCTYe31gJ.wuWnZYIaGpOSqCkKqsaDE2rirU3ubSXq.ntbHaurP+zHXKwdXPhtc24jCL1OE3jui8Y30Rh0CPEP5Qe0exAgPzb4fvm1WWS3rWVcPBIjFx8cKsUeTud40CXBjceYal4DoiStKxoyatvtQpwfjYkMNS0WFyLmpNntqOmRK90A2y8Zlo1pYyHEPInoCMlGlGqeppMatVasNpzJTudzYyWyLGrRjIgRfi0222Cxbmn27wdDnWVEkoaLwrQ0ZEcKUCkZz8lnLaRp6FI+8pb4ygaDNW9GxER+8wFg5uibCPyRYPdZ4G..w.k5felNvNy7XRp7uol1V2MPhvCTNH7o1pWBtgekKVYwGPvvnhsoz5zFSsiE+Ky5zJKbyM7LK1ay.0cG+Ehe9cxcXSC8Roc2xxO6Ap4l0+.MfRj1WEY2BVt8bwMv70yNPpoMrYoBXqZbNxVAnrR.Sq+XtVFE5UVC1MThnyF9IqYjunikNMaRpoW7UykOG5ltTdqXwuONITum8WA8bSeS4u3m9owiW6eJMbloAF6mj4wIpM7wu8NKYyGufpppOPT8AcgOfD3W6pVKV9xpA..RCiG9VW+YMh2t35YLJb18PoakGmZkEGD.uSVFOe3QPRgE4BSCmEc3FaNOIbt91DEkNgXEJS.msj8tgdhbKG1jNeY2PswcTj6wtVwLX+8Kni3m6EYul8niPQcuVNgsErPKXdCWNRAX4G.zOMDjFY1bLtIu9y63gPRZvh+Dw6fHZfxAgO0V8Rv0d4W.jRfXR4TyHM5yqWa8PlFNuAVWH0.W0Iq9jKUGZc4fH+aOEGvgwci3MXOPu4mNV+wOftq0aGNKdtbnEeTHjuEvxJgVFhSBi2CzqXEpSK4wM9bnNBR0IIMZM+h4mTPzGjFihhbWem9kurFGjXC3ieGchG6dGoXNW7D9felHPDp4ftvGPB7oa+RPMKIdCL0vXvMwA47NP1qdxlAt5NfysxhIf5W9Kl2suo+0MMkccHY7EYtQyQhOWJUUCWmDXY83x0VOfelogZMNawcgewZV9AL6ETl+9g4Wm.p0RurWUUpQGKtlKtOeTj8aLqPiAwIf9BRm.N749BW7S+z3XKxAAvlK3yU1PGwO.fHZHY4UFanfnNKGD979OuyFen2+4A.fXR4N+iWe8bpsq2FXlAtpSAWXwN8dcpUAj9lJ8hRSqiP2qgtYxSPBm9rSwrBfGDnNnD71Ax7MXXcMxbsrb2xONYw0YPtI.zIwOEpH7b48ii.GRvgBysWlnb+0C6JmK63LSCbx2Vuikn1vu4eZYWvyRjnmftvGPD9stlKA.pZ5SH4B84sqp9JbxUUlE8vrI7vLn+bapCphUV91p.7SwbRoryxWpnbeS5Bgtfp8rjO8ktxcKl4janxUKeUruwBW0Rbti3G0opuhVwO7sGKmNbRRChtuyVJJyEuBJTjftvmNuhVv4e1KCRIfgT12st9kOtWur5ivryQmM5ygw0InCyUL6QR51E2YJ8Tt6dl7k9P90fNYxOz4FK7M2Hj6I9oe5D.hdbsymUzzkWIfn5IiPQKJyEuBgn9frvmy9rVJ9DQtPyVXwV+er922vd8RpODmbYU19i3y.2O9ZLs3SktaSXBdrQT9TDBYJB3hV9A.8SiBI1jqdNyanMfM9WNnWOKbMBvBe.IvM+QubTyRBCCow9hgEJ6bKoKgYfVlOrC39tzoKvBeXBdzHJuBpclh.tq3G.y3+Qmhdj1Pu2wxummftKz8c0oaNW7LBvBe1vk2LtnU1.hYHOoAB2CmcWYk7MM0KFA5repuawjYJ2iMkbE9ysdC5zG4JEI+fV3Bo5tcHF.RiHfDtSbBjmhe..HhFV18c0Bd36NXuga.U3yY+9pCe73t6Bjw+0Ms9ZG2qWJ84XViJxkMzzsF2jKzJzKVI1CTta6HH0.usIjLkhin44hI+vOI9wOTMo0Iaesqsg.nVKMKkCQP4skOcprOjquWFnVqbeK+.XF+Oc5oc+cSHpdQnvi30SiBl.nvGHDn+qsMTcUggDF8uoJ2p3btRtF3xEihZnSYBxLPUJ4iB66wWGApLOKJTsVBlhGNsYegd215tIXcv6E4VGbVLXlZaH.IakKOB.9ht9rKXQsH2D.4zmC8UYkXwQ7CPx.f1M5+WUuzB64STazm9+2nE77vSg1WPS3yudaWDV8xWFLLjacSqeYQ85Uv.Do2apxF6KGNV2jcCNKi7KTna53TEhV2M.8C0WMmr9vjnRnAXqG5HJNWbgnSu+6qpwVEOwO.p.fFhNKzSi7bVaAOUHRzq3l9a5qfOQdEBwnAIgOWz41H9XW0ZgzPt063pWZed8xW.DcigmeTQcVjYJUUt4JUzI9I.TY0jSV5vIQpNMdDMmOAgrqxWY8Ae.NIHocnm3Wc9bntUg8RBEWwO.lY.V+E8qidrkPe1uRwIc7KxHIwvAEgO0V8Rvu2G8xkmb1y78XgO4M6ANeG4GDdW.Dp6c4WG.tth4DoLk0.mqqSc.8xpoBUnZsPUubxF8AeTMbIKzDzWXY5MT3xQzonndGH6Bfz8yg9lfcFnTH9A.neJZAI.ZEs3ZSEojhhady9Ayyla7D2+v.zg76Be.Ivs7w9.3jyL+HC1Q8eZudYK.iNM7zhYqrvI5BNaR7N.veA3BjX9R6PUch6.ot4SqPI1nWMNG5zOjzYSo1gZSPqVApt3+7c.+iUebxRF0B0ZW1D.0HT02JcVecKraOo5vheu2sQGgw0B06w2XZykHH29bnuxM4Eor8xF5mhhsHAHrkb9499Vo6MOHpdAnQL5cysfsto.UFfIEgFjDhs3mE97YZ+xvryM+99p+Fm2ulWudUFvNPluipIQw00S5z.PuQnD.MJR1GfZBIaEGdcvuVNPinv1DVGAx5toTqv+acGylSZ1bASaPIpYq3uE..T.nIQTPTozLP8sd7dUFd0GTuWYNWLyTxZAv8VDutlUVdmDuVKz6FdxDd4MpYKkFK+XR9ZAnUzRgGzyVgn5EFgGA8t4FbuSZIfG+9hpr9i+T3yUeQmGVVsK409p+FmWvyxZ9SlFYtkWTLZkEV4fvY2tAn9C0cAkPoaM9WaGrvG+.S.8bqgo30xEz0ZFsC0mW6M9WuAT7D93z5asoMWZCI+cnhs6hJFYKpUz8ygkTJshe.xeAPm+k4xSDpMRVcTW9jVzQFxrAm5uD9r5y9rvU17Jes+oa37uXudMpLC69CSyfRyeLw2c2ZL4DOXNbrkSuW6Ges3qb4SZLIJd2L0LvmlcckdwO.lBfVetjF7x09gb8oAQT2T+e8gb8SbwjG8qLpDT+9IgOfHb9K+8s0+YV3SwfIgJc1sRo5OtaZFdlfGaC4lECJmdu1r.F5mHecQcoJHgeD3biUNeXavmJ7yaD+.jLM30U.zE9AKJSCB31E+9ey9JJm7hEO58DUJk2suP3Cv9L.csO2mORed7pR4LVSm8YPo6OrOM.teTd4RjJA1Cx8Oi3FuWOC7OBn1FJNalmunS1aZGkxe2KJb20rsBen6tLw6D+.XJ.pEHMR+NaWLKoNf09qTrlICg+fsDrhSku+e8fRRzumI7AzTPRax3u62LBt2qeDud4nLGqoz9nv8akEYii.U.WluEnrYPwO9jJGYBj6q4y.0FNQyyqYg7d8Lwet9EwO.p0gB4FEbyaxXZnDjkqTpsZRTnlmEhnqIgp5u6aE9.30he.r1JL1pSGpbcan3LGHpdAPTz6VBVA.8Ce2QkFFWKHbnRlvGhlRBb2FFy2hwl+MBVtLLXi4eHtXGbh1wQfpT+uUn+layfjsQ.eUwMKfvzPIlP26DeOP8dTgtgi460aG5uAn46y9Q2arMn1H14avNIGDp097QrR1X2H2rt1Dva9cmc.0mA1AxMQPSB0eivu9YgTf75IPJrEYeNkJ7zCrIfSeb.QHa9WXaebRiiAhPPB5tkeidGrD8p08n66pAJbMCPgnA.Ep9hhvGPGRRTTILFB22mLPUh.JinK3OhkAyzv0Ls1shYih7fnzZgpfFaDYuTBXtALPxRGv5PpYQ2QfZCxho0.ifjueakRw01swrtD0HV7qmIg50jc8oth07nUr3e+wbc8.kf4gtzJTe1yrouZEyFZb5MHVeO9KwO..aQFAvHJxTGg+fOEnc9OUTD+.QHXfvqEesO63k1WztDcu4FnZVX.hB0GBIZtfE9.ZJIggEBwvwtuO4vd8KOFlxHxEwOLLLtL9OwO..aQ1.fwffD2tcCS+6+uAN9urnH9QRgtO4+3MOPo9krqyMu4HDEtGPTmTnPaPKgOPNkjDiBJzHRfQv+vmYDu9kACSYJr3GFFOjRWEdNWne5D.X.rE4vwsBTyVGV19MC5Q+aKVW8fUfOmIdfMMpLd5UJA.589aAxvsfvR.P.RIPnPpiUJ.pd1Qw80O6NKFFFFlxd7mheLoeZD.zB1RrAAv.fD0C.fUeI.Mudfi7hd3jKfwVu0wAv3d7rfgggggwyw6y1Kcn+PCBHhXMivjezOmJ82caH43t+IkggggggwuPvP7C.P+z3n+P8AIVKla5eJVRsP10s45WFogHpqeRYXXXXXX7MDbD+XR+z33VV5uBF6EZCKL+qgK6Wy0N0Robq3q8YGw0NgLLLLLLL9N72w7S13tu5WD.WrbC81.Bsr9HorOn5Dt4ERo79jeieufeVdwvvTNPopmNwvTQh+LU2yW932dK.U0IEJTmHTnHPDtsrlp6jXJYnPCKEhn3e5ObDud5yvvTwfco59LPUEfKmZxnLL9RJuD+XGceWsfvgaAHbb6bEFHbX.YUm.Oveb91ocYXXXJDrJ9YRjrYjFTpVxLLLLLLLL4DaD.eI.zgWOQXXpD4+e9yf1I.FXOL......IUjSD4pPfIH" ],
									"embed" : 1,
									"id" : "obj-99",
									"maxclass" : "fpic",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "jit_matrix" ],
									"patching_rect" : [ 15.0, 15.0, 287.5, 100.0 ],
									"pic" : "fluidcorpusmanipulation.png",
									"presentation" : 1,
									"presentation_rect" : [ 15.0, 15.0, 405.0, 135.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-97",
									"linecount" : 2,
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 21.046584000000053, 925.0, 129.0, 35.0 ],
									"text" : ";\rmax launchbrowser $1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-95",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "https://discourse.flucoma.org" ],
									"patching_rect" : [ 21.046584000000053, 899.0, 169.0, 22.0 ],
									"text" : "t https://discourse.flucoma.org"
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 0.301961, 0.301961, 0.301961, 1.0 ],
									"bgcolor2" : [ 0.301961, 0.301961, 0.301961, 1.0 ],
									"bgfillcolor_angle" : 270.0,
									"bgfillcolor_autogradient" : 0.0,
									"bgfillcolor_color" : [ 0.2, 0.2, 0.2, 0.0 ],
									"bgfillcolor_color1" : [ 0.301961, 0.301961, 0.301961, 1.0 ],
									"bgfillcolor_color2" : [ 0.2, 0.2, 0.2, 1.0 ],
									"bgfillcolor_proportion" : 0.5,
									"bgfillcolor_type" : "color",
									"fontname" : "Lato",
									"fontsize" : 16.0,
									"gradient" : 1,
									"id" : "obj-85",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 21.046584000000053, 851.0, 78.0, 28.0 ],
									"presentation" : 1,
									"presentation_rect" : [ 618.0, 59.0, 78.0, 28.0 ],
									"text" : "our forum",
									"textcolor" : [ 0.321569, 0.54902, 0.792157, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"fontname" : "Lato",
									"fontsize" : 16.0,
									"id" : "obj-84",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 15.0, 780.0, 192.0, 26.0 ],
									"presentation" : 1,
									"presentation_rect" : [ 435.0, 60.0, 185.0, 26.0 ],
									"text" : "More help / discussion at"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-5", 0 ],
									"source" : [ "obj-1", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-23", 0 ],
									"source" : [ "obj-11", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-4", 0 ],
									"source" : [ "obj-5", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-95", 0 ],
									"source" : [ "obj-85", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-97", 0 ],
									"source" : [ "obj-95", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 471.0, 555.0, 166.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"tags" : ""
					}
,
					"text" : "p \"Fluid Corpus Manipulation\""
				}

			}
 ],
		"lines" : [  ],
		"parameters" : 		{
			"obj-6::obj-23::obj-13" : [ "live.tab[3]", "live.tab[3]", 0 ],
			"obj-6::obj-23::obj-23" : [ "live.tab[19]", "live.tab", 0 ],
			"obj-6::obj-23::obj-24" : [ "live.tab[1]", "live.tab", 0 ],
			"obj-6::obj-23::obj-25" : [ "live.tab[4]", "live.tab", 0 ],
			"obj-6::obj-23::obj-32" : [ "live.tab[5]", "live.tab[3]", 0 ],
			"obj-6::obj-23::obj-75" : [ "live.tab[24]", "live.tab[17]", 0 ],
			"obj-6::obj-23::obj-9::obj-68::obj-1" : [ "live.tab[41]", "live.tab", 0 ],
			"obj-6::obj-23::obj-9::obj-68::obj-3" : [ "live.tab[42]", "live.tab", 0 ],
			"obj-6::obj-23::obj-9::obj-69::obj-40" : [ "live.tab[34]", "live.tab", 0 ],
			"obj-6::obj-23::obj-9::obj-69::obj-41" : [ "live.tab[23]", "live.tab", 0 ],
			"obj-6::obj-23::obj-9::obj-70::obj-42" : [ "live.tab[40]", "live.tab", 0 ],
			"obj-6::obj-23::obj-9::obj-70::obj-43" : [ "live.tab[39]", "live.tab", 0 ],
			"obj-6::obj-23::obj-9::obj-70::obj-44" : [ "live.tab[33]", "live.tab", 0 ],
			"obj-6::obj-23::obj-9::obj-70::obj-45" : [ "live.tab[22]", "live.tab", 0 ],
			"obj-6::obj-23::obj-9::obj-70::obj-46" : [ "live.tab[38]", "live.tab", 0 ],
			"obj-6::obj-23::obj-9::obj-70::obj-47" : [ "live.tab[32]", "live.tab", 0 ],
			"obj-6::obj-23::obj-9::obj-71::obj-10" : [ "live.tab[37]", "live.tab", 0 ],
			"obj-6::obj-23::obj-9::obj-71::obj-9" : [ "live.tab[31]", "live.tab", 0 ],
			"obj-6::obj-23::obj-9::obj-72::obj-58" : [ "live.tab[21]", "live.tab", 0 ],
			"obj-6::obj-23::obj-9::obj-72::obj-59" : [ "live.tab[36]", "live.tab", 0 ],
			"obj-6::obj-23::obj-9::obj-72::obj-60" : [ "live.tab[35]", "live.tab", 0 ],
			"obj-6::obj-23::obj-9::obj-73::obj-56" : [ "live.tab[20]", "live.tab", 0 ],
			"obj-6::obj-23::obj-9::obj-73::obj-57" : [ "live.tab[30]", "live.tab", 0 ],
			"parameterbanks" : 			{

			}
,
			"inherited_shortname" : 1
		}
,
		"autosave" : 0,
		"styles" : [ 			{
				"name" : "max6box",
				"default" : 				{
					"accentcolor" : [ 0.8, 0.839216, 0.709804, 1.0 ],
					"bgcolor" : [ 1.0, 1.0, 1.0, 0.5 ],
					"textcolor_inverse" : [ 0.0, 0.0, 0.0, 1.0 ]
				}
,
				"parentstyle" : "",
				"multi" : 0
			}
, 			{
				"name" : "max6inlet",
				"default" : 				{
					"color" : [ 0.423529, 0.372549, 0.27451, 1.0 ]
				}
,
				"parentstyle" : "",
				"multi" : 0
			}
, 			{
				"name" : "max6message",
				"default" : 				{
					"bgfillcolor" : 					{
						"angle" : 270.0,
						"autogradient" : 0,
						"color" : [ 0.290196, 0.309804, 0.301961, 1.0 ],
						"color1" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
						"color2" : [ 0.788235, 0.788235, 0.788235, 1.0 ],
						"proportion" : 0.39,
						"type" : "gradient"
					}
,
					"textcolor_inverse" : [ 0.0, 0.0, 0.0, 1.0 ]
				}
,
				"parentstyle" : "max6box",
				"multi" : 0
			}
, 			{
				"name" : "max6outlet",
				"default" : 				{
					"color" : [ 0.0, 0.454902, 0.498039, 1.0 ]
				}
,
				"parentstyle" : "",
				"multi" : 0
			}
 ]
	}

}
