within DisHeatLib.Demand.BaseDemands.Examples;
model FixedReturn
  extends Modelica.Icons.Example;
  package Medium = IBPSA.Media.Water;
  Modelica.Fluid.Sources.FixedBoundary boundaryRL(          redeclare package
      Medium = Medium, nPorts=1)
    annotation (Placement(transformation(extent={{40,-10},{20,10}})));
  Modelica.Fluid.Sources.MassFlowSource_T
                                     boundarySL(
    redeclare package Medium = Medium,
    use_T_in=true,
    m_flow=1,
    T=343.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Sources.Ramp T(
    height=80,
    offset=273.15 + 10.0,
    duration(displayUnit="d") = 864000,
    startTime(displayUnit="d") = 86400)
    annotation (Placement(transformation(extent={{-74,-6},{-54,14}})));

  BaseDemands.FixedReturn fixedReturn(
    redeclare package Medium = Medium,
    Q_flow_nominal(displayUnit="kW") = 10000,
    TemRet_nominal=35 + 273.15,
    returnTemperature=DisHeatLib.Demand.BaseClasses.InputTypeTret.Constant)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(T.y, boundarySL.T_in)
    annotation (Line(points={{-53,4},{-42,4}},   color={0,0,127}));
  connect(boundaryRL.ports[1], fixedReturn.port_b)
    annotation (Line(points={{20,0},{10,0}}, color={0,127,255}));
  connect(boundarySL.ports[1], fixedReturn.port_a)
    annotation (Line(points={{-20,0},{-10,0}}, color={0,127,255}));
  annotation (__Dymola_Commands(file="modelica://DisHeatLib/Resources/Scripts/Dymola/Demand/BaseDemands/Examples/FixedReturn.mos"
        "Simulate and plot"),
        Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>Feburary 27, 2019, by Benedikt Leitner:<br>Implementation and added User&apos;s guide. </li>
</ul>
</html>", info="<html>
<p><span style=\"font-family: Arial,sans-serif;\">This example demonstrates how this model removes heat from a medium in order for that medium to go down to a specific temperature and then output this heat. If the temperature of the medium is already below this threshold then nothing happens. The absorbed heat is measured and can be accesed through the output node. Since the medium looses heat the value of the heat flow is negative.</span></p>
<p><span style=\"font-family: Arial,sans-serif;\">The plot shows how the increase in temperature is followed by proportionally bigger negative heat flow as soon as the temperature is above the nominal return temperature.</span></p>
<p><span style=\"font-family: Arial,sans-serif;\">Available commands: Simulate and plot: simulates the example and plots the results so that the example can be better understood.</span></p>
</html>"),
    experiment(StopTime=1036800));
end FixedReturn;
