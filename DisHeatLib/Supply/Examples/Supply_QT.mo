within DisHeatLib.Supply.Examples;
model Supply_QT
  import DisHeatLib;
  extends Modelica.Icons.Example;
  package Medium = IBPSA.Media.Water;

  DisHeatLib.Supply.Supply_QT supply_QT(
    redeclare package Medium = Medium,
    show_T=true,
    Q_flow_nominal=5000,
    TemSup_nominal=343.15,
    TemRet_nominal=313.15,
    dp_nominal=100000,
    powerCha(Q_flow={0,0.97}, P={0,1}),
    use_Q_in=true,
    use_m_flow_limit=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  IBPSA.Fluid.Sources.FixedBoundary bou(
    redeclare package Medium = Medium,
    use_T=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{40,-10},{20,10}})));
  IBPSA.Fluid.Sources.FixedBoundary bou1(
    redeclare package Medium = Medium,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Sources.Ramp Q_flow_set(
    height=10000,
    offset=0,
    duration(displayUnit="h") = 72000,
    startTime(displayUnit="h") = 7200)
    annotation (Placement(transformation(extent={{-36,30},{-16,50}})));
  Modelica.Blocks.Sources.Ramp m_flow_limit(
    height=-0.02,
    offset=0.03,
    duration(displayUnit="h") = 72000,
    startTime(displayUnit="h") = 7200)
    annotation (Placement(transformation(extent={{38,30},{18,50}})));
equation
  connect(Q_flow_set.y, supply_QT.QSet)
    annotation (Line(points={{-15,40},{-6,40},{-6,12}}, color={0,0,127}));
  connect(bou1.ports[1], supply_QT.port_a)
    annotation (Line(points={{-20,0},{-10,0}}, color={0,127,255}));
  connect(supply_QT.ports_b[1], bou.ports[1])
    annotation (Line(points={{10,0},{20,0}}, color={0,127,255}));
  connect(m_flow_limit.y, supply_QT.m_flow_limit)
    annotation (Line(points={{17,40},{0,40},{0,12}}, color={0,0,127}));
  annotation (__Dymola_Commands(file="modelica://DisHeatLib/Resources/Scripts/Dymola/Supply/Examples/Supply_QT.mos"
        "Simulate and plot"),
        Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>Feburary 27, 2019, by Benedikt Leitner:<br>Implementation and added User&apos;s guide. </li>
</ul>
</html>"));
end Supply_QT;
