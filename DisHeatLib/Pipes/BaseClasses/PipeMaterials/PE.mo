within DisHeatLib.Pipes.BaseClasses.PipeMaterials;
record PE
  extends DisHeatLib.Pipes.BaseClasses.BasePipeMaterial(
    roughness=2.5e-5,
    cPip=2300,
    rhoPip=930);
  annotation (Documentation(revisions="<html>
<ul>
<li>Feburary 27, 2019, by Benedikt Leitner:<br>Implementation and added User&apos;s guide. </li>
</ul>
</html>"));
end PE;
