include("compress.jl")
include("time_evolve.jl")
using Plots
using Gallium
using DataFrames

data=readtable("11.data",separator=',',header=false)
################################################################################
################################################################################
#main

  L=11
  dim=50
  points=201
  J=1
  Jz=1
  b=0;
  h=[-b/2+Jz/4 0 0 0; 0 -Jz/4 J/2 0; 0 J/2 -Jz/4 0; 0 0 0 Jz/4+b/2]
  A2=reshape(complex([0.;1.]),1,1,2)
  A1=reshape(complex([1.;0.]),1,1,2)
  spin=zeros(points)
  Sz=[0.5 0;0 -0.5]
  Sz=reshape(Sz,1,1,2,2)
  site=11
  D=Array{Any}(L)
  D2=Array{Any}(L)

  for i=1:L
    if i%2==1
      D[i]=A2
    else
      D[i]=A1
    end
  end

for i=1:points-1
  for j=1:L
    D2[j]=D[j]
  end
  D2[site]=operator(D[site],Sz)
  spin[i]=real(overlap(D2,D)[1])
  @time tMPS(D,h,0.1,0.1,dim)

  println(i,": ",spin[i])
end

for j=1:L
  D2[j]=D[j]
end
D2[site]=operator(D[site],Sz)
spin[size(spin)[1]]=real(overlap(D2,D)[1])
print(spin)
plot(data[1][1:points],[data[site+2][1:points],spin])


#spin1=[-0.5,-0.497507,-0.490083,-0.477895,-0.461213,-0.440406,-0.415927,-0.388303,-0.358117,-0.325993,-0.292578,-0.258524,-0.224472,-0.191032,-0.158776,-0.128216,-0.0997997,-0.0739016,-0.050815,-0.0307507,-0.0138367,-0.000119483,0.0104312,0.0179167,0.0225019,0.0244063,0.0238944,0.0212658,0.0168446,0.0109695,0.00398383,-0.00377348,-0.0119762,-0.020318,-0.0285189,-0.0363301,-0.043538,-0.0499667,-0.0554797,-0.0599799,-0.0634094,-0.0657479,-0.0670089,-0.0672389,-0.0665113,-0.0649234,-0.0625912,-0.0596446,-0.056223,-0.0524697,-0.0485282,-0.0445387,-0.0406275,-0.0369153,-0.0335062,-0.0304876,-0.0279291,-0.0258848,-0.0243792,-0.0234291,-0.0230295,-0.0231581,-0.0237827,-0.0248577,-0.0263282,-0.0281323,-0.0302041,-0.0324782,-0.0348905,-0.0373805,-0.0398895,-0.0423688,-0.0447776,-0.0470833,-0.0492644,-0.0513034,-0.0531994,-0.0549542,-0.056579,-0.0580903,-0.0595092,-0.0608603,-0.0621699,-0.0634735,-0.0647843,-0.0661298,-0.0675284,-0.0689936,-0.0705339,-0.0721513,-0.0738432,-0.0755996,-0.0774087,-0.0792539,-0.0810984,-0.0829116,-0.0846589,-0.086303,-0.0878053,-0.089126,-0.0902266,-0.0910708,-0.0916253,-0.0918614,-0.0917561,-0.0912916,-0.090459,-0.0892548,-0.0876848,-0.0857633,-0.0835126,-0.0809633,-0.0781543,-0.0751331,-0.0719572,-0.0686824,-0.0653745,-0.0621033,-0.0589416,-0.0559636,-0.0532439,-0.0508533,-0.0488593,-0.0473243,-0.0463029,-0.0458399,-0.0459698,-0.0467169,-0.0480927,-0.0500985,-0.0527272,-0.0559453,-0.0597117,-0.0639722,-0.0686628,-0.0737088,-0.0790272,-0.0845277,-0.0901171,-0.0956938,-0.101159,-0.106415,-0.111366,-0.115922,-0.12,-0.123526,-0.126433,-0.128672,-0.1302,-0.130993,-0.131037,-0.130334,-0.128896,-0.126754,-0.123949,-0.120532,-0.116568,-0.112131,-0.107303,-0.102174,-0.0968366,-0.0913878,-0.0859265,-0.0805514,-0.0753585,-0.0704428,-0.0658906,-0.0617819,-0.0581881,-0.0551716,-0.0527844,-0.0510673,-0.0500485,-0.0497439,-0.0501566,-0.0512777,-0.053086,-0.0555485,-0.0586205,-0.0622465,-0.066361,-0.0708897,-0.0757509,-0.0808572,-0.0861169,-0.0914343,-0.0967155,-0.101866,-0.106791,-0.111403,-0.115619,-0.119363,-0.122565,-0.12517,-0.127131,-0.128415,-0.129003,-0.128888,-0.128079,-0.126597,-0.124476]

#spin2=[0.5,0.495012,0.480203,0.456033,0.423247,0.382846,0.336047,0.284238,0.228919,0.171653,0.114001,0.0574768,0.00348737,-0.0467052,-0.0920224,-0.131595,-0.164782,-0.191177,-0.210603,-0.223107,-0.22894,-0.228529,-0.222452,-0.211406,-0.19617,-0.177579,-0.156485,-0.133735,-0.110145,-0.0864734,-0.0634117,-0.0415666,-0.021454,-0.00349299,0.0119951,0.0247855,0.0347466,0.0418343,0.0460852,0.0476086,0.0465782,0.0432221,0.0378148,0.030665,0.0221076,0.0124935,0.0021796,-0.00848081,-0.019147,-0.0294994,-0.0392474,-0.0481387,-0.0559553,-0.0625312,-0.0677465,-0.071532,-0.0738675,-0.0747843,-0.0743449,-0.0726636,-0.069891,-0.0661855,-0.0617374,-0.0567453,-0.0514081,-0.0459233,-0.0404749,-0.0352319,-0.0303408,-0.0259212,-0.0220579,-0.0188089,-0.0162003,-0.0142291,-0.0128647,-0.0120466,-0.0117017,-0.0117342,-0.0120374,-0.0124975,-0.0129978,-0.0134234,-0.0136658,-0.0136348,-0.0132327,-0.0124016,-0.0110911,-0.00927037,-0.00692763,-0.0040703,-0.000718391,0.0030709,0.00725446,0.0117504,0.0164812,0.0213549,0.0262767,0.0311487,0.0358715,0.0403464,0.0444786,0.048177,0.0513558,0.0539359,0.0558449,0.0570193,0.0574024,0.0569501,0.0556267,0.0534102,0.0502903,0.0462705,0.041369,0.0356215,0.0290716,0.0217929,0.0138727,0.0054165,-0.00345286,-0.0125973,-0.0218657,-0.0310939,-0.0401125,-0.0487497,-0.0568368,-0.0642119,-0.0707262,-0.076248,-0.0806667,-0.0839,-0.0858966,-0.0866273,-0.0860982,-0.0843441,-0.0814304,-0.0774481,-0.0725119,-0.0667567,-0.0603341,-0.0534053,-0.0461373,-0.0387005,-0.0312633,-0.0239886,-0.0170307,-0.010532,-0.00461995,0.000591172,0.00500786,0.00855045,0.0111601,0.0127968,0.0134404,0.0130856,0.0117505,0.00946843,0.00629311,0.00229241,-0.00245162,-0.00784432,-0.0137802,-0.0201448,-0.0268174,-0.0336735,-0.0405866,-0.0474323,-0.0540899,-0.0604446,-0.0663893,-0.0718262,-0.0766681,-0.0808391,-0.0842757,-0.0869261,-0.088751,-0.0897232,-0.089828,-0.0890623,-0.087435,-0.0849664,-0.0816882,-0.0776438,-0.0728883,-0.0674893,-0.0615268,-0.0550924,-0.0482912,-0.0412387,-0.03406,-0.0268887,-0.019864,-0.0131275,-0.00681904,-0.0010722,0.00399059,0.00826226,0.0116551,0.0141048,0.0155737,0.0160528,0.0155629]

#spin3=[-0.5,-0.49502,-0.480277,-0.456356,-0.424198,-0.385055,-0.340426,-0.291988,-0.241514,-0.190792,-0.141547,-0.0953627,-0.0536246,-0.0174651,0.0122717,0.0350493,0.0506442,0.0591345,0.0608764,0.0564683,0.0467076,0.0325405,0.0150097,-0.00479802,-0.0258014,-0.0469701,-0.0673626,-0.0861573,-0.102675,-0.116391,-0.126942,-0.134123,-0.137878,-0.138287,-0.135545,-0.129944,-0.12185,-0.111682,-0.0998911,-0.0869394,-0.0732872,-0.0593774,-0.0456242,-0.0324059,-0.0200581,-0.0088693,0.000921312,0.00912513,0.0156046,0.0202727,0.0230922,0.0240728,0.0232743,0.0207962,0.0167806,0.0114036,0.00487302,-0.00258101,-0.0107005,-0.0192274,-0.0279062,-0.0364654,-0.0446659,-0.0522864,-0.0591333,-0.0650502,-0.0699191,-0.0736687,-0.0762724,-0.0777493,-0.0781568,-0.0775951,-0.076198,-0.074126,-0.0715592,-0.0686885,-0.0657147,-0.0628283,-0.0602097,-0.0580215,-0.0564025,-0.0554629,-0.0552825,-0.0559189,-0.0573749,-0.0596406,-0.0626747,-0.0664129,-0.0707723,-0.0756513,-0.0809518,-0.086573,-0.0923859,-0.0983029,-0.10422,-0.110054,-0.115729,-0.121182,-0.126357,-0.131207,-0.135696,-0.139789,-0.143452,-0.146652,-0.149354,-0.151518,-0.153097,-0.154041,-0.154296,-0.153805,-0.152513,-0.150367,-0.147321,-0.143336,-0.138401,-0.132512,-0.125693,-0.117993,-0.109488,-0.10028,-0.0904949,-0.0802799,-0.0698021,-0.0592413,-0.0487831,-0.0386132,-0.0289102,-0.0198397,-0.0115482,-0.00415588,0.00224204,0.00758781,0.0118544,0.0150479,0.0172023,0.0183786,0.018659,0.0181408,0.0169345,0.0151395,0.0128665,0.0102148,0.00727199,0.00411131,0.000790382,-0.00264884,-0.00617769,-0.00978239,-0.0134559,-0.0171993,-0.0210135,-0.0248965,-0.0288394,-0.032825,-0.0368216,-0.0407825,-0.0446509,-0.0483553,-0.0518131,-0.0549337,-0.0576214,-0.0597806,-0.0613183,-0.0621493,-0.0622005,-0.0614162,-0.05976,-0.0572179,-0.0538004,-0.0495429,-0.0445065,-0.0387763,-0.0324605,-0.0256884,-0.0186069,-0.0113764,-0.00416649,0.00284958,0.00949981,0.0156189,0.021053,0.025664,0.0293344,0.0319703,0.0335049,0.0339017,0.033152,0.0312783,0.0283317,0.0243904,0.0195556,0.0139517,0.00771912,0.00101037,-0.00601553,-0.0131989,-0.0203854,-0.0274311,-0.034207,-0.0406039,-0.046535]

#spin4=[0.5,0.49502,0.480277,0.456355,0.424189,0.385021,0.340327,0.291744,0.240991,0.189776,0.139727,0.0923128,0.0487901,0.0101556,-0.0228798,-0.0499021,-0.0707888,-0.0856891,-0.0949915,-0.0992821,-0.0992966,-0.0958689,-0.0898796,-0.0822078,-0.0736869,-0.0650687,-0.0569943,-0.0499752,-0.0443826,-0.0404455,-0.038257,-0.0377864,-0.0388969,-0.0413671,-0.0449135,-0.0492143,-0.0539318,-0.0587328,-0.0633062,-0.0673769,-0.0707164,-0.0731492,-0.0745555,-0.0748719,-0.074088,-0.0722421,-0.0694148,-0.0657219,-0.0613073,-0.0563351,-0.0509831,-0.0454364,-0.0398773,-0.0344879,-0.0294392,-0.0248903,-0.0209805,-0.0178315,-0.0155349,-0.014161,-0.013756,-0.0143153,-0.015817,-0.0182044,-0.0213873,-0.0252469,-0.0296363,-0.0343861,-0.039306,-0.0441921,-0.048832,-0.0530191,-0.0565558,-0.0592613,-0.0609789,-0.0615805,-0.0609789,-0.059122,-0.0559998,-0.0516441,-0.0461268,-0.0395571,-0.0320766,-0.0238614,-0.0150841,-0.00594931,0.00333803,0.0125771,0.0215776,0.0301576,0.0381789,0.0455076,0.0520585,0.0577503,0.062559,0.0664744,0.0695128,0.0717121,0.0731278,0.0738274,0.0738898,0.0733945,0.0724201,0.0710402,0.0693206,0.0673176,0.0650731,0.0626119,0.0599453,0.0570723,0.0539793,0.0506428,0.0470324,0.0431194,0.0388612,0.0342258,0.0291856,0.023722,0.0178286,0.0115156,0.00480043,-0.00227774,-0.00966111,-0.0172748,-0.025029,-0.0328211,-0.0405393,-0.0480676,-0.0552894,-0.0620949,-0.0683932,-0.074103,-0.0791688,-0.0835579,-0.0872599,-0.0902895,-0.0926812,-0.0944849,-0.0957607,-0.0965736,-0.0969824,-0.0970407,-0.0967895,-0.0962532,-0.0954385,-0.0943348,-0.0929138,-0.091141,-0.0889741,-0.0863718,-0.0833031,-0.0797509,-0.0757175,-0.0712348,-0.0663567,-0.0611599,-0.05575,-0.0502519,-0.0448068,-0.039566,-0.0346834,-0.0303086,-0.0265792,-0.0236139,-0.0215075,-0.0203265,-0.0201103,-0.0208694,-0.0225832,-0.0252023,-0.0286516,-0.0328333,-0.0376307,-0.0429118,-0.0485337,-0.0543464,-0.0601965,-0.0659298,-0.0713941,-0.0764412,-0.0809299,-0.0847283,-0.0877176,-0.0897944,-0.0908745,-0.0908952,-0.0898198,-0.087638,-0.0843692,-0.0800632,-0.0748,-0.0686884,-0.061861,-0.0544717,-0.0466894,-0.0386916,-0.0306568,-0.0227566,-0.0151482,-0.00796913,-0.00133264]

#spin5=[-0.5,-0.49502,-0.480277,-0.456355,-0.42419,-0.385021,-0.340328,-0.291749,-0.241004,-0.189808,-0.139797,-0.0924544,-0.049057,-0.0106297,0.0220796,0.0486105,0.0687847,0.0826867,0.0906329,0.0931325,0.090842,0.0845183,0.0749716,0.0630214,0.0494579,0.0350105,0.020323,0.00593753,-0.00771368,-0.0203097,-0.031636,-0.0415747,-0.0500913,-0.0572197,-0.063046,-0.0676928,-0.0713053,-0.0740382,-0.0760462,-0.0774756,-0.0784593,-0.0791137,-0.0795345,-0.0797993,-0.0799671,-0.0800795,-0.080163,-0.0802282,-0.0802734,-0.0802848,-0.080239,-0.0801036,-0.0798236,-0.0793696,-0.0786984,-0.0777731,-0.0765592,-0.0750048,-0.0730975,-0.0708476,-0.0682752,-0.0653914,-0.0622904,-0.0590563,-0.0557463,-0.0525252,-0.0495191,-0.0468996,-0.044789,-0.0433399,-0.0426588,-0.0428392,-0.043953,-0.0460174,-0.0490241,-0.0529673,-0.0577066,-0.0631399,-0.069141,-0.0755572,-0.0822189,-0.0889497,-0.0955795,-0.102034,-0.10811,-0.113704,-0.11872,-0.123119,-0.126896,-0.130123,-0.132791,-0.134952,-0.136682,-0.138139,-0.139412,-0.140586,-0.141733,-0.142913,-0.14417,-0.145577,-0.147116,-0.14878,-0.150544,-0.152366,-0.154181,-0.155933,-0.157528,-0.158875,-0.159879,-0.160446,-0.160468,-0.159844,-0.158486,-0.15632,-0.153254,-0.149248,-0.144264,-0.13828,-0.131295,-0.123286,-0.114389,-0.104638,-0.0941479,-0.0830564,-0.0715213,-0.0597174,-0.0478401,-0.0361068,-0.0247503,-0.013954,-0.0039017,0.00524559,0.0133554,0.0203426,0.026133,0.030712,0.0341062,0.0363792,0.0376235,0.0379617,0.0374987,0.0363439,0.0345991,0.0323535,0.0296799,0.0266342,0.0232578,0.01958,0.0155909,0.0113424,0.00685357,0.00214797,-0.00271085,-0.0076821,-0.0127328,-0.0177883,-0.022765,-0.0275818,-0.0321464,-0.0363659,-0.0401533,-0.0434237,-0.0461141,-0.0481821,-0.049651,-0.0504975,-0.0507234,-0.0503842,-0.0495627,-0.0483388,-0.0467817,-0.0449585,-0.0429325,-0.0407627,-0.0385037,-0.0362047,-0.0339113,-0.031669,-0.0295257,-0.0275345,-0.0257547,-0.024253,-0.0231031,-0.0223834,-0.0221743,-0.0225834,-0.0236427,-0.0254056,-0.027904,-0.0311439,-0.0351001,-0.0397234,-0.0449329,-0.0506231,-0.056669,-0.0629326,-0.0692707,-0.0755457,-0.0816361,-0.0874437,-0.0928979]

#spin6=[0.5,0.49502,0.480277,0.456355,0.42419,0.385021,0.340328,0.291749,0.241004,0.189807,0.139795,0.0924506,0.0490484,0.0106115,-0.0221158,-0.0486788,-0.0689073,-0.0828976,-0.0909819,-0.0936907,-0.0917074,-0.0858228,-0.0768874,-0.0657686,-0.0533115,-0.0403058,-0.0274607,-0.0153868,-0.00458486,0.00455765,0.0117652,0.0168679,0.0197914,0.0205455,0.0192107,0.0159255,0.0108733,0.004272,-0.00363645,-0.0125944,-0.0223354,-0.0325904,-0.0430934,-0.0535886,-0.0638291,-0.0735843,-0.0826448,-0.0908247,-0.0979684,-0.103953,-0.108693,-0.112146,-0.114307,-0.115185,-0.114833,-0.113307,-0.110716,-0.107315,-0.10319,-0.0984429,-0.0933204,-0.0878468,-0.0821056,-0.0761899,-0.0702776,-0.0643406,-0.0583193,-0.052259,-0.0461659,-0.040069,-0.0339279,-0.0277487,-0.0215928,-0.015456,-0.00941428,-0.00351002,0.0020596,0.00719143,0.0117654,0.0156584,0.0187621,0.0209917,0.0222913,0.0226854,0.0222161,0.0209326,0.0188481,0.0161167,0.0129254,0.00950954,0.00608051,0.00307165,0.000554846,-0.00114869,-0.00191573,-0.00165749,-0.000317393,0.00212848,0.00567216,0.0104115,0.0161447,0.0227527,0.0300795,0.0379335,0.0460908,0.0543407,0.0624068,0.0700123,0.0769428,0.0829517,0.0878427,0.091435,0.0936004,0.0943143,0.0933386,0.0905736,0.0859663,0.0795187,0.0712809,0.0612242,0.0497346,0.0369202,0.0230324,0.00835833,-0.0068009,-0.0221521,-0.0373969,-0.0522226,-0.0662377,-0.0792412,-0.0909857,-0.101294,-0.110023,-0.117085,-0.122443,-0.12613,-0.128235,-0.128889,-0.12824,-0.126673,-0.124173,-0.120907,-0.117027,-0.112669,-0.107949,-0.102961,-0.0977719,-0.0924209,-0.0868571,-0.0812454,-0.0756106,-0.0699752,-0.0642008,-0.0585327,-0.052953,-0.0475355,-0.0422693,-0.0371869,-0.0323334,-0.0277688,-0.0235628,-0.0197884,-0.0165978,-0.0140591,-0.0120377,-0.0107978,-0.0102487,-0.010311,-0.0109067,-0.0119394,-0.0133455,-0.0150845,-0.0171198,-0.0194124,-0.0219244,-0.0246192,-0.0274576,-0.0303921,-0.033364,-0.0363036,-0.0391343,-0.0417761,-0.0441487,-0.0461739,-0.0477762,-0.0488252,-0.0493087,-0.049172,-0.048378,-0.0469091,-0.0447973,-0.0420319,-0.0386576,-0.0347335,-0.0303309,-0.0255277,-0.0204005,-0.0150202,-0.00945298,-0.00376106,0.00200391]

#spin7=[-0.5,-0.49502,-0.480277,-0.456355,-0.42419,-0.385021,-0.340328,-0.291749,-0.241004,-0.189808,-0.139797,-0.0924546,-0.0490574,-0.0106304,0.0220784,0.0486087,0.068782,0.0826828,0.0906275,0.0931251,0.0908323,0.084506,0.0749562,0.0630027,0.0494358,0.0349851,0.0202944,0.00590625,-0.00774686,-0.0203437,-0.0316693,-0.0416055,-0.0501173,-0.0572382,-0.0630551,-0.0676899,-0.0712875,-0.0740032,-0.0759918,-0.0774009,-0.0783648,-0.0790123,-0.0794361,-0.0797124,-0.0799033,-0.080053,-0.0801884,-0.0803209,-0.0804465,-0.0805469,-0.0805919,-0.080516,-0.0802707,-0.079849,-0.0791802,-0.0782703,-0.0770873,-0.0754856,-0.0735476,-0.071287,-0.068692,-0.0658481,-0.0628538,-0.0597854,-0.0565761,-0.0533353,-0.0501437,-0.0472488,-0.0448815,-0.0433159,-0.0425013,-0.0425281,-0.0434643,-0.0453287,-0.0482547,-0.0520838,-0.056749,-0.062159,-0.0681734,-0.0746367,-0.0813858,-0.0882456,-0.095041,-0.101464,-0.107594,-0.113347,-0.118542,-0.123141,-0.127132,-0.130592,-0.133447,-0.135883,-0.138047,-0.139926,-0.141641,-0.143272,-0.14489,-0.146534,-0.148218,-0.149919,-0.151654,-0.153403,-0.155136,-0.156819,-0.158413,-0.159826,-0.161009,-0.161877,-0.162433,-0.162503,-0.162019,-0.160939,-0.159247,-0.156889,-0.153669,-0.149628,-0.144706,-0.138847,-0.132012,-0.124085,-0.115246,-0.105497,-0.0949223,-0.083637,-0.0717833,-0.0595215,-0.0470527,-0.0346199,-0.0226257,-0.0111597,-0.000377054,0.00956836,0.0185537,0.0264613,0.0332482,0.0388636,0.0432877,0.0465386,0.0487538,0.0500785,0.0504026,0.0497856,0.0482948,0.0460055,0.0430008,0.039367,0.0352791,0.0307067,0.0257182,0.020405,0.0148503,0.00914605,0.00321013,-0.00265773,-0.00841416,-0.0138939,-0.0191737,-0.0241796,-0.0288277,-0.0330277,-0.0366975,-0.0397833,-0.0421416,-0.0437329,-0.0446933,-0.0448629,-0.0443287,-0.0432107,-0.0416265,-0.0397176,-0.0375978,-0.035356,-0.0330708,-0.0308082,-0.0286194,-0.0265488,-0.0246411,-0.0229447,-0.0215156,-0.0204186,-0.0197209,-0.019482,-0.0197495,-0.0205631,-0.0219619,-0.0239909,-0.0266618,-0.0299685,-0.0338718,-0.0383017,-0.0431555,-0.0483634,-0.0538374,-0.0594835,-0.0651981,-0.0708742,-0.0764134,-0.0817345,-0.086777,-0.091502,-0.0958876]

#spin8=[0.5,0.49502,0.480277,0.456355,0.424189,0.385021,0.340327,0.291745,0.240992,0.189778,0.139731,0.0923195,0.0488004,0.0101707,-0.0228585,-0.0498732,-0.0707508,-0.0856406,-0.0949312,-0.0992091,-0.0992101,-0.0957686,-0.0897657,-0.0820808,-0.0735483,-0.0649201,-0.0568382,-0.0498145,-0.0442206,-0.0402858,-0.0381034,-0.0376427,-0.0387672,-0.0412552,-0.044824,-0.0491511,-0.0538985,-0.0587329,-0.0633429,-0.0674527,-0.0708324,-0.0733019,-0.0747244,-0.0750443,-0.0742476,-0.0723681,-0.0694818,-0.065702,-0.0611714,-0.0560557,-0.0505365,-0.0447976,-0.0390542,-0.0334638,-0.0282316,-0.0234811,-0.0193574,-0.0160333,-0.0135778,-0.0120484,-0.0115141,-0.0119982,-0.0134088,-0.0156885,-0.0188663,-0.0228461,-0.0274867,-0.0325952,-0.0379094,-0.0432253,-0.0483277,-0.052996,-0.0569801,-0.0601383,-0.0623224,-0.0633383,-0.0631264,-0.0616171,-0.0587999,-0.0547063,-0.0493969,-0.0429679,-0.0355598,-0.0274413,-0.0188005,-0.00972956,-0.000395839,0.00903806,0.0183929,0.027632,0.0363044,0.0442539,0.0514454,0.0577538,0.0631111,0.0675276,0.0710111,0.0735742,0.0752416,0.0760115,0.0760125,0.0753215,0.0740134,0.0721684,0.069856,0.0671947,0.0642828,0.0611372,0.0578381,0.0543203,0.05058,0.0466264,0.0424844,0.0381965,0.0336987,0.0290536,0.0242662,0.0193194,0.0141836,0.00886101,0.00324432,-0.00264592,-0.00879191,-0.0151451,-0.0216302,-0.0282027,-0.0348407,-0.0414747,-0.0479705,-0.0542471,-0.0600862,-0.0655854,-0.0707407,-0.0755631,-0.0800339,-0.0841232,-0.0877997,-0.0910399,-0.0937907,-0.0959591,-0.0976654,-0.0988931,-0.0996305,-0.0998596,-0.0995555,-0.0986924,-0.0974102,-0.0955196,-0.0930385,-0.0898506,-0.0859627,-0.0814222,-0.0763013,-0.070744,-0.0648437,-0.0585623,-0.0521084,-0.0456056,-0.0392152,-0.0331287,-0.0275468,-0.0226544,-0.0185948,-0.0154955,-0.0135184,-0.0126995,-0.0130815,-0.0146,-0.0172139,-0.0208517,-0.0253828,-0.0306503,-0.0364885,-0.0427313,-0.0492066,-0.0557334,-0.0621262,-0.0682052,-0.0738053,-0.0787741,-0.0829718,-0.0862832,-0.0886244,-0.0899432,-0.0902135,-0.0894364,-0.0876262,-0.0848287,-0.0811164,-0.0765886,-0.0713482,-0.06553,-0.0592606,-0.0526644,-0.0458676,-0.0389974,-0.0321789,-0.0255321,-0.019167,-0.0131782,-0.00763946]

#spin9=[-0.5,-0.49502,-0.480277,-0.456357,-0.4242,-0.385058,-0.340433,-0.292,-0.241533,-0.190819,-0.141583,-0.0954102,-0.0536833,-0.0175344,0.0121929,0.0349631,0.0505534,0.0590426,0.0607871,0.0563859,0.0466362,0.0324841,0.014972,-0.00481372,-0.0257925,-0.0469344,-0.0672987,-0.0860645,-0.102553,-0.11624,-0.126764,-0.133918,-0.137648,-0.138033,-0.135269,-0.129648,-0.121535,-0.111347,-0.0995342,-0.086559,-0.0728814,-0.0589506,-0.0451886,-0.0319697,-0.0196328,-0.00847127,0.00126902,0.00939381,0.0157597,0.0202749,0.0228989,0.0236744,0.0226158,0.0198434,0.0155597,0.00988762,0.00304487,-0.00470266,-0.0131156,-0.0219159,-0.0308255,-0.0395401,-0.04786,-0.0555615,-0.0623684,-0.0681286,-0.072803,-0.0762279,-0.0784798,-0.0795074,-0.0794709,-0.0784896,-0.0767227,-0.0743216,-0.0714496,-0.068339,-0.065191,-0.0621887,-0.0595139,-0.0573315,-0.0557821,-0.0549836,-0.0550136,-0.0558538,-0.0576537,-0.0602667,-0.0636965,-0.0678722,-0.0727008,-0.0780747,-0.0838041,-0.0898607,-0.0960054,-0.102122,-0.10815,-0.114015,-0.11965,-0.124993,-0.129979,-0.134547,-0.138641,-0.142218,-0.14524,-0.147691,-0.149588,-0.15095,-0.151785,-0.152017,-0.15153,-0.15032,-0.148327,-0.145499,-0.141803,-0.137269,-0.13183,-0.125537,-0.118451,-0.110657,-0.102264,-0.0934865,-0.0842845,-0.0747952,-0.0651587,-0.0555485,-0.0461685,-0.0371792,-0.0286654,-0.020698,-0.0133746,-0.00681075,-0.00118104,0.00356339,0.0074398,0.0104565,0.0126957,0.0142213,0.0150976,0.0153825,0.0150298,0.0140837,0.0127574,0.011116,0.00921274,0.00708075,0.00473513,0.00218312,-0.000509903,-0.00340998,-0.00653976,-0.00996139,-0.0136864,-0.0177004,-0.0220085,-0.0266023,-0.0313755,-0.0362529,-0.0411265,-0.0459269,-0.050573,-0.0549551,-0.0589406,-0.0623799,-0.0651108,-0.0670053,-0.0679717,-0.0679302,-0.06687,-0.0647915,-0.0616696,-0.0575233,-0.0524123,-0.0464306,-0.0397118,-0.0324212,-0.0247517,-0.0169181,-0.0091448,-0.00165078,0.00536165,0.0117126,0.0172502,0.021856,0.0254465,0.0279741,0.0294169,0.0297922,0.0290874,0.0273252,0.0245567,0.0208715,0.0163937,0.0112799,0.00567679,-0.000278131,-0.00645127,-0.0127076,-0.0189099,-0.0249226,-0.0306192,-0.0358884,-0.0406504]

#spin10=[0.5,0.495018,0.480228,0.456087,0.423339,0.382983,0.336235,0.284477,0.229207,0.171986,0.114372,0.0578767,0.0039054,-0.0462807,-0.0916033,-0.131193,-0.164408,-0.190838,-0.210307,-0.22286,-0.228743,-0.228381,-0.222352,-0.211348,-0.196148,-0.177585,-0.15651,-0.133771,-0.110182,-0.0865033,-0.0634263,-0.0415593,-0.0214193,-0.00342708,0.0120948,0.0249196,0.0349136,0.0420308,0.0463057,0.0478458,0.046823,0.043478,0.038066,0.0309086,0.022342,0.012719,0.00240003,-0.0082596,-0.0189169,-0.0292512,-0.0389724,-0.0478593,-0.0556687,-0.0622386,-0.0674432,-0.0712232,-0.0735647,-0.0744985,-0.0741103,-0.0725122,-0.0697964,-0.0661617,-0.0617937,-0.0568817,-0.0517209,-0.0464858,-0.0413512,-0.0364595,-0.0318712,-0.0276677,-0.0240082,-0.0209468,-0.0185051,-0.0166966,-0.0154137,-0.0146573,-0.0143396,-0.0143752,-0.0146487,-0.0150441,-0.0154566,-0.0157888,-0.0159378,-0.0158147,-0.0151748,-0.0141024,-0.0125314,-0.010463,-0.00790895,-0.0049741,-0.00162908,0.00218574,0.00639368,0.0109322,0.0157483,0.0207595,0.0258867,0.0310354,0.0360902,0.0408567,0.0452686,0.0492078,0.0525802,0.0553163,0.0574095,0.0587399,0.0592691,0.0589486,0.0577782,0.055694,0.0526697,0.0487101,0.0438292,0.0380261,0.0313562,0.0239247,0.0158169,0.00714335,-0.00196301,-0.011279,-0.0206762,-0.0300071,-0.0390988,-0.0477684,-0.0558312,-0.0631375,-0.0695852,-0.0750783,-0.0795031,-0.082754,-0.0848427,-0.0856955,-0.0853308,-0.083758,-0.0811034,-0.0774681,-0.072963,-0.0677031,-0.0618143,-0.0554162,-0.0486761,-0.0417376,-0.0347413,-0.0278287,-0.0211431,-0.0148252,-0.00894807,-0.0037261,0.000658336,0.00421782,0.00689063,0.00864249,0.00944168,0.00943011,0.0085823,0.00681398,0.00422335,0.000882398,-0.00310339,-0.00761692,-0.012549,-0.0178531,-0.0234771,-0.0293423,-0.0352889,-0.0412452,-0.0470906,-0.0527106,-0.0580055,-0.0628802,-0.0672882,-0.0712015,-0.0745768,-0.0773536,-0.0794715,-0.0808781,-0.0815275,-0.0813791,-0.0803986,-0.078566,-0.0758869,-0.0723963,-0.0681575,-0.0632544,-0.0577782,-0.0518444,-0.045531,-0.0389311,-0.0321532,-0.0253302,-0.018594,-0.0121274,-0.00606684,-0.000537328,0.00433884,0.00844125,0.0116591,0.0139025,0.0151146,0.0152732,0.0143901]

#spin11=[-0.5,-0.497504,-0.490071,-0.477867,-0.461164,-0.440331,-0.415822,-0.388164,-0.357942,-0.325779,-0.292324,-0.25823,-0.224138,-0.19066,-0.158367,-0.127774,-0.0993276,-0.0734032,-0.0502943,-0.0302122,-0.0132848,0.000441224,0.0109963,0.0184821,0.0230635,0.0249604,0.0244378,0.0217956,0.0173584,0.0114652,0.00445989,-0.00331833,-0.011543,-0.0199075,-0.0281291,-0.0359605,-0.0431875,-0.0496339,-0.0551625,-0.0596757,-0.0631149,-0.0654568,-0.0667153,-0.0669426,-0.0662123,-0.0646215,-0.0622861,-0.0593362,-0.0559105,-0.0521514,-0.0481999,-0.0442105,-0.0403055,-0.0365991,-0.0332621,-0.0303264,-0.0278566,-0.0258784,-0.0244022,-0.023465,-0.0229938,-0.0230895,-0.0236847,-0.0247429,-0.0261875,-0.0279856,-0.0301425,-0.0325451,-0.0350935,-0.0376319,-0.040169,-0.0426598,-0.0450503,-0.0473415,-0.049454,-0.0514851,-0.0533523,-0.0550729,-0.0566626,-0.0581292,-0.0594854,-0.0607525,-0.0619647,-0.0631881,-0.0644078,-0.0656617,-0.0670063,-0.0684602,-0.0700246,-0.0716624,-0.0733796,-0.0752214,-0.0771771,-0.0792944,-0.0814631,-0.083621,-0.0857091,-0.087675,-0.0894748,-0.0910774,-0.0924597,-0.0935933,-0.0944515,-0.0950045,-0.0952299,-0.0950928,-0.0945562,-0.0935956,-0.092308,-0.0906103,-0.0885222,-0.0860722,-0.0833042,-0.0803303,-0.0772153,-0.0739624,-0.0706198,-0.0672387,-0.063877,-0.0606236,-0.0575792,-0.0548323,-0.0524778,-0.0506127,-0.0493128,-0.0486035,-0.0484734,-0.0489275,-0.0499411,-0.0515839,-0.0538506,-0.0567145,-0.0601298,-0.064028,-0.0683457,-0.0730074,-0.0779321,-0.0830399,-0.0882849,-0.0935427,-0.0987321,-0.103767,-0.108562,-0.11303,-0.11709,-0.120664,-0.123752,-0.126206,-0.12791,-0.128895,-0.129141,-0.128654,-0.127418,-0.125483,-0.122887,-0.119775,-0.116104,-0.111956,-0.107426,-0.102619,-0.0976283,-0.0924953,-0.0873224,-0.0821946,-0.077186,-0.0723491,-0.0678062,-0.063678,-0.060054,-0.0570059,-0.0545811,-0.0528025,-0.0516844,-0.0512404,-0.0514745,-0.0523739,-0.0539146,-0.0560682,-0.0588026,-0.0620806,-0.0658556,-0.0700677,-0.0746408,-0.0794855,-0.0844997,-0.0895916,-0.0946425,-0.0995553,-0.104245,-0.108633,-0.112671,-0.116277,-0.119393,-0.121972,-0.123971,-0.125355,-0.1261,-0.126191,-0.125626,-0.124417,-0.122581]