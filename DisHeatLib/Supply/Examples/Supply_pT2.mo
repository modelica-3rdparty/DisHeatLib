within DisHeatLib.Supply.Examples;
model Supply_pT2
  import DisHeatLib;
  extends Modelica.Icons.Example;
  package Medium = IBPSA.Media.Water;

  DisHeatLib.Supply.Supply_pT supply_pT(
    redeclare package Medium = Medium,
    show_T=true,
    Q_flow_nominal(displayUnit="kW") = 100000,
    TemSup_nominal=353.15,
    TemRet_nominal=313.15,
    powerCha(Q_flow={0,1000}, P={0,-2000}),
    SupplyTemperature=DisHeatLib.Supply.BaseClasses.InputTypeSupplyTemp.Input,
    dp_controller=false,
    dp_nominal=100000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
  IBPSA.Fluid.HeatExchangers.SensibleCooler_T coo(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    dp_nominal(displayUnit="bar") = 100000,
    QMin_flow(displayUnit="MW") = -2000000)
    annotation (Placement(transformation(extent={{12,30},{-8,50}})));
  Modelica.Blocks.Sources.Ramp T(
    height=90,
    offset=10 + 273.15,
    startTime(displayUnit="h") = 3600,
    duration(displayUnit="h") = 21600)
    annotation (Placement(transformation(extent={{48,54},{28,74}})));
  Modelica.Blocks.Sources.Sine T1(
    amplitude=40,
    freqHz=1/2400,
    offset=50 + 273.15,
    startTime(displayUnit="h") = 3600)
    annotation (Placement(transformation(extent={{78,-28},{58,-8}})));
equation
  connect(T.y, coo.TSet)
    annotation (Line(points={{27,64},{14,64},{14,48}}, color={0,0,127}));
  connect(supply_pT.ports_b[1], coo.port_a) annotation (Line(points={{8,0},{20,
          0},{20,40},{12,40}}, color={0,127,255}));
  connect(coo.port_b, supply_pT.port_a) annotation (Line(points={{-8,40},{-20,
          40},{-20,0},{-12,0}}, color={0,127,255}));
  connect(T1.y, supply_pT.TSup_in) annotation (Line(points={{57,-18},{30,-18},{
          30,12},{4,12}}, color={0,0,127}));
  annotation (__Dymola_Commands(file=
          "modelica://DisHeatLib/Resources/Scripts/Dymola/Supply/Examples/Supply_pT2.mos"
        "Simulate and plot"),
        Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>Feburary 27, 2019, by Benedikt Leitner:<br>Implementation and added User&apos;s guide. </li>
</ul>
</html>", info="<html>
<p><span style=\"font-family: Arial,sans-serif;\">This example shows how the Supply_pT model fulfills the role of a pump with a fixed pressure drop and a heat supply with limited heat generation.</span></p>
<p><span style=\"font-family: Arial,sans-serif;\">Available commands: Simulate and plot: simulates the example and plots the results so that the example can be better understood.</span></p>
</html>"));
end Supply_pT2;
