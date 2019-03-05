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
		"rect" : [ 34.0, 79.0, 1212.0, 955.0 ],
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
		"showontab" : 1,
		"boxes" : [ 			{
				"box" : 				{
					"hidden" : 1,
					"id" : "obj-6",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 7,
							"minor" : 3,
							"revision" : 5,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"rect" : [ 34.0, 105.0, 1212.0, 929.0 ],
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
						"showontab" : 1,
						"boxes" : [ 							{
								"box" : 								{
									"id" : "obj-14",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 571.0, 89.0, 97.0, 22.0 ],
									"style" : "",
									"text" : "sizeinsamps 1 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-49",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 86.5, 488.5, 254.0, 20.0 ],
									"style" : "",
									"text" : "filters"
								}

							}
, 							{
								"box" : 								{
									"buffername" : "filter",
									"chanoffset" : 3,
									"id" : "obj-46",
									"maxclass" : "waveform~",
									"numinlets" : 5,
									"numoutlets" : 6,
									"outlettype" : [ "float", "float", "float", "float", "list", "" ],
									"patching_rect" : [ 63.0, 728.0, 438.0, 73.0 ],
									"style" : "",
									"voffset" : 1.0
								}

							}
, 							{
								"box" : 								{
									"buffername" : "filter",
									"chanoffset" : 2,
									"id" : "obj-47",
									"maxclass" : "waveform~",
									"numinlets" : 5,
									"numoutlets" : 6,
									"outlettype" : [ "float", "float", "float", "float", "list", "" ],
									"patching_rect" : [ 63.0, 650.0, 438.0, 73.0 ],
									"style" : "",
									"voffset" : 1.0
								}

							}
, 							{
								"box" : 								{
									"buffername" : "filter",
									"id" : "obj-48",
									"maxclass" : "waveform~",
									"numinlets" : 5,
									"numoutlets" : 6,
									"outlettype" : [ "float", "float", "float", "float", "list", "" ],
									"patching_rect" : [ 63.0, 573.0, 438.0, 73.0 ],
									"style" : "",
									"voffset" : 1.0
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-45",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 63.0, 343.0, 24.0, 24.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-43",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 567.0, 273.5, 103.0, 22.0 ],
									"style" : "",
									"text" : "filtupdate 1, bang"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-42",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 963.0, 516.0, 113.0, 22.0 ],
									"style" : "",
									"text" : "name didact-dest 3"
								}

							}
, 							{
								"box" : 								{
									"buffername" : "didact-dest",
									"chanoffset" : 3,
									"id" : "obj-41",
									"maxclass" : "waveform~",
									"numinlets" : 5,
									"numoutlets" : 6,
									"outlettype" : [ "float", "float", "float", "float", "list", "" ],
									"patching_rect" : [ 724.0, 728.0, 438.0, 73.0 ],
									"style" : "",
									"voffset" : 1.0
								}

							}
, 							{
								"box" : 								{
									"buffername" : "didact-dest",
									"chanoffset" : 2,
									"id" : "obj-40",
									"maxclass" : "waveform~",
									"numinlets" : 5,
									"numoutlets" : 6,
									"outlettype" : [ "float", "float", "float", "float", "list", "" ],
									"patching_rect" : [ 724.0, 650.0, 438.0, 73.0 ],
									"style" : "",
									"voffset" : 1.0
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-39",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 230.0, 516.0, 77.0, 22.0 ],
									"style" : "",
									"text" : "name filter 3"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-38",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 151.0, 516.0, 77.0, 22.0 ],
									"style" : "",
									"text" : "name filter 2"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-37",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 70.0, 516.0, 77.0, 22.0 ],
									"style" : "",
									"text" : "name filter 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-27",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 428.0, 70.0, 24.0, 24.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-20",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patcher" : 									{
										"fileversion" : 1,
										"appversion" : 										{
											"major" : 7,
											"minor" : 3,
											"revision" : 5,
											"architecture" : "x64",
											"modernui" : 1
										}
,
										"rect" : [ 691.0, -788.0, 640.0, 480.0 ],
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
										"boxes" : [ 											{
												"box" : 												{
													"id" : "obj-13",
													"maxclass" : "newobj",
													"numinlets" : 3,
													"numoutlets" : 1,
													"outlettype" : [ "float" ],
													"patching_rect" : [ 105.0, 299.0, 80.0, 22.0 ],
													"style" : "",
													"text" : "peek~ filter 3"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-11",
													"maxclass" : "button",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "bang" ],
													"patching_rect" : [ 77.0, 40.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-9",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"patching_rect" : [ 292.0, 264.0, 29.5, 22.0 ],
													"style" : "",
													"text" : "+ 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-8",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"patching_rect" : [ 292.0, 240.0, 34.0, 22.0 ],
													"style" : "",
													"text" : "> 50"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-7",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 4,
													"outlettype" : [ "int", "float", "int", "int" ],
													"patching_rect" : [ 201.0, 204.0, 56.0, 22.0 ],
													"style" : "",
													"text" : "t i 0.1 1 i"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-5",
													"maxclass" : "newobj",
													"numinlets" : 3,
													"numoutlets" : 1,
													"outlettype" : [ "float" ],
													"patching_rect" : [ 222.0, 295.0, 80.0, 22.0 ],
													"style" : "",
													"text" : "peek~ filter 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-4",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 3,
													"outlettype" : [ "bang", "bang", "int" ],
													"patching_rect" : [ 141.0, 154.0, 59.0, 22.0 ],
													"style" : "",
													"text" : "uzi 513 0"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-3",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 234.0, 128.0, 100.0, 22.0 ],
													"style" : "",
													"text" : "sizeinsamps 513"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-14",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "float", "bang" ],
													"patching_rect" : [ 234.0, 154.0, 94.0, 22.0 ],
													"style" : "",
													"text" : "buffer~ filter 3 3"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-2",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "bang", "bang" ],
													"patching_rect" : [ 141.0, 104.0, 34.0, 22.0 ],
													"style" : "",
													"text" : "t b b"
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
													"outlettype" : [ "bang" ],
													"patching_rect" : [ 141.0, 63.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
 ],
										"lines" : [ 											{
												"patchline" : 												{
													"destination" : [ "obj-2", 0 ],
													"source" : [ "obj-1", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-2", 0 ],
													"source" : [ "obj-11", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-3", 0 ],
													"source" : [ "obj-2", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-4", 0 ],
													"source" : [ "obj-2", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-14", 0 ],
													"source" : [ "obj-3", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-7", 0 ],
													"source" : [ "obj-4", 2 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-13", 1 ],
													"source" : [ "obj-7", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-13", 0 ],
													"order" : 1,
													"source" : [ "obj-7", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-5", 1 ],
													"source" : [ "obj-7", 2 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-5", 0 ],
													"order" : 0,
													"source" : [ "obj-7", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-8", 0 ],
													"source" : [ "obj-7", 3 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-9", 0 ],
													"source" : [ "obj-8", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-5", 2 ],
													"source" : [ "obj-9", 0 ]
												}

											}
 ],
										"styles" : [ 											{
												"name" : "max6box",
												"default" : 												{
													"textcolor_inverse" : [ 0.0, 0.0, 0.0, 1.0 ],
													"accentcolor" : [ 0.8, 0.839216, 0.709804, 1.0 ],
													"bgcolor" : [ 1.0, 1.0, 1.0, 0.5 ]
												}
,
												"parentstyle" : "",
												"multi" : 0
											}
, 											{
												"name" : "max6inlet",
												"default" : 												{
													"color" : [ 0.423529, 0.372549, 0.27451, 1.0 ]
												}
,
												"parentstyle" : "",
												"multi" : 0
											}
, 											{
												"name" : "max6message",
												"default" : 												{
													"textcolor_inverse" : [ 0.0, 0.0, 0.0, 1.0 ],
													"bgfillcolor" : 													{
														"type" : "gradient",
														"color1" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
														"color2" : [ 0.788235, 0.788235, 0.788235, 1.0 ],
														"color" : [ 0.290196, 0.309804, 0.301961, 1.0 ],
														"angle" : 270.0,
														"proportion" : 0.39,
														"autogradient" : 0
													}

												}
,
												"parentstyle" : "max6box",
												"multi" : 0
											}
, 											{
												"name" : "max6outlet",
												"default" : 												{
													"color" : [ 0.0, 0.454902, 0.498039, 1.0 ]
												}
,
												"parentstyle" : "",
												"multi" : 0
											}
 ]
									}
,
									"patching_rect" : [ 428.0, 100.0, 61.0, 22.0 ],
									"saved_object_attributes" : 									{
										"description" : "",
										"digest" : "",
										"globalpatchername" : "",
										"style" : "",
										"tags" : ""
									}
,
									"style" : "",
									"text" : "p fill_filter"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-25",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 745.0, 488.5, 254.0, 20.0 ],
									"style" : "",
									"text" : "watch for a clear different between activations"
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
									"fontname" : "Arial Bold",
									"hint" : "",
									"id" : "obj-33",
									"ignoreclick" : 1,
									"legacytextcolor" : 1,
									"maxclass" : "textbutton",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 44.0, 43.0, 20.0, 20.0 ],
									"presentation_rect" : [ 1230.0, 342.0, 20.0, 20.0 ],
									"rounded" : 60.0,
									"style" : "",
									"text" : "1",
									"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
									"fontname" : "Arial Bold",
									"hint" : "",
									"id" : "obj-32",
									"ignoreclick" : 1,
									"legacytextcolor" : 1,
									"maxclass" : "textbutton",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 44.0, 151.0, 20.0, 20.0 ],
									"presentation_rect" : [ 1231.0, 374.5, 20.0, 20.0 ],
									"rounded" : 60.0,
									"style" : "",
									"text" : "2",
									"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
									"fontname" : "Arial Bold",
									"hint" : "",
									"id" : "obj-22",
									"ignoreclick" : 1,
									"legacytextcolor" : 1,
									"maxclass" : "textbutton",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 44.0, 257.0, 20.0, 20.0 ],
									"presentation_rect" : [ 1230.0, 402.5, 20.0, 20.0 ],
									"rounded" : 60.0,
									"style" : "",
									"text" : "3",
									"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
									"fontname" : "Arial Bold",
									"hint" : "",
									"id" : "obj-26",
									"ignoreclick" : 1,
									"legacytextcolor" : 1,
									"maxclass" : "textbutton",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 723.0, 488.5, 20.0, 20.0 ],
									"presentation_rect" : [ 1234.0, 435.5, 20.0, 20.0 ],
									"rounded" : 60.0,
									"style" : "",
									"text" : "4",
									"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
									"fontname" : "Arial Bold",
									"hint" : "",
									"id" : "obj-24",
									"ignoreclick" : 1,
									"legacytextcolor" : 1,
									"maxclass" : "textbutton",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 532.0, 248.5, 20.0, 20.0 ],
									"presentation_rect" : [ 1234.0, 468.067627, 20.0, 20.0 ],
									"rounded" : 60.0,
									"style" : "",
									"text" : "5",
									"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-19",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 561.0, 245.0, 298.0, 20.0 ],
									"style" : "",
									"text" : "improve the filter by allowing to update the seed filters"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-17",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 732.0, 10.0, 116.0, 22.0 ],
									"style" : "",
									"text" : "name didact-source"
								}

							}
, 							{
								"box" : 								{
									"buffername" : "didact-source",
									"id" : "obj-15",
									"maxclass" : "waveform~",
									"numinlets" : 5,
									"numoutlets" : 6,
									"outlettype" : [ "float", "float", "float", "float", "list", "" ],
									"patching_rect" : [ 732.0, 54.5, 438.0, 113.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"format" : 6,
									"id" : "obj-31",
									"maxclass" : "flonum",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 1083.0, 516.0, 50.0, 22.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-29",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 837.0, 516.0, 113.0, 22.0 ],
									"style" : "",
									"text" : "name didact-dest 2"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-28",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 720.0, 516.0, 113.0, 22.0 ],
									"style" : "",
									"text" : "name didact-dest 1"
								}

							}
, 							{
								"box" : 								{
									"buffername" : "didact-dest",
									"id" : "obj-18",
									"maxclass" : "waveform~",
									"numinlets" : 5,
									"numoutlets" : 6,
									"outlettype" : [ "float", "float", "float", "float", "list", "" ],
									"patching_rect" : [ 724.0, 573.0, 438.0, 73.0 ],
									"style" : "",
									"voffset" : 1.0
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-16",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 63.0, 257.0, 251.0, 20.0 ],
									"style" : "",
									"text" : "decompose in 3 ranks with nmf with fixed dict"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-9",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 66.0, 151.0, 251.0, 20.0 ],
									"style" : "",
									"text" : "composite a buffer to have them sequencially"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-4",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 66.0, 43.0, 579.0, 20.0 ],
									"style" : "",
									"text" : "create 2 sines of clearly different frequency and 3 seeding filters (2 blocks of frequencies and a bit of dc)"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-13",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 561.0, 145.5, 130.0, 22.0 ],
									"style" : "",
									"text" : "buffer~ didact-dest 1 2"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-12",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 63.0, 279.0, 103.0, 22.0 ],
									"style" : "",
									"text" : "filtupdate 2, bang"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-11",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "" ],
									"patching_rect" : [ 63.0, 309.0, 436.0, 22.0 ],
									"style" : "",
									"text" : "fluid.bufnmf~ @srcbuf didact-source @envbuf didact-dest @filtbuf filter @rank 3"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-10",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 63.0, 180.0, 523.0, 22.0 ],
									"style" : "",
									"text" : "reset, dstgain 1, dstbuf didact-source, srcbuf lowsine, bang, srcbuf hisine, dststartat 44100, bang"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-8",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 561.0, 118.0, 123.0, 22.0 ],
									"style" : "",
									"text" : "buffer~ didact-source"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-7",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "" ],
									"patching_rect" : [ 63.0, 211.0, 108.0, 22.0 ],
									"style" : "",
									"text" : "fluid.bufcompose~"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-6",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 243.0, 70.0, 71.0, 22.0 ],
									"style" : "",
									"text" : "fill sin 5000"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-2",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 243.0, 100.0, 170.0, 22.0 ],
									"style" : "",
									"text" : "buffer~ hisine @samps 44100"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-1",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 60.0, 100.0, 179.0, 22.0 ],
									"style" : "",
									"text" : "buffer~ lowsine @samps 44100"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-5",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 60.0, 70.0, 64.0, 22.0 ],
									"style" : "",
									"text" : "fill sin 500"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-7", 0 ],
									"source" : [ "obj-10", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-45", 0 ],
									"source" : [ "obj-11", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-11", 0 ],
									"source" : [ "obj-12", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-8", 0 ],
									"source" : [ "obj-14", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-15", 0 ],
									"source" : [ "obj-17", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-20", 0 ],
									"source" : [ "obj-27", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-18", 0 ],
									"source" : [ "obj-28", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-40", 0 ],
									"source" : [ "obj-29", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-18", 1 ],
									"order" : 2,
									"source" : [ "obj-31", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-40", 1 ],
									"order" : 1,
									"source" : [ "obj-31", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-41", 1 ],
									"order" : 0,
									"source" : [ "obj-31", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-48", 0 ],
									"source" : [ "obj-37", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-47", 0 ],
									"source" : [ "obj-38", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-46", 0 ],
									"source" : [ "obj-39", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-41", 0 ],
									"source" : [ "obj-42", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-11", 0 ],
									"midpoints" : [ 576.5, 306.75, 72.5, 306.75 ],
									"source" : [ "obj-43", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-28", 0 ],
									"order" : 2,
									"source" : [ "obj-45", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-29", 0 ],
									"order" : 1,
									"source" : [ "obj-45", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-37", 0 ],
									"order" : 5,
									"source" : [ "obj-45", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-38", 0 ],
									"order" : 4,
									"source" : [ "obj-45", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-39", 0 ],
									"order" : 3,
									"source" : [ "obj-45", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-42", 0 ],
									"order" : 0,
									"source" : [ "obj-45", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-1", 0 ],
									"source" : [ "obj-5", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-2", 0 ],
									"source" : [ "obj-6", 0 ]
								}

							}
 ],
						"styles" : [ 							{
								"name" : "max6box",
								"default" : 								{
									"textcolor_inverse" : [ 0.0, 0.0, 0.0, 1.0 ],
									"accentcolor" : [ 0.8, 0.839216, 0.709804, 1.0 ],
									"bgcolor" : [ 1.0, 1.0, 1.0, 0.5 ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
, 							{
								"name" : "max6inlet",
								"default" : 								{
									"color" : [ 0.423529, 0.372549, 0.27451, 1.0 ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
, 							{
								"name" : "max6message",
								"default" : 								{
									"textcolor_inverse" : [ 0.0, 0.0, 0.0, 1.0 ],
									"bgfillcolor" : 									{
										"type" : "gradient",
										"color1" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
										"color2" : [ 0.788235, 0.788235, 0.788235, 1.0 ],
										"color" : [ 0.290196, 0.309804, 0.301961, 1.0 ],
										"angle" : 270.0,
										"proportion" : 0.39,
										"autogradient" : 0
									}

								}
,
								"parentstyle" : "max6box",
								"multi" : 0
							}
, 							{
								"name" : "max6outlet",
								"default" : 								{
									"color" : [ 0.0, 0.454902, 0.498039, 1.0 ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
 ]
					}
,
					"patching_rect" : [ 599.0, 1052.0, 139.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"style" : "",
						"tags" : ""
					}
,
					"style" : "",
					"text" : "p \"updating dictionaries\""
				}

			}
, 			{
				"box" : 				{
					"hidden" : 1,
					"id" : "obj-4",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 7,
							"minor" : 3,
							"revision" : 5,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"rect" : [ 0.0, 26.0, 1212.0, 929.0 ],
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
						"showontab" : 1,
						"boxes" : [ 							{
								"box" : 								{
									"id" : "obj-30",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 63.0, 279.0, 24.0, 24.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-23",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 434.0, 78.0, 97.0, 22.0 ],
									"style" : "",
									"text" : "sizeinsamps 1 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-25",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 576.0, 195.5, 254.0, 20.0 ],
									"style" : "",
									"text" : "watch for a clear different between activations"
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
									"fontname" : "Arial Bold",
									"hint" : "",
									"id" : "obj-33",
									"ignoreclick" : 1,
									"legacytextcolor" : 1,
									"maxclass" : "textbutton",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 44.0, 43.0, 20.0, 20.0 ],
									"presentation_rect" : [ 1230.0, 342.0, 20.0, 20.0 ],
									"rounded" : 60.0,
									"style" : "",
									"text" : "1",
									"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
									"fontname" : "Arial Bold",
									"hint" : "",
									"id" : "obj-32",
									"ignoreclick" : 1,
									"legacytextcolor" : 1,
									"maxclass" : "textbutton",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 44.0, 151.0, 20.0, 20.0 ],
									"presentation_rect" : [ 1231.0, 374.5, 20.0, 20.0 ],
									"rounded" : 60.0,
									"style" : "",
									"text" : "2",
									"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
									"fontname" : "Arial Bold",
									"hint" : "",
									"id" : "obj-22",
									"ignoreclick" : 1,
									"legacytextcolor" : 1,
									"maxclass" : "textbutton",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 44.0, 257.0, 20.0, 20.0 ],
									"presentation_rect" : [ 1230.0, 402.5, 20.0, 20.0 ],
									"rounded" : 60.0,
									"style" : "",
									"text" : "3",
									"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
									"fontname" : "Arial Bold",
									"hint" : "",
									"id" : "obj-26",
									"ignoreclick" : 1,
									"legacytextcolor" : 1,
									"maxclass" : "textbutton",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 554.0, 195.5, 20.0, 20.0 ],
									"presentation_rect" : [ 1234.0, 435.5, 20.0, 20.0 ],
									"rounded" : 60.0,
									"style" : "",
									"text" : "4",
									"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
									"fontname" : "Arial Bold",
									"hint" : "",
									"id" : "obj-24",
									"ignoreclick" : 1,
									"legacytextcolor" : 1,
									"maxclass" : "textbutton",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 35.0, 442.5, 20.0, 20.0 ],
									"presentation_rect" : [ 1234.0, 468.067627, 20.0, 20.0 ],
									"rounded" : 60.0,
									"style" : "",
									"text" : "5",
									"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-19",
									"linecount" : 2,
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 57.0, 436.0, 298.0, 33.0 ],
									"style" : "",
									"text" : "composite a buffer to have them superimposed, for harder training. Not remotely as conclusive."
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-20",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 57.0, 471.0, 431.0, 22.0 ],
									"style" : "",
									"text" : "reset, dstgain 1, dstbuf didact-source, srcbuf lowsine, bang, srcbuf hisine, bang"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-17",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 558.0, 10.0, 116.0, 22.0 ],
									"style" : "",
									"text" : "name didact-source"
								}

							}
, 							{
								"box" : 								{
									"buffername" : "didact-source",
									"chanoffset" : 0,
									"id" : "obj-15",
									"maxclass" : "waveform~",
									"numinlets" : 5,
									"numoutlets" : 6,
									"outlettype" : [ "float", "float", "float", "float", "list", "" ],
									"patching_rect" : [ 558.0, 54.5, 438.0, 113.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"format" : 6,
									"id" : "obj-31",
									"maxclass" : "flonum",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 796.0, 222.0, 50.0, 22.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-29",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 671.0, 222.0, 113.0, 22.0 ],
									"style" : "",
									"text" : "name didact-dest 2"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-28",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 554.0, 222.0, 113.0, 22.0 ],
									"style" : "",
									"text" : "name didact-dest 1"
								}

							}
, 							{
								"box" : 								{
									"buffername" : "didact-dest",
									"chanoffset" : 2,
									"id" : "obj-21",
									"maxclass" : "waveform~",
									"numinlets" : 5,
									"numoutlets" : 6,
									"outlettype" : [ "float", "float", "float", "float", "list", "" ],
									"patching_rect" : [ 558.0, 396.0, 438.0, 113.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"buffername" : "didact-dest",
									"id" : "obj-18",
									"maxclass" : "waveform~",
									"numinlets" : 5,
									"numoutlets" : 6,
									"outlettype" : [ "float", "float", "float", "float", "list", "" ],
									"patching_rect" : [ 558.0, 279.0, 438.0, 113.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-16",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 63.0, 257.0, 176.0, 20.0 ],
									"style" : "",
									"text" : "decompose in 2 ranks with nmf"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-9",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 66.0, 151.0, 251.0, 20.0 ],
									"style" : "",
									"text" : "composite a buffer to have them sequencially"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-4",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 66.0, 43.0, 253.0, 20.0 ],
									"style" : "",
									"text" : "create 2 sines of clearly different frequency"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-13",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 375.0, 150.0, 130.0, 22.0 ],
									"style" : "",
									"text" : "buffer~ didact-dest 1 2"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-11",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "" ],
									"patching_rect" : [ 63.0, 309.0, 366.0, 22.0 ],
									"style" : "",
									"text" : "fluid.bufnmf~ @srcbuf didact-source @envbuf didact-dest @rank 2"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-10",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 63.0, 180.0, 523.0, 22.0 ],
									"style" : "",
									"text" : "reset, dstgain 1, dstbuf didact-source, srcbuf lowsine, bang, srcbuf hisine, dststartat 44100, bang"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-8",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 375.0, 124.0, 123.0, 22.0 ],
									"style" : "",
									"text" : "buffer~ didact-source"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-7",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "" ],
									"patching_rect" : [ 63.0, 211.0, 108.0, 22.0 ],
									"style" : "",
									"text" : "fluid.bufcompose~"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-6",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 243.0, 70.0, 71.0, 22.0 ],
									"style" : "",
									"text" : "fill sin 5000"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-2",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 243.0, 100.0, 170.0, 22.0 ],
									"style" : "",
									"text" : "buffer~ hisine @samps 44100"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-1",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 60.0, 100.0, 179.0, 22.0 ],
									"style" : "",
									"text" : "buffer~ lowsine @samps 44100"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-5",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 60.0, 70.0, 64.0, 22.0 ],
									"style" : "",
									"text" : "fill sin 500"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-7", 0 ],
									"source" : [ "obj-10", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-15", 0 ],
									"source" : [ "obj-17", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-7", 0 ],
									"midpoints" : [ 66.5, 497.0, 33.0, 497.0, 33.0, 208.0, 72.5, 208.0 ],
									"source" : [ "obj-20", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-8", 0 ],
									"source" : [ "obj-23", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-18", 0 ],
									"source" : [ "obj-28", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-21", 0 ],
									"source" : [ "obj-29", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-11", 0 ],
									"source" : [ "obj-30", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-18", 1 ],
									"order" : 1,
									"source" : [ "obj-31", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-21", 1 ],
									"order" : 0,
									"source" : [ "obj-31", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-1", 0 ],
									"source" : [ "obj-5", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-2", 0 ],
									"source" : [ "obj-6", 0 ]
								}

							}
 ],
						"styles" : [ 							{
								"name" : "max6box",
								"default" : 								{
									"textcolor_inverse" : [ 0.0, 0.0, 0.0, 1.0 ],
									"accentcolor" : [ 0.8, 0.839216, 0.709804, 1.0 ],
									"bgcolor" : [ 1.0, 1.0, 1.0, 0.5 ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
, 							{
								"name" : "max6inlet",
								"default" : 								{
									"color" : [ 0.423529, 0.372549, 0.27451, 1.0 ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
, 							{
								"name" : "max6message",
								"default" : 								{
									"textcolor_inverse" : [ 0.0, 0.0, 0.0, 1.0 ],
									"bgfillcolor" : 									{
										"type" : "gradient",
										"color1" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
										"color2" : [ 0.788235, 0.788235, 0.788235, 1.0 ],
										"color" : [ 0.290196, 0.309804, 0.301961, 1.0 ],
										"angle" : 270.0,
										"proportion" : 0.39,
										"autogradient" : 0
									}

								}
,
								"parentstyle" : "max6box",
								"multi" : 0
							}
, 							{
								"name" : "max6outlet",
								"default" : 								{
									"color" : [ 0.0, 0.454902, 0.498039, 1.0 ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
 ]
					}
,
					"patching_rect" : [ 16.0, 1051.0, 118.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"style" : "",
						"tags" : ""
					}
,
					"style" : "",
					"text" : "p \"didactic example\""
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-7",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 84.0, 596.0, 487.0, 20.0 ],
					"style" : "",
					"text" : "This is the method that calls for the factorisation to be calculated on a given source buffer."
				}

			}
, 			{
				"box" : 				{
					"fontface" : 1,
					"id" : "obj-24",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 16.0, 576.0, 66.0, 20.0 ],
					"style" : "",
					"text" : "message:"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-19",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 84.0, 576.0, 338.0, 20.0 ],
					"style" : "",
					"text" : "process srcBuf <startAt> <nFrames> <startChan> <nChans> "
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-18",
					"linecount" : 25,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 113.449341, 639.0, 1360.0, 342.0 ],
					"style" : "",
					"text" : "The index of the buffer to use as the source material to be decomposed through the NMF process. The different channels of multichannel buffers will be processing sequentially.\nWhere in the srcBuf should the NMF process start, in sample.\nHow many frames should be processed.\nFor multichannel srcBuf, which channel should be processed first.\nFor multichannel srcBuf, how many channel should be processed.\nThe index of the buffer where the different reconstructed ranks will be reconstructed. The buffer will be resized to rank * numChannelsProcessed channels and sourceDuration lenght. If nil is provided, the reconstruction will not happen.\nThe index of the buffer where the different dictionaries will be written to and/or read from: the behaviour is set in the following argument. If nil is provided, no dictionary will be returned.\nThis flag decides of how the dictionnary buffer passed as the previous argument is treated.\nThe dictionaries are seeded randomly, and the resulting ones will be written after the process in the passed buffer. The buffer is resized to rank * numChannelsProcessed channels and (fftSize / 2 + 1) lenght.\nThe passed buffer is considered as seed for the dictionaries. Its dimensions should match the values above. The resulting dictionaries will replace the seed ones.\nThe passed buffer is considered as a template for the dictionaries, and will therefore not change. Its dictionaries should match the values above.\nThe index of the buffer where the different activations will be written to and/or read from: the behaviour is set in the following argument. If nil is provided, no activation will be returned.\nThis flag decides of how the activation buffer passed as the previous argument is treated.\nThe activations are seeded randomly, and the resulting ones will be written after the process in the passed buffer. The buffer is resized to rank * numChannelsProcessed channels and (sourceDuration / hopsize + 1) lenght.\nThe passed buffer is considered as seed for the activations. Its dimensions should match the values above. The resulting activations will replace the seed ones.\nThe passed buffer is considered as a template for the activations, and will therefore not change. Its dimensions should match the values above.\nThe number of elements the NMF algorithm will try to divide the spectrogram of the source in.\nThe NMF process is iterative, trying to converge to the smallest error in its factorisation. The number of iterations will decide how many times it tries to adjust its estimates. Higher numbers here will be more CPU expensive, lower numbers will be more unpredictable in quality.\nThis allows to choose between the different methods of sorting the ranks in order to get similar sonic qualities on a given rank (not implemented yet)\nThe window size. As NMF relies on spectral frames, we need to decide what precision we give it spectrally and temporally, in line with Gabor Uncertainty principles. http://www.subsurfwiki.org/wiki/Gabor_uncertainty\nThe window hope size. As NMF relies on spectral frames, we need to move the window forward. It can be any size but low overlap will create audible artefacts.\nThe inner FFT/IFFT size. It should be at least 4 samples long, at least the size of the window, and a power of 2. Making it larger allows an oversampling of the spectral precision.\nThe inner FFT/IFFT windowing type (not implemented yet)\nThe NMF process needs to seed its starting point. If specified, the same values will be used. The default of -1 will randomly assign them. (not implemented yet)"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-16",
					"linecount" : 24,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 16.0, 639.0, 92.0, 328.0 ],
					"style" : "",
					"text" : "srcBuf\nstartAt\nnFrames\nstartChan\nnChans\ndstBuf\ndictBuf\ndictFlag\n0\n1\n2\nactBuf\nactFlag\n0\n1\n2\nrank\nnIter\nsortFlag\nwinSize\nhopSize\nfftSize\nwinType\nrandSeed"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-12",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 16.0, 48.0, 376.0, 20.0 ],
					"style" : "",
					"text" : "Buffer-Based Non-Negative Matrix Factorisation on Spectral Frames"
				}

			}
, 			{
				"box" : 				{
					"fontsize" : 24.0,
					"id" : "obj-10",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 16.0, 22.0, 157.0, 33.0 ],
					"style" : "",
					"text" : "Fluid.BufNMF"
				}

			}
, 			{
				"box" : 				{
					"fontsize" : 11.0,
					"id" : "obj-8",
					"linecount" : 4,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 31.0, 988.0, 902.0, 56.0 ],
					"style" : "",
					"text" : "[1] - Lee, Daniel D., and H. Sebastian Seung. 1999. ‘Learning the Parts of Objects by Non-Negative Matrix Factorization’. Nature 401 (6755): 788–91. https://doi.org/10.1038/44565.\n[2] - Smaragdis and Brown, Non-Negative Matrix Factorization for Polyphonic Music Transcription.\n[3] - This was made possible thanks to the FluCoMa project ( http://www.flucoma.org/ ) funded by the European Research Council ( https://erc.europa.eu/ ) under the European Union’s Horizon 2020 research and innovation programme (grant agreement No 725899).\n"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-5",
					"linecount" : 33,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 16.0, 100.0, 1004.0, 449.0 ],
					"style" : "",
					"text" : "The FluidBufNMF object decomposes the spectrum of a sound into a number of components using Non-Negative Matrix Factorisation (NMF)1 . NMF has been a popular technique in signal processing research for things like source separation and transcription2 , although its creative potential is so far relatively unexplored.\n\nThe algorithm takes a buffer in and divides it into a number of components, determined by the rank argument. It works iteratively, by trying to find a combination of spectral templates ('dictionaries') and envelopes ('activations') that yield the original magnitude spectrogram when added together. By and large, there is no unique answer to this question (i.e. there are different ways of accounting for an evolving spectrum in terms of some set of templates and envelopes). In its basic form, NMF is a form of unsupervised learning: it starts with some random data and then converges towards something that minimizes the distance between its generated data and the original:it tends to converge very quickly at first and then level out. Fewer iterations mean less processing, but also less predictable results.\n\nThe object can return either or all of the following:\n• a spectral contour of each component in the form of a magnitude spectrogram (called a dictionary in NMF lingo);\n• an amplitude envelope of each component in the form of gains for each consecutive frame of the underlying spectrogram (called an activation in NMF lingo);\n• an audio reconstruction of each components in the time domain.\n\nThe dictionaries and activations can be used to make a kind of vocoder based on what NMF has 'learned' from the original data. Alternatively, taking the matrix product of a dictionary and an activation will yield a synthetic magnitude spectrogram of a component (which could be reconsructed, given some phase informaiton from somewhere).\n\nSome additional options and flexibility can be found through combinations of the dictFlag and actFlag arguments. If these flags are set to 1, the object expects to be supplied with pre-formed spectra (or envelopes) that will be used as seeds for the decomposition, providing more guided results. When set to 2, the supplied buffers won't be updated, so become templates to match against instead. Note that having both dictionaries and activations set to 2 doesn't make sense, so the object will complain.\n\nIf supplying pre-formed data, it's up to the user to make sure that the supplied buffers are the right size:\n• dictionaries must be (fft size / 2) + 1 frames and (rank * input channels) channels\n• activations must be (input frames / hopSize) + 1 frames and (rank * input channels) channels\n\nIn this implementation, the components are reconstructed by masking the ogriginal spectrum, such that they will sum to yield the original sound.\n\nThe whole process can be related to a channel vocoder where, instead of fixed bandpass filters, we get more complex filter shapes that are learned from the data, and the activations correspond to channel envelopes.\n\nMore information on possible musicianly uses of NMF are availabe in The Fluid Corpus Manipulation Project overview file.\n\nFluidBufNMF is part of the Fluid Decomposition Toolkit of the FluCoMa project.3"
				}

			}
, 			{
				"box" : 				{
					"fontsize" : 16.0,
					"id" : "obj-3",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 16.0, 74.0, 92.0, 24.0 ],
					"style" : "",
					"text" : "Description"
				}

			}
, 			{
				"box" : 				{
					"hidden" : 1,
					"id" : "obj-2",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 7,
							"minor" : 3,
							"revision" : 5,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"rect" : [ 0.0, 26.0, 1212.0, 929.0 ],
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
						"showontab" : 1,
						"isolateaudio" : 1,
						"boxes" : [ 							{
								"box" : 								{
									"id" : "obj-50",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 328.0, 665.0, 123.0, 22.0 ],
									"style" : "",
									"text" : "prepend dststartchan"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-38",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 462.0, 665.0, 107.0, 22.0 ],
									"style" : "",
									"text" : "prepend startchan"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-36",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "bang", "int", "int" ],
									"patching_rect" : [ 429.0, 621.0, 40.0, 22.0 ],
									"style" : "",
									"text" : "t b i i"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-10",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 244.0, 972.0, 351.0, 22.0 ],
									"style" : "",
									"text" : "sprintf process guit-dicts 0 -1 %d 1 guit-dicts-sum guit-dicts-sum"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-14",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 668.0, 972.0, 303.0, 22.0 ],
									"style" : "",
									"text" : "sprintf process guit-dicts 0 -1 %d 1 1 0 1 guit-dicts-sum"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-7",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 185.0, 727.0, 24.0, 24.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-26",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1024.0, 194.0, 33.0, 22.0 ],
									"style" : "",
									"text" : "stop"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-19",
									"local" : 1,
									"maxclass" : "ezdac~",
									"numinlets" : 2,
									"numoutlets" : 0,
									"patching_rect" : [ 949.0, 355.5, 45.0, 45.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-12",
									"maxclass" : "number",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 906.0, 170.0, 50.0, 22.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-16",
									"maxclass" : "newobj",
									"numinlets" : 3,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 980.0, 301.0, 70.0, 22.0 ],
									"style" : "",
									"text" : "selector~ 2"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-17",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 965.0, 194.0, 34.0, 22.0 ],
									"style" : "",
									"text" : "start"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-25",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "signal", "signal", "bang" ],
									"patching_rect" : [ 975.0, 237.0, 106.0, 22.0 ],
									"style" : "",
									"text" : "play~ guit-audio 2"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-40",
									"linecount" : 7,
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 902.0, 450.0, 404.0, 100.0 ],
									"style" : "",
									"text" : "what is happening: We split 2 seconds of guitar in 10 ranks, find the one that has the highest log_centroid, which we estimate to be the best guess of where the pick sound is. We then take the activation of that pick sound and place it in a buffer on channel 1, and sum all the others to the other channel. This 2 channel buffer becomes our new, fixed template dictionnary, and we run 20 seconds of sound and we know where things will go."
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-35",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 960.0, 136.5, 150.0, 20.0 ],
									"style" : "",
									"text" : "play: 2 is pick, 1 is string"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-31",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 254.0, 878.0, 150.0, 20.0 ],
									"style" : "",
									"text" : "wait for finishing"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-27",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 133.5, 93.0, 150.0, 20.0 ],
									"style" : "",
									"text" : "press to start"
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
									"fontname" : "Arial Bold",
									"hint" : "",
									"id" : "obj-33",
									"ignoreclick" : 1,
									"legacytextcolor" : 1,
									"maxclass" : "textbutton",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 108.0, 93.0, 20.0, 20.0 ],
									"presentation_rect" : [ 1215.0, 327.0, 20.0, 20.0 ],
									"rounded" : 60.0,
									"style" : "",
									"text" : "1",
									"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
									"fontname" : "Arial Bold",
									"hint" : "",
									"id" : "obj-32",
									"ignoreclick" : 1,
									"legacytextcolor" : 1,
									"maxclass" : "textbutton",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 220.0, 874.0, 20.0, 20.0 ],
									"presentation_rect" : [ 1216.0, 359.5, 20.0, 20.0 ],
									"rounded" : 60.0,
									"style" : "",
									"text" : "2",
									"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
									"fontname" : "Arial Bold",
									"hint" : "",
									"id" : "obj-1",
									"ignoreclick" : 1,
									"legacytextcolor" : 1,
									"maxclass" : "textbutton",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 926.0, 136.5, 20.0, 20.0 ],
									"presentation_rect" : [ 1215.0, 387.5, 20.0, 20.0 ],
									"rounded" : 60.0,
									"style" : "",
									"text" : "3",
									"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-48",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "" ],
									"patching_rect" : [ 328.0, 775.0, 36.0, 22.0 ],
									"style" : "",
									"text" : "sel 9"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-45",
									"maxclass" : "newobj",
									"numinlets" : 5,
									"numoutlets" : 4,
									"outlettype" : [ "int", "", "", "int" ],
									"patching_rect" : [ 380.0, 758.0, 71.0, 22.0 ],
									"style" : "",
									"text" : "counter 0 9"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-44",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 220.0, 833.0, 24.0, 24.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-13",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "int" ],
									"patching_rect" : [ 328.0, 627.0, 29.5, 22.0 ],
									"style" : "",
									"text" : "=="
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-11",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "int" ],
									"patching_rect" : [ 295.0, 460.0, 30.0, 22.0 ],
									"style" : "",
									"text" : "t b i"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-8",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 3,
									"outlettype" : [ "bang", "bang", "int" ],
									"patching_rect" : [ 268.0, 550.0, 53.0, 22.0 ],
									"style" : "",
									"text" : "uzi 10 0"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-43",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 45.0, 995.0, 146.0, 22.0 ],
									"style" : "",
									"text" : "buffer~ guit-dicts-sum 1 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-42",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "" ],
									"patching_rect" : [ 381.0, 716.0, 462.0, 22.0 ],
									"style" : "",
									"text" : "fluid.bufcompose~ @dstbuf guit-dicts-sum @dstgain 1 @srcbuf guit-dicts @nchans 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-39",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "" ],
									"patching_rect" : [ 220.0, 802.0, 694.0, 22.0 ],
									"style" : "",
									"text" : "fluid.bufnmf~ @srcbuf guit @fft 1024 256 2048 @iters 100 @filtbuf guit-dicts-sum @filtupdate 2 @rank 2 @resynthbuf guit-audio"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-30",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "int", "int" ],
									"patching_rect" : [ 251.0, 408.0, 63.0, 22.0 ],
									"style" : "",
									"text" : "maximum"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-24",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 251.0, 371.0, 70.0, 22.0 ],
									"style" : "",
									"text" : "zl group 10"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-23",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 304.0, 252.0, 60.0, 22.0 ],
									"style" : "",
									"text" : "loadbang"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-22",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 108.0, 283.0, 165.0, 22.0 ],
									"style" : "",
									"text" : "sprintf analyze guit-audio %d"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-21",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 3,
									"outlettype" : [ "bang", "bang", "int" ],
									"patching_rect" : [ 108.0, 234.0, 43.0, 22.0 ],
									"style" : "",
									"text" : "uzi 10"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-20",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 295.0, 299.0, 290.0, 22.0 ],
									"style" : "",
									"text" : "fftparams 1024 256, descriptors log_centroid median"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-18",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "list" ],
									"patching_rect" : [ 251.0, 337.0, 76.0, 22.0 ],
									"style" : "",
									"text" : "descriptors~"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-9",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 128.0, 194.0, 24.0, 24.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-6",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 108.0, 123.0, 37.0, 22.0 ],
									"style" : "",
									"text" : "bang"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-4",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 45.0, 915.0, 104.0, 22.0 ],
									"style" : "",
									"text" : "buffer~ guit-audio"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-3",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 45.0, 951.0, 99.0, 22.0 ],
									"style" : "",
									"text" : "buffer~ guit-dicts"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-2",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "" ],
									"patching_rect" : [ 108.0, 151.0, 695.0, 22.0 ],
									"style" : "",
									"text" : "fluid.bufnmf~ @srcbuf guit @nframes 88200 @fft 1024 256 2048 @iters 100 @filtbuf guit-dicts @rank 10 @resynthbuf guit-audio"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-13", 1 ],
									"source" : [ "obj-11", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-8", 0 ],
									"source" : [ "obj-11", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-16", 0 ],
									"source" : [ "obj-12", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-50", 0 ],
									"source" : [ "obj-13", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-19", 1 ],
									"order" : 0,
									"source" : [ "obj-16", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-19", 0 ],
									"order" : 1,
									"source" : [ "obj-16", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-25", 0 ],
									"source" : [ "obj-17", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-24", 0 ],
									"source" : [ "obj-18", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-21", 0 ],
									"order" : 1,
									"source" : [ "obj-2", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-9", 0 ],
									"order" : 0,
									"source" : [ "obj-2", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-18", 0 ],
									"source" : [ "obj-20", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-22", 0 ],
									"source" : [ "obj-21", 2 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-18", 0 ],
									"source" : [ "obj-22", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-20", 0 ],
									"source" : [ "obj-23", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-30", 0 ],
									"source" : [ "obj-24", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-16", 2 ],
									"source" : [ "obj-25", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-16", 1 ],
									"source" : [ "obj-25", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-25", 0 ],
									"source" : [ "obj-26", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-11", 0 ],
									"source" : [ "obj-30", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-13", 0 ],
									"source" : [ "obj-36", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-38", 0 ],
									"source" : [ "obj-36", 2 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-42", 0 ],
									"source" : [ "obj-36", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-42", 0 ],
									"source" : [ "obj-38", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-44", 0 ],
									"source" : [ "obj-39", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-45", 0 ],
									"source" : [ "obj-42", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-48", 0 ],
									"source" : [ "obj-45", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-7", 0 ],
									"source" : [ "obj-48", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-42", 0 ],
									"source" : [ "obj-50", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-2", 0 ],
									"source" : [ "obj-6", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-39", 0 ],
									"source" : [ "obj-7", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-36", 0 ],
									"source" : [ "obj-8", 2 ]
								}

							}
 ],
						"styles" : [ 							{
								"name" : "max6box",
								"default" : 								{
									"textcolor_inverse" : [ 0.0, 0.0, 0.0, 1.0 ],
									"accentcolor" : [ 0.8, 0.839216, 0.709804, 1.0 ],
									"bgcolor" : [ 1.0, 1.0, 1.0, 0.5 ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
, 							{
								"name" : "max6inlet",
								"default" : 								{
									"color" : [ 0.423529, 0.372549, 0.27451, 1.0 ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
, 							{
								"name" : "max6message",
								"default" : 								{
									"textcolor_inverse" : [ 0.0, 0.0, 0.0, 1.0 ],
									"bgfillcolor" : 									{
										"type" : "gradient",
										"color1" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
										"color2" : [ 0.788235, 0.788235, 0.788235, 1.0 ],
										"color" : [ 0.290196, 0.309804, 0.301961, 1.0 ],
										"angle" : 270.0,
										"proportion" : 0.39,
										"autogradient" : 0
									}

								}
,
								"parentstyle" : "max6box",
								"multi" : 0
							}
, 							{
								"name" : "max6outlet",
								"default" : 								{
									"color" : [ 0.0, 0.454902, 0.498039, 1.0 ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
 ]
					}
,
					"patching_rect" : [ 455.0, 1051.0, 109.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"style" : "",
						"tags" : ""
					}
,
					"style" : "",
					"text" : "p \"fixed dictionary\""
				}

			}
, 			{
				"box" : 				{
					"hidden" : 1,
					"id" : "obj-1",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 7,
							"minor" : 3,
							"revision" : 5,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"rect" : [ 0.0, 26.0, 1212.0, 929.0 ],
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
						"showontab" : 1,
						"isolateaudio" : 1,
						"boxes" : [ 							{
								"box" : 								{
									"id" : "obj-56",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 460.0, 367.5, 34.0, 20.0 ],
									"style" : "",
									"text" : "start"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-54",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 39.0, 623.0, 155.0, 20.0 ],
									"style" : "",
									"text" : "select your listening source"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-51",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 110.0, 439.0, 150.0, 20.0 ],
									"style" : "",
									"text" : "bang when done"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-41",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 157.886536, 160.0, 150.0, 20.0 ],
									"style" : "",
									"text" : "trigger the process"
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
									"fontname" : "Arial Bold",
									"hint" : "",
									"id" : "obj-33",
									"ignoreclick" : 1,
									"legacytextcolor" : 1,
									"maxclass" : "textbutton",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 131.0, 160.0, 20.0, 20.0 ],
									"presentation_rect" : [ 1215.0, 327.0, 20.0, 20.0 ],
									"rounded" : 60.0,
									"style" : "",
									"text" : "1",
									"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
									"fontname" : "Arial Bold",
									"hint" : "",
									"id" : "obj-32",
									"ignoreclick" : 1,
									"legacytextcolor" : 1,
									"maxclass" : "textbutton",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 88.0, 439.0, 20.0, 20.0 ],
									"presentation_rect" : [ 1216.0, 359.5, 20.0, 20.0 ],
									"rounded" : 60.0,
									"style" : "",
									"text" : "2",
									"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
									"fontname" : "Arial Bold",
									"hint" : "",
									"id" : "obj-28",
									"ignoreclick" : 1,
									"legacytextcolor" : 1,
									"maxclass" : "textbutton",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 17.0, 623.0, 20.0, 20.0 ],
									"presentation_rect" : [ 1215.0, 387.5, 20.0, 20.0 ],
									"rounded" : 60.0,
									"style" : "",
									"text" : "3",
									"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
									"fontname" : "Arial Bold",
									"hint" : "",
									"id" : "obj-26",
									"ignoreclick" : 1,
									"legacytextcolor" : 1,
									"maxclass" : "textbutton",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 425.0, 367.5, 20.0, 20.0 ],
									"presentation_rect" : [ 1219.0, 420.5, 20.0, 20.0 ],
									"rounded" : 60.0,
									"style" : "",
									"text" : "4",
									"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
									"fontname" : "Arial Bold",
									"hint" : "",
									"id" : "obj-24",
									"ignoreclick" : 1,
									"legacytextcolor" : 1,
									"maxclass" : "textbutton",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 502.0, 510.0, 20.0, 20.0 ],
									"presentation_rect" : [ 1219.0, 453.067627, 20.0, 20.0 ],
									"rounded" : 60.0,
									"style" : "",
									"text" : "5",
									"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
									"fontname" : "Arial Bold",
									"hint" : "",
									"id" : "obj-19",
									"ignoreclick" : 1,
									"legacytextcolor" : 1,
									"maxclass" : "textbutton",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 833.0, 560.0, 20.0, 20.0 ],
									"presentation_rect" : [ 1219.0, 482.067627, 20.0, 20.0 ],
									"rounded" : 60.0,
									"style" : "",
									"text" : "6",
									"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-5",
									"local" : 1,
									"maxclass" : "ezdac~",
									"numinlets" : 2,
									"numoutlets" : 0,
									"patching_rect" : [ 110.0, 796.0, 45.0, 45.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-49",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 425.0, 391.0, 33.0, 22.0 ],
									"style" : "",
									"text" : "stop"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-50",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 460.0, 391.0, 37.0, 22.0 ],
									"style" : "",
									"text" : "bang"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-30",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 93.0, 160.0, 24.0, 24.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-27",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 215.0, 391.0, 93.0, 22.0 ],
									"style" : "",
									"text" : "2392.209296"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-25",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "float", "" ],
									"patching_rect" : [ 285.0, 356.0, 37.0, 22.0 ],
									"style" : "",
									"text" : "timer"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-23",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "bang" ],
									"patching_rect" : [ 93.0, 210.0, 34.0, 22.0 ],
									"style" : "",
									"text" : "t b b"
								}

							}
, 							{
								"box" : 								{
									"format" : 6,
									"id" : "obj-21",
									"maxclass" : "flonum",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 725.449341, 666.0, 50.0, 22.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-13",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 712.449341, 701.0, 32.0, 22.0 ],
									"style" : "",
									"text" : "*~ 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-4",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 736.449341, 112.0, 122.0, 22.0 ],
									"style" : "",
									"text" : "s new_buffer_loaded"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-1",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "" ],
									"patching_rect" : [ 93.0, 266.0, 620.0, 22.0 ],
									"style" : "",
									"text" : "fluid.bufnmf~ @srcbuf synth @resynthbuf resynth @filtbuf filt @envbuf env @rank 5 @iters 100 @fft 512 256 1024"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-52",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 319.0, 44.0, 67.0, 22.0 ],
									"style" : "",
									"text" : "replace $1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-36",
									"maxclass" : "dropfile",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 82.0, 10.0, 192.0, 45.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-45",
									"maxclass" : "live.meter~",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "list" ],
									"patching_rect" : [ 294.449341, 623.0, 25.0, 65.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-38",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patcher" : 									{
										"fileversion" : 1,
										"appversion" : 										{
											"major" : 7,
											"minor" : 3,
											"revision" : 5,
											"architecture" : "x64",
											"modernui" : 1
										}
,
										"rect" : [ 816.0, 111.0, 640.0, 480.0 ],
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
										"boxes" : [ 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-3",
													"index" : 1,
													"maxclass" : "inlet",
													"numinlets" : 0,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 95.0, 185.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-2",
													"maxclass" : "newobj",
													"numinlets" : 0,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 306.449341, 122.0, 120.0, 22.0 ],
													"style" : "",
													"text" : "r new_buffer_loaded"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-1",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "signal" ],
													"patching_rect" : [ 79.5, 233.0, 168.0, 22.0 ],
													"style" : "",
													"text" : "count~ 0 1 1 @autoreset 1 @"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-26",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 3,
													"outlettype" : [ "", "", "" ],
													"patching_rect" : [ 306.449341, 157.0, 83.0, 22.0 ],
													"style" : "",
													"text" : "getattr samps"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-5",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "float", "bang" ],
													"patching_rect" : [ 338.449341, 191.0, 80.0, 22.0 ],
													"style" : "",
													"text" : "buffer~ synth"
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-36",
													"index" : 1,
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 306.449341, 348.0, 30.0, 30.0 ],
													"style" : "",
													"varname" : "u415000522"
												}

											}
 ],
										"lines" : [ 											{
												"patchline" : 												{
													"destination" : [ "obj-36", 0 ],
													"source" : [ "obj-1", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-26", 0 ],
													"source" : [ "obj-2", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-1", 1 ],
													"source" : [ "obj-26", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-5", 0 ],
													"source" : [ "obj-26", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-1", 0 ],
													"source" : [ "obj-3", 0 ]
												}

											}
 ]
									}
,
									"patching_rect" : [ 394.0, 472.0, 76.0, 22.0 ],
									"saved_object_attributes" : 									{
										"description" : "",
										"digest" : "",
										"globalpatchername" : "",
										"style" : "",
										"tags" : ""
									}
,
									"style" : "",
									"text" : "p sync ramp"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-35",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 478.449341, 472.0, 112.0, 22.0 ],
									"style" : "",
									"text" : "loadmess 1 1 1 1 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-31",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 294.449341, 592.0, 29.5, 22.0 ],
									"style" : "",
									"text" : "-~"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-29",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 294.449341, 517.0, 78.0, 22.0 ],
									"style" : "",
									"text" : "index~ synth"
								}

							}
, 							{
								"box" : 								{
									"fontface" : 1,
									"fontsize" : 14.0,
									"id" : "obj-15",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 859.949341, 560.0, 337.0, 22.0 ],
									"style" : "",
									"text" : "Vocoder: Combine different filters and envelopes"
								}

							}
, 							{
								"box" : 								{
									"fontface" : 1,
									"fontsize" : 14.0,
									"id" : "obj-48",
									"linecount" : 2,
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 502.0, 539.0, 142.0, 38.0 ],
									"style" : "",
									"text" : "Resynthesis: Turn sources on/off"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-46",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 424.0, 72.5, 265.0, 22.0 ],
									"style" : "",
									"text" : "buffer~ synth Tremblay-AaS-SynthTwoVoices-M"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-44",
									"linecount" : 3,
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 1026.449341, 273.5, 150.0, 47.0 ],
									"style" : "",
									"text" : "This buffer will be filled with resynthesised components"
								}

							}
, 							{
								"box" : 								{
									"fontsize" : 16.0,
									"id" : "obj-40",
									"items" : [ "off", ",", "source", ",", "resynthesis", ",", "vocoder" ],
									"maxclass" : "umenu",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "int", "", "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 17.0, 651.5, 100.0, 26.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-39",
									"maxclass" : "newobj",
									"numinlets" : 4,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 110.0, 746.0, 329.0, 22.0 ],
									"style" : "",
									"text" : "selector~ 3"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-37",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "list" ],
									"patching_rect" : [ 472.449341, 597.0, 68.0, 22.0 ],
									"style" : "",
									"text" : "listfunnel 1"
								}

							}
, 							{
								"box" : 								{
									"activecolor" : [ 0.952941, 0.564706, 0.098039, 1.0 ],
									"disabled" : [ 0, 0, 0, 0, 0 ],
									"id" : "obj-34",
									"itemtype" : 1,
									"maxclass" : "radiogroup",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 478.449341, 509.0, 22.550659, 82.0 ],
									"shape" : 1,
									"size" : 5,
									"style" : "",
									"values" : [ 0, 0, 0, 1, 0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-3",
									"linecount" : 2,
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 394.0, 631.0, 164.0, 35.0 ],
									"style" : "",
									"text" : "poly~ fluid.bufnmf.polyplay 5 @target 0 @args resynth"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-20",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 901.449341, 279.5, 91.0, 22.0 ],
									"style" : "",
									"text" : "buffer~ resynth"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-11",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 93.0, 355.0, 76.5, 76.5 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-16",
									"maxclass" : "number",
									"maximum" : 5,
									"minimum" : 1,
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 905.449341, 593.5, 50.0, 22.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-10",
									"maxclass" : "number",
									"maximum" : 5,
									"minimum" : 1,
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 807.949341, 593.5, 50.0, 22.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-12",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 424.0, 53.0, 150.0, 20.0 ],
									"style" : "",
									"text" : "Sound to decompose"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-8",
									"linecount" : 2,
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 1008.886536, 227.5, 150.0, 33.0 ],
									"style" : "",
									"text" : "This buffer will be filled with envelopes"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-6",
									"linecount" : 2,
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 1008.886536, 183.0, 150.0, 33.0 ],
									"style" : "",
									"text" : "This buffer will be filled with filter shapes"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-14",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 712.449341, 576.0, 46.0, 22.0 ],
									"style" : "",
									"text" : "noise~"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-9",
									"maxclass" : "newobj",
									"numinlets" : 3,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 712.449341, 631.0, 212.0, 22.0 ],
									"style" : "",
									"text" : "pfft~ fluid.bufnmf.noiseplay.pfft 1024 4"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-7",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 901.449341, 238.5, 71.0, 22.0 ],
									"style" : "",
									"text" : "buffer~ env"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-2",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 901.449341, 188.5, 63.0, 22.0 ],
									"style" : "",
									"text" : "buffer~ filt"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-11", 0 ],
									"order" : 1,
									"source" : [ "obj-1", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-25", 1 ],
									"order" : 0,
									"source" : [ "obj-1", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-9", 1 ],
									"source" : [ "obj-10", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-39", 3 ],
									"source" : [ "obj-13", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-9", 0 ],
									"source" : [ "obj-14", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-9", 2 ],
									"source" : [ "obj-16", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-13", 1 ],
									"source" : [ "obj-21", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-1", 0 ],
									"source" : [ "obj-23", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-25", 0 ],
									"source" : [ "obj-23", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-27", 1 ],
									"source" : [ "obj-25", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-31", 0 ],
									"order" : 0,
									"source" : [ "obj-29", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-39", 1 ],
									"midpoints" : [ 303.949341, 559.0, 222.833333, 559.0 ],
									"order" : 1,
									"source" : [ "obj-29", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-31", 1 ],
									"order" : 1,
									"source" : [ "obj-3", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-39", 2 ],
									"order" : 0,
									"source" : [ "obj-3", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-23", 0 ],
									"source" : [ "obj-30", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-45", 0 ],
									"source" : [ "obj-31", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-37", 0 ],
									"source" : [ "obj-34", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-34", 0 ],
									"source" : [ "obj-35", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-52", 0 ],
									"source" : [ "obj-36", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-3", 1 ],
									"source" : [ "obj-37", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-29", 0 ],
									"order" : 1,
									"source" : [ "obj-38", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-3", 0 ],
									"order" : 0,
									"source" : [ "obj-38", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-5", 1 ],
									"order" : 0,
									"source" : [ "obj-39", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-5", 0 ],
									"order" : 1,
									"source" : [ "obj-39", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-39", 0 ],
									"source" : [ "obj-40", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-4", 0 ],
									"source" : [ "obj-46", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-38", 0 ],
									"source" : [ "obj-49", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-38", 0 ],
									"source" : [ "obj-50", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-46", 0 ],
									"source" : [ "obj-52", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-13", 0 ],
									"source" : [ "obj-9", 0 ]
								}

							}
 ],
						"styles" : [ 							{
								"name" : "max6box",
								"default" : 								{
									"textcolor_inverse" : [ 0.0, 0.0, 0.0, 1.0 ],
									"accentcolor" : [ 0.8, 0.839216, 0.709804, 1.0 ],
									"bgcolor" : [ 1.0, 1.0, 1.0, 0.5 ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
, 							{
								"name" : "max6inlet",
								"default" : 								{
									"color" : [ 0.423529, 0.372549, 0.27451, 1.0 ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
, 							{
								"name" : "max6message",
								"default" : 								{
									"textcolor_inverse" : [ 0.0, 0.0, 0.0, 1.0 ],
									"bgfillcolor" : 									{
										"type" : "gradient",
										"color1" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
										"color2" : [ 0.788235, 0.788235, 0.788235, 1.0 ],
										"color" : [ 0.290196, 0.309804, 0.301961, 1.0 ],
										"angle" : 270.0,
										"proportion" : 0.39,
										"autogradient" : 0
									}

								}
,
								"parentstyle" : "max6box",
								"multi" : 0
							}
, 							{
								"name" : "max6outlet",
								"default" : 								{
									"color" : [ 0.0, 0.454902, 0.498039, 1.0 ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
 ]
					}
,
					"patching_rect" : [ 150.0, 1051.0, 106.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"style" : "",
						"tags" : ""
					}
,
					"style" : "",
					"text" : "p \"basic example\""
				}

			}
, 			{
				"box" : 				{
					"hidden" : 1,
					"id" : "obj-17",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 7,
							"minor" : 3,
							"revision" : 5,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"rect" : [ 0.0, 26.0, 1212.0, 929.0 ],
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
						"showontab" : 1,
						"isolateaudio" : 1,
						"boxes" : [ 							{
								"box" : 								{
									"id" : "obj-27",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 42.0, 180.0, 277.0, 22.0 ],
									"style" : "",
									"text" : "startat 0, nframes -1, startchan 0, nchans -1, bang"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-17",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 381.0, 593.0, 97.0, 22.0 ],
									"style" : "",
									"text" : "sizeinsamps 1 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-10",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 723.0, 180.0, 76.0, 22.0 ],
									"style" : "",
									"text" : "set resynth1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-41",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 446.0, 153.0, 194.0, 20.0 ],
									"style" : "",
									"text" : "choose other buffer for the outputs"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-39",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 170.0, 334.0, 117.0, 20.0 ],
									"style" : "",
									"text" : "play whichever rank"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-37",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 42.0, 122.0, 137.0, 20.0 ],
									"style" : "",
									"text" : "process a section, or all"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-36",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 59.0, 28.0, 115.0, 20.0 ],
									"style" : "",
									"text" : "composite a source"
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
									"fontname" : "Arial Bold",
									"hint" : "",
									"id" : "obj-33",
									"ignoreclick" : 1,
									"legacytextcolor" : 1,
									"maxclass" : "textbutton",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 31.0, 25.0, 20.0, 20.0 ],
									"presentation_rect" : [ 1215.0, 327.0, 20.0, 20.0 ],
									"rounded" : 60.0,
									"style" : "",
									"text" : "1",
									"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
									"fontname" : "Arial Bold",
									"hint" : "",
									"id" : "obj-32",
									"ignoreclick" : 1,
									"legacytextcolor" : 1,
									"maxclass" : "textbutton",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 12.0, 122.0, 20.0, 20.0 ],
									"presentation_rect" : [ 1216.0, 359.5, 20.0, 20.0 ],
									"rounded" : 60.0,
									"style" : "",
									"text" : "2",
									"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
									"fontname" : "Arial Bold",
									"hint" : "",
									"id" : "obj-13",
									"ignoreclick" : 1,
									"legacytextcolor" : 1,
									"maxclass" : "textbutton",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 142.0, 328.5, 20.0, 20.0 ],
									"presentation_rect" : [ 1215.0, 387.5, 20.0, 20.0 ],
									"rounded" : 60.0,
									"style" : "",
									"text" : "3",
									"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"bgcolor" : [ 1.0, 0.788235, 0.470588, 1.0 ],
									"fontname" : "Arial Bold",
									"hint" : "",
									"id" : "obj-23",
									"ignoreclick" : 1,
									"legacytextcolor" : 1,
									"maxclass" : "textbutton",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "int" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 424.0, 153.0, 20.0, 20.0 ],
									"presentation_rect" : [ 1219.0, 420.5, 20.0, 20.0 ],
									"rounded" : 60.0,
									"style" : "",
									"text" : "4",
									"textcolor" : [ 0.34902, 0.34902, 0.34902, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-31",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "" ],
									"patching_rect" : [ 26.0, 79.0, 108.0, 22.0 ],
									"style" : "",
									"text" : "fluid.bufcompose~"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-24",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 26.0, 50.0, 623.0, 22.0 ],
									"style" : "",
									"text" : "reset, dstbuf stereosource, dstgain 1., srcbuf synth, bang, srcbuf guit, startat 550000, gain 0.6, dststartchan 1, bang"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-4",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 378.0, 655.0, 276.0, 22.0 ],
									"style" : "",
									"text" : "buffer~ guit Tremblay-AaS-AcousticStrums-M.wav"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-22",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 59.0, 290.0, 24.0, 24.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-28",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 3.0, 146.0, 315.0, 22.0 ],
									"style" : "",
									"text" : "startat 8810, nframes 44100, startchan 1, nchans 1, bang"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-26",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 204.0, 366.5, 33.0, 22.0 ],
									"style" : "",
									"text" : "stop"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-19",
									"local" : 1,
									"maxclass" : "ezdac~",
									"numinlets" : 2,
									"numoutlets" : 0,
									"patching_rect" : [ 129.0, 528.0, 45.0, 45.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-18",
									"maxclass" : "number",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 254.0, 366.5, 50.0, 22.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-16",
									"maxclass" : "newobj",
									"numinlets" : 9,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 160.0, 473.5, 103.0, 22.0 ],
									"style" : "",
									"text" : "selector~ 8"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-15",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 145.0, 366.5, 34.0, 22.0 ],
									"style" : "",
									"text" : "start"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-12",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 9,
									"outlettype" : [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "bang" ],
									"patching_rect" : [ 155.0, 409.5, 147.0, 22.0 ],
									"style" : "",
									"text" : "play~ resynth2 8 @loop 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-11",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 421.0, 180.0, 279.0, 22.0 ],
									"style" : "",
									"text" : "filtbuf filt1, envbuf env1, resynthbuf resynth1, bang"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-9",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 254.0, 651.0, 70.0, 22.0 ],
									"style" : "",
									"text" : "buffer~ filt1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-6",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 249.0, 748.5, 97.0, 22.0 ],
									"style" : "",
									"text" : "buffer~ resynth1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-3",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 254.0, 697.5, 77.0, 22.0 ],
									"style" : "",
									"text" : "buffer~ env1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-20",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 70.449341, 742.0, 97.0, 22.0 ],
									"style" : "",
									"text" : "buffer~ resynth2"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-7",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 70.449341, 701.0, 77.0, 22.0 ],
									"style" : "",
									"text" : "buffer~ env2"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-2",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 70.449341, 651.0, 70.0, 22.0 ],
									"style" : "",
									"text" : "buffer~ filt2"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-5",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "" ],
									"patching_rect" : [ 42.0, 238.0, 674.0, 22.0 ],
									"style" : "",
									"text" : "fluid.bufnmf~ @srcbuf stereosource @resynthbuf resynth2 @filtbuf filt2 @envbuf env2 @rank 4 @iters 50 @fft 512 256 1024"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-1",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 378.0, 686.0, 141.0, 22.0 ],
									"style" : "",
									"text" : "buffer~ stereosource 2 2"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-12", 0 ],
									"source" : [ "obj-10", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-5", 0 ],
									"source" : [ "obj-11", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-16", 8 ],
									"source" : [ "obj-12", 7 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-16", 7 ],
									"source" : [ "obj-12", 6 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-16", 6 ],
									"source" : [ "obj-12", 5 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-16", 5 ],
									"source" : [ "obj-12", 4 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-16", 4 ],
									"source" : [ "obj-12", 3 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-16", 3 ],
									"source" : [ "obj-12", 2 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-16", 2 ],
									"source" : [ "obj-12", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-16", 1 ],
									"source" : [ "obj-12", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-12", 0 ],
									"source" : [ "obj-15", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-19", 1 ],
									"order" : 0,
									"source" : [ "obj-16", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-19", 0 ],
									"order" : 1,
									"source" : [ "obj-16", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-1", 0 ],
									"source" : [ "obj-17", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-16", 0 ],
									"source" : [ "obj-18", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-31", 0 ],
									"source" : [ "obj-24", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-12", 0 ],
									"source" : [ "obj-26", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-5", 0 ],
									"source" : [ "obj-27", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-5", 0 ],
									"source" : [ "obj-28", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-22", 0 ],
									"source" : [ "obj-5", 0 ]
								}

							}
 ],
						"styles" : [ 							{
								"name" : "max6box",
								"default" : 								{
									"textcolor_inverse" : [ 0.0, 0.0, 0.0, 1.0 ],
									"accentcolor" : [ 0.8, 0.839216, 0.709804, 1.0 ],
									"bgcolor" : [ 1.0, 1.0, 1.0, 0.5 ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
, 							{
								"name" : "max6inlet",
								"default" : 								{
									"color" : [ 0.423529, 0.372549, 0.27451, 1.0 ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
, 							{
								"name" : "max6message",
								"default" : 								{
									"textcolor_inverse" : [ 0.0, 0.0, 0.0, 1.0 ],
									"bgfillcolor" : 									{
										"type" : "gradient",
										"color1" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
										"color2" : [ 0.788235, 0.788235, 0.788235, 1.0 ],
										"color" : [ 0.290196, 0.309804, 0.301961, 1.0 ],
										"angle" : 270.0,
										"proportion" : 0.39,
										"autogradient" : 0
									}

								}
,
								"parentstyle" : "max6box",
								"multi" : 0
							}
, 							{
								"name" : "max6outlet",
								"default" : 								{
									"color" : [ 0.0, 0.454902, 0.498039, 1.0 ]
								}
,
								"parentstyle" : "",
								"multi" : 0
							}
 ]
					}
,
					"patching_rect" : [ 281.449341, 1051.0, 122.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"style" : "",
						"tags" : ""
					}
,
					"style" : "",
					"text" : "p \"stereo buffertests\""
				}

			}
 ],
		"lines" : [  ],
		"dependency_cache" : [ 			{
				"name" : "fluid.bufnmf.noiseplay.pfft.maxpat",
				"bootpath" : "~/Documents/documents@hudd/research/projects/fluid corpus navigation/research/flucoma-max/help",
				"patcherrelativepath" : ".",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "fluid.bufnmf.polyplay.maxpat",
				"bootpath" : "~/Documents/documents@hudd/research/projects/fluid corpus navigation/research/flucoma-max/help",
				"patcherrelativepath" : ".",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "fluid.bufnmf~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "fluid.bufcompose~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "vlessthan~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "vtimes~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "vminus~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "descriptors~.mxo",
				"type" : "iLaX"
			}
 ],
		"autosave" : 0
	}

}
