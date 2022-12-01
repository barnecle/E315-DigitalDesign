`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
// Created for Indiana University's E315 Class
//
// 
// Andrew Lukefahr
// lukefahr@iu.edu
//
// 2021-03-24
// 2020-04-27
//
//////////////////////////////////////////////////////////////////////////////////

module dot_40_20(

		// AXI4-Stream Interface
		input                           clk,
		input                           rst,

        // Incomming Matrix AXI4-Stream
		input [31:0]                    INPUT_AXIS_TDATA,
        input                           INPUT_AXIS_TLAST,
        input                           INPUT_AXIS_TVALID,
        output                          INPUT_AXIS_TREADY,
        
        // Outgoing Vector AXI4-Stream 		
		output [31:0]                   OUTPUT_AXIS_TDATA,
        output                          OUTPUT_AXIS_TLAST,
        output                          OUTPUT_AXIS_TVALID,
        input                           OUTPUT_AXIS_TREADY 

    );
    
// This is autogenerated. See ../vtests/dot_40_20/dot_40_20.py for details. 
localparam ROWS = 40;
localparam COLS = 20;

localparam logic [31:0] weights [0:ROWS-1] [0:COLS-1] = '{
  '{ 
    $shortrealtobits(-0.30479565),$shortrealtobits(0.4214893),$shortrealtobits(0.11129182),$shortrealtobits(0.0065651783),
    $shortrealtobits(0.8011568),$shortrealtobits(0.123111084),$shortrealtobits(-0.49238843),$shortrealtobits(0.693382),
    $shortrealtobits(0.76831776),$shortrealtobits(0.032844406),$shortrealtobits(0.7921849),$shortrealtobits(-0.44385654),
    $shortrealtobits(0.586317),$shortrealtobits(0.94825166),$shortrealtobits(0.3197064),$shortrealtobits(-0.2810165),
    $shortrealtobits(-0.7467916),$shortrealtobits(-0.042224173),$shortrealtobits(-0.30069333),$shortrealtobits(-0.88640344)
  },
  '{ 
    $shortrealtobits(-0.082800575),$shortrealtobits(-0.03487179),$shortrealtobits(-0.3279497),$shortrealtobits(0.29574126),
    $shortrealtobits(-0.2611428),$shortrealtobits(0.3706904),$shortrealtobits(-0.053742535),$shortrealtobits(-0.39298552),
    $shortrealtobits(0.16093849),$shortrealtobits(0.3382439),$shortrealtobits(-0.008072713),$shortrealtobits(0.42624086),
    $shortrealtobits(-0.39301693),$shortrealtobits(0.9722994),$shortrealtobits(0.16777958),$shortrealtobits(0.105979495),
    $shortrealtobits(0.35342598),$shortrealtobits(-0.32240742),$shortrealtobits(-0.34804657),$shortrealtobits(-0.21378362)
  },
  '{ 
    $shortrealtobits(0.20445743),$shortrealtobits(0.65226656),$shortrealtobits(-0.202225),$shortrealtobits(-0.37480527),
    $shortrealtobits(0.12610552),$shortrealtobits(0.039407738),$shortrealtobits(0.15487581),$shortrealtobits(0.7793557),
    $shortrealtobits(0.43650284),$shortrealtobits(0.2070703),$shortrealtobits(-0.61918265),$shortrealtobits(0.22835152),
    $shortrealtobits(0.43416932),$shortrealtobits(-0.8505315),$shortrealtobits(0.4490663),$shortrealtobits(-0.6363666),
    $shortrealtobits(0.7537725),$shortrealtobits(-0.21877936),$shortrealtobits(0.361489),$shortrealtobits(-0.7444852)
  },
  '{ 
    $shortrealtobits(0.08402267),$shortrealtobits(-0.005056635),$shortrealtobits(-0.3523766),$shortrealtobits(-0.4310904),
    $shortrealtobits(0.26549545),$shortrealtobits(-0.030254431),$shortrealtobits(-0.23288848),$shortrealtobits(-0.7441059),
    $shortrealtobits(-0.07525979),$shortrealtobits(-0.3215998),$shortrealtobits(0.034073897),$shortrealtobits(-0.23692001),
    $shortrealtobits(-0.26041543),$shortrealtobits(-0.18996054),$shortrealtobits(0.41397655),$shortrealtobits(0.55841434),
    $shortrealtobits(-0.39768937),$shortrealtobits(-0.05036626),$shortrealtobits(0.10662569),$shortrealtobits(-0.6250599)
  },
  '{ 
    $shortrealtobits(0.0034260675),$shortrealtobits(-0.973575),$shortrealtobits(-0.093575984),$shortrealtobits(-0.077192225),
    $shortrealtobits(0.24296775),$shortrealtobits(0.15886217),$shortrealtobits(-0.030901363),$shortrealtobits(0.49804083),
    $shortrealtobits(0.5177046),$shortrealtobits(-0.33498162),$shortrealtobits(-0.64862114),$shortrealtobits(0.04071031),
    $shortrealtobits(0.10614585),$shortrealtobits(0.46375296),$shortrealtobits(-0.062643394),$shortrealtobits(-0.4659263),
    $shortrealtobits(0.45270577),$shortrealtobits(0.19633548),$shortrealtobits(-0.13544072),$shortrealtobits(0.8432204)
  },
  '{ 
    $shortrealtobits(-0.53254336),$shortrealtobits(-0.8616058),$shortrealtobits(-0.27211237),$shortrealtobits(-0.021056361),
    $shortrealtobits(0.36016285),$shortrealtobits(-0.37654004),$shortrealtobits(-0.12238856),$shortrealtobits(0.38789576),
    $shortrealtobits(0.054291457),$shortrealtobits(-0.21956529),$shortrealtobits(0.6043058),$shortrealtobits(0.014591108),
    $shortrealtobits(0.20342954),$shortrealtobits(-0.3059404),$shortrealtobits(0.07258507),$shortrealtobits(0.087520055),
    $shortrealtobits(-0.56362087),$shortrealtobits(0.009029179),$shortrealtobits(-0.13531195),$shortrealtobits(0.3786285)
  },
  '{ 
    $shortrealtobits(0.93115497),$shortrealtobits(-0.08690053),$shortrealtobits(0.2200795),$shortrealtobits(-0.37365058),
    $shortrealtobits(0.036033258),$shortrealtobits(0.4734211),$shortrealtobits(0.21795607),$shortrealtobits(-0.06334385),
    $shortrealtobits(0.26592687),$shortrealtobits(-0.058605),$shortrealtobits(0.07623027),$shortrealtobits(0.10782986),
    $shortrealtobits(0.05657335),$shortrealtobits(1.0599608),$shortrealtobits(0.39239812),$shortrealtobits(0.00044054873),
    $shortrealtobits(-0.2719713),$shortrealtobits(-0.26575014),$shortrealtobits(-0.056042925),$shortrealtobits(0.05488061)
  },
  '{ 
    $shortrealtobits(-0.4514538),$shortrealtobits(0.46450728),$shortrealtobits(-0.0021549743),$shortrealtobits(-0.32400706),
    $shortrealtobits(-0.036228314),$shortrealtobits(0.36558223),$shortrealtobits(0.42320397),$shortrealtobits(-0.17137414),
    $shortrealtobits(0.020491086),$shortrealtobits(0.25786263),$shortrealtobits(0.22276893),$shortrealtobits(-0.14535426),
    $shortrealtobits(0.10921718),$shortrealtobits(-0.25686806),$shortrealtobits(0.025874283),$shortrealtobits(-0.31297332),
    $shortrealtobits(-0.20694685),$shortrealtobits(-0.38953936),$shortrealtobits(0.5178373),$shortrealtobits(0.036950003)
  },
  '{ 
    $shortrealtobits(-0.35869357),$shortrealtobits(-0.54061514),$shortrealtobits(0.07585521),$shortrealtobits(0.26203993),
    $shortrealtobits(-0.05483549),$shortrealtobits(-0.04019768),$shortrealtobits(-0.29625034),$shortrealtobits(0.8081332),
    $shortrealtobits(-0.59862196),$shortrealtobits(0.5201472),$shortrealtobits(-0.08468713),$shortrealtobits(0.22730826),
    $shortrealtobits(-0.8764761),$shortrealtobits(0.046884302),$shortrealtobits(-0.42008078),$shortrealtobits(-0.44067004),
    $shortrealtobits(-0.904008),$shortrealtobits(0.20650673),$shortrealtobits(0.05033003),$shortrealtobits(-0.42782655)
  },
  '{ 
    $shortrealtobits(-0.3196944),$shortrealtobits(-0.682489),$shortrealtobits(0.35083464),$shortrealtobits(0.14693175),
    $shortrealtobits(0.18733989),$shortrealtobits(-0.0049760914),$shortrealtobits(0.34998447),$shortrealtobits(0.45262071),
    $shortrealtobits(0.5600423),$shortrealtobits(0.09686167),$shortrealtobits(0.6771317),$shortrealtobits(0.12864976),
    $shortrealtobits(0.2337784),$shortrealtobits(-0.25778595),$shortrealtobits(0.04377746),$shortrealtobits(0.7510356),
    $shortrealtobits(-0.10379248),$shortrealtobits(0.06614841),$shortrealtobits(-0.033349395),$shortrealtobits(-0.48500624)
  },
  '{ 
    $shortrealtobits(0.52682674),$shortrealtobits(-0.38141656),$shortrealtobits(0.2905717),$shortrealtobits(0.24085057),
    $shortrealtobits(0.08825328),$shortrealtobits(-0.11428282),$shortrealtobits(0.08030063),$shortrealtobits(-0.24196376),
    $shortrealtobits(0.42440012),$shortrealtobits(-0.3560438),$shortrealtobits(-0.41386646),$shortrealtobits(-0.16414368),
    $shortrealtobits(0.3024654),$shortrealtobits(0.04346252),$shortrealtobits(-0.122585885),$shortrealtobits(-0.26937),
    $shortrealtobits(0.96357346),$shortrealtobits(-0.26308882),$shortrealtobits(-0.114705674),$shortrealtobits(-0.51195)
  },
  '{ 
    $shortrealtobits(-0.48356226),$shortrealtobits(0.34704217),$shortrealtobits(0.44919392),$shortrealtobits(-0.28411594),
    $shortrealtobits(0.4018025),$shortrealtobits(0.42076454),$shortrealtobits(0.36966026),$shortrealtobits(0.0158033),
    $shortrealtobits(0.71544564),$shortrealtobits(0.45092195),$shortrealtobits(0.22046952),$shortrealtobits(-0.08721386),
    $shortrealtobits(0.032004166),$shortrealtobits(0.24247672),$shortrealtobits(-0.0607229),$shortrealtobits(-0.23346534),
    $shortrealtobits(0.39966625),$shortrealtobits(0.05316763),$shortrealtobits(0.24480529),$shortrealtobits(-0.21664956)
  },
  '{ 
    $shortrealtobits(0.1793381),$shortrealtobits(0.14554575),$shortrealtobits(0.42988822),$shortrealtobits(0.33026633),
    $shortrealtobits(-0.104146525),$shortrealtobits(-0.10007216),$shortrealtobits(-0.5345886),$shortrealtobits(-0.21731898),
    $shortrealtobits(0.14516035),$shortrealtobits(-0.029543275),$shortrealtobits(0.309592),$shortrealtobits(-0.39254063),
    $shortrealtobits(0.36358136),$shortrealtobits(-0.37091646),$shortrealtobits(-0.3771339),$shortrealtobits(-0.10186255),
    $shortrealtobits(0.09894851),$shortrealtobits(0.28857967),$shortrealtobits(-0.43847165),$shortrealtobits(-0.8745145)
  },
  '{ 
    $shortrealtobits(0.18900058),$shortrealtobits(0.14905426),$shortrealtobits(0.18624264),$shortrealtobits(0.3838327),
    $shortrealtobits(0.1301832),$shortrealtobits(-0.025575968),$shortrealtobits(0.48218688),$shortrealtobits(-0.23890953),
    $shortrealtobits(0.28509083),$shortrealtobits(0.20321548),$shortrealtobits(0.040871944),$shortrealtobits(-0.057455443),
    $shortrealtobits(-0.1042477),$shortrealtobits(-0.06117003),$shortrealtobits(0.0058627357),$shortrealtobits(0.24412541),
    $shortrealtobits(-0.37006375),$shortrealtobits(-0.40671715),$shortrealtobits(-0.04971855),$shortrealtobits(0.35002542)
  },
  '{ 
    $shortrealtobits(-0.28440866),$shortrealtobits(-0.49803805),$shortrealtobits(0.34732383),$shortrealtobits(0.24525347),
    $shortrealtobits(-0.13624763),$shortrealtobits(0.12725554),$shortrealtobits(0.39510703),$shortrealtobits(-0.17284063),
    $shortrealtobits(-0.23886934),$shortrealtobits(-0.21420152),$shortrealtobits(-0.028840344),$shortrealtobits(0.19868039),
    $shortrealtobits(-0.06292624),$shortrealtobits(0.043273926),$shortrealtobits(0.3406135),$shortrealtobits(0.071032785),
    $shortrealtobits(-0.24609224),$shortrealtobits(0.003990756),$shortrealtobits(0.19514294),$shortrealtobits(0.048453636)
  },
  '{ 
    $shortrealtobits(-0.57922685),$shortrealtobits(-0.21996924),$shortrealtobits(0.43907782),$shortrealtobits(0.49166986),
    $shortrealtobits(0.32547364),$shortrealtobits(0.46379697),$shortrealtobits(0.35543767),$shortrealtobits(0.98292595),
    $shortrealtobits(0.5005306),$shortrealtobits(0.47752175),$shortrealtobits(0.733186),$shortrealtobits(0.08219525),
    $shortrealtobits(-0.21788342),$shortrealtobits(0.18661977),$shortrealtobits(0.007984069),$shortrealtobits(-0.008900724),
    $shortrealtobits(-0.22725676),$shortrealtobits(-0.454571),$shortrealtobits(0.5279948),$shortrealtobits(-0.16465335)
  },
  '{ 
    $shortrealtobits(0.08512579),$shortrealtobits(0.111560896),$shortrealtobits(0.30672798),$shortrealtobits(0.41608033),
    $shortrealtobits(-0.23562099),$shortrealtobits(0.18444896),$shortrealtobits(-0.23308794),$shortrealtobits(-0.4542558),
    $shortrealtobits(0.37868002),$shortrealtobits(0.27361903),$shortrealtobits(0.15296486),$shortrealtobits(0.10749873),
    $shortrealtobits(-1.0219294),$shortrealtobits(-0.5307668),$shortrealtobits(-0.16620228),$shortrealtobits(-0.0032808215),
    $shortrealtobits(-0.16868372),$shortrealtobits(-0.51495063),$shortrealtobits(0.028884787),$shortrealtobits(1.6181707)
  },
  '{ 
    $shortrealtobits(0.45657295),$shortrealtobits(0.64394414),$shortrealtobits(0.38083377),$shortrealtobits(0.35680494),
    $shortrealtobits(-0.27425918),$shortrealtobits(0.21252683),$shortrealtobits(-0.2915839),$shortrealtobits(0.013300433),
    $shortrealtobits(-0.23870957),$shortrealtobits(0.44786006),$shortrealtobits(-0.13240753),$shortrealtobits(-0.30137956),
    $shortrealtobits(-0.32080704),$shortrealtobits(0.15776819),$shortrealtobits(0.18740892),$shortrealtobits(-0.11332117),
    $shortrealtobits(0.0506486),$shortrealtobits(-0.095086366),$shortrealtobits(0.3839847),$shortrealtobits(0.5808335)
  },
  '{ 
    $shortrealtobits(0.6950764),$shortrealtobits(-0.17259781),$shortrealtobits(0.4101595),$shortrealtobits(-0.0089128455),
    $shortrealtobits(-0.4154462),$shortrealtobits(-0.36081004),$shortrealtobits(-0.42601863),$shortrealtobits(-0.46726477),
    $shortrealtobits(0.0979324),$shortrealtobits(0.14665624),$shortrealtobits(-0.30699253),$shortrealtobits(-0.37903312),
    $shortrealtobits(-0.07616774),$shortrealtobits(0.046385825),$shortrealtobits(0.41574472),$shortrealtobits(0.4887145),
    $shortrealtobits(-0.5560277),$shortrealtobits(0.26035738),$shortrealtobits(-0.4750658),$shortrealtobits(-0.2927131)
  },
  '{ 
    $shortrealtobits(-0.3391999),$shortrealtobits(0.44299674),$shortrealtobits(-0.36868837),$shortrealtobits(-0.46302235),
    $shortrealtobits(0.6141925),$shortrealtobits(-0.5002851),$shortrealtobits(0.39761093),$shortrealtobits(0.04012637),
    $shortrealtobits(1.0237418),$shortrealtobits(-0.4431552),$shortrealtobits(-0.11547117),$shortrealtobits(-0.40621328),
    $shortrealtobits(-0.11790178),$shortrealtobits(-0.73868567),$shortrealtobits(0.3598744),$shortrealtobits(-0.28369448),
    $shortrealtobits(-0.94350487),$shortrealtobits(0.37305632),$shortrealtobits(0.17060384),$shortrealtobits(0.5133256)
  },
  '{ 
    $shortrealtobits(0.071898684),$shortrealtobits(-0.3424497),$shortrealtobits(-0.01876013),$shortrealtobits(-0.42181766),
    $shortrealtobits(-0.14007555),$shortrealtobits(-0.51443166),$shortrealtobits(0.33549252),$shortrealtobits(-0.058464777),
    $shortrealtobits(-0.0753942),$shortrealtobits(-0.13329737),$shortrealtobits(-0.055651907),$shortrealtobits(-0.49027267),
    $shortrealtobits(-0.30562752),$shortrealtobits(0.3861049),$shortrealtobits(0.39954066),$shortrealtobits(0.44321737),
    $shortrealtobits(-0.16456793),$shortrealtobits(0.49134237),$shortrealtobits(-0.08375305),$shortrealtobits(0.29156873)
  },
  '{ 
    $shortrealtobits(0.5969138),$shortrealtobits(-0.26742932),$shortrealtobits(-0.23739697),$shortrealtobits(-0.26537606),
    $shortrealtobits(-0.39854518),$shortrealtobits(-0.09120924),$shortrealtobits(-0.030120764),$shortrealtobits(-0.87099284),
    $shortrealtobits(-0.3162293),$shortrealtobits(0.11609516),$shortrealtobits(-0.27039433),$shortrealtobits(-0.40245897),
    $shortrealtobits(0.58734435),$shortrealtobits(-0.0054734875),$shortrealtobits(0.53609097),$shortrealtobits(-0.07106618),
    $shortrealtobits(-0.36678702),$shortrealtobits(-0.107922874),$shortrealtobits(-0.5738566),$shortrealtobits(0.34343413)
  },
  '{ 
    $shortrealtobits(0.07836575),$shortrealtobits(-0.3527387),$shortrealtobits(0.102189384),$shortrealtobits(0.15448691),
    $shortrealtobits(-0.3190723),$shortrealtobits(-0.0058892383),$shortrealtobits(-0.53759557),$shortrealtobits(-0.2943664),
    $shortrealtobits(0.15065622),$shortrealtobits(-0.43336213),$shortrealtobits(-0.15379514),$shortrealtobits(0.15580694),
    $shortrealtobits(0.07185638),$shortrealtobits(-0.120905526),$shortrealtobits(0.4670674),$shortrealtobits(0.7219294),
    $shortrealtobits(0.14784954),$shortrealtobits(-0.23677403),$shortrealtobits(-0.16122459),$shortrealtobits(0.056845754)
  },
  '{ 
    $shortrealtobits(-0.49021232),$shortrealtobits(0.5141446),$shortrealtobits(-0.31969085),$shortrealtobits(-0.07122647),
    $shortrealtobits(-0.62586296),$shortrealtobits(-0.39629433),$shortrealtobits(0.18329483),$shortrealtobits(0.44467625),
    $shortrealtobits(0.9136732),$shortrealtobits(-0.13705191),$shortrealtobits(-1.0527236),$shortrealtobits(0.2475522),
    $shortrealtobits(-0.37751964),$shortrealtobits(-0.5596511),$shortrealtobits(-0.06691338),$shortrealtobits(1.0297852),
    $shortrealtobits(0.22591579),$shortrealtobits(0.3727037),$shortrealtobits(0.17783178),$shortrealtobits(0.4865906)
  },
  '{ 
    $shortrealtobits(0.10188712),$shortrealtobits(-0.5456072),$shortrealtobits(-0.0648329),$shortrealtobits(-0.5491169),
    $shortrealtobits(-0.19088869),$shortrealtobits(-0.088008784),$shortrealtobits(-0.24695292),$shortrealtobits(-0.8881319),
    $shortrealtobits(-0.5158887),$shortrealtobits(0.009231893),$shortrealtobits(-0.086443424),$shortrealtobits(-0.44453198),
    $shortrealtobits(-0.32588315),$shortrealtobits(-0.18281421),$shortrealtobits(0.34304044),$shortrealtobits(0.21671565),
    $shortrealtobits(-0.37047684),$shortrealtobits(0.3203774),$shortrealtobits(-0.08934711),$shortrealtobits(-0.011315311)
  },
  '{ 
    $shortrealtobits(-0.04631023),$shortrealtobits(0.32686856),$shortrealtobits(0.2341006),$shortrealtobits(0.33170357),
    $shortrealtobits(-0.08072524),$shortrealtobits(-0.28520924),$shortrealtobits(0.18436445),$shortrealtobits(0.5445336),
    $shortrealtobits(0.65399915),$shortrealtobits(0.08484856),$shortrealtobits(0.4515948),$shortrealtobits(0.32475916),
    $shortrealtobits(-0.47623268),$shortrealtobits(0.56503326),$shortrealtobits(-0.027718272),$shortrealtobits(-0.49219453),
    $shortrealtobits(0.73937047),$shortrealtobits(-0.45313516),$shortrealtobits(0.121345215),$shortrealtobits(-0.26720783)
  },
  '{ 
    $shortrealtobits(0.6801923),$shortrealtobits(-0.24126899),$shortrealtobits(0.13438985),$shortrealtobits(0.16074327),
    $shortrealtobits(0.0058362675),$shortrealtobits(-0.02001179),$shortrealtobits(0.28380835),$shortrealtobits(0.90304106),
    $shortrealtobits(0.009145398),$shortrealtobits(0.14369357),$shortrealtobits(0.29370445),$shortrealtobits(-0.33355978),
    $shortrealtobits(-0.42429894),$shortrealtobits(-0.6641948),$shortrealtobits(-0.17301217),$shortrealtobits(-0.012150677),
    $shortrealtobits(-0.04770754),$shortrealtobits(0.11203618),$shortrealtobits(-0.0919307),$shortrealtobits(0.29836404)
  },
  '{ 
    $shortrealtobits(0.06936455),$shortrealtobits(0.25847992),$shortrealtobits(-0.2685192),$shortrealtobits(-0.4053744),
    $shortrealtobits(0.09455573),$shortrealtobits(0.34215203),$shortrealtobits(-0.21763746),$shortrealtobits(-0.7981169),
    $shortrealtobits(-0.15629773),$shortrealtobits(-0.0045011328),$shortrealtobits(0.5266591),$shortrealtobits(0.18314236),
    $shortrealtobits(0.6511426),$shortrealtobits(-0.2642401),$shortrealtobits(0.06672991),$shortrealtobits(0.629159),
    $shortrealtobits(-0.25642544),$shortrealtobits(0.25680017),$shortrealtobits(0.103021346),$shortrealtobits(0.6132011)
  },
  '{ 
    $shortrealtobits(1.0043416),$shortrealtobits(0.9232539),$shortrealtobits(0.2646181),$shortrealtobits(-0.29766372),
    $shortrealtobits(-0.45512503),$shortrealtobits(0.020670244),$shortrealtobits(-0.041454572),$shortrealtobits(0.810616),
    $shortrealtobits(-0.1347977),$shortrealtobits(-0.16887344),$shortrealtobits(-0.46348998),$shortrealtobits(0.12679577),
    $shortrealtobits(-0.12011026),$shortrealtobits(0.56202346),$shortrealtobits(0.1946778),$shortrealtobits(0.5525547),
    $shortrealtobits(-0.46747646),$shortrealtobits(0.24039626),$shortrealtobits(0.17890327),$shortrealtobits(0.663901)
  },
  '{ 
    $shortrealtobits(-0.4220611),$shortrealtobits(0.53213084),$shortrealtobits(0.3476112),$shortrealtobits(-0.118337296),
    $shortrealtobits(0.1690453),$shortrealtobits(0.50328237),$shortrealtobits(0.20349137),$shortrealtobits(0.05102538),
    $shortrealtobits(-0.3669094),$shortrealtobits(0.35291415),$shortrealtobits(-0.29095477),$shortrealtobits(0.21755356),
    $shortrealtobits(0.0089126555),$shortrealtobits(0.31749198),$shortrealtobits(-0.23884636),$shortrealtobits(-0.51162237),
    $shortrealtobits(-0.216713),$shortrealtobits(0.039029058),$shortrealtobits(0.33337587),$shortrealtobits(0.29097295)
  },
  '{ 
    $shortrealtobits(-1.0423384),$shortrealtobits(-0.12671292),$shortrealtobits(-0.15720601),$shortrealtobits(-0.48160568),
    $shortrealtobits(0.40137485),$shortrealtobits(0.18615481),$shortrealtobits(-0.489861),$shortrealtobits(0.52174515),
    $shortrealtobits(-0.47984356),$shortrealtobits(-0.19223747),$shortrealtobits(0.31712598),$shortrealtobits(0.097988755),
    $shortrealtobits(-0.35052836),$shortrealtobits(-0.95021343),$shortrealtobits(0.4677145),$shortrealtobits(-0.3576304),
    $shortrealtobits(-0.20503975),$shortrealtobits(0.023212431),$shortrealtobits(-0.20583767),$shortrealtobits(0.65407115)
  },
  '{ 
    $shortrealtobits(0.15881523),$shortrealtobits(0.36204463),$shortrealtobits(-0.20804289),$shortrealtobits(-0.13689768),
    $shortrealtobits(-0.48664477),$shortrealtobits(-0.07206346),$shortrealtobits(0.18366183),$shortrealtobits(0.58238864),
    $shortrealtobits(-0.8643456),$shortrealtobits(-0.3552938),$shortrealtobits(0.6238592),$shortrealtobits(-0.49984446),
    $shortrealtobits(-0.3612151),$shortrealtobits(0.2620314),$shortrealtobits(0.3998565),$shortrealtobits(0.5985023),
    $shortrealtobits(0.20120913),$shortrealtobits(-0.23305617),$shortrealtobits(-0.14647484),$shortrealtobits(-0.3304875)
  },
  '{ 
    $shortrealtobits(-0.34289077),$shortrealtobits(0.12183835),$shortrealtobits(0.038313217),$shortrealtobits(0.42768127),
    $shortrealtobits(0.32669237),$shortrealtobits(0.32846412),$shortrealtobits(-0.30812618),$shortrealtobits(0.11408994),
    $shortrealtobits(0.22579387),$shortrealtobits(-0.34609872),$shortrealtobits(0.66477275),$shortrealtobits(0.4676329),
    $shortrealtobits(-0.5269374),$shortrealtobits(-0.025959795),$shortrealtobits(-0.2740295),$shortrealtobits(-0.6826814),
    $shortrealtobits(0.45086136),$shortrealtobits(-0.32154593),$shortrealtobits(0.06512789),$shortrealtobits(0.04525063)
  },
  '{ 
    $shortrealtobits(0.4478897),$shortrealtobits(-0.56544477),$shortrealtobits(-0.3951155),$shortrealtobits(-0.24910499),
    $shortrealtobits(-0.056203347),$shortrealtobits(-0.49188662),$shortrealtobits(-0.5631654),$shortrealtobits(-0.9857198),
    $shortrealtobits(-0.48746616),$shortrealtobits(-0.27615568),$shortrealtobits(-0.50961864),$shortrealtobits(-0.39866537),
    $shortrealtobits(0.48130724),$shortrealtobits(-0.40064687),$shortrealtobits(-0.2911867),$shortrealtobits(-0.09492289),
    $shortrealtobits(-0.67070335),$shortrealtobits(-0.24623823),$shortrealtobits(0.24662073),$shortrealtobits(-0.26107076)
  },
  '{ 
    $shortrealtobits(0.89006585),$shortrealtobits(0.42993575),$shortrealtobits(0.1399211),$shortrealtobits(0.14416221),
    $shortrealtobits(0.78411925),$shortrealtobits(0.2272036),$shortrealtobits(-0.29413593),$shortrealtobits(-0.78740656),
    $shortrealtobits(0.67095345),$shortrealtobits(0.003690167),$shortrealtobits(1.2385958),$shortrealtobits(0.23021689),
    $shortrealtobits(-0.3664499),$shortrealtobits(-0.48662314),$shortrealtobits(-0.02720856),$shortrealtobits(-0.57281137),
    $shortrealtobits(-0.40025562),$shortrealtobits(0.24801782),$shortrealtobits(0.030905325),$shortrealtobits(-0.5136098)
  },
  '{ 
    $shortrealtobits(0.28661862),$shortrealtobits(-0.2636385),$shortrealtobits(0.040937793),$shortrealtobits(-0.3161712),
    $shortrealtobits(-0.625977),$shortrealtobits(-0.2628345),$shortrealtobits(-0.14157568),$shortrealtobits(-0.8678831),
    $shortrealtobits(-0.4029979),$shortrealtobits(0.09219284),$shortrealtobits(-0.8600653),$shortrealtobits(0.2849145),
    $shortrealtobits(0.40409875),$shortrealtobits(-0.24362338),$shortrealtobits(0.54470575),$shortrealtobits(0.47460437),
    $shortrealtobits(-0.15020944),$shortrealtobits(0.27727613),$shortrealtobits(0.080174245),$shortrealtobits(-0.42160746)
  },
  '{ 
    $shortrealtobits(-0.26103002),$shortrealtobits(-0.3240105),$shortrealtobits(-0.13164763),$shortrealtobits(-0.3480135),
    $shortrealtobits(0.17574531),$shortrealtobits(-0.2456495),$shortrealtobits(-0.3908657),$shortrealtobits(-0.09083375),
    $shortrealtobits(0.525394),$shortrealtobits(0.03273028),$shortrealtobits(0.72383547),$shortrealtobits(-0.033063725),
    $shortrealtobits(0.023279285),$shortrealtobits(-0.22069383),$shortrealtobits(0.15154022),$shortrealtobits(0.7639722),
    $shortrealtobits(0.05271151),$shortrealtobits(-0.17913258),$shortrealtobits(0.20364289),$shortrealtobits(0.01017269)
  },
  '{ 
    $shortrealtobits(0.18611826),$shortrealtobits(0.16923541),$shortrealtobits(0.22643803),$shortrealtobits(0.17204769),
    $shortrealtobits(0.06528528),$shortrealtobits(0.27075407),$shortrealtobits(-0.15624622),$shortrealtobits(-0.18880741),
    $shortrealtobits(-0.43585527),$shortrealtobits(-0.0036364282),$shortrealtobits(0.3075163),$shortrealtobits(-0.4425329),
    $shortrealtobits(-0.038428687),$shortrealtobits(-0.41996318),$shortrealtobits(-0.12661913),$shortrealtobits(-0.0958706),
    $shortrealtobits(-0.5744239),$shortrealtobits(-0.3160906),$shortrealtobits(-0.24730778),$shortrealtobits(0.80067724)
  },
  '{ 
    $shortrealtobits(-0.047798384),$shortrealtobits(0.2788464),$shortrealtobits(0.08086269),$shortrealtobits(0.058773145),
    $shortrealtobits(-0.34863853),$shortrealtobits(-0.35468048),$shortrealtobits(-0.09496665),$shortrealtobits(0.101295434),
    $shortrealtobits(-0.8181846),$shortrealtobits(-0.32617983),$shortrealtobits(-0.2957226),$shortrealtobits(-0.43125635),
    $shortrealtobits(0.27532157),$shortrealtobits(-0.21633077),$shortrealtobits(0.31534612),$shortrealtobits(-0.99002403),
    $shortrealtobits(0.38290253),$shortrealtobits(0.067673504),$shortrealtobits(-0.23119606),$shortrealtobits(-0.44129825)
  },
  '{ 
    $shortrealtobits(0.9197979),$shortrealtobits(-0.3584518),$shortrealtobits(-0.01979027),$shortrealtobits(-0.36625612),
    $shortrealtobits(0.3996464),$shortrealtobits(0.24126638),$shortrealtobits(-0.3546081),$shortrealtobits(0.8758327),
    $shortrealtobits(0.07414756),$shortrealtobits(-0.01974643),$shortrealtobits(0.3094358),$shortrealtobits(-0.5035694),
    $shortrealtobits(-0.05359844),$shortrealtobits(0.06802872),$shortrealtobits(0.22828552),$shortrealtobits(-0.4167618),
    $shortrealtobits(0.43927592),$shortrealtobits(-0.3005144),$shortrealtobits(-0.20189765),$shortrealtobits(0.20767477)
	}
};

    accel_dot #(
        .ROWS(ROWS),
        .COLS(COLS)
    ) accel_dot0 (
    
		// AXI4-Stream Interface
		.clk(clk),
		.rst(rst),
		
        .weights(weights),

        .INPUT_AXIS_TDATA(INPUT_AXIS_TDATA),
        .INPUT_AXIS_TLAST(INPUT_AXIS_TLAST),
        .INPUT_AXIS_TVALID(INPUT_AXIS_TVALID),
        .INPUT_AXIS_TREADY(INPUT_AXIS_TREADY),
                            
        .OUTPUT_AXIS_TDATA(OUTPUT_AXIS_TDATA),
        .OUTPUT_AXIS_TLAST(OUTPUT_AXIS_TLAST),
        .OUTPUT_AXIS_TVALID(OUTPUT_AXIS_TVALID),
        .OUTPUT_AXIS_TREADY(OUTPUT_AXIS_TREADY) 	

    );

    
endmodule