# thermal_expansion_coeff_circles = 8.0e-5
# '${thermal_expansion_coeff_circles}'

[Mesh]
  file = gold/fusion_tube_v5.e
  block_id = '1 2 3'
  block_name = 'boundary sml_circles big_circles '

  boundary_id = '1 2'
  boundary_name = 'fix_surfaces floating_circles'

  # patch_update_strategy = iteration
  construct_side_list_from_node_list=true
[]

[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[Variables]
  [./temperature]
    order = FIRST
    family = LAGRANGE
    initial_condition = 25.0
    block = 'sml_circles big_circles'
  [../]
[]

[Kernels]
  [./Tdot_sml_circles]
    type     = HeatConductionTimeDerivative
    specific_heat = 1
    variable = temperature
    block = 'sml_circles'
  [../]
  [./heat_conduction_sml_circles]
    type = HeatConduction
    variable = temperature
    diffusion_coefficient = 1e-5
    block = 'sml_circles'
  [../]
  [./Tdot_big_circles]
    type     = HeatConductionTimeDerivative
    specific_heat = 1
    variable = temperature
    block = 'big_circles'
  [../]
  [./heat_conduction_big_circles]
    type = HeatConduction
    variable = temperature
    diffusion_coefficient = 1e-4
    block = 'big_circles'
  [../]
[]

[Modules/TensorMechanics/Master]
  generate_output = 'stress_xx stress_yy stress_zz stress_xy stress_yz stress_zx
                     strain_xx strain_yy strain_zz strain_xy strain_yz strain_zx
                     vonmises_stress hydrostatic_stress
                     elastic_strain_xx elastic_strain_yy elastic_strain_zz'
  [./circles]
    strain = FINITE
    block = 'sml_circles big_circles'
    add_variables = true
    eigenstrain_names = 'thermal_expansion'
    save_in = 'resid_x resid_y'
  [../]
  [./boundary]
    strain = FINITE
    block = 'boundary'
    add_variables = true
    save_in = 'resid_x resid_y'
  [../]
[]

[AuxVariables]
  [./resid_x]
  [../]
  [./resid_y]
  [../]
  [./thermal_strain_xx]
    order = CONSTANT
    family = MONOMIAL
    block = 'sml_circles big_circles'
  [../]
  [./thermal_strain_yy]
    order = CONSTANT
    family = MONOMIAL
    block = 'sml_circles big_circles'
  [../]
[]

[AuxKernels]
  [./thermal_strain_xx]
    type = RankTwoAux
    block = 'sml_circles big_circles'
    rank_two_tensor = thermal_expansion
    variable = thermal_strain_xx
    index_i = 0
    index_j = 0
    execute_on = 'timestep_end'
  [../]
  [./thermal_strain_yy]
    type = RankTwoAux
    block = 'sml_circles big_circles'
    rank_two_tensor = thermal_expansion
    variable = thermal_strain_yy
    index_i = 1
    index_j = 1
    execute_on = 'timestep_end'
  [../]
[]

[Contact]
  [./circle_w_boundary]
    secondary = 'floating_circles'
    primary = 'fix_surfaces'
    penalty = 1e12
    model = glued
    formulation = penalty
  [../]
  [./bet_circles]
    secondary =  '10001  10002  10003  10004  10005  10006  10007  10008  10009  10010  10011  10012  10013  10014  10015  10016  10017  10018  10019  10020  10021  10022  10023  10024  10025  10026  10027  10028  10029  10030  10031  10032  10033  10034  10035  10036  10037  10038  10039  10040  10041  10042  10043  10044  10045  10046  10047  10048  10049  10050  10051  10052  10053  10054  10055  10056  10057  10058  10059  10060  10061  10062  10063  10064  10065  10066  10067  10068  10069  10070  10071  10072  10073  10074  10075  10076  10077  10078  10079  10080  10081  10082  10083  10084  10085  10086  10087  10088  10089  10090  10091  10092  10093  10094  10095  10096  10097  10098  10099  10100  10101  10102  10103  10104  10105  10106  10107  10108  10109  10110  10111  10112  10113  10114  10115  10116  10117  10118  10119  10120  10121  10122  10123  10124  10125  10126  10127  10128  10129  10130  10131  10132  10133  10134  10135  10136  10137  10138  10139  10140  10141  10142  10143  10144  10145  10146  10147  10148  10149  10150  10151  10152  10153  10154  10155  10156  10157  10158  10159  10160  10161  10162  10163  10164  10165  10166  10167  10168  10169  10170  10171  10172  10173  10174  10175  10176  10177  10178  10179  10180  10181  10182  10183  10184  10185  10186  10187  10188  10189  10190  10191  10192  10193  10194  10195  10196  10197  10198  10199  10200  10201  10202  10203  10204  10205  10206  10207  10208  10209  10210  10211  10212  10213  10214  10215  10216  10217  10218  10219  10220  10221  10222  10223  10224  10225  10226  10227  10228  10229  10230  10231  10232  10233  10234  10235  10236  10237  10238  10239  10240  10241  10242  10243  10244  10245  10246  10247  10248  10249  10250  10251  10252  10253  10254  10255  10256  10257  10258  10259  10260  10261  10262  10263  10264  10265  10266  10267  10268  10269  10270  10271  10272  10273  10274  10275  10276  10277  10278  10279  10280  10281  10282  10283  10284  10285  10286  10287  10288  10289  10290  10291  10292  10293  10294  10295  10296  10297  10298  10299  10300  10301  10302  10303  10304  10305  10306  10307  10308  10309  10310  10311  10312  10313  10314  10315  10316  10317  10318  10319  10320  10321  10322  10323  10324  10325  10326  10327  10328  10329  10330  10331  10332  10333  10334  10335  10336  10337  10338  10339  10340  10341  10342  10343  10344  10345  10346  10347  10348  10349  10350  10351  10352  10353  10354  10355  10356  10357  10358  10359  10360  10361  10362  10363  10364  10365  10366  10367  10368  10369  10370  10371  10372  10373  10374  10375  10376  10377  10378  10379  10380  10381  10382  10383  10384  10385  10386  10387  10388  10389  10390  10391  10392  10393  10394  10395  10396  10397  10398  10399  10400  10401  10402  10403  10404  10405  10406  10407  10408  10409  10410  10411  10412  10413  10414  10415  10416  10417  10418  10419  10420  10421  10422  10423  10424  10425  10426  10427  10428  10429  10430  10431  10432  10433  10434  10435  10436  10437  10438  10439  10440  10441  10442  10443  10444  10445  10446  10447  10448  10449  10450  10451  10452  10453  10454  10455  10456  10457  10458  10459  10460  10461  10462  10463  10464  10465  10466  10467  10468  10469  10470  10471  10472  10473  10474  10475  10476  10477  10478  10479  10480  10481  10482  10483  10484  10485  10486  10487  10488  10489  10490  10491  10492  10493  10494  10495  10496  10497  10498  10499  10500  10501  10502  10503  10504  10505  10506  10507  10508  10509  10510  10511  10512  10513  10514  10515  10516  10517  10518  10519  10520  10521  10522  10523  10524  10525  10526  10527  10528  10529  10530  10531  10532  10533  10534  10535  10536  10537  10538  10539  10540  10541  10542  10543  10544  10545  10546  10547  10548  10549  10550  10551  10552  10553  10554  10555  10556  10557  10558  10559  10560  10561  10562  10563  10564  10565  10566  10567  10568  10569  10570  10571  10572  10573  10574  10575  10576  10577  10578  10579  10580  10581  10582  10583  10584  10585  10586  10587  10588  10589  10590  10591  10592  10593  10594  10595  10596  10597  10598  10599  10600  10601  10602  10603  10604  10605  10606  10607  10608  10609  10610  10611  10612  10613  10614  10615  10616  10617  10618  10619  10620  10621  10622  10623  10624  10625  10626  10627  10628  10629  10630  10631  10632  10633  10634  10635  10636  10637  10638  10639  10640  10641  10642  10643  10644  10645  10646  10647  10648  10649  10650  10651  10652  10653  10654  10655  10656  10657  10658  10659  10660  10661  10662  10663  10664  10665  10666  10667  10668  10669  10670  10671  10672  10673  10674  10675  10676  10677  10678  10679'
    primary =  '1001  1002  1003  1004  1005  1006  1007  1008  1009  1010  1011  1012  1013  1014  1015  1016  1017  1018  1019  1020  1021  1022  1023  1024  1025  1026  1027  1028  1029  1030  1031  1032  1033  1034  1035  1036  1037  1038  1039  1040  1041  1042  1043  1044  1045  1046  1047  1048  1049  1050  1051  1052  1053  1054  1055  1056  1057  1058  1059  1060  1061  1062  1063  1064  1065  1066  1067  1068  1069  1070  1071  1072  1073  1074  1075  1076  1077  1078  1079  1080  1081  1082  1083  1084  1085  1086  1087  1088  1089  1090  1091  1092  1093  1094  1095  1096  1097  1098  1099  1100  1101  1102  1103  1104  1105  1106  1107  1108  1109  1110  1111  1112  1113  1114  1115  1116  1117  1118  1119  1120  1121  1122  1123  1124  1125  1126  1127  1128  1129  1130  1131  1132  1133  1134  1135  1136  1137  1138  1139  1140  1141  1142  1143  1144  1145  1146  1147  1148  1149  1150  1151  1152  1153  1154  1155  1156  1157  1158  1159  1160  1161  1162  1163  1164  1165  1166  1167  1168  1169  1170  1171  1172  1173  1174  1175  1176  1177  1178  1179  1180  1181  1182  1183  1184  1185  1186  1187  1188  1189  1190  1191  1192  1193  1194  1195  1196  1197  1198  1199  1200  1201  1202  1203  1204  1205  1206  1207  1208  1209  1210  1211  1212  1213  1214  1215  1216  1217  1218  1219  1220  1221  1222  1223  1224  1225  1226  1227  1228  1229  1230  1231  1232  1233  1234  1235  1236  1237  1238  1239  1240  1241  1242  1243  1244  1245  1246  1247  1248  1249  1250  1251  1252  1253  1254  1255  1256  1257  1258  1259  1260  1261  1262  1263  1264  1265  1266  1267  1268  1269  1270  1271  1272  1273  1274  1275  1276  1277  1278  1279  1280  1281  1282  1283  1284  1285  1286  1287  1288  1289  1290  1291  1292  1293  1294  1295  1296  1297  1298  1299  1300  1301  1302  1303  1304  1305  1306  1307  1308  1309  1310  1311  1312  1313  1314  1315  1316  1317  1318  1319  1320  1321  1322  1323  1324  1325  1326  1327  1328  1329  1330  1331  1332  1333  1334  1335  1336  1337  1338  1339  1340  1341  1342  1343  1344  1345  1346  1347  1348  1349  1350  1351  1352  1353  1354  1355  1356  1357  1358  1359  1360  1361  1362  1363  1364  1365  1366  1367  1368  1369  1370  1371  1372  1373  1374  1375  1376  1377  1378  1379  1380  1381  1382  1383  1384  1385  1386  1387  1388  1389  1390  1391  1392  1393  1394  1395  1396  1397  1398  1399  1400  1401  1402  1403  1404  1405  1406  1407  1408  1409  1410  1411  1412  1413  1414  1415  1416  1417  1418  1419  1420  1421  1422  1423  1424  1425  1426  1427  1428  1429  1430  1431  1432  1433  1434  1435  1436  1437  1438  1439  1440  1441  1442  1443  1444  1445  1446  1447  1448  1449  1450  1451  1452  1453  1454  1455  1456  1457  1458  1459  1460  1461  1462  1463  1464  1465  1466  1467  1468  1469  1470  1471  1472  1473  1474  1475  1476  1477  1478  1479  1480  1481  1482  1483  1484  1485  1486  1487  1488  1489  1490  1491  1492  1493  1494  1495  1496  1497  1498  1499  1500  1501  1502  1503  1504  1505  1506  1507  1508  1509  1510  1511  1512  1513  1514  1515  1516  1517  1518  1519  1520  1521  1522  1523  1524  1525  1526  1527  1528  1529  1530  1531  1532  1533  1534  1535  1536  1537  1538  1539  1540  1541  1542  1543  1544  1545  1546  1547  1548  1549  1550  1551  1552  1553  1554  1555  1556  1557  1558  1559  1560  1561  1562  1563  1564  1565  1566  1567  1568  1569  1570  1571  1572  1573  1574  1575  1576  1577  1578  1579  1580  1581  1582  1583  1584  1585  1586  1587  1588  1589  1590  1591  1592  1593  1594  1595  1596  1597  1598  1599  1600  1601  1602  1603  1604  1605  1606  1607  1608  1609  1610  1611  1612  1613  1614  1615  1616  1617  1618  1619  1620  1621  1622  1623  1624  1625  1626  1627  1628  1629  1630  1631  1632  1633  1634  1635  1636  1637  1638  1639  1640  1641  1642  1643  1644  1645  1646  1647  1648  1649  1650  1651  1652  1653  1654  1655  1656  1657  1658  1659  1660  1661  1662  1663  1664  1665  1666  1667  1668  1669  1670  1671  1672  1673  1674  1675  1676  1677  1678  1679'
    penalty = 1e12
    model = glued
    formulation = penalty
  [../]
[]

[Dampers]
  [limitx] #nonlinear iteration
    type = MaxIncrement
    max_increment = 1
    variable = disp_x
  []
  [limity]
    type = MaxIncrement
    max_increment = 1
    variable = disp_y
  []
[]

[BCs]
  [./x_disp]
    type = DirichletBC
    variable = disp_x
    boundary = 'fix_surfaces'
    value    = 0.0
  [../]
  [./y_disp]
    type = DirichletBC
    variable = disp_y
    boundary = 'fix_surfaces'
    value    = 0.0
  [../]
  [./temperature]
    type = FunctionDirichletBC
    variable = temperature
    boundary = 'floating_circles'
    function = '(100-2*y)*t'
  [../]
[]

[Materials]
  [thermal_strain_circles]
    type = ComputeThermalExpansionEigenstrain
    block = 'sml_circles big_circles'
    temperature = temperature
    thermal_expansion_coeff = 8.0e-5
    stress_free_temperature = 23.0
    eigenstrain_name = thermal_expansion
  []
  [./elasticity_tensor_all]
    type = ComputeElasticityTensor
    block = 'sml_circles big_circles boundary'
    fill_method = symmetric_isotropic
    C_ijkl = '0 5E9'
  [../]
  [./stress_all]
    type = ComputeFiniteStrainElasticStress
    block = 'sml_circles big_circles boundary'
  [../]
  [./density_sml_circles]
    type = GenericConstantMaterial
    block = 'sml_circles'
    prop_names = 'density'
    prop_values = '100'
  [../]
  [./density_big_circles]
    type = GenericConstantMaterial
    block = 'big_circles'
    prop_names = 'density'
    prop_values = '50'
  [../]
  [./density_boundary]
    type = GenericConstantMaterial
    block = 'boundary'
    prop_names = 'density'
    prop_values = '1000'
  [../]
[]

[Executioner]
  type = Transient
  dt = 0.1
  automatic_scaling = true
  end_time = 50

  solve_type = 'PJFNK'
  petsc_options_iname = '-pc_type -pc_factor_shift_type -pc_factor_shift_amount -ksp_gmres_restart'
  petsc_options_value = 'lu NONZERO   1e-5 50'

  nl_max_its = 50
  l_max_its = 30
  nl_abs_tol = 5e-3
  nl_rel_tol = 1e-5
  line_search = none
  petsc_options = '-snes_converged_reason'
[]

[Outputs]
  perf_graph = true
  [./Exo]
    type = Exodus
    elemental_as_nodal = true
  [../]
[]

[Debug]
  show_var_residual_norms = true
[]
