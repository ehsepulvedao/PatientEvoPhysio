package PatientEvoPhysio
  package Icons
    class Resistance
      annotation(
        Icon(graphics = {Bitmap(origin = {1, 1}, extent = {{-89, 89}, {89, -89}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/icons_resistance.svg")}));
    end Resistance;

    class Inertia
      annotation(
        Icon(graphics = {Bitmap(origin = {0, 1}, extent = {{-100, 63}, {100, -63}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/icons_inertia.svg")}));
    end Inertia;

    class Height
      annotation(
        Icon(graphics = {Bitmap(origin = {2, 3}, rotation = 180, extent = {{-86, 75}, {86, -75}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/icons_height.svg")}));
    end Height;

    class Function_in
      annotation(
        Icon(graphics = {Bitmap(origin = {2, 5}, extent = {{-72, 59}, {72, -59}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/icons_function_in.svg")}));
    end Function_in;

    class Constant_time_elastance
      annotation(
        Icon(graphics = {Bitmap(origin = {-1, 3}, extent = {{-95, 87}, {95, -87}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/icons_constant_time_elastance.svg")}));
    end Constant_time_elastance;

    class Time_Variant_Elastance
      annotation(
        Icon(graphics = {Bitmap(origin = {1, 3}, extent = {{-95, 87}, {95, -87}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/icons_time_variant_elastance.svg")}));
    end Time_Variant_Elastance;

    class Valve
      annotation(
        Icon(graphics = {Bitmap(origin = {0, 2}, extent = {{-96, 56}, {96, -56}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/icons_valve.svg")}));
    end Valve;

    class Cardiovascular_System
      annotation(
        Icon(graphics = {Bitmap(origin = {0, 0}, extent = {{-95, 95}, {95, -95}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/icons_cardiovascular_system.svg")}));
    end Cardiovascular_System;

    class Valve_2
      annotation(
        Icon(graphics = {Bitmap(origin = {0, 2}, extent = {{-96, 56}, {96, -56}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/icons_valve_2.svg")}));
    end Valve_2;
    annotation(
      Icon(graphics = {Rectangle(lineColor = {114, 113, 125}, fillColor = {248, 248, 248}, fillPattern = FillPattern.VerticalCylinder, extent = {{-100, -100}, {100, 100}}, radius = 25)}),
      Documentation(info = "<html>
  <p>
  This package contains all the icons used in the components of the physiological models.
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
  end Icons;

  package Components
    model Altitude
      extends Icons.Height;
      Connectors.PressureOutput P_partial_O2 annotation(
        Placement(visible = true, transformation(origin = {108, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {112, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Types.Pressure P_atm "Atmospheric pressure";
      Types.Pressure Po = 101324.72 "Pressure at sea level";
      parameter Modelica.SIunits.MolarMass m = 0.02896 "molar mass of earth air";
      parameter Modelica.SIunits.Temperature T = 298.15 "Standard temperature";
      parameter Modelica.SIunits.Length H = 520.503 "Height at sea level";
      parameter Real g(unit = "m/s2") = 9.81 "gravity acceleration";
      Real euler = Modelica.Constants.e;
      final constant Real K(final unit = "J/(mol.K)") = 8.3144598 "Molar gas constant";
    equation
      P_atm = Po*euler^((-m*g*H)/(K*T));
      P_partial_O2 = 0.2095*P_atm;
      annotation(
        Documentation(info = "<html>
<p>
The transition from fetus to neonate is governed by the availability of oxygen in the environment, leading to variations in birth outcomes between high-altitude and sea-level births. Studies have demonstrated that a decrease in the partial pressure of oxygen (P_partial_O2) in alveolar air is linked to an increase in pulmonary vascular resistance. Furthermore, chronic hypoxia resulting from living at high altitudes can not only delay fetal growth but also elevate perinatal mortality. This component represents the altitude-related phenomenon.
</p>
</html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
    end Altitude;

    model Blood_Inertia "Inertia of blood flow"
      extends Icons.Inertia;
      extends Connectors.Ports_Connector;
      extends Physiolibrary.SteadyStates.Interfaces.SteadyState(state_start = volumeFlow_start, storeUnit = "ml/min");
      parameter Types.VolumeFlowRate volumeFlow_start = 0.3 annotation(
        Dialog(group = "Initialization"));
      parameter Types.Resistance RETHA = 1.095e+08;
      parameter Types.Pressure PTH = 0;
      parameter Types.Inertance I = 1e-11;
    equation
      state = q_in.q;
      change = (q_in.pressure + PTH - (RETHA*q_in.q) - q_out.pressure)/I;
      q_in.conc = inStream(q_out.conc);
      q_out.conc = inStream(q_in.conc);
      annotation(
        Documentation(info = "<html>
    <p>
    This component represents the inertial behavior of the blood. This inertia produces a reduction in pressure when the velocity of the flow increases. Furthermore, with this element, it is simulated that the flow velocity in the aorta increases to its maximum during systole, while the flow is reduced during diastole.
    </p>
    </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"),
  Icon(graphics = {Text(origin = {6, -8}, textColor = {0, 0, 255}, extent = {{-220, -40}, {200, -80}}, textString = "%name")}));
    end Blood_Inertia;

    model Vascular_Resistance
      //------------------------------------
      //------------------------------------
      //-------Icon and conectors-----------
      //------------------------------------
      //------------------------------------
      extends Connectors.Ports_Connector;
      extends Icons.Resistance;
      //------------------------------------
      //------------------------------------
      //---------External Breathing---------
      //------------------------------------
      //------------------------------------
      parameter Boolean useOxygenInput = false annotation(
        Evaluate = true,
        HideResult = true,
        choices(checkBox = true),
        Dialog(group = "External inputs/outputs"));
      parameter Modelica.SIunits.Concentration Oxygen = 0 annotation(
        Dialog(enable = not useOxygenInput));
      Connectors.OxygenFlowInput oxygen(start = Oxygen) = O2_in if useOxygenInput annotation(
        Placement(transformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, -68}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
      Connectors.OxygenFlowOutput O2_current annotation(
        Placement(visible = true, transformation(origin = {91, -104}, extent = {{-20, -20}, {20, 20}}, rotation = 270), iconTransformation(origin = {-94, -64}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      Connectors.VolumeFlowRateOutput Q_PLAC annotation(
        Placement(visible = true, transformation(origin = {-82, -96}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {108, -54}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      //------------------------------------
      //------------------------------------
      //------Hydraulic Conductance---------
      //------------------------------------
      //------------------------------------
      parameter Boolean useConductanceInput = false annotation(
        Evaluate = true,
        HideResult = true,
        choices(checkBox = true),
        Dialog(group = "External inputs/outputs"));
      parameter Types.Conductance Conductance = 0 annotation(
        Dialog(enable = not useConductanceInput));
      Connectors.ConductanceInput cond(start = Conductance) = c if useConductanceInput annotation(
        Placement(visible = true, transformation(origin = {0, -106}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {0, 68}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      //------------------------------------
      //------------------------------------
      Real flow_L_per_min;
      Types.Resistance R;

    protected
      Types.Conductance c;
      Modelica.SIunits.Concentration O2_in;
    equation
      if not useConductanceInput then
        c = Conductance;
      end if;
      if not useOxygenInput then
        O2_in = Oxygen;
      end if;
      flow_L_per_min = q_in.q*6e4;

      R = noEvent(if abs(c) > 1e-30 then 1/c else 0);

      q_in.q = c*(q_in.pressure - q_out.pressure);
      q_in.conc = inStream(q_out.conc);
      q_out.conc = inStream(q_in.conc) + O2_in;
      O2_current = inStream(q_in.conc);
      Q_PLAC = q_in.q;


      annotation(
        Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Text(origin = {12, -56}, textColor = {0, 0, 255}, extent = {{-220, -40}, {200, -80}}, textString = "%name")}),
        Documentation(info = "<html>
    <p>
    This component represents the vascular resistances that emulate the arterial or venous ducts. This element has no accumulation of blood in the tissue and allows the entry of oxygen concentration from the outside. In this element, the blood flow of the elements connected at their ends in the direction of the flow of the element j to the element i is computed.
    </p>
    </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));
    end Vascular_Resistance;

    model Heart_Valve
      extends Connectors.Ports_Connector;
      extends Icons.Valve;
      Boolean open(start = true);
      Real passableVariable(start = 0, final unit = "1");
      parameter Types.Conductance _Gon(final min = 0, displayUnit = "l/(mmHg.min)") = 1.2501026264094e-02 annotation(
        Dialog(enable = not useLimitationInputs));
      parameter Types.Conductance _Goff(final min = 0, displayUnit = "l/(mmHg.min)") = 1.2501026264094e-12 annotation(
        Dialog(enable = not useLimitationInputs));
      parameter Types.Pressure Pknee(final min = 0) = 0;
      parameter Boolean useLimitationInputs = false annotation(
        Evaluate = true,
        HideResult = true,
        choices(checkBox = true),
        Dialog(group = "External inputs/outputs"));
      Connectors.ConductanceInput Gon(start = _Gon) = gon if useLimitationInputs annotation(
        Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {-60, 100})));
      Connectors.ConductanceInput Goff(start = _Goff) = goff if useLimitationInputs annotation(
        Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {60, 100})));
    protected
      Types.Conductance gon, goff;
      constant Types.Pressure unitPressure = 1;
      constant Types.VolumeFlowRate unitFlow = 1;
    equation
      if not useLimitationInputs then
        gon = _Gon;
        goff = _Goff;
      end if;
      open = passableVariable > Modelica.Constants.eps;
      dp = passableVariable*unitFlow*(if open then 1/gon else 1) + Pknee;
      volumeFlowRate = passableVariable*unitPressure*(if open then 1 else goff) + goff*Pknee;
      q_in.conc = inStream(q_out.conc);
      q_out.conc = inStream(q_in.conc);

      annotation(
        Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Text(textColor = {255, 0, 0}, extent = {{-188, -96}, {192, -118}}, textString = "%name")}),
        Documentation(info = "<html>
    <p>
    This component represents the valves that allow a blood flow in one direction in case the pressure gradient be greater. This element does not store blood in its tissue and simulates the mitral, aortic, tricuspid and pulmonary valves.
    </p>
    </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));
    end Heart_Valve;

    model Foramen_Ovale_Valve
      extends Connectors.Ports_Connector;
      extends Icons.Valve_2;
      Boolean open(start = true);
      Real passableVariable(start = 0, final unit = "1");

      parameter Types.Conductance _Gon(final min = 0, displayUnit = "l/(mmHg.min)") = 1.2501026264094e-02  annotation(
        Dialog(enable = not useLimitationInputs));
      parameter Types.Conductance _Goff(final min = 0, displayUnit = "l/(mmHg.min)") = 1.2501026264094e-12 annotation(
        Dialog(enable = not useLimitationInputs));
      parameter Types.Pressure Pknee(final min = 0) = 0 ;
      parameter Boolean useLimitationInputs = false annotation(
        Evaluate = true,
        HideResult = true,
        choices(checkBox = true),
        Dialog(group = "External inputs/outputs"));
      Connectors.ConductanceInput Gon(start = _Gon) = gon if useLimitationInputs annotation(
        Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {-60, 100})));
      Connectors.ConductanceInput Goff(start = _Goff) = goff if useLimitationInputs annotation(
        Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {60, 100})));
      Connectors.VolumeFlowRateInput Q_DV annotation(
        Placement(visible = true, transformation(origin = {-94, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {44, -106}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Types.VolumeFlowRate Q_FO;
    protected
      Types.Conductance gon, goff;
      constant Types.Pressure unitPressure = 1;
      constant Types.VolumeFlowRate unitFlow = 1;
    equation
      if not useLimitationInputs then
        gon = _Gon;
        goff = _Goff;
      end if;
      open = passableVariable > Modelica.Constants.eps;
      dp = passableVariable*unitFlow*(if open then 1/gon else 1) + Pknee;
      volumeFlowRate = passableVariable*unitPressure*(if open then 1 else goff) + goff*Pknee;
//----------------------------------
//----Preferential streaming of-----
//-----umbilical venous return------
//----------------------------------
      Q_FO = volumeFlowRate;
      q_in.conc = inStream(q_out.conc);
      q_out.conc = inStream(q_in.conc);
      annotation(
        Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Text(origin = {0, -18}, textColor = {255, 0, 0}, extent = {{-188, -96}, {192, -118}}, textString = "%name")}),
        Documentation(info = "<html>
    <p>
    This component represents the existence of the foramen ovale. This existence is represented by the path that connects the right and left atria through a valve.
    </p>
    </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));
    end Foramen_Ovale_Valve;

model Constant_Elastance
  extends Icons.Constant_time_elastance;
  extends Physiolibrary.SteadyStates.Interfaces.SteadyState(state_start = volume_start, storeUnit = "ml");
  Connectors.Input_Connector q_in(conc(start = (((SO2/100))*((Conc_Hb*1340)*((1)/(1000*22.4)))))) annotation(
    Placement(transformation(extent = {{-14, -14}, {14, 14}})));
  constant Types.Volume NormalVolume = 0.001 "1 liter" annotation(
    Evaluate = true,
    HideResult = true);
  parameter Types.Volume volume_start = 1e-11 annotation(
    Dialog(group = "Initialization"));
  Types.Volume excessVolume ;
  parameter Boolean useV0Input = false  annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "External inputs/outputs"));
  parameter Types.Volume ZeroPressureVolume = 1e-11 annotation(
    Dialog(enable = not useV0Input));
  parameter Types.Volume CollapsingPressureVolume = 1e-12 ;
  //------------------------------------
      //------------------------------------
      //---------Metabolic Rate-------------
      //------------------------------------
      //------------------------------------
      parameter Types.MolarFlow metabolicConsumption = 0 ;
  Types.MolarFlow metabolicConsumptionRate;
  parameter Real SO2 = 40 "Initial oxygen saturation [%]";
  Real oxygenSaturation(start = SO2) "Oxygen saturation [%]";
  parameter Modelica.SIunits.MassConcentration Conc_Hb = 175 "Hemoglobin mass concentration (SI kg/m3; numerically equal to g/L)";
  Modelica.SIunits.Concentration O2_Hb_max "Concentration carried by hemoglobin";
  Real k1 = 1.62, k2 = 0.22;
  Connectors.OxygenFlowOutput O2_current annotation(
    Placement(transformation(origin = {91, -104}, extent = {{-20, -20}, {20, 20}}, rotation = 270), iconTransformation(origin = {86, -80}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  parameter Boolean useOxygenInput = false annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "External inputs/outputs"));
  parameter Types.MolarFlow Oxygen = 1e-5 annotation(
    Dialog(enable = not useOxygenInput));
  //------------------------------------
      //------------------------------------
      //------------------------------------
      //------------------------------------
  Connectors.VolumeInput zeroPressureVolume(start = ZeroPressureVolume) = zpv if useV0Input annotation(
    Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {-80, 80})));
  parameter Boolean useComplianceInput = false annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "External inputs/outputs"));
  parameter Types.Compliance Compliance = 1 annotation(
    Dialog(enable = not useComplianceInput));
  Connectors.ComplianceInput compliance(start = Compliance) = c if useComplianceInput annotation(
    Placement(visible = true, transformation(origin = {0, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 270), iconTransformation(origin = {0, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 270)));
  parameter Boolean useExternalPressureInput = false annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(group = "External inputs/outputs"));
  parameter Types.Pressure ExternalPressure = 0 annotation(
    Dialog(enable = not useExternalPressureInput));
  parameter Types.Pressure MinimalCollapsingPressure = -101325;
  Connectors.PressureInput externalPressure(start = ExternalPressure) = ep if useExternalPressureInput annotation(
    Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {80, 80})));
  Connectors.VolumeOutput volume annotation(
    Placement(transformation(origin = {1, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 270), iconTransformation(origin = {-80, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 270)));
  Real pressure_mmHg(unit = "mmHg") "Diagnostic pressure in mmHg";
  Real flow_L_per_min(unit = "l/min") "Diagnostic volumetric flow in L/min";
  Modelica.SIunits.AmountOfSubstance solute;
  Types.Time normalizedTime;
  Types.Volume evolution;
protected
  Types.Volume zpv;
  Types.Compliance c;
  Types.Pressure ep;
  parameter Types.Pressure a = MinimalCollapsingPressure/log(Modelica.Constants.eps);
equation
  if not useV0Input then
    zpv = ZeroPressureVolume;
  end if;
  if not useComplianceInput then
    c = Compliance;
  end if;
  if not useExternalPressureInput then
    ep = ExternalPressure;
  end if;

  evolution = if volume_start - volume < 0 then 0 else volume_start - volume;
  excessVolume = max(0, volume - zpv);
  q_in.pressure = smooth(0, if noEvent(volume > CollapsingPressureVolume) then excessVolume/c + ep else a*log(max(Modelica.Constants.eps, volume/CollapsingPressureVolume)) + ep);
  state = volume;
  change = q_in.q;
  pressure_mmHg = q_in.pressure*0.0075;
  flow_L_per_min = q_in.q*6e4;
  normalizedTime = time/600;
  metabolicConsumptionRate = ((metabolicConsumption)/(86400));
  O2_Hb_max = (Conc_Hb*1340)*((1)/(1000*22.4));
  oxygenSaturation = (q_in.conc/O2_Hb_max)*100;
  solute = q_in.conc*volume;
  O2_current = q_in.conc;
  der(volume*q_in.conc) = actualStream(q_in.conc)*q_in.q - metabolicConsumptionRate;

  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-318, -140}, {160, -100}}, textString = "%name", lineColor = {0, 0, 255})}),
    Documentation(info = "<html>
<p>
This component represents cavities or compartments that accumulate blood and whose elastance allows the structure to recover its initial shape once the stress deformation has been suppressed.
</p>
</html>", revisions = "<html>
<table>
<tr>
<td>Authors:</td>
<td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
<td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
<td> Leonardo Bermeo Clavijo (2)</td>
</tr>
<tr>
<td>Copyright:</td>
<td>In public domains</td>
</tr>
<tr>
<td>By:</td>
<td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
<td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
</tr>
<tr>
<td>Last revision:</td>
<td>October 2023</td>
</tr>
</table>
</html>"));
end Constant_Elastance;

    model Time_Variant_Elastance
      extends Icons.Time_Variant_Elastance;
      extends Physiolibrary.SteadyStates.Interfaces.SteadyState(state_start = volume_start, storeUnit = "ml");
      Connectors.Input_Connector q_in(conc(start = (((SO2/100))*((Conc_Hb*1340)*((1)/(1000*22.4)))))) annotation(
        Placement(transformation(extent = {{-14, -14}, {14, 14}})));
      constant Types.Volume NormalVolume = 0.001 annotation(
        Evaluate = true,
        HideResult = true);
      parameter Types.Volume volume_start = 1e-11 annotation(
        Dialog(group = "Initialization"));
      Types.Volume excessVolume ;
      parameter Boolean useV0Input = false annotation(
        Evaluate = true,
        HideResult = true,
        choices(checkBox = true),
        Dialog(group = "External inputs/outputs"));
      parameter Types.Volume ZeroPressureVolume = 1e-11 annotation(
        Dialog(enable = not useV0Input));
      parameter Types.Volume CollapsingPressureVolume = 1e-12;
      //------------------------------------
      //------------------------------------
      //---------Metabolic Rate-------------
      //------------------------------------
      //------------------------------------
      parameter Types.MolarFlow metabolicConsumption = 0;
      Types.MolarFlow metabolicConsumptionRate;
      parameter Real SO2 = 40 "Initial oxygen saturation [%]";
      Real oxygenSaturation(start = SO2) "Oxygen saturation [%]";
      parameter Modelica.SIunits.MassConcentration Conc_Hb = 175 "Hemoglobin mass concentration (SI kg/m3; numerically equal to g/L)";
      Modelica.SIunits.Concentration O2_Hb_max "Concentration carried by hemoglobin";
      Real k1 = 1.62, k2 = 0.22;
      Connectors.OxygenFlowOutput O2_current annotation(
        Placement(transformation(origin = {91, -104}, extent = {{-20, -20}, {20, 20}}, rotation = 270), iconTransformation(origin = {86, -80}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      parameter Boolean useOxygenInput = false annotation(
        Evaluate = true,
        HideResult = true,
        choices(checkBox = true),
        Dialog(group = "External inputs/outputs"));
      parameter Types.MolarFlow Oxygen = 1e-5 annotation(
        Dialog(enable = not useOxygenInput));
      //------------------------------------
      //------------------------------------
      //------------------------------------
      //------------------------------------
      Connectors.VolumeInput zeroPressureVolume(start = ZeroPressureVolume) = zpv if useV0Input annotation(
        Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {-80, 80})));
      parameter Boolean useComplianceInput = false annotation(
        Evaluate = true,
        HideResult = true,
        choices(checkBox = true),
        Dialog(group = "External inputs/outputs"));
      parameter Types.Compliance Compliance = 1 annotation(
        Dialog(enable = not useComplianceInput));
      Connectors.ComplianceInput compliance(start = Compliance) = c if useComplianceInput annotation(
        Placement(visible = true, transformation(origin = {0, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 270), iconTransformation(origin = {0, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 270)));
      parameter Boolean useExternalPressureInput = false annotation(
        Evaluate = true,
        HideResult = true,
        choices(checkBox = true),
        Dialog(group = "External inputs/outputs"));
      parameter Types.Pressure ExternalPressure = 0 annotation(
        Dialog(enable = not useExternalPressureInput));
      parameter Types.Pressure MinimalCollapsingPressure = -101325;
      Connectors.PressureInput externalPressure(start = ExternalPressure) = ep if useExternalPressureInput annotation(
        Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {80, 80})));
      Connectors.VolumeOutput volume annotation(
        Placement(transformation(origin = {1, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 270), iconTransformation(origin = {-80, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 270)));
      Real pressure_mmHg(unit = "mmHg") "Diagnostic pressure in mmHg";
      Real flow_L_per_min(unit = "l/min") "Diagnostic volumetric flow in L/min";
      Modelica.SIunits.AmountOfSubstance solute;
      Types.Time normalizedTime;
    protected
      Types.Volume zpv;
      Types.Compliance c;
      Types.Pressure ep;
      parameter Types.Pressure a = MinimalCollapsingPressure/log(Modelica.Constants.eps);
    equation
      if not useV0Input then
        zpv = ZeroPressureVolume;
      end if;
      if not useComplianceInput then
        c = Compliance;
      end if;
      if not useExternalPressureInput then
        ep = ExternalPressure;
      end if;
      excessVolume = max(0, volume - zpv);
      q_in.pressure = smooth(0, if noEvent(volume > CollapsingPressureVolume) then excessVolume/c + ep else a*log(max(Modelica.Constants.eps, volume/CollapsingPressureVolume)) + ep);
      state = volume;
      change = q_in.q;
      pressure_mmHg = q_in.pressure*0.0075;
      flow_L_per_min = q_in.q*6e4;
      normalizedTime = time/600;
      metabolicConsumptionRate = ((metabolicConsumption)/(86400));
      O2_Hb_max = (Conc_Hb*1340)*((1)/(1000*22.4));
      oxygenSaturation = (q_in.conc/O2_Hb_max)*100;
      solute = q_in.conc*volume;
      O2_current = q_in.conc;
      der(volume*q_in.conc) = actualStream(q_in.conc)*q_in.q - metabolicConsumptionRate;
      annotation(
        Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{-318, -140}, {160, -100}}, textString = "%name", lineColor = {0, 0, 255})}),
        Documentation(info = "<html>
  <p>
  This component represents the elastic compartments with pulsatile flow and an elastance variant in time. These elements reflect the diastole and systole of the atria and ventricles, emulating the cardiac behavior of muscular distension and contraction. Variable elastances in time inherit the hemodynamic and respiratory behavior of elastances constant over time.
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
    end Time_Variant_Elastance;
    annotation(
      Icon(graphics = {Rectangle(lineColor = {255, 190, 111}, fillColor = {248, 248, 248}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, -100}, {100, 100}}, radius = 25), Bitmap(origin = {-1, 14}, extent = {{-83, 78}, {83, -78}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/package_components.svg")}),
      Documentation(info = "<html>
<p>
This package contains all the components for the construction of multiple physiological models.
</p>
</html>", revisions = "<html>
  <table>
  <tr>
  <td>Authors:</td>
  <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
  <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
  <td> Leonardo Bermeo Clavijo (2)</td>
  </tr>
  <tr>
  <td>Copyright:</td>
  <td>In public domains</td>
  </tr>
  <tr>
  <td>By:</td>
  <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
  <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
  </tr>
  <tr>
  <td>Last revision:</td>
  <td>October 2023</td>
  </tr>
  </table>
  </html>"));
  end Components;

  package Types
    type Pressure = Modelica.SIunits.Pressure(displayUnit = "mmHg", nominal = 133.322387415);
    type VolumeFlowRate = Modelica.SIunits.VolumeFlowRate(displayUnit = "ml/min", nominal = (1e-6)/60);
    type Inertance = Real(final quantity = "Inertance", final unit = "Pa.s2/m3", displayUnit = "mmHg.min2/ml", nominal = ((133.322387415)*(60^2)/(1e-6))) annotation(
      Documentation(info = "<html><head></head><body>Inertance refers to the tendency of blood to resist changing its speed or flow. It is like the resistance of a moving object to stopping or changing its speed. In the cardiovascular system, it is related to the inertia of blood as it moves through blood vessels.</body></html>"));
    type Conductance = Real(final quantity = "Conductance", final unit = "m3/(Pa.s)", displayUnit = "ml/(mmHg.min)", nominal = (1e-6)/((133.322387415)*60), min = 0) annotation(
      Documentation(info = "<html><head></head><body>Conductance is the ease with which blood flow can pass through a vessel or artery. The higher the conductance, the easier the blood flow. It is related to the width of blood vessels and their ability to accommodate blood flow.</body></html>"));
    type Time = Modelica.SIunits.Time(displayUnit = "min", nominal = 60);
    type Volume = Modelica.SIunits.Volume(displayUnit = "ml", nominal = 1e-6, min = 0);
    type MolarFlow = Modelica.SIunits.MolarFlowRate(displayUnit = "mmol/min") annotation(
      Documentation(info = "<html><head></head><body>SI molar flow rate used for oxygen mass-balance equations. The legacy numerical scaling of metabolic-consumption parameters is preserved in the component equations.</body></html>"));
    type Compliance = Real(final quantity = "Compliance", final unit = "m3/Pa", displayUnit = "ml/mmHg", nominal = (1e-6)/(133.322387415)) annotation(
      Documentation(info = "<html><head></head><body>Compliance is the ability of blood vessels and arteries to expand and contract in response to blood pressure. The greater the compliance, the easier it is for the vessels to expand to accommodate blood flow.</body></html>"));
    type Resistance = Real(final quantity = "Resistance", final unit = "Pa.s/m3", displayUnit = "mmHg.min/ml", nominal = (1e+6)*(133.322387415)*60, min = 0) annotation(
      Documentation(info = "<html><head></head><body>Resistance is the opposition to the flow of blood in the blood vessels. The greater the resistance, the more difficult it is for blood to flow through the vessels. It is similar to electrical resistance in a circuit, but in this case, it is applied to blood circulation.</body></html>"));
    type Elastance = Real(final quantity = "Elastance", final unit = "Pa/m3", displayUnit = "mmHg/ml", nominal = (133.322387415)/(1e-6)) annotation(
      Documentation(info = "<html><head></head><body>Elastance refers to the ability of a blood vessel or cardiovascular structure to recover its original shape after being stretched or contracted. The higher the elastance, the stiffer the structure, and the less it expands with blood pressure.</body></html>"));
    type Frequency = Modelica.SIunits.Frequency(displayUnit = "1/min");
    type Height = Modelica.SIunits.Height(displayUnit = "cm", nominal = 1e-2);
    type Temperature = Modelica.SIunits.Temperature(displayUnit = "degC", nominal = 1, min = 0);
    type Mass = Modelica.SIunits.Mass(displayUnit = "g", nominal = 1e-3, min = 0);
    type Concentration = Modelica.SIunits.Concentration(displayUnit = "mmol/l", min = 0);
    annotation(
      Icon(graphics = {Rectangle(lineColor = {38, 156, 38}, fillColor = {248, 248, 248}, fillPattern = FillPattern.Sphere, extent = {{-100, -100}, {100, 100}}, radius = 25), Text(origin = {-19, 3}, extent = {{-101, 81}, {101, -81}}, textString = "T", textStyle = {TextStyle.Bold, TextStyle.Italic})}),
      Documentation(info = "<html>
  <p>
  This package contains all the data types used in the components of the physiological models.
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
  end Types;

  package Scenarios
    package Adult
      model Healthy
        extends Icons.Cardiovascular_System;
        Components.Vascular_Resistance pulmonaryVenousResistance(Conductance(displayUnit = "m3/(Pa.s)") = 2.5e-06, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {112, 198}, extent = {{15, -15}, {-15, 15}}, rotation = 180)));
        Components.Vascular_Resistance pulmonaryPeripheralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 6.82e-08, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {0, 228}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Time_Variant_Elastance leftAtrium(Compliance(displayUnit = "ml/mmHg"), ExternalPressure = -533.3333333, ZeroPressureVolume = 3e-05, useComplianceInput = true, useExternalPressureInput = false, volume_start(displayUnit = "ml") = 9.31e-05) annotation(
          Placement(visible = true, transformation(origin = {159, 165}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Heart_Valve mitralValve(_Gon(displayUnit = "l/(mmHg.min)") = 2.5e-06, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {189, 123}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Time_Variant_Elastance leftVentricle(ExternalPressure = -533.3333333, ZeroPressureVolume = 6e-05, useComplianceInput = true, useExternalPressureInput = false, volume_start = 0.00014) annotation(
          Placement(visible = true, transformation(origin = {223, 39}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Vascular_Resistance mitralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 2.5e-06, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {213, 81}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Heart_Valve aorticValve(_Gon(displayUnit = "l/(mmHg.min)") = 9.375e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {225, -33}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Constant_Elastance intrathoracicArteries(Compliance(displayUnit = "ml/mmHg") = 5.24e-09, ExternalPressure = -533.3333333, ZeroPressureVolume = 0.00014, volume_start = 0.0002) annotation(
          Placement(visible = true, transformation(origin = {187, -139}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance aorticResistance(Conductance(displayUnit = "m3/(Pa.s)") = 9.38e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {209, -97}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Constant_Elastance arteries(Compliance(displayUnit = "ml/mmHg") = 1.35e-08, ZeroPressureVolume = 0.00037, volume_start = 0.000522) annotation(
          Placement(visible = true, transformation(origin = {65, -221}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance systemicPeripheralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 7.50e-09, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {1, -235}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Heart_Valve tricuspidValve(_Gon(displayUnit = "l/(mmHg.min)") = 2.5e-06, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {-217, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Time_Variant_Elastance rightVentricle(ExternalPressure = -533.3333333, ZeroPressureVolume = 4e-05, useComplianceInput = true, useExternalPressureInput = false, volume_start = 0.000131) annotation(
          Placement(visible = true, transformation(origin = {-203, 103}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Vascular_Resistance tricuspidResistance(Conductance(displayUnit = "m3/(Pa.s)") = 2.5e-06, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {-219, 49}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Heart_Valve pulmonaryValve(_Gon(displayUnit = "l/(mmHg.min)") = 9.375e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {-171, 151}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Constant_Elastance pulmonaryArteries(Compliance(displayUnit = "m3/Pa") = 3.22e-08, ExternalPressure = -533.3333333, ZeroPressureVolume = 5e-05, volume_start = 0.000104) annotation(
          Placement(visible = true, transformation(origin = {-71, 217}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Constant_Elastance pulmonaryVeins(Compliance(displayUnit = "ml/mmHg") = 1.65e-07, ExternalPressure = -533.3333333, ZeroPressureVolume = 0.00035, volume_start = 0.000514) annotation(
          Placement(visible = true, transformation(origin = {66, 216}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Constant_Elastance veins(Compliance(displayUnit = "ml/mmHg") = 4.44e-07, ZeroPressureVolume = 0.001, volume_start(displayUnit = "ml") = 0.00153) annotation(
          Placement(visible = true, transformation(origin = {-69, -223}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Physiolibrary.Types.Constants.FrequencyConst heartRate(k(displayUnit = "1/min") = 1.2) annotation(
          Placement(visible = true, transformation(origin = {3.4638, -0.6059}, extent = {{-20.5362, -21.6059}, {20.5362, 21.6059}}, rotation = 0)));
        Components.Vascular_Resistance pulmonaryArterialResistance(Conductance(displayUnit = "m3/(Pa.s)") = 2.5e-06) annotation(
          Placement(visible = true, transformation(origin = {-124, 190}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Vascular_Resistance systemicArterialResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.25e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {111, -207}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Vascular_Resistance extrathoracicVenousResistance(Conductance(displayUnit = "m3/(Pa.s)") = 8.33e-08) annotation(
          Placement(visible = true, transformation(origin = {-123, -199}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Constant_Elastance intrathoracicVeins(Compliance(displayUnit = "ml/mmHg") = 4.12e-07, ExternalPressure = -533.3333333, ZeroPressureVolume = 0.00119, volume_start(displayUnit = "ml") = 0.001475) annotation(
          Placement(visible = true, transformation(origin = {-163, -165}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance rightAtrialInletResistance(Conductance(displayUnit = "m3/(Pa.s)") = 2.5e-06) annotation(
          Placement(visible = true, transformation(origin = {-195, -117}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Time_Variant_Elastance rightAtrium(Compliance(displayUnit = "ml/mmHg"), ExternalPressure = -533.3333333, ZeroPressureVolume = 3e-05, useComplianceInput = true, useExternalPressureInput = false, volume_start(displayUnit = "ml") = 0.000135) annotation(
          Placement(visible = true, transformation(origin = {-217, -65}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Signals.Ventricular_Elastances.Ventricular_signal_3 rightVentricularElastanceSignal(EMAX = 6.53e07, EMIN = 7.60e06) annotation(
          Placement(visible = true, transformation(origin = {-166, 104}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Signals.Ventricular_Elastances.Ventricular_signal_3 leftVentricularElastanceSignal(EMAX = 5.33e08, EMIN = 1.2e07) annotation(
          Placement(visible = true, transformation(origin = {192, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Signals.Atrial_Elastances.Atrial_signal_3 rightAtrialElastanceSignal(EMAX = 2e07, EMIN = 6.67e06) annotation(
          Placement(visible = true, transformation(origin = {-185, -64}, extent = {{-10, -11}, {10, 11}}, rotation = -90)));
        Signals.Atrial_Elastances.Atrial_signal_3 leftAtrialElastanceSignal(EMAX = 3.73e07, EMIN = 1.6e07) annotation(
          Placement(visible = true, transformation(origin = {128, 164}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Components.Blood_Inertia pulmonaryArterialInertia(I = 9.3e04, volumeFlow_start = 2.16667e-05) annotation(
          Placement(visible = true, transformation(origin = {152, -180}, extent = {{15, -15}, {-15, 15}}, rotation = 0)));
      equation
        connect(systemicArterialResistance.q_out, arteries.q_in) annotation(
          Line(points = {{96, -209}, {82.5, -209}, {82.5, -221}, {65, -221}}));
        connect(systemicPeripheralResistance.q_in, arteries.q_in) annotation(
          Line(points = {{16, -235}, {51, -235}, {51, -223}, {65, -223}}));
        connect(veins.q_in, extrathoracicVenousResistance.q_in) annotation(
          Line(points = {{-68, -222}, {-110, -222}, {-110, -198}, {-108, -198}}));
        connect(systemicPeripheralResistance.q_out, veins.q_in) annotation(
          Line(points = {{-14, -234}, {-70, -234}, {-70, -222}, {-68, -222}}));
        connect(leftAtrialElastanceSignal.C, leftAtrium.compliance) annotation(
          Line(points = {{139, 164}, {142, 164}, {142, 165}, {147, 165}}, color = {0, 0, 127}));
        connect(leftAtrium.q_in, mitralValve.q_in) annotation(
          Line(points = {{159, 165}, {190, 165}, {190, 138}}));
        connect(pulmonaryVenousResistance.q_out, leftAtrium.q_in) annotation(
          Line(points = {{128, 198}, {156, 198}, {156, 165}, {159, 165}}));
        connect(mitralValve.q_out, mitralResistance.q_in) annotation(
          Line(points = {{190, 108}, {214, 108}, {214, 96}, {214, 96}}));
        connect(mitralResistance.q_out, leftVentricle.q_in) annotation(
          Line(points = {{214, 66}, {224, 66}, {224, 40}, {224, 40}}));
        connect(aorticValve.q_in, leftVentricle.q_in) annotation(
          Line(points = {{226, -18}, {222, -18}, {222, 40}, {224, 40}}));
        connect(aorticResistance.q_in, aorticValve.q_out) annotation(
          Line(points = {{210, -82}, {226, -82}, {226, -48}, {226, -48}}));
        connect(intrathoracicArteries.q_in, aorticResistance.q_out) annotation(
          Line(points = {{188, -138}, {208, -138}, {208, -112}, {210, -112}}));
        connect(tricuspidValve.q_out, tricuspidResistance.q_in) annotation(
          Line(points = {{-216, 14}, {-218, 14}, {-218, 34}, {-218, 34}}));
        connect(tricuspidValve.q_in, rightAtrium.q_in) annotation(
          Line(points = {{-219, -16}, {-216, -16}, {-216, -65}, {-217, -65}}));
        connect(rightAtrialInletResistance.q_out, rightAtrium.q_in) annotation(
          Line(points = {{-194, -102}, {-214, -102}, {-214, -64}, {-214, -64}}));
        connect(rightAtrium.compliance, rightAtrialElastanceSignal.C) annotation(
          Line(points = {{-201, -65}, {-194, -65}}, color = {0, 0, 127}));
        connect(intrathoracicVeins.q_in, rightAtrialInletResistance.q_in) annotation(
          Line(points = {{-162, -164}, {-196, -164}, {-196, -132}, {-194, -132}}));
        connect(extrathoracicVenousResistance.q_out, intrathoracicVeins.q_in) annotation(
          Line(points = {{-138, -198}, {-164, -198}, {-164, -164}, {-162, -164}}));
        connect(pulmonaryVeins.q_in, pulmonaryVenousResistance.q_in) annotation(
          Line(points = {{66, 216}, {97.5, 216}, {97.5, 198}, {95, 198}}));
        connect(pulmonaryPeripheralResistance.q_out, pulmonaryVeins.q_in) annotation(
          Line(points = {{17.5, 228}, {48.75, 228}, {48.75, 218}, {66, 218}}));
        connect(heartRate.y, rightAtrialElastanceSignal.HR) annotation(
          Line(points = {{29, -1}, {-175, -1}, {-175, -55}}, color = {0, 0, 127}));
        connect(heartRate.y, leftVentricularElastanceSignal.HR) annotation(
          Line(points = {{30, 0}, {186, 0}, {186, 29}}, color = {0, 0, 127}));
        connect(leftVentricularElastanceSignal.C, leftVentricle.compliance) annotation(
          Line(points = {{203, 38}, {211.5, 38}, {211.5, 39}, {211, 39}}, color = {0, 0, 127}));
        connect(heartRate.y, leftAtrialElastanceSignal.HR) annotation(
          Line(points = {{29, -1}, {122, -1}, {122, 155}}, color = {0, 0, 127}));
        connect(intrathoracicArteries.q_in, pulmonaryArterialInertia.q_in) annotation(
          Line(points = {{189, -139}, {189, -176.5}, {167, -176.5}, {167, -180}}));
        connect(pulmonaryArterialInertia.q_out, systemicArterialResistance.q_in) annotation(
          Line(points = {{139, -180}, {121, -180}, {121, -207}, {126, -207}}));
        connect(pulmonaryArteries.q_in, pulmonaryPeripheralResistance.q_in) annotation(
          Line(points = {{-71, 217}, {-17.5, 217}, {-17.5, 230}}));
        connect(pulmonaryArterialResistance.q_out, pulmonaryArteries.q_in) annotation(
          Line(points = {{-106.5, 190}, {-72, 190}, {-72, 219}, {-71, 219}}));
        connect(pulmonaryValve.q_out, pulmonaryArterialResistance.q_in) annotation(
          Line(points = {{-171, 166}, {-143.5, 166}, {-143.5, 190}}));
        connect(rightVentricle.q_in, pulmonaryValve.q_in) annotation(
          Line(points = {{-203, 103}, {-173, 103}, {-173, 136}}));
        connect(rightVentricle.compliance, rightVentricularElastanceSignal.C) annotation(
          Line(points = {{-190, 104}, {-176, 104}, {-176, 102}, {-174, 102}}, color = {0, 0, 127}));
        connect(heartRate.y, rightVentricularElastanceSignal.HR) annotation(
          Line(points = {{29, -1}, {-158, -1}, {-158, 111}}, color = {0, 0, 127}));
        connect(rightVentricle.q_in, tricuspidResistance.q_out) annotation(
          Line(points = {{-203, 103}, {-203, 84.5}, {-219, 84.5}, {-219, 64}}));
        annotation(
          Diagram(coordinateSystem(extent = {{-250, -250}, {250, 250}}, preserveAspectRatio = false)),
          Icon(coordinateSystem(extent = {{-250, -250}, {250, 250}}, preserveAspectRatio = false)),
          Documentation(info = "<html><head></head><body><p>
      Contains a cardiovascular model of a healthy adult.
      </p>
      </body></html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
      end Healthy;
      annotation(
        Icon(graphics = {Rectangle(lineColor = {170, 255, 255}, fillColor = {248, 248, 248}, fillPattern = FillPattern.VerticalCylinder, extent = {{-100, -100}, {100, 100}}, radius = 25), Bitmap(origin = {-1, 4}, extent = {{-105, 94}, {105, -94}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/scenario_adult.svg")}),
        Documentation(info = "<html>
    <p>
    Physiological models of the adult
    </p>
    </html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
    end Adult;

    package Child
      model Stenosis
        extends Icons.Cardiovascular_System;
        Components.Vascular_Resistance pulmonaryVenousResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.25013e-06, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {112, 198}, extent = {{15, -15}, {-15, 15}}, rotation = 180)));
        Components.Vascular_Resistance pulmonaryPeripheralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 3.40943e-08, useConductanceInput = false, useOxygenInput = true) annotation(
          Placement(visible = true, transformation(origin = {0, 228}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Time_Variant_Elastance leftAtrium(Compliance(displayUnit = "ml/mmHg"), ExternalPressure = -433.298, ZeroPressureVolume = 1e-06, useComplianceInput = true, useExternalPressureInput = false, volume_start(displayUnit = "ml") = 2.03434e-05) annotation(
          Placement(visible = true, transformation(origin = {159, 165}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Heart_Valve mitralValve(_Gon(displayUnit = "m3/(Pa.s)") = 1.25013e-06, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {189, 123}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Time_Variant_Elastance leftVentricle(ExternalPressure = -433.298, ZeroPressureVolume = 0, useComplianceInput = true, useExternalPressureInput = false, volume_start = 6.84566e-06) annotation(
          Placement(visible = true, transformation(origin = {223, 37}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Vascular_Resistance mitralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.25013e-06, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {213, 81}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Heart_Valve aorticValve(_Gon(displayUnit = "m3/(Pa.s)") = 9.37593e-09, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {225, -33}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Constant_Elastance intrathoracicArteries(Compliance(displayUnit = "m3/Pa") = 9.67002e-10, ExternalPressure = -433.298, ZeroPressureVolume = 1.82e-05, volume_start = 2.25483e-05) annotation(
          Placement(visible = true, transformation(origin = {187, -139}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance aorticResistance(Conductance(displayUnit = "m3/(Pa.s)") = 9.37593e-09, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {209, -97}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Constant_Elastance extrathoracicArteries(Compliance(displayUnit = "m3/Pa") = 2.48e-09, ZeroPressureVolume = 4.81e-05, volume_start = 5.78612e-05) annotation(
          Placement(visible = true, transformation(origin = {65, -221}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance systemicPeripheralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 3.75038e-09, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {1, -235}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Heart_Valve tricuspidValve(_Gon(displayUnit = "m3/(Pa.s)") = 1.25013e-06, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {-217, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Time_Variant_Elastance rightVentricle(ExternalPressure = -433.298, ZeroPressureVolume = 3e-06, useComplianceInput = true, useExternalPressureInput = false, volume_start = 1.29705e-05) annotation(
          Placement(visible = true, transformation(origin = {-203, 103}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Vascular_Resistance tricuspidResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.25013e-06, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {-219, 49}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Heart_Valve pulmonaryValve(_Gon(displayUnit = "m3/(Pa.s)") = 1.25013e-06, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {-171, 151}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Constant_Elastance pulmonaryArteries(Compliance(displayUnit = "m3/Pa") = 5.91e-09, ExternalPressure = -433.298, ZeroPressureVolume = 6.5e-06, volume_start = 1.80798e-05) annotation(
          Placement(visible = true, transformation(origin = {-71, 215}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Constant_Elastance pulmonaryVeins(Compliance(displayUnit = "m3/Pa") = 3.04e-08, ExternalPressure = -433.298, ZeroPressureVolume = 4.55e-05, volume_start = 9.94574e-05) annotation(
          Placement(visible = true, transformation(origin = {54, 218}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Constant_Elastance extrathoracicVeins(Compliance(displayUnit = "m3/Pa") = 8.16997e-08, ZeroPressureVolume = 0.00013, volume_start(displayUnit = "ml") = 0.00018762) annotation(
          Placement(visible = true, transformation(origin = {-69, -223}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance pulmonaryArterialResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.25013e-06) annotation(
          Placement(visible = true, transformation(origin = {-124, 190}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Vascular_Resistance systemicArterialResistance(Conductance(displayUnit = "m3/(Pa.s)") = 6.25063e-08, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {111, -207}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Vascular_Resistance extrathoracicVenousResistance(Conductance(displayUnit = "m3/(Pa.s)") = 4.16708e-08) annotation(
          Placement(visible = true, transformation(origin = {-123, -199}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Constant_Elastance intrathoracicVeins(Compliance(displayUnit = "m3/Pa") = 7.57997e-08, ExternalPressure = -433.298, ZeroPressureVolume = 0.000155, volume_start(displayUnit = "ml") = 0.000212709) annotation(
          Placement(visible = true, transformation(origin = {-163, -165}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance rightAtrialInletResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.25013e-06) annotation(
          Placement(visible = true, transformation(origin = {-195, -117}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Time_Variant_Elastance rightAtrium(Compliance(displayUnit = "ml/mmHg"), ExternalPressure = -400, ZeroPressureVolume = 2.5e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start(displayUnit = "ml") = 3.03061e-06) annotation(
          Placement(visible = true, transformation(origin = {-217, -65}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Blood_Inertia systemicBloodInertia(I(displayUnit = "Pa.s2/m3") = 2.67e05, volumeFlow_start = 2.16667e-05) annotation(
          Placement(visible = true, transformation(origin = {152, -180}, extent = {{15, -15}, {-15, 15}}, rotation = 0)));
        Signals.Ventricular_Elastances.Ventricular_signal_2 rightVentricularElastanceSignal(ELVMAX = 2.78644e+08, ELVMIN = 4.63962e+07, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {-176, 102}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Signals.Ventricular_Elastances.Ventricular_signal_2 leftVentricularElastanceSignal(ELVMAX = 3.78636e+09, ELVMIN = 1.99984e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {196, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Signals.Atrial_Elastances.Atrial_signal_2 rightAtrialElastanceSignal(ELAMAX = 8.39931e+07, ELAMIN = 4.22632e+07, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {-188, -68}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Signals.Atrial_Elastances.Atrial_signal_2 leftAtrialElastanceSignal(ELAMAX = 2.65312e+08, ELAMIN = 9.77253e+07, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {132, 164}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Signals.Respirations.Pulmonary_Respiration pulmonaryRespiration(t0 = 0) annotation(
          Placement(visible = true, transformation(origin = {-56, 252}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(pulmonaryRespiration.O2_inPAB, pulmonaryPeripheralResistance.oxygen) annotation(
          Line(points = {{-46, 252}, {0, 252}, {0, 240}}, color = {0, 0, 127}));
        connect(pulmonaryArteries.O2_current, pulmonaryRespiration.O2_PA) annotation(
          Line(points = {{-84, 224}, {-84, 252}, {-66, 252}}, color = {0, 0, 127}));
        connect(pulmonaryArteries.q_in, pulmonaryPeripheralResistance.q_in) annotation(
          Line(points = {{-71, 215}, {-17.5, 215}, {-17.5, 230}}));
        connect(pulmonaryArterialResistance.q_out, pulmonaryArteries.q_in) annotation(
          Line(points = {{-106.5, 190}, {-72, 190}, {-72, 215}, {-71, 215}}));
        connect(rightVentricularElastanceSignal.C, rightVentricle.compliance) annotation(
          Line(points = {{-187, 102}, {-190, 102}, {-190, 104}}, color = {0, 0, 127}));
        connect(pulmonaryValve.q_in, rightVentricle.q_in) annotation(
          Line(points = {{-170, 136}, {-186, 136}, {-186, 124}, {-198, 124}, {-198, 104}, {-202, 104}}));
        connect(leftVentricularElastanceSignal.C, leftVentricle.compliance) annotation(
          Line(points = {{207, 36}, {208, 36}, {208, 37}, {211, 37}}, color = {0, 0, 127}));
        connect(leftAtrialElastanceSignal.C, leftAtrium.compliance) annotation(
          Line(points = {{139, 164}, {146, 164}, {146, 166}, {148, 166}}, color = {0, 0, 127}));
        connect(rightAtrialElastanceSignal.C, rightAtrium.compliance) annotation(
          Line(points = {{-195, -68}, {-204, -68}, {-204, -64}}, color = {0, 0, 127}));
        connect(aorticValve.q_in, leftVentricle.q_in) annotation(
          Line(points = {{226, -18}, {222, -18}, {222, 37}, {223, 37}}));
        connect(mitralResistance.q_out, leftVentricle.q_in) annotation(
          Line(points = {{214, 66}, {223, 66}, {223, 37}}));
        connect(pulmonaryPeripheralResistance.q_out, pulmonaryVeins.q_in) annotation(
          Line(points = {{17.5, 228}, {48.75, 228}, {48.75, 218}, {54, 218}}));
        connect(pulmonaryVeins.q_in, pulmonaryVenousResistance.q_in) annotation(
          Line(points = {{54, 218}, {97.5, 218}, {97.5, 198}, {95, 198}}));
        connect(leftAtrium.q_in, mitralValve.q_in) annotation(
          Line(points = {{159, 165}, {190, 165}, {190, 138}}));
        connect(pulmonaryVenousResistance.q_out, leftAtrium.q_in) annotation(
          Line(points = {{128, 198}, {156, 198}, {156, 165}, {159, 165}}));
        connect(mitralValve.q_out, mitralResistance.q_in) annotation(
          Line(points = {{190, 108}, {214, 108}, {214, 96}, {214, 96}}));
        connect(aorticResistance.q_in, aorticValve.q_out) annotation(
          Line(points = {{210, -82}, {226, -82}, {226, -48}, {226, -48}}));
        connect(intrathoracicArteries.q_in, aorticResistance.q_out) annotation(
          Line(points = {{188, -138}, {208, -138}, {208, -112}, {210, -112}}));
        connect(tricuspidValve.q_out, tricuspidResistance.q_in) annotation(
          Line(points = {{-216, 14}, {-218, 14}, {-218, 34}, {-218, 34}}));
        connect(tricuspidValve.q_in, rightAtrium.q_in) annotation(
          Line(points = {{-219, -16}, {-216, -16}, {-216, -65}, {-217, -65}}));
        connect(rightAtrialInletResistance.q_out, rightAtrium.q_in) annotation(
          Line(points = {{-194, -102}, {-214, -102}, {-214, -64}, {-214, -64}}));
        connect(intrathoracicVeins.q_in, rightAtrialInletResistance.q_in) annotation(
          Line(points = {{-162, -164}, {-196, -164}, {-196, -132}, {-194, -132}}));
        connect(extrathoracicVenousResistance.q_out, intrathoracicVeins.q_in) annotation(
          Line(points = {{-138, -198}, {-164, -198}, {-164, -164}, {-162, -164}}));
        connect(extrathoracicVeins.q_in, extrathoracicVenousResistance.q_in) annotation(
          Line(points = {{-68, -222}, {-110, -222}, {-110, -198}, {-108, -198}}));
        connect(systemicPeripheralResistance.q_out, extrathoracicVeins.q_in) annotation(
          Line(points = {{-14, -234}, {-70, -234}, {-70, -222}, {-68, -222}}));
        connect(intrathoracicArteries.q_in, systemicBloodInertia.q_in) annotation(
          Line(points = {{189, -139}, {189, -176.5}, {167, -176.5}, {167, -180}}));
        connect(systemicBloodInertia.q_out, systemicArterialResistance.q_in) annotation(
          Line(points = {{139, -180}, {121, -180}, {121, -207}, {126, -207}}));
        connect(systemicArterialResistance.q_out, extrathoracicArteries.q_in) annotation(
          Line(points = {{96, -209}, {82.5, -209}, {82.5, -221}, {65, -221}}));
        connect(systemicPeripheralResistance.q_in, extrathoracicArteries.q_in) annotation(
          Line(points = {{16, -235}, {51, -235}, {51, -223}, {65, -223}}));
        connect(pulmonaryValve.q_out, pulmonaryArterialResistance.q_in) annotation(
          Line(points = {{-171, 166}, {-143.5, 166}, {-143.5, 190}}));
        connect(rightVentricle.q_in, tricuspidResistance.q_out) annotation(
          Line(points = {{-203, 103}, {-203, 84.5}, {-219, 84.5}, {-219, 64}}));
        annotation(
          Diagram(coordinateSystem(extent = {{-250, -250}, {250, 250}}, preserveAspectRatio = false)),
          Icon(coordinateSystem(extent = {{-250, -250}, {250, 250}}, preserveAspectRatio = false)),
          Documentation(info = "<html><head></head><body><p>
    Model of a child of six months of extrauterine life and weighing 8 kilograms with non-congenital aortic stenosis.</p>
    </body></html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
      end Stenosis;

      model Healthy
        extends Icons.Cardiovascular_System;
        Components.Vascular_Resistance pulmonaryVenousResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.25013e-06, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {112, 198}, extent = {{15, -15}, {-15, 15}}, rotation = 180)));
        Components.Vascular_Resistance pulmonaryPeripheralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 3.40943e-08, useConductanceInput = false, useOxygenInput = true) annotation(
          Placement(visible = true, transformation(origin = {0, 228}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Time_Variant_Elastance leftAtrium(Compliance(displayUnit = "ml/mmHg"), ExternalPressure = -433.298, ZeroPressureVolume = 1e-06, useComplianceInput = true, useExternalPressureInput = false, volume_start(displayUnit = "ml") = 1.2719e-05) annotation(
          Placement(visible = true, transformation(origin = {159, 165}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Heart_Valve mitralValve(_Gon(displayUnit = "m3/(Pa.s)") = 1.25013e-06, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {189, 123}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Time_Variant_Elastance leftVentricle(ExternalPressure = -433.298, ZeroPressureVolume = 2e-06, useComplianceInput = true, useExternalPressureInput = false, volume_start = 1.28583e-05) annotation(
          Placement(visible = true, transformation(origin = {223, 37}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Vascular_Resistance mitralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.25013e-06, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {213, 81}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Heart_Valve aorticValve(_Gon(displayUnit = "m3/(Pa.s)") = 4.68797e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {225, -33}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Constant_Elastance intrathoracicArteries(Compliance(displayUnit = "m3/Pa") = 9.67002e-10, ExternalPressure = -433.298, ZeroPressureVolume = 1.82e-05, volume_start = 2.46108e-05) annotation(
          Placement(visible = true, transformation(origin = {187, -139}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance aorticResistance(Conductance(displayUnit = "m3/(Pa.s)") = 4.68797e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {209, -97}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Constant_Elastance extrathoracicArteries(Compliance(displayUnit = "m3/Pa") = 2.48e-09, ZeroPressureVolume = 4.81e-05, volume_start = 6.32569e-05) annotation(
          Placement(visible = true, transformation(origin = {65, -221}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance systemicPeripheralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 3.75038e-09, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {1, -235}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Heart_Valve tricuspidValve(_Gon(displayUnit = "m3/(Pa.s)") = 1.25013e-06, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {-217, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Time_Variant_Elastance rightVentricle(ExternalPressure = -433.298, ZeroPressureVolume = 3e-06, useComplianceInput = true, useExternalPressureInput = false, volume_start = 1.15529e-05) annotation(
          Placement(visible = true, transformation(origin = {-203, 103}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Vascular_Resistance tricuspidResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.25013e-06, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {-219, 49}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Heart_Valve pulmonaryValve(_Gon(displayUnit = "m3/(Pa.s)") = 1.25013e-06, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {-171, 151}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Constant_Elastance pulmonaryArteries(Compliance(displayUnit = "m3/Pa") = 5.91e-09, ExternalPressure = -433.298, ZeroPressureVolume = 6.5e-06, volume_start = 1.36165e-05) annotation(
          Placement(visible = true, transformation(origin = {-71, 215}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Constant_Elastance pulmonaryVeins(Compliance(displayUnit = "m3/Pa") = 3.04e-08, ExternalPressure = -433.298, ZeroPressureVolume = 4.55e-05, volume_start = 7.44345e-05) annotation(
          Placement(visible = true, transformation(origin = {54, 218}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Constant_Elastance extrathoracicVeins(Compliance(displayUnit = "m3/Pa") = 8.16997e-08, ZeroPressureVolume = 0.00013, volume_start(displayUnit = "ml") = 0.000215656) annotation(
          Placement(visible = true, transformation(origin = {-69, -223}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance pulmonaryArterialResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.25013e-06) annotation(
          Placement(visible = true, transformation(origin = {-124, 190}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Vascular_Resistance systemicArterialResistance(Conductance(displayUnit = "m3/(Pa.s)") = 6.25063e-08, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {111, -207}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Vascular_Resistance extrathoracicVenousResistance(Conductance(displayUnit = "m3/(Pa.s)") = 4.16708e-08) annotation(
          Placement(visible = true, transformation(origin = {-123, -199}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Constant_Elastance intrathoracicVeins(Compliance(displayUnit = "m3/Pa") = 7.57997e-08, ExternalPressure = -433.298, ZeroPressureVolume = 0.000155, volume_start(displayUnit = "ml") = 0.000222152) annotation(
          Placement(visible = true, transformation(origin = {-163, -165}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance rightAtrialInletResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.25013e-06) annotation(
          Placement(visible = true, transformation(origin = {-195, -117}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Time_Variant_Elastance rightAtrium(Compliance(displayUnit = "ml/mmHg"), ExternalPressure = -400, ZeroPressureVolume = 2.5e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start(displayUnit = "ml") = 3.03061e-06) annotation(
          Placement(visible = true, transformation(origin = {-217, -65}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Blood_Inertia systemicBloodInertia(I(displayUnit = "Pa.s2/m3") = 2.67e05, volumeFlow_start = 2.16667e-05) annotation(
          Placement(visible = true, transformation(origin = {152, -180}, extent = {{15, -15}, {-15, 15}}, rotation = 0)));
        Signals.Ventricular_Elastances.Ventricular_signal_2 rightVentricularElastanceSignal(ELVMAX = 2.78644e+08, ELVMIN = 4.63962e+07, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {-176, 102}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Signals.Ventricular_Elastances.Ventricular_signal_2 leftVentricularElastanceSignal(ELVMAX = 3.78636e+09, ELVMIN = 7.33273e+07, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {196, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Signals.Atrial_Elastances.Atrial_signal_2 rightAtrialElastanceSignal(ELAMAX = 8.39931e+07, ELAMIN = 4.22632e+07, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {-188, -68}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Signals.Atrial_Elastances.Atrial_signal_2 leftAtrialElastanceSignal(ELAMAX = 2.65312e+08, ELAMIN = 9.77253e+07, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {132, 164}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Signals.Respirations.Pulmonary_Respiration pulmonaryRespiration(t0 = 0) annotation(
          Placement(visible = true, transformation(origin = {-56, 252}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(pulmonaryRespiration.O2_inPAB, pulmonaryPeripheralResistance.oxygen) annotation(
          Line(points = {{-46, 252}, {0, 252}, {0, 240}}, color = {0, 0, 127}));
        connect(pulmonaryArteries.O2_current, pulmonaryRespiration.O2_PA) annotation(
          Line(points = {{-84, 224}, {-84, 252}, {-66, 252}}, color = {0, 0, 127}));
        connect(pulmonaryArteries.q_in, pulmonaryPeripheralResistance.q_in) annotation(
          Line(points = {{-71, 215}, {-17.5, 215}, {-17.5, 230}}));
        connect(pulmonaryArterialResistance.q_out, pulmonaryArteries.q_in) annotation(
          Line(points = {{-106.5, 190}, {-72, 190}, {-72, 215}, {-71, 215}}));
        connect(rightVentricularElastanceSignal.C, rightVentricle.compliance) annotation(
          Line(points = {{-187, 102}, {-190, 102}, {-190, 104}}, color = {0, 0, 127}));
        connect(pulmonaryValve.q_in, rightVentricle.q_in) annotation(
          Line(points = {{-170, 136}, {-186, 136}, {-186, 124}, {-198, 124}, {-198, 104}, {-202, 104}}));
        connect(leftVentricularElastanceSignal.C, leftVentricle.compliance) annotation(
          Line(points = {{207, 36}, {208, 36}, {208, 37}, {211, 37}}, color = {0, 0, 127}));
        connect(leftAtrialElastanceSignal.C, leftAtrium.compliance) annotation(
          Line(points = {{139, 164}, {146, 164}, {146, 166}, {148, 166}}, color = {0, 0, 127}));
        connect(rightAtrialElastanceSignal.C, rightAtrium.compliance) annotation(
          Line(points = {{-195, -68}, {-204, -68}, {-204, -64}}, color = {0, 0, 127}));
        connect(aorticValve.q_in, leftVentricle.q_in) annotation(
          Line(points = {{226, -18}, {222, -18}, {222, 37}, {223, 37}}));
        connect(mitralResistance.q_out, leftVentricle.q_in) annotation(
          Line(points = {{214, 66}, {223, 66}, {223, 37}}));
        connect(pulmonaryPeripheralResistance.q_out, pulmonaryVeins.q_in) annotation(
          Line(points = {{17.5, 228}, {48.75, 228}, {48.75, 218}, {54, 218}}));
        connect(pulmonaryVeins.q_in, pulmonaryVenousResistance.q_in) annotation(
          Line(points = {{54, 218}, {97.5, 218}, {97.5, 198}, {95, 198}}));
        connect(leftAtrium.q_in, mitralValve.q_in) annotation(
          Line(points = {{159, 165}, {190, 165}, {190, 138}}));
        connect(pulmonaryVenousResistance.q_out, leftAtrium.q_in) annotation(
          Line(points = {{128, 198}, {156, 198}, {156, 165}, {159, 165}}));
        connect(mitralValve.q_out, mitralResistance.q_in) annotation(
          Line(points = {{190, 108}, {214, 108}, {214, 96}, {214, 96}}));
        connect(aorticResistance.q_in, aorticValve.q_out) annotation(
          Line(points = {{210, -82}, {226, -82}, {226, -48}, {226, -48}}));
        connect(intrathoracicArteries.q_in, aorticResistance.q_out) annotation(
          Line(points = {{188, -138}, {208, -138}, {208, -112}, {210, -112}}));
        connect(tricuspidValve.q_out, tricuspidResistance.q_in) annotation(
          Line(points = {{-216, 14}, {-218, 14}, {-218, 34}, {-218, 34}}));
        connect(tricuspidValve.q_in, rightAtrium.q_in) annotation(
          Line(points = {{-219, -16}, {-216, -16}, {-216, -65}, {-217, -65}}));
        connect(rightAtrialInletResistance.q_out, rightAtrium.q_in) annotation(
          Line(points = {{-194, -102}, {-214, -102}, {-214, -64}, {-214, -64}}));
        connect(intrathoracicVeins.q_in, rightAtrialInletResistance.q_in) annotation(
          Line(points = {{-162, -164}, {-196, -164}, {-196, -132}, {-194, -132}}));
        connect(extrathoracicVenousResistance.q_out, intrathoracicVeins.q_in) annotation(
          Line(points = {{-138, -198}, {-164, -198}, {-164, -164}, {-162, -164}}));
        connect(extrathoracicVeins.q_in, extrathoracicVenousResistance.q_in) annotation(
          Line(points = {{-68, -222}, {-110, -222}, {-110, -198}, {-108, -198}}));
        connect(systemicPeripheralResistance.q_out, extrathoracicVeins.q_in) annotation(
          Line(points = {{-14, -234}, {-70, -234}, {-70, -222}, {-68, -222}}));
        connect(intrathoracicArteries.q_in, systemicBloodInertia.q_in) annotation(
          Line(points = {{189, -139}, {189, -176.5}, {167, -176.5}, {167, -180}}));
        connect(systemicBloodInertia.q_out, systemicArterialResistance.q_in) annotation(
          Line(points = {{139, -180}, {121, -180}, {121, -207}, {126, -207}}));
        connect(systemicArterialResistance.q_out, extrathoracicArteries.q_in) annotation(
          Line(points = {{96, -209}, {82.5, -209}, {82.5, -221}, {65, -221}}));
        connect(systemicPeripheralResistance.q_in, extrathoracicArteries.q_in) annotation(
          Line(points = {{16, -235}, {51, -235}, {51, -223}, {65, -223}}));
        connect(pulmonaryValve.q_out, pulmonaryArterialResistance.q_in) annotation(
          Line(points = {{-171, 166}, {-143.5, 166}, {-143.5, 190}}));
        connect(rightVentricle.q_in, tricuspidResistance.q_out) annotation(
          Line(points = {{-203, 103}, {-203, 84.5}, {-219, 84.5}, {-219, 64}}));
        annotation(
          Diagram(coordinateSystem(extent = {{-250, -250}, {250, 250}}, preserveAspectRatio = false)),
          Icon(coordinateSystem(extent = {{-250, -250}, {250, 250}}, preserveAspectRatio = false)),
          Documentation(info = "<html><head></head><body><p>
    Model of a healthy child of six months of extrauterine life and weighing 8 kilograms.
    </p>
    </body></html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
      end Healthy;
      annotation(
        Icon(graphics = {Rectangle(lineColor = {170, 255, 255}, fillColor = {248, 248, 248}, fillPattern = FillPattern.VerticalCylinder, extent = {{-100, -100}, {100, 100}}, radius = 25), Bitmap(origin = {-1, 0}, extent = {{-115, 106}, {115, -106}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/scenario_child.svg")}),
        Documentation(info = "<html>
    <p>
    Physiological models of the child
    </p>
    </html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
    end Child;

    package Neonate
      model Healthy
        extends Icons.Cardiovascular_System;
        Components.Vascular_Resistance pulmonaryVenousResistance(Conductance(displayUnit = "m3/(Pa.s)") = 5e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {112, 198}, extent = {{15, -15}, {-15, 15}}, rotation = 180)));
        Components.Vascular_Resistance pulmonaryPeripheralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 8.82e-09, useConductanceInput = false, useOxygenInput = true) annotation(
          Placement(visible = true, transformation(origin = {0, 228}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Time_Variant_Elastance leftAtrium(Compliance(displayUnit = "ml/mmHg"), ExternalPressure = -400, ZeroPressureVolume = 2.5e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start(displayUnit = "ml") = 3.46601e-06) annotation(
          Placement(visible = true, transformation(origin = {159, 165}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Heart_Valve mitralValve(_Gon(displayUnit = "m3/(Pa.s)") = 1.25e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {189, 123}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Time_Variant_Elastance leftVentricle(ExternalPressure = -400, ZeroPressureVolume = 5e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start = 4.86548e-06) annotation(
          Placement(visible = true, transformation(origin = {223, 37}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Vascular_Resistance mitralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.25e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {213, 81}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Heart_Valve aorticValve(_Gon(displayUnit = "l/(mmHg.min)") = 4.16667e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {225, -33}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Constant_Elastance intrathoracicArteries(Compliance(displayUnit = "ml/mmHg") = 5.51516e-10, ExternalPressure = -400, ZeroPressureVolume = 9.16e-06, volume_start = 1.21673e-05) annotation(
          Placement(visible = true, transformation(origin = {187, -139}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance aorticResistance(Conductance(displayUnit = "m3/(Pa.s)") = 4.17e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {209, -97}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Constant_Elastance extrathoracicArteries(Compliance(displayUnit = "ml/mmHg") = 1.29321e-09, ZeroPressureVolume = 2.42e-05, volume_start = 3.06887e-05) annotation(
          Placement(visible = true, transformation(origin = {65, -221}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance systemicPeripheralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.79e-09, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {1, -235}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Heart_Valve tricuspidValve(_Gon(displayUnit = "l/(mmHg.min)") = 1.25e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {-217, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Time_Variant_Elastance rightVentricle(ExternalPressure = -400, ZeroPressureVolume = 3.3e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start = 2.75961e-06) annotation(
          Placement(visible = true, transformation(origin = {-203, 103}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Vascular_Resistance tricuspidResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.25e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {-219, 49}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Heart_Valve pulmonaryValve(_Gon(displayUnit = "l/(mmHg.min)") = 4.1667e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {-171, 151}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Constant_Elastance pulmonaryArteries(Compliance(displayUnit = "ml/mmHg") = 6.8813e-10, ExternalPressure = -400, ZeroPressureVolume = 3.27e-06, volume_start = 4.81283e-06) annotation(
          Placement(visible = true, transformation(origin = {-71, 215}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Constant_Elastance pulmonaryVeins(Compliance(displayUnit = "ml/mmHg") = 1.56263e-08, ExternalPressure = -400, ZeroPressureVolume = 2.29e-05, volume_start = 4.71283e-05) annotation(
          Placement(visible = true, transformation(origin = {54, 218}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Constant_Elastance extrathoracicVeins(Compliance(displayUnit = "ml/mmHg") = 3.00025e-08, ZeroPressureVolume = 6.54e-05, volume_start(displayUnit = "ml") = 0.000101375) annotation(
          Placement(visible = true, transformation(origin = {-69, -223}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance pulmonaryArterialResistance(Conductance(displayUnit = "m3/(Pa.s)") = 4.17e-07) annotation(
          Placement(visible = true, transformation(origin = {-124, 190}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Vascular_Resistance systemicArterialResistance(Conductance(displayUnit = "m3/(Pa.s)") = 5e-09, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {111, -207}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Vascular_Resistance extrathoracicVenousResistance(Conductance(displayUnit = "m3/(Pa.s)") = 3.57e-08) annotation(
          Placement(visible = true, transformation(origin = {-123, -199}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Constant_Elastance intrathoracicVeins(Compliance(displayUnit = "ml/mmHg") = 1.50012e-08, ExternalPressure = -400, ZeroPressureVolume = 7.78e-05, volume_start(displayUnit = "ml") = 9.97711e-05) annotation(
          Placement(visible = true, transformation(origin = {-163, -165}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance rightAtrialInletResistance(Conductance(displayUnit = "m3/(Pa.s)") = 5e-07) annotation(
          Placement(visible = true, transformation(origin = {-195, -117}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Time_Variant_Elastance rightAtrium(Compliance(displayUnit = "ml/mmHg"), ExternalPressure = -400, ZeroPressureVolume = 2.5e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start(displayUnit = "ml") = 3.03061e-06) annotation(
          Placement(visible = true, transformation(origin = {-217, -65}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Blood_Inertia systemicBloodInertia(I(displayUnit = "Pa.s2/m3") = 2.40e05, volumeFlow_start = 2.16667e-05) annotation(
          Placement(visible = true, transformation(origin = {152, -180}, extent = {{15, -15}, {-15, 15}}, rotation = 0)));
        Signals.Ventricular_Elastances.Ventricular_signal_2 rightVentricularElastanceSignal(ELVMAX = 4.58629e+09, ELVMIN = 3.49305e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {-176, 102}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Signals.Ventricular_Elastances.Ventricular_signal_2 leftVentricularElastanceSignal(ELVMAX = 7.07942e+09, ELVMIN = 3.50638e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {196, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Signals.Atrial_Elastances.Atrial_signal_2 rightAtrialElastanceSignal(ELAMAX = 1.34656e+09, ELAMIN = 3.46638e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {-188, -68}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Signals.Atrial_Elastances.Atrial_signal_2 leftAtrialElastanceSignal(ELAMAX = 4.95959e+08, ELAMIN = 4.66628e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {132, 164}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Signals.Respirations.Pulmonary_Respiration pulmonaryRespiration(t0 = 0) annotation(
          Placement(visible = true, transformation(origin = {-56, 252}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(pulmonaryRespiration.O2_inPAB, pulmonaryPeripheralResistance.oxygen) annotation(
          Line(points = {{-46, 252}, {0, 252}, {0, 240}}, color = {0, 0, 127}));
        connect(pulmonaryArteries.O2_current, pulmonaryRespiration.O2_PA) annotation(
          Line(points = {{-84, 224}, {-84, 252}, {-66, 252}}, color = {0, 0, 127}));
        connect(pulmonaryArteries.q_in, pulmonaryPeripheralResistance.q_in) annotation(
          Line(points = {{-71, 215}, {-17.5, 215}, {-17.5, 230}}));
        connect(pulmonaryArterialResistance.q_out, pulmonaryArteries.q_in) annotation(
          Line(points = {{-106.5, 190}, {-72, 190}, {-72, 215}, {-71, 215}}));
        connect(rightVentricularElastanceSignal.C, rightVentricle.compliance) annotation(
          Line(points = {{-187, 102}, {-190, 102}, {-190, 104}}, color = {0, 0, 127}));
        connect(pulmonaryValve.q_in, rightVentricle.q_in) annotation(
          Line(points = {{-170, 136}, {-186, 136}, {-186, 124}, {-198, 124}, {-198, 104}, {-202, 104}}));
        connect(leftVentricularElastanceSignal.C, leftVentricle.compliance) annotation(
          Line(points = {{207, 36}, {208, 36}, {208, 37}, {211, 37}}, color = {0, 0, 127}));
        connect(leftAtrialElastanceSignal.C, leftAtrium.compliance) annotation(
          Line(points = {{139, 164}, {146, 164}, {146, 166}, {148, 166}}, color = {0, 0, 127}));
        connect(rightAtrialElastanceSignal.C, rightAtrium.compliance) annotation(
          Line(points = {{-195, -68}, {-204, -68}, {-204, -64}}, color = {0, 0, 127}));
        connect(aorticValve.q_in, leftVentricle.q_in) annotation(
          Line(points = {{226, -18}, {222, -18}, {222, 37}, {223, 37}}));
        connect(mitralResistance.q_out, leftVentricle.q_in) annotation(
          Line(points = {{214, 66}, {223, 66}, {223, 37}}));
        connect(pulmonaryPeripheralResistance.q_out, pulmonaryVeins.q_in) annotation(
          Line(points = {{17.5, 228}, {48.75, 228}, {48.75, 218}, {54, 218}}));
        connect(pulmonaryVeins.q_in, pulmonaryVenousResistance.q_in) annotation(
          Line(points = {{54, 218}, {97.5, 218}, {97.5, 198}, {95, 198}}));
        connect(leftAtrium.q_in, mitralValve.q_in) annotation(
          Line(points = {{159, 165}, {190, 165}, {190, 138}}));
        connect(pulmonaryVenousResistance.q_out, leftAtrium.q_in) annotation(
          Line(points = {{128, 198}, {156, 198}, {156, 165}, {159, 165}}));
        connect(mitralValve.q_out, mitralResistance.q_in) annotation(
          Line(points = {{190, 108}, {214, 108}, {214, 96}, {214, 96}}));
        connect(aorticResistance.q_in, aorticValve.q_out) annotation(
          Line(points = {{210, -82}, {226, -82}, {226, -48}, {226, -48}}));
        connect(intrathoracicArteries.q_in, aorticResistance.q_out) annotation(
          Line(points = {{188, -138}, {208, -138}, {208, -112}, {210, -112}}));
        connect(tricuspidValve.q_out, tricuspidResistance.q_in) annotation(
          Line(points = {{-216, 14}, {-218, 14}, {-218, 34}, {-218, 34}}));
        connect(tricuspidValve.q_in, rightAtrium.q_in) annotation(
          Line(points = {{-219, -16}, {-216, -16}, {-216, -65}, {-217, -65}}));
        connect(rightAtrialInletResistance.q_out, rightAtrium.q_in) annotation(
          Line(points = {{-194, -102}, {-214, -102}, {-214, -64}, {-214, -64}}));
        connect(intrathoracicVeins.q_in, rightAtrialInletResistance.q_in) annotation(
          Line(points = {{-162, -164}, {-196, -164}, {-196, -132}, {-194, -132}}));
        connect(extrathoracicVenousResistance.q_out, intrathoracicVeins.q_in) annotation(
          Line(points = {{-138, -198}, {-164, -198}, {-164, -164}, {-162, -164}}));
        connect(extrathoracicVeins.q_in, extrathoracicVenousResistance.q_in) annotation(
          Line(points = {{-68, -222}, {-110, -222}, {-110, -198}, {-108, -198}}));
        connect(systemicPeripheralResistance.q_out, extrathoracicVeins.q_in) annotation(
          Line(points = {{-14, -234}, {-70, -234}, {-70, -222}, {-68, -222}}));
        connect(intrathoracicArteries.q_in, systemicBloodInertia.q_in) annotation(
          Line(points = {{189, -139}, {189, -176.5}, {167, -176.5}, {167, -180}}));
        connect(systemicBloodInertia.q_out, systemicArterialResistance.q_in) annotation(
          Line(points = {{139, -180}, {121, -180}, {121, -207}, {126, -207}}));
        connect(systemicArterialResistance.q_out, extrathoracicArteries.q_in) annotation(
          Line(points = {{96, -209}, {82.5, -209}, {82.5, -221}, {65, -221}}));
        connect(systemicPeripheralResistance.q_in, extrathoracicArteries.q_in) annotation(
          Line(points = {{16, -235}, {51, -235}, {51, -223}, {65, -223}}));
        connect(pulmonaryValve.q_out, pulmonaryArterialResistance.q_in) annotation(
          Line(points = {{-171, 166}, {-143.5, 166}, {-143.5, 190}}));
        connect(rightVentricle.q_in, tricuspidResistance.q_out) annotation(
          Line(points = {{-203, 103}, {-203, 84.5}, {-219, 84.5}, {-219, 64}}));
        annotation(
          Diagram(coordinateSystem(extent = {{-250, -250}, {250, 250}}, preserveAspectRatio = false)),
          Icon(coordinateSystem(extent = {{-250, -250}, {250, 250}}, preserveAspectRatio = false)),
          Documentation(info = "<html><head></head><body><p>
      Model of a healthy neonate
      </p>
      </body></html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
      end Healthy;

      model Stenosis
        extends Icons.Cardiovascular_System;
        Components.Vascular_Resistance pulmonaryVenousResistance(Conductance(displayUnit = "m3/(Pa.s)") = 5e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {112, 198}, extent = {{15, -15}, {-15, 15}}, rotation = 180)));
        Components.Vascular_Resistance pulmonaryPeripheralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 8.82e-09, useConductanceInput = false, useOxygenInput = true) annotation(
          Placement(visible = true, transformation(origin = {0, 228}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Time_Variant_Elastance leftAtrium(Compliance(displayUnit = "ml/mmHg"), ExternalPressure = -400, ZeroPressureVolume = 2.5e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start(displayUnit = "ml") = 3.46601e-06) annotation(
          Placement(visible = true, transformation(origin = {159, 165}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Heart_Valve mitralValve(_Gon(displayUnit = "m3/(Pa.s)") = 1.25e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {189, 123}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Time_Variant_Elastance leftVentricle(ExternalPressure = -400, ZeroPressureVolume = 0, useComplianceInput = true, useExternalPressureInput = false, volume_start = 4.86548e-06) annotation(
          Placement(visible = true, transformation(origin = {223, 37}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Vascular_Resistance mitralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.25e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {213, 81}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Heart_Valve aorticValve(_Gon(displayUnit = "m3/(Pa.s)") = 9.37594E-09, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {225, -33}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Constant_Elastance intrathoracicArteries(Compliance(displayUnit = "ml/mmHg") = 5.51516e-10, ExternalPressure = -400, ZeroPressureVolume = 9.16e-06, volume_start = 1.21673e-05) annotation(
          Placement(visible = true, transformation(origin = {187, -139}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance aorticResistance(Conductance(displayUnit = "m3/(Pa.s)") = 9.37594E-09, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {209, -97}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Constant_Elastance extrathoracicArteries(Compliance(displayUnit = "ml/mmHg") = 1.29321e-09, ZeroPressureVolume = 2.42e-05, volume_start = 3.06887e-05) annotation(
          Placement(visible = true, transformation(origin = {65, -221}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance systemicPeripheralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.79e-09, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {1, -235}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Heart_Valve tricuspidValve(_Gon(displayUnit = "l/(mmHg.min)") = 1.25e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {-217, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Time_Variant_Elastance rightVentricle(ExternalPressure = -400, ZeroPressureVolume = 3.3e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start = 2.75961e-06) annotation(
          Placement(visible = true, transformation(origin = {-203, 103}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Vascular_Resistance tricuspidResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.25e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {-219, 49}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Heart_Valve pulmonaryValve(_Gon(displayUnit = "l/(mmHg.min)") = 4.1667e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {-171, 151}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Constant_Elastance pulmonaryArteries(Compliance(displayUnit = "ml/mmHg") = 6.8813e-10, ExternalPressure = -400, ZeroPressureVolume = 3.27e-06, volume_start = 4.81283e-06) annotation(
          Placement(visible = true, transformation(origin = {-71, 215}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Constant_Elastance pulmonaryVeins(Compliance(displayUnit = "ml/mmHg") = 1.56263e-08, ExternalPressure = -400, ZeroPressureVolume = 2.29e-05, volume_start = 4.71283e-05) annotation(
          Placement(visible = true, transformation(origin = {54, 218}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Constant_Elastance extrathoracicVeins(Compliance(displayUnit = "ml/mmHg") = 3.00025e-08, ZeroPressureVolume = 6.54e-05, volume_start(displayUnit = "ml") = 0.000101375) annotation(
          Placement(visible = true, transformation(origin = {-69, -223}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance pulmonaryArterialResistance(Conductance(displayUnit = "m3/(Pa.s)") = 4.17e-07) annotation(
          Placement(visible = true, transformation(origin = {-124, 190}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Vascular_Resistance systemicArterialResistance(Conductance(displayUnit = "m3/(Pa.s)") = 5e-09, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {111, -207}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Vascular_Resistance extrathoracicVenousResistance(Conductance(displayUnit = "m3/(Pa.s)") = 3.57e-08) annotation(
          Placement(visible = true, transformation(origin = {-123, -199}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Constant_Elastance intrathoracicVeins(Compliance(displayUnit = "ml/mmHg") = 1.50012e-08, ExternalPressure = -400, ZeroPressureVolume = 7.78e-05, volume_start(displayUnit = "ml") = 9.97711e-05) annotation(
          Placement(visible = true, transformation(origin = {-163, -165}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance rightAtrialInletResistance(Conductance(displayUnit = "m3/(Pa.s)") = 5e-07) annotation(
          Placement(visible = true, transformation(origin = {-195, -117}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Time_Variant_Elastance rightAtrium(Compliance(displayUnit = "ml/mmHg"), ExternalPressure = -400, ZeroPressureVolume = 2.5e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start(displayUnit = "ml") = 3.03061e-06) annotation(
          Placement(visible = true, transformation(origin = {-217, -65}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Blood_Inertia systemicBloodInertia(I(displayUnit = "Pa.s2/m3") = 2.40e05, volumeFlow_start = 2.16667e-05) annotation(
          Placement(visible = true, transformation(origin = {152, -180}, extent = {{15, -15}, {-15, 15}}, rotation = 0)));
        Signals.Ventricular_Elastances.Ventricular_signal_2 rightVentricularElastanceSignal(ELVMAX = 4.58629e+09, ELVMIN = 3.49305e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {-176, 102}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Signals.Ventricular_Elastances.Ventricular_signal_2 leftVentricularElastanceSignal(ELVMAX = 3.78636e+09, ELVMIN = 1.99984e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {196, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Signals.Atrial_Elastances.Atrial_signal_2 rightAtrialElastanceSignal(ELAMAX = 1.34656e+09, ELAMIN = 3.46638e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {-188, -68}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Signals.Atrial_Elastances.Atrial_signal_2 leftAtrialElastanceSignal(ELAMAX = 4.95959e+08, ELAMIN = 4.66628e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {132, 164}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Signals.Respirations.Pulmonary_Respiration pulmonaryRespiration(t0 = 0) annotation(
          Placement(visible = true, transformation(origin = {-56, 252}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(pulmonaryRespiration.O2_inPAB, pulmonaryPeripheralResistance.oxygen) annotation(
          Line(points = {{-46, 252}, {0, 252}, {0, 240}}, color = {0, 0, 127}));
        connect(pulmonaryArteries.O2_current, pulmonaryRespiration.O2_PA) annotation(
          Line(points = {{-84, 224}, {-84, 252}, {-66, 252}}, color = {0, 0, 127}));
        connect(pulmonaryArteries.q_in, pulmonaryPeripheralResistance.q_in) annotation(
          Line(points = {{-71, 215}, {-17.5, 215}, {-17.5, 230}}));
        connect(pulmonaryArterialResistance.q_out, pulmonaryArteries.q_in) annotation(
          Line(points = {{-106.5, 190}, {-72, 190}, {-72, 215}, {-71, 215}}));
        connect(rightVentricularElastanceSignal.C, rightVentricle.compliance) annotation(
          Line(points = {{-187, 102}, {-190, 102}, {-190, 104}}, color = {0, 0, 127}));
        connect(pulmonaryValve.q_in, rightVentricle.q_in) annotation(
          Line(points = {{-170, 136}, {-186, 136}, {-186, 124}, {-198, 124}, {-198, 104}, {-202, 104}}));
        connect(leftVentricularElastanceSignal.C, leftVentricle.compliance) annotation(
          Line(points = {{207, 36}, {208, 36}, {208, 37}, {211, 37}}, color = {0, 0, 127}));
        connect(leftAtrialElastanceSignal.C, leftAtrium.compliance) annotation(
          Line(points = {{139, 164}, {146, 164}, {146, 166}, {148, 166}}, color = {0, 0, 127}));
        connect(rightAtrialElastanceSignal.C, rightAtrium.compliance) annotation(
          Line(points = {{-195, -68}, {-204, -68}, {-204, -64}}, color = {0, 0, 127}));
        connect(aorticValve.q_in, leftVentricle.q_in) annotation(
          Line(points = {{226, -18}, {222, -18}, {222, 37}, {223, 37}}));
        connect(mitralResistance.q_out, leftVentricle.q_in) annotation(
          Line(points = {{214, 66}, {223, 66}, {223, 37}}));
        connect(pulmonaryPeripheralResistance.q_out, pulmonaryVeins.q_in) annotation(
          Line(points = {{17.5, 228}, {48.75, 228}, {48.75, 218}, {54, 218}}));
        connect(pulmonaryVeins.q_in, pulmonaryVenousResistance.q_in) annotation(
          Line(points = {{54, 218}, {97.5, 218}, {97.5, 198}, {95, 198}}));
        connect(leftAtrium.q_in, mitralValve.q_in) annotation(
          Line(points = {{159, 165}, {190, 165}, {190, 138}}));
        connect(pulmonaryVenousResistance.q_out, leftAtrium.q_in) annotation(
          Line(points = {{128, 198}, {156, 198}, {156, 165}, {159, 165}}));
        connect(mitralValve.q_out, mitralResistance.q_in) annotation(
          Line(points = {{190, 108}, {214, 108}, {214, 96}, {214, 96}}));
        connect(aorticResistance.q_in, aorticValve.q_out) annotation(
          Line(points = {{210, -82}, {226, -82}, {226, -48}, {226, -48}}));
        connect(intrathoracicArteries.q_in, aorticResistance.q_out) annotation(
          Line(points = {{188, -138}, {208, -138}, {208, -112}, {210, -112}}));
        connect(tricuspidValve.q_out, tricuspidResistance.q_in) annotation(
          Line(points = {{-216, 14}, {-218, 14}, {-218, 34}, {-218, 34}}));
        connect(tricuspidValve.q_in, rightAtrium.q_in) annotation(
          Line(points = {{-219, -16}, {-216, -16}, {-216, -65}, {-217, -65}}));
        connect(rightAtrialInletResistance.q_out, rightAtrium.q_in) annotation(
          Line(points = {{-194, -102}, {-214, -102}, {-214, -64}, {-214, -64}}));
        connect(intrathoracicVeins.q_in, rightAtrialInletResistance.q_in) annotation(
          Line(points = {{-162, -164}, {-196, -164}, {-196, -132}, {-194, -132}}));
        connect(extrathoracicVenousResistance.q_out, intrathoracicVeins.q_in) annotation(
          Line(points = {{-138, -198}, {-164, -198}, {-164, -164}, {-162, -164}}));
        connect(extrathoracicVeins.q_in, extrathoracicVenousResistance.q_in) annotation(
          Line(points = {{-68, -222}, {-110, -222}, {-110, -198}, {-108, -198}}));
        connect(systemicPeripheralResistance.q_out, extrathoracicVeins.q_in) annotation(
          Line(points = {{-14, -234}, {-70, -234}, {-70, -222}, {-68, -222}}));
        connect(intrathoracicArteries.q_in, systemicBloodInertia.q_in) annotation(
          Line(points = {{189, -139}, {189, -176.5}, {167, -176.5}, {167, -180}}));
        connect(systemicBloodInertia.q_out, systemicArterialResistance.q_in) annotation(
          Line(points = {{139, -180}, {121, -180}, {121, -207}, {126, -207}}));
        connect(systemicArterialResistance.q_out, extrathoracicArteries.q_in) annotation(
          Line(points = {{96, -209}, {82.5, -209}, {82.5, -221}, {65, -221}}));
        connect(systemicPeripheralResistance.q_in, extrathoracicArteries.q_in) annotation(
          Line(points = {{16, -235}, {51, -235}, {51, -223}, {65, -223}}));
        connect(pulmonaryValve.q_out, pulmonaryArterialResistance.q_in) annotation(
          Line(points = {{-171, 166}, {-143.5, 166}, {-143.5, 190}}));
        connect(rightVentricle.q_in, tricuspidResistance.q_out) annotation(
          Line(points = {{-203, 103}, {-203, 84.5}, {-219, 84.5}, {-219, 64}}));
        annotation(
          Diagram(coordinateSystem(extent = {{-250, -250}, {250, 250}}, preserveAspectRatio = false)),
          Icon(coordinateSystem(extent = {{-250, -250}, {250, 250}}, preserveAspectRatio = false)),
          Documentation(info = "<html><head></head><body><p>
    This disease increases cardiac muscle mass and reduces flow from the left ventricle to the aorta.
    </p>
    </body></html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
      end Stenosis;

      model Coarctation_of_the_Aorta
        extends Icons.Cardiovascular_System;
        Components.Vascular_Resistance pulmonaryVenousResistance(Conductance(displayUnit = "m3/(Pa.s)") = 5e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {112, 198}, extent = {{15, -15}, {-15, 15}}, rotation = 180)));
        Components.Vascular_Resistance pulmonaryPeripheralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 8.82e-09, useConductanceInput = false, useOxygenInput = true) annotation(
          Placement(visible = true, transformation(origin = {0, 228}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Time_Variant_Elastance leftAtrium(Compliance(displayUnit = "ml/mmHg"), ExternalPressure = -400, ZeroPressureVolume = 2.5e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start(displayUnit = "ml") = 3.46601e-06) annotation(
          Placement(visible = true, transformation(origin = {159, 165}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Heart_Valve mitralValve(_Gon(displayUnit = "m3/(Pa.s)") = 1.25e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {189, 123}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Time_Variant_Elastance leftVentricle(ExternalPressure = -400, ZeroPressureVolume = 5e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start = 4.86548e-06) annotation(
          Placement(visible = true, transformation(origin = {223, 37}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Vascular_Resistance mitralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.25e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {213, 81}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Heart_Valve aorticValve(_Gon(displayUnit = "l/(mmHg.min)") = 4.16667e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {225, -33}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Constant_Elastance intrathoracicArteries(Compliance(displayUnit = "ml/mmHg") = 5.51516e-10, ExternalPressure = -400, ZeroPressureVolume = 9.16e-06, volume_start = 1.21673e-05) annotation(
          Placement(visible = true, transformation(origin = {187, -139}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance aorticResistance(Conductance(displayUnit = "m3/(Pa.s)") = 2.08354E-08, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {209, -97}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Constant_Elastance extrathoracicArteries(Compliance(displayUnit = "ml/mmHg") = 1.29321e-09, ZeroPressureVolume = 2.42e-05, volume_start = 3.06887e-05) annotation(
          Placement(visible = true, transformation(origin = {65, -221}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance systemicPeripheralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.79e-09, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {1, -235}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Heart_Valve tricuspidValve(_Gon(displayUnit = "l/(mmHg.min)") = 1.25e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {-217, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Time_Variant_Elastance rightVentricle(ExternalPressure = -400, ZeroPressureVolume = 3.3e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start = 2.75961e-06) annotation(
          Placement(visible = true, transformation(origin = {-203, 103}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Vascular_Resistance tricuspidResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.25e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {-219, 49}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Heart_Valve pulmonaryValve(_Gon(displayUnit = "l/(mmHg.min)") = 4.1667e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {-171, 151}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Constant_Elastance pulmonaryArteries(Compliance(displayUnit = "ml/mmHg") = 6.8813e-10, ExternalPressure = -400, ZeroPressureVolume = 3.27e-06, volume_start = 4.81283e-06) annotation(
          Placement(transformation(origin = {-71, 215}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Constant_Elastance pulmonaryVeins(Compliance(displayUnit = "ml/mmHg") = 1.56263e-08, ExternalPressure = -400, ZeroPressureVolume = 2.29e-05, volume_start = 4.71283e-05) annotation(
          Placement(visible = true, transformation(origin = {54, 218}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Constant_Elastance extrathoracicVeins(Compliance(displayUnit = "ml/mmHg") = 3.00025e-08, ZeroPressureVolume = 6.54e-05, volume_start(displayUnit = "ml") = 0.000101375) annotation(
          Placement(visible = true, transformation(origin = {-69, -223}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance pulmonaryArterialResistance(Conductance(displayUnit = "m3/(Pa.s)") = 4.17e-07) annotation(
          Placement(visible = true, transformation(origin = {-124, 190}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Vascular_Resistance systemicArterialResistance(Conductance(displayUnit = "m3/(Pa.s)") = 5e-09, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {111, -207}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Vascular_Resistance extrathoracicVenousResistance(Conductance(displayUnit = "m3/(Pa.s)") = 3.57e-08) annotation(
          Placement(visible = true, transformation(origin = {-123, -199}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Constant_Elastance intrathoracicVeins(Compliance(displayUnit = "ml/mmHg") = 1.50012e-08, ExternalPressure = -400, ZeroPressureVolume = 7.78e-05, volume_start(displayUnit = "ml") = 9.97711e-05) annotation(
          Placement(visible = true, transformation(origin = {-163, -165}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance rightAtrialInletResistance(Conductance(displayUnit = "m3/(Pa.s)") = 5e-07) annotation(
          Placement(visible = true, transformation(origin = {-195, -117}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Time_Variant_Elastance rightAtrium(Compliance(displayUnit = "ml/mmHg"), ExternalPressure = -400, ZeroPressureVolume = 2.5e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start(displayUnit = "ml") = 3.03061e-06) annotation(
          Placement(visible = true, transformation(origin = {-217, -65}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Blood_Inertia systemicBloodInertia(I(displayUnit = "Pa.s2/m3") = 2.40e05, volumeFlow_start = 2.16667e-05) annotation(
          Placement(visible = true, transformation(origin = {152, -180}, extent = {{15, -15}, {-15, 15}}, rotation = 0)));
        Signals.Ventricular_Elastances.Ventricular_signal_2 rightVentricularElastanceSignal(ELVMAX = 1.51988e+10, ELVMIN = 1.74652e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {-176, 102}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Signals.Ventricular_Elastances.Ventricular_signal_2 leftVentricularElastanceSignal(ELVMAX = 7.07942e+09, ELVMIN = 3.50638e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {196, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Signals.Atrial_Elastances.Atrial_signal_2 rightAtrialElastanceSignal(ELAMAX = 1.34656e+09, ELAMIN = 3.46638e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {-188, -68}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Signals.Atrial_Elastances.Atrial_signal_2 leftAtrialElastanceSignal(ELAMAX = 4.95959e+08, ELAMIN = 4.66628e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {132, 164}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Components.Vascular_Resistance ductusArteriosusResistance(Conductance(displayUnit = "m3/(Pa.s)") = 8.33417E-09) annotation(
          Placement(visible = true, transformation(origin = {8, 90}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Blood_Inertia ductusArteriosusInertia(I(displayUnit = "Pa.s2/m3") = 2.40e05, volumeFlow_start = 2.16667e-05) annotation(
          Placement(visible = true, transformation(origin = {88, -16}, extent = {{15, -15}, {-15, 15}}, rotation = 180)));
        Components.Vascular_Resistance foramenOvaleResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.50015E-08) annotation(
          Placement(visible = true, transformation(origin = {-30, 34}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Signals.Respirations.Pulmonary_Respiration pulmonaryRespiration(t0 = 0) annotation(
          Placement(visible = true, transformation(origin = {-56, 252}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(pulmonaryRespiration.O2_inPAB, pulmonaryPeripheralResistance.oxygen) annotation(
          Line(points = {{-46, 252}, {0, 252}, {0, 240}}, color = {0, 0, 127}));
        connect(pulmonaryArteries.O2_current, pulmonaryRespiration.O2_PA) annotation(
          Line(points = {{-84, 224}, {-84, 252}, {-66, 252}}, color = {0, 0, 127}));
        connect(foramenOvaleResistance.q_out, leftAtrium.q_in) annotation(
          Line(points = {{-12, 34}, {44, 34}, {44, 94}, {98, 94}, {98, 140}, {160, 140}, {160, 166}, {160, 166}}));
        connect(rightAtrium.q_in, foramenOvaleResistance.q_in) annotation(
          Line(points = {{-216, -64}, {-142, -64}, {-142, -6}, {-84, -6}, {-84, 34}, {-48, 34}, {-48, 34}}));
        connect(rightAtrialElastanceSignal.C, rightAtrium.compliance) annotation(
          Line(points = {{-195, -68}, {-204, -68}, {-204, -64}}, color = {0, 0, 127}));
        connect(tricuspidValve.q_in, rightAtrium.q_in) annotation(
          Line(points = {{-219, -16}, {-216, -16}, {-216, -65}, {-217, -65}}));
        connect(rightAtrialInletResistance.q_out, rightAtrium.q_in) annotation(
          Line(points = {{-194, -102}, {-214, -102}, {-214, -64}, {-214, -64}}));
        connect(ductusArteriosusInertia.q_out, intrathoracicArteries.q_in) annotation(
          Line(points = {{104, -16}, {134, -16}, {134, -78}, {186, -78}, {186, -138}, {188, -138}}));
        connect(ductusArteriosusResistance.q_out, ductusArteriosusInertia.q_in) annotation(
          Line(points = {{26, 90}, {26, 90}, {26, 44}, {54, 44}, {54, -16}, {74, -16}, {74, -16}}));
        connect(pulmonaryArteries.q_in, ductusArteriosusResistance.q_in) annotation(
          Line(points = {{-71, 215}, {-72, 215}, {-72, 138}, {-38, 138}, {-38, 90}, {-10, 90}}));
        connect(rightVentricularElastanceSignal.C, rightVentricle.compliance) annotation(
          Line(points = {{-187, 102}, {-190, 102}, {-190, 104}}, color = {0, 0, 127}));
        connect(pulmonaryValve.q_in, rightVentricle.q_in) annotation(
          Line(points = {{-170, 136}, {-186, 136}, {-186, 124}, {-198, 124}, {-198, 104}, {-202, 104}}));
        connect(leftVentricularElastanceSignal.C, leftVentricle.compliance) annotation(
          Line(points = {{207, 36}, {208, 36}, {208, 37}, {211, 37}}, color = {0, 0, 127}));
        connect(leftAtrialElastanceSignal.C, leftAtrium.compliance) annotation(
          Line(points = {{139, 164}, {146, 164}, {146, 166}, {148, 166}}, color = {0, 0, 127}));
        connect(pulmonaryArterialResistance.q_out, pulmonaryArteries.q_in) annotation(
          Line(points = {{-106.5, 190}, {-72, 190}, {-72, 215}, {-71, 215}}));
        connect(pulmonaryArteries.q_in, pulmonaryPeripheralResistance.q_in) annotation(
          Line(points = {{-71, 215}, {-17.5, 215}, {-17.5, 230}}));
        connect(aorticValve.q_in, leftVentricle.q_in) annotation(
          Line(points = {{226, -18}, {222, -18}, {222, 37}, {223, 37}}));
        connect(mitralResistance.q_out, leftVentricle.q_in) annotation(
          Line(points = {{214, 66}, {223, 66}, {223, 37}}));
        connect(pulmonaryPeripheralResistance.q_out, pulmonaryVeins.q_in) annotation(
          Line(points = {{17.5, 228}, {48.75, 228}, {48.75, 218}, {54, 218}}));
        connect(pulmonaryVeins.q_in, pulmonaryVenousResistance.q_in) annotation(
          Line(points = {{54, 218}, {97.5, 218}, {97.5, 198}, {95, 198}}));
        connect(leftAtrium.q_in, mitralValve.q_in) annotation(
          Line(points = {{159, 165}, {190, 165}, {190, 138}}));
        connect(pulmonaryVenousResistance.q_out, leftAtrium.q_in) annotation(
          Line(points = {{128, 198}, {156, 198}, {156, 165}, {159, 165}}));
        connect(mitralValve.q_out, mitralResistance.q_in) annotation(
          Line(points = {{190, 108}, {214, 108}, {214, 96}, {214, 96}}));
        connect(aorticResistance.q_in, aorticValve.q_out) annotation(
          Line(points = {{210, -82}, {226, -82}, {226, -48}, {226, -48}}));
        connect(intrathoracicArteries.q_in, aorticResistance.q_out) annotation(
          Line(points = {{188, -138}, {208, -138}, {208, -112}, {210, -112}}));
        connect(tricuspidValve.q_out, tricuspidResistance.q_in) annotation(
          Line(points = {{-216, 14}, {-218, 14}, {-218, 34}, {-218, 34}}));
        connect(intrathoracicVeins.q_in, rightAtrialInletResistance.q_in) annotation(
          Line(points = {{-162, -164}, {-196, -164}, {-196, -132}, {-194, -132}}));
        connect(extrathoracicVenousResistance.q_out, intrathoracicVeins.q_in) annotation(
          Line(points = {{-138, -198}, {-164, -198}, {-164, -164}, {-162, -164}}));
        connect(extrathoracicVeins.q_in, extrathoracicVenousResistance.q_in) annotation(
          Line(points = {{-68, -222}, {-110, -222}, {-110, -198}, {-108, -198}}));
        connect(systemicPeripheralResistance.q_out, extrathoracicVeins.q_in) annotation(
          Line(points = {{-14, -234}, {-70, -234}, {-70, -222}, {-68, -222}}));
        connect(intrathoracicArteries.q_in, systemicBloodInertia.q_in) annotation(
          Line(points = {{189, -139}, {189, -176.5}, {167, -176.5}, {167, -180}}));
        connect(systemicBloodInertia.q_out, systemicArterialResistance.q_in) annotation(
          Line(points = {{139, -180}, {121, -180}, {121, -207}, {126, -207}}));
        connect(systemicArterialResistance.q_out, extrathoracicArteries.q_in) annotation(
          Line(points = {{96, -209}, {82.5, -209}, {82.5, -221}, {65, -221}}));
        connect(systemicPeripheralResistance.q_in, extrathoracicArteries.q_in) annotation(
          Line(points = {{16, -235}, {51, -235}, {51, -223}, {65, -223}}));
        connect(pulmonaryValve.q_out, pulmonaryArterialResistance.q_in) annotation(
          Line(points = {{-171, 166}, {-143.5, 166}, {-143.5, 190}}));
        connect(rightVentricle.q_in, tricuspidResistance.q_out) annotation(
          Line(points = {{-203, 103}, {-203, 84.5}, {-219, 84.5}, {-219, 64}}));
        annotation(
          Diagram(coordinateSystem(extent = {{-250, -250}, {250, 250}}, preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(origin = {-34, 33}, fillColor = {255, 217, 252}, fillPattern = FillPattern.Solid, extent = {{-22, 17}, {28, -17}}), Rectangle(origin = {4, 89}, fillColor = {255, 217, 252}, fillPattern = FillPattern.Solid, extent = {{-22, 17}, {28, -17}}), Rectangle(origin = {90, -13}, fillColor = {255, 217, 252}, fillPattern = FillPattern.Solid, extent = {{-22, 17}, {18, -23}}), Rectangle(origin = {214, -89}, fillColor = {255, 217, 252}, fillPattern = FillPattern.Solid, extent = {{-22, 17}, {12, -31}}), Rectangle(origin = {-204, 105}, fillColor = {255, 217, 252}, fillPattern = FillPattern.Solid, extent = {{-22, 17}, {46, -23}})}),
          Icon(coordinateSystem(extent = {{-250, -250}, {250, 250}}, preserveAspectRatio = false)),
          Documentation(info = "<html><head></head><body><p>This is a vascular obstruction that decreases blood perfusion, generating an overload in pressure of the left ventricle and a dilatation of the right ventricle.</p>
    </body></html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
      end Coarctation_of_the_Aorta;

      model Tetralogy_of_Fallot
        extends Icons.Cardiovascular_System;
        Components.Vascular_Resistance pulmonaryVenousResistance(Conductance(displayUnit = "m3/(Pa.s)") = 5e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {112, 198}, extent = {{15, -15}, {-15, 15}}, rotation = 180)));
        Components.Vascular_Resistance pulmonaryPeripheralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 8.82e-09, useConductanceInput = false, useOxygenInput = true) annotation(
          Placement(visible = true, transformation(origin = {0, 228}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Time_Variant_Elastance leftAtrium(Compliance(displayUnit = "ml/mmHg"), ExternalPressure = -400, ZeroPressureVolume = 2.5e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start(displayUnit = "ml") = 3.46601e-06) annotation(
          Placement(visible = true, transformation(origin = {159, 165}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Heart_Valve mitralValve(_Gon(displayUnit = "m3/(Pa.s)") = 1.25e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {189, 123}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Time_Variant_Elastance leftVentricle(ExternalPressure = -400, ZeroPressureVolume = 5e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start = 4.86548e-06) annotation(
          Placement(visible = true, transformation(origin = {223, 37}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Vascular_Resistance mitralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.25e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {213, 81}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Heart_Valve aorticValve(_Gon(displayUnit = "l/(mmHg.min)") = 4.16667e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {225, -33}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Constant_Elastance intrathoracicArteries(Compliance(displayUnit = "ml/mmHg") = 5.51516e-10, ExternalPressure = -400, ZeroPressureVolume = 9.16e-06, volume_start = 1.21673e-05) annotation(
          Placement(visible = true, transformation(origin = {187, -139}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance aorticResistance(Conductance(displayUnit = "m3/(Pa.s)") = 4.17e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {209, -97}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Constant_Elastance extrathoracicArteries(Compliance(displayUnit = "ml/mmHg") = 1.29321e-09, ZeroPressureVolume = 2.42e-05, volume_start = 3.06887e-05) annotation(
          Placement(visible = true, transformation(origin = {65, -221}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance systemicPeripheralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.79e-09, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {1, -235}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Heart_Valve tricuspidValve(_Gon(displayUnit = "l/(mmHg.min)") = 1.25e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {-217, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Time_Variant_Elastance rightVentricle(ExternalPressure = -400, ZeroPressureVolume = 3.3e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start = 2.75961e-06) annotation(
          Placement(visible = true, transformation(origin = {-203, 103}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Vascular_Resistance tricuspidResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.25e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {-219, 49}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Heart_Valve pulmonaryValve(_Gon(displayUnit = "l/(mmHg.min)") = 4.1667e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {-171, 151}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Constant_Elastance pulmonaryArteries(Compliance(displayUnit = "ml/mmHg") = 6.8813e-10, ExternalPressure = -400, ZeroPressureVolume = 3.27e-06, volume_start = 4.81283e-06) annotation(
          Placement(transformation(origin = {-71, 215}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Constant_Elastance pulmonaryVeins(Compliance(displayUnit = "ml/mmHg") = 1.56263e-08, ExternalPressure = -400, ZeroPressureVolume = 2.29e-05, volume_start = 4.71283e-05) annotation(
          Placement(visible = true, transformation(origin = {54, 218}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Constant_Elastance extrathoracicVeins(Compliance(displayUnit = "ml/mmHg") = 3.00025e-08, ZeroPressureVolume = 6.54e-05, volume_start(displayUnit = "ml") = 0.000101375) annotation(
          Placement(visible = true, transformation(origin = {-69, -223}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance pulmonaryArterialResistance(Conductance(displayUnit = "m3/(Pa.s)") = 2.08354E-09) annotation(
          Placement(visible = true, transformation(origin = {-124, 190}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Vascular_Resistance systemicArterialResistance(Conductance(displayUnit = "m3/(Pa.s)") = 5e-09, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {111, -207}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Vascular_Resistance extrathoracicVenousResistance(Conductance(displayUnit = "m3/(Pa.s)") = 3.57e-08) annotation(
          Placement(visible = true, transformation(origin = {-123, -199}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Constant_Elastance intrathoracicVeins(Compliance(displayUnit = "ml/mmHg") = 1.50012e-08, ExternalPressure = -400, ZeroPressureVolume = 7.78e-05, volume_start(displayUnit = "ml") = 9.97711e-05) annotation(
          Placement(visible = true, transformation(origin = {-163, -165}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance rightAtrialInletResistance(Conductance(displayUnit = "m3/(Pa.s)") = 5e-07) annotation(
          Placement(visible = true, transformation(origin = {-195, -117}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Time_Variant_Elastance rightAtrium(Compliance(displayUnit = "ml/mmHg"), ExternalPressure = -400, ZeroPressureVolume = 2.5e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start(displayUnit = "ml") = 3.03061e-06) annotation(
          Placement(visible = true, transformation(origin = {-217, -65}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Blood_Inertia systemicBloodInertia(I(displayUnit = "Pa.s2/m3") = 2.40e05, volumeFlow_start = 2.16667e-05) annotation(
          Placement(visible = true, transformation(origin = {152, -180}, extent = {{15, -15}, {-15, 15}}, rotation = 0)));
        Signals.Ventricular_Elastances.Ventricular_signal_2 rightVentricularElastanceSignal(ELVMAX = 6.87944e+09, ELVMIN = 2.33314e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {-176, 102}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Signals.Ventricular_Elastances.Ventricular_signal_2 leftVentricularElastanceSignal(ELVMAX = 7.07942e+09, ELVMIN = 3.50638e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {196, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Signals.Atrial_Elastances.Atrial_signal_2 rightAtrialElastanceSignal(ELAMAX = 1.34656e+09, ELAMIN = 3.46638e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {-188, -68}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Signals.Atrial_Elastances.Atrial_signal_2 leftAtrialElastanceSignal(ELAMAX = 4.95959e+08, ELAMIN = 4.66628e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {132, 164}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Components.Heart_Valve overridingAortaValve(_Gon(displayUnit = "m3/(Pa.s)") = 1.50015e-07) annotation(
          Placement(visible = true, transformation(origin = {-97, 13}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance ventricularSeptalResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.50015E-08) annotation(
          Placement(visible = true, transformation(origin = {20, 70}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Vascular_Resistance overridingAortaResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.50015E-07) annotation(
          Placement(visible = true, transformation(origin = {48, -60}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Signals.Respirations.Pulmonary_Respiration pulmonaryRespiration(t0 = 0) annotation(
          Placement(visible = true, transformation(origin = {-56, 252}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(pulmonaryRespiration.O2_inPAB, pulmonaryPeripheralResistance.oxygen) annotation(
          Line(points = {{-46, 252}, {0, 252}, {0, 240}}, color = {0, 0, 127}));
        connect(pulmonaryArteries.O2_current, pulmonaryRespiration.O2_PA) annotation(
          Line(points = {{-84, 224}, {-84, 252}, {-66, 252}}, color = {0, 0, 127}));
        connect(overridingAortaResistance.q_out, intrathoracicArteries.q_in) annotation(
          Line(points = {{66, -60}, {100, -60}, {100, -84}, {138, -84}, {138, -104}, {188, -104}, {188, -138}, {188, -138}}));
        connect(overridingAortaValve.q_out, overridingAortaResistance.q_in) annotation(
          Line(points = {{-82, 14}, {-50, 14}, {-50, -24}, {-4, -24}, {-4, -62}, {30, -62}, {30, -60}}));
        connect(rightVentricle.q_in, overridingAortaValve.q_in) annotation(
          Line(points = {{-202, 104}, {-198, 104}, {-198, 52}, {-150, 52}, {-150, 14}, {-112, 14}, {-112, 14}}));
        connect(ventricularSeptalResistance.q_out, leftVentricle.q_in) annotation(
          Line(points = {{38, 70}, {122, 70}, {122, 38}, {224, 38}, {224, 38}}));
        connect(rightVentricle.q_in, ventricularSeptalResistance.q_in) annotation(
          Line(points = {{-202, 104}, {-88, 104}, {-88, 70}, {2, 70}, {2, 70}}));
        connect(rightVentricularElastanceSignal.C, rightVentricle.compliance) annotation(
          Line(points = {{-187, 102}, {-190, 102}, {-190, 104}}, color = {0, 0, 127}));
        connect(pulmonaryValve.q_in, rightVentricle.q_in) annotation(
          Line(points = {{-170, 136}, {-186, 136}, {-186, 124}, {-198, 124}, {-198, 104}, {-202, 104}}));
        connect(leftVentricularElastanceSignal.C, leftVentricle.compliance) annotation(
          Line(points = {{207, 36}, {208, 36}, {208, 37}, {211, 37}}, color = {0, 0, 127}));
        connect(leftAtrialElastanceSignal.C, leftAtrium.compliance) annotation(
          Line(points = {{139, 164}, {146, 164}, {146, 166}, {148, 166}}, color = {0, 0, 127}));
        connect(rightAtrialElastanceSignal.C, rightAtrium.compliance) annotation(
          Line(points = {{-195, -68}, {-204, -68}, {-204, -64}}, color = {0, 0, 127}));
        connect(pulmonaryArterialResistance.q_out, pulmonaryArteries.q_in) annotation(
          Line(points = {{-106.5, 190}, {-72, 190}, {-72, 215}, {-71, 215}}));
        connect(pulmonaryArteries.q_in, pulmonaryPeripheralResistance.q_in) annotation(
          Line(points = {{-71, 215}, {-17.5, 215}, {-17.5, 230}}));
        connect(aorticValve.q_in, leftVentricle.q_in) annotation(
          Line(points = {{226, -18}, {222, -18}, {222, 37}, {223, 37}}));
        connect(mitralResistance.q_out, leftVentricle.q_in) annotation(
          Line(points = {{214, 66}, {223, 66}, {223, 37}}));
        connect(pulmonaryPeripheralResistance.q_out, pulmonaryVeins.q_in) annotation(
          Line(points = {{17.5, 228}, {48.75, 228}, {48.75, 218}, {54, 218}}));
        connect(pulmonaryVeins.q_in, pulmonaryVenousResistance.q_in) annotation(
          Line(points = {{54, 218}, {97.5, 218}, {97.5, 198}, {95, 198}}));
        connect(leftAtrium.q_in, mitralValve.q_in) annotation(
          Line(points = {{159, 165}, {190, 165}, {190, 138}}));
        connect(pulmonaryVenousResistance.q_out, leftAtrium.q_in) annotation(
          Line(points = {{128, 198}, {156, 198}, {156, 165}, {159, 165}}));
        connect(mitralValve.q_out, mitralResistance.q_in) annotation(
          Line(points = {{190, 108}, {214, 108}, {214, 96}, {214, 96}}));
        connect(aorticResistance.q_in, aorticValve.q_out) annotation(
          Line(points = {{210, -82}, {226, -82}, {226, -48}, {226, -48}}));
        connect(intrathoracicArteries.q_in, aorticResistance.q_out) annotation(
          Line(points = {{188, -138}, {208, -138}, {208, -112}, {210, -112}}));
        connect(tricuspidValve.q_out, tricuspidResistance.q_in) annotation(
          Line(points = {{-216, 14}, {-218, 14}, {-218, 34}, {-218, 34}}));
        connect(tricuspidValve.q_in, rightAtrium.q_in) annotation(
          Line(points = {{-219, -16}, {-216, -16}, {-216, -65}, {-217, -65}}));
        connect(rightAtrialInletResistance.q_out, rightAtrium.q_in) annotation(
          Line(points = {{-194, -102}, {-214, -102}, {-214, -64}, {-214, -64}}));
        connect(intrathoracicVeins.q_in, rightAtrialInletResistance.q_in) annotation(
          Line(points = {{-162, -164}, {-196, -164}, {-196, -132}, {-194, -132}}));
        connect(extrathoracicVenousResistance.q_out, intrathoracicVeins.q_in) annotation(
          Line(points = {{-138, -198}, {-164, -198}, {-164, -164}, {-162, -164}}));
        connect(extrathoracicVeins.q_in, extrathoracicVenousResistance.q_in) annotation(
          Line(points = {{-68, -222}, {-110, -222}, {-110, -198}, {-108, -198}}));
        connect(systemicPeripheralResistance.q_out, extrathoracicVeins.q_in) annotation(
          Line(points = {{-14, -234}, {-70, -234}, {-70, -222}, {-68, -222}}));
        connect(intrathoracicArteries.q_in, systemicBloodInertia.q_in) annotation(
          Line(points = {{189, -139}, {189, -176.5}, {167, -176.5}, {167, -180}}));
        connect(systemicBloodInertia.q_out, systemicArterialResistance.q_in) annotation(
          Line(points = {{139, -180}, {121, -180}, {121, -207}, {126, -207}}));
        connect(systemicArterialResistance.q_out, extrathoracicArteries.q_in) annotation(
          Line(points = {{96, -209}, {82.5, -209}, {82.5, -221}, {65, -221}}));
        connect(systemicPeripheralResistance.q_in, extrathoracicArteries.q_in) annotation(
          Line(points = {{16, -235}, {51, -235}, {51, -223}, {65, -223}}));
        connect(pulmonaryValve.q_out, pulmonaryArterialResistance.q_in) annotation(
          Line(points = {{-171, 166}, {-143.5, 166}, {-143.5, 190}}));
        connect(rightVentricle.q_in, tricuspidResistance.q_out) annotation(
          Line(points = {{-203, 103}, {-203, 84.5}, {-219, 84.5}, {-219, 64}}));
        annotation(
          Diagram(coordinateSystem(extent = {{-250, -250}, {250, 250}}, preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(origin = {-89, 18}, fillColor = {255, 217, 252}, fillPattern = FillPattern.Solid, extent = {{-29, 18}, {15, -28}}), Rectangle(origin = {15, 70}, fillColor = {255, 217, 252}, fillPattern = FillPattern.Solid, extent = {{-29, 18}, {37, -20}}), Rectangle(origin = {43, -60}, fillColor = {255, 217, 252}, fillPattern = FillPattern.Solid, extent = {{-29, 18}, {37, -20}}), Rectangle(origin = {-129, 190}, fillColor = {255, 217, 252}, fillPattern = FillPattern.Solid, extent = {{-29, 18}, {37, -20}}), Rectangle(origin = {-201, 106}, fillColor = {255, 217, 252}, fillPattern = FillPattern.Solid, extent = {{-29, 18}, {41, -24}})}),
          Icon(coordinateSystem(extent = {{-250, -250}, {250, 250}}, preserveAspectRatio = false)),
          Documentation(info = "<html><head></head><body><p>This cardiac anomaly refers to a combination of four related heart defects that commonly occur together. These defects are: pulmonary stenosis, ventricular septal defect, dominant aorta and hypertrophy of the right ventricle.</p>
    </body></html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
      end Tetralogy_of_Fallot;

      model Transposition_of_the_Great_Arteries
        extends Icons.Cardiovascular_System;
        Components.Vascular_Resistance pulmonaryVenousResistance(Conductance(displayUnit = "m3/(Pa.s)") = 5e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {112, 198}, extent = {{15, -15}, {-15, 15}}, rotation = 180)));
        Components.Vascular_Resistance pulmonaryPeripheralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 8.82e-09, useConductanceInput = false, useOxygenInput = true) annotation(
          Placement(visible = true, transformation(origin = {0, 228}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Time_Variant_Elastance leftAtrium(Compliance(displayUnit = "ml/mmHg"), ExternalPressure = -400, ZeroPressureVolume = 2.5e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start(displayUnit = "ml") = 3.46601e-06) annotation(
          Placement(visible = true, transformation(origin = {159, 165}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Heart_Valve mitralValve(_Gon(displayUnit = "m3/(Pa.s)") = 1.25e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {189, 123}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Time_Variant_Elastance leftVentricle(ExternalPressure = -400, ZeroPressureVolume = 5e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start = 4.86548e-06) annotation(
          Placement(visible = true, transformation(origin = {223, 37}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Vascular_Resistance mitralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.25e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {213, 81}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Constant_Elastance intrathoracicArteries(Compliance(displayUnit = "ml/mmHg") = 5.51516e-10, ExternalPressure = -400, ZeroPressureVolume = 9.16e-06, volume_start = 1.21673e-05) annotation(
          Placement(visible = true, transformation(origin = {187, -139}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Constant_Elastance extrathoracicArteries(Compliance(displayUnit = "ml/mmHg") = 1.29321e-09, ZeroPressureVolume = 2.42e-05, volume_start = 3.06887e-05) annotation(
          Placement(visible = true, transformation(origin = {65, -221}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance systemicPeripheralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.79e-09, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {1, -235}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Heart_Valve tricuspidValve(_Gon(displayUnit = "l/(mmHg.min)") = 1.25e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {-217, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Time_Variant_Elastance rightVentricle(ExternalPressure = -400, ZeroPressureVolume = 3.3e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start = 2.75961e-06) annotation(
          Placement(visible = true, transformation(origin = {-203, 103}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Vascular_Resistance tricuspidResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.25e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {-219, 49}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Constant_Elastance pulmonaryArteries(Compliance(displayUnit = "ml/mmHg") = 6.8813e-10, ExternalPressure = -400, ZeroPressureVolume = 3.27e-06, volume_start = 4.81283e-06) annotation(
          Placement(transformation(origin = {-71, 215}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Constant_Elastance pulmonaryVeins(Compliance(displayUnit = "ml/mmHg") = 1.56263e-08, ExternalPressure = -400, ZeroPressureVolume = 2.29e-05, volume_start = 4.71283e-05) annotation(
          Placement(visible = true, transformation(origin = {54, 218}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Constant_Elastance extrathoracicVeins(Compliance(displayUnit = "ml/mmHg") = 3.00025e-08, ZeroPressureVolume = 6.54e-05, volume_start(displayUnit = "ml") = 0.000101375) annotation(
          Placement(visible = true, transformation(origin = {-69, -223}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance systemicArterialResistance(Conductance(displayUnit = "m3/(Pa.s)") = 5e-09, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {111, -207}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Vascular_Resistance extrathoracicVenousResistance(Conductance(displayUnit = "m3/(Pa.s)") = 3.57e-08) annotation(
          Placement(visible = true, transformation(origin = {-123, -199}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Constant_Elastance intrathoracicVeins(Compliance(displayUnit = "ml/mmHg") = 1.50012e-08, ExternalPressure = -400, ZeroPressureVolume = 7.78e-05, volume_start(displayUnit = "ml") = 9.97711e-05) annotation(
          Placement(visible = true, transformation(origin = {-163, -165}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance rightAtrialInletResistance(Conductance(displayUnit = "m3/(Pa.s)") = 5e-07) annotation(
          Placement(visible = true, transformation(origin = {-195, -117}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Time_Variant_Elastance rightAtrium(Compliance(displayUnit = "ml/mmHg"), ExternalPressure = -400, ZeroPressureVolume = 2.5e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start(displayUnit = "ml") = 3.03061e-06) annotation(
          Placement(visible = true, transformation(origin = {-217, -65}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Blood_Inertia systemicBloodInertia(I(displayUnit = "Pa.s2/m3") = 2.40e05, volumeFlow_start = 2.16667e-05) annotation(
          Placement(visible = true, transformation(origin = {152, -180}, extent = {{15, -15}, {-15, 15}}, rotation = 0)));
        Signals.Ventricular_Elastances.Ventricular_signal_2 rightVentricularElastanceSignal(ELVMAX = 1.14591e+10, ELVMIN = 1.74652e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {-176, 102}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Signals.Ventricular_Elastances.Ventricular_signal_2 leftVentricularElastanceSignal(ELVMAX = 7.07942e+09, ELVMIN = 3.50638e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {196, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Signals.Atrial_Elastances.Atrial_signal_2 rightAtrialElastanceSignal(ELAMAX = 1.34656e+09, ELAMIN = 3.46638e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {-188, -68}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Signals.Atrial_Elastances.Atrial_signal_2 leftAtrialElastanceSignal(ELAMAX = 4.95959e+08, ELAMIN = 4.66628e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {132, 164}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Components.Vascular_Resistance foramenOvaleResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.50015E-08) annotation(
          Placement(visible = true, transformation(origin = {-30, 34}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Heart_Valve transposedAorticValve annotation(
          Placement(visible = true, transformation(origin = {-49, -37}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance transposedAorticResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.50015E-07) annotation(
          Placement(visible = true, transformation(origin = {68, -122}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Vascular_Resistance ventricularSeptalResistance(Conductance(displayUnit = "m3/(Pa.s)") = 7.50075E-08) annotation(
          Placement(visible = true, transformation(origin = {-4, 84}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Heart_Valve transposedPulmonaryValve(_Gon(displayUnit = "m3/(Pa.s)") = 1.50015e-08) annotation(
          Placement(visible = true, transformation(origin = {135, 95}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Vascular_Resistance transposedPulmonaryResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.50015E-08) annotation(
          Placement(visible = true, transformation(origin = {22, 160}, extent = {{15, -15}, {-15, 15}}, rotation = 0)));
        Signals.Respirations.Pulmonary_Respiration pulmonaryRespiration(t0 = 0) annotation(
          Placement(visible = true, transformation(origin = {-56, 252}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(pulmonaryRespiration.O2_inPAB, pulmonaryPeripheralResistance.oxygen) annotation(
          Line(points = {{-46, 252}, {0, 252}, {0, 240}}, color = {0, 0, 127}));
        connect(pulmonaryArteries.O2_current, pulmonaryRespiration.O2_PA) annotation(
          Line(points = {{-84, 224}, {-84, 252}, {-66, 252}}, color = {0, 0, 127}));
        connect(transposedPulmonaryResistance.q_out, pulmonaryArteries.q_in) annotation(
          Line(points = {{8, 160}, {-34, 160}, {-34, 180}, {-72, 180}, {-72, 215}, {-71, 215}}));
        connect(transposedPulmonaryValve.q_out, transposedPulmonaryResistance.q_in) annotation(
          Line(points = {{120, 96}, {108, 96}, {108, 120}, {64, 120}, {64, 160}, {38, 160}, {38, 160}}));
        connect(leftVentricle.q_in, transposedPulmonaryValve.q_in) annotation(
          Line(points = {{224, 38}, {172, 38}, {172, 96}, {150, 96}, {150, 96}}));
        connect(ventricularSeptalResistance.q_out, leftVentricle.q_in) annotation(
          Line(points = {{14, 84}, {30, 84}, {30, 68}, {102, 68}, {102, 38}, {224, 38}, {224, 38}}));
        connect(rightVentricle.q_in, ventricularSeptalResistance.q_in) annotation(
          Line(points = {{-202, 104}, {-102, 104}, {-102, 86}, {-22, 86}, {-22, 84}}));
        connect(transposedAorticValve.q_out, transposedAorticResistance.q_in) annotation(
          Line(points = {{-34, -36}, {-4, -36}, {-4, -82}, {32, -82}, {32, -120}, {48, -120}, {48, -122}, {50, -122}}));
        connect(rightVentricle.q_in, transposedAorticValve.q_in) annotation(
          Line(points = {{-202, 104}, {-198, 104}, {-198, 64}, {-164, 64}, {-164, 22}, {-114, 22}, {-114, -37}, {-62, -37}}));
        connect(transposedAorticResistance.q_out, intrathoracicArteries.q_in) annotation(
          Line(points = {{86, -122}, {136, -122}, {136, -140}, {186, -140}, {186, -138}, {188, -138}}));
        connect(foramenOvaleResistance.q_out, leftAtrium.q_in) annotation(
          Line(points = {{-12, 34}, {44, 34}, {44, 94}, {98, 94}, {98, 140}, {160, 140}, {160, 166}, {160, 166}}));
        connect(rightAtrium.q_in, foramenOvaleResistance.q_in) annotation(
          Line(points = {{-216, -64}, {-142, -64}, {-142, -6}, {-84, -6}, {-84, 34}, {-48, 34}, {-48, 34}}));
        connect(rightAtrialElastanceSignal.C, rightAtrium.compliance) annotation(
          Line(points = {{-195, -68}, {-204, -68}, {-204, -64}}, color = {0, 0, 127}));
        connect(tricuspidValve.q_in, rightAtrium.q_in) annotation(
          Line(points = {{-219, -16}, {-216, -16}, {-216, -65}, {-217, -65}}));
        connect(rightAtrialInletResistance.q_out, rightAtrium.q_in) annotation(
          Line(points = {{-194, -102}, {-214, -102}, {-214, -64}, {-214, -64}}));
        connect(rightVentricularElastanceSignal.C, rightVentricle.compliance) annotation(
          Line(points = {{-187, 102}, {-190, 102}, {-190, 104}}, color = {0, 0, 127}));
        connect(leftVentricularElastanceSignal.C, leftVentricle.compliance) annotation(
          Line(points = {{207, 36}, {208, 36}, {208, 37}, {211, 37}}, color = {0, 0, 127}));
        connect(leftAtrialElastanceSignal.C, leftAtrium.compliance) annotation(
          Line(points = {{139, 164}, {146, 164}, {146, 166}, {148, 166}}, color = {0, 0, 127}));
        connect(pulmonaryArteries.q_in, pulmonaryPeripheralResistance.q_in) annotation(
          Line(points = {{-71, 215}, {-17.5, 215}, {-17.5, 230}}));
        connect(mitralResistance.q_out, leftVentricle.q_in) annotation(
          Line(points = {{214, 66}, {223, 66}, {223, 37}}));
        connect(pulmonaryPeripheralResistance.q_out, pulmonaryVeins.q_in) annotation(
          Line(points = {{17.5, 228}, {48.75, 228}, {48.75, 218}, {54, 218}}));
        connect(pulmonaryVeins.q_in, pulmonaryVenousResistance.q_in) annotation(
          Line(points = {{54, 218}, {97.5, 218}, {97.5, 198}, {95, 198}}));
        connect(leftAtrium.q_in, mitralValve.q_in) annotation(
          Line(points = {{159, 165}, {190, 165}, {190, 138}}));
        connect(pulmonaryVenousResistance.q_out, leftAtrium.q_in) annotation(
          Line(points = {{128, 198}, {156, 198}, {156, 165}, {159, 165}}));
        connect(mitralValve.q_out, mitralResistance.q_in) annotation(
          Line(points = {{190, 108}, {214, 108}, {214, 96}, {214, 96}}));
        connect(tricuspidValve.q_out, tricuspidResistance.q_in) annotation(
          Line(points = {{-216, 14}, {-218, 14}, {-218, 34}, {-218, 34}}));
        connect(intrathoracicVeins.q_in, rightAtrialInletResistance.q_in) annotation(
          Line(points = {{-162, -164}, {-196, -164}, {-196, -132}, {-194, -132}}));
        connect(extrathoracicVenousResistance.q_out, intrathoracicVeins.q_in) annotation(
          Line(points = {{-138, -198}, {-164, -198}, {-164, -164}, {-162, -164}}));
        connect(extrathoracicVeins.q_in, extrathoracicVenousResistance.q_in) annotation(
          Line(points = {{-68, -222}, {-110, -222}, {-110, -198}, {-108, -198}}));
        connect(systemicPeripheralResistance.q_out, extrathoracicVeins.q_in) annotation(
          Line(points = {{-14, -234}, {-70, -234}, {-70, -222}, {-68, -222}}));
        connect(intrathoracicArteries.q_in, systemicBloodInertia.q_in) annotation(
          Line(points = {{189, -139}, {189, -176.5}, {167, -176.5}, {167, -180}}));
        connect(systemicBloodInertia.q_out, systemicArterialResistance.q_in) annotation(
          Line(points = {{139, -180}, {121, -180}, {121, -207}, {126, -207}}));
        connect(systemicArterialResistance.q_out, extrathoracicArteries.q_in) annotation(
          Line(points = {{96, -209}, {82.5, -209}, {82.5, -221}, {65, -221}}));
        connect(systemicPeripheralResistance.q_in, extrathoracicArteries.q_in) annotation(
          Line(points = {{16, -235}, {51, -235}, {51, -223}, {65, -223}}));
        connect(rightVentricle.q_in, tricuspidResistance.q_out) annotation(
          Line(points = {{-203, 103}, {-203, 84.5}, {-219, 84.5}, {-219, 64}}));
        annotation(
          Diagram(coordinateSystem(extent = {{-250, -250}, {250, 250}}, preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(origin = {-31, 33}, fillColor = {255, 217, 252}, fillPattern = FillPattern.Solid, extent = {{-25, 17}, {27, -17}}), Rectangle(origin = {-5, 83}, fillColor = {255, 217, 252}, fillPattern = FillPattern.Solid, extent = {{-25, 17}, {27, -17}}), Rectangle(origin = {21, 161}, fillColor = {255, 217, 252}, fillPattern = FillPattern.Solid, extent = {{-25, 17}, {27, -17}}), Rectangle(origin = {139, 95}, fillColor = {255, 217, 252}, fillPattern = FillPattern.Solid, extent = {{-25, 17}, {17, -21}}), Rectangle(origin = {-45, -33}, fillColor = {255, 217, 252}, fillPattern = FillPattern.Solid, extent = {{-25, 17}, {17, -21}}), Rectangle(origin = {67, -123}, fillColor = {255, 217, 252}, fillPattern = FillPattern.Solid, extent = {{-25, 17}, {27, -17}}), Rectangle(origin = {-205, 105}, fillColor = {255, 217, 252}, fillPattern = FillPattern.Solid, extent = {{-25, 17}, {47, -21}})}),
          Icon(coordinateSystem(extent = {{-250, -250}, {250, 250}}, preserveAspectRatio = false)),
          Documentation(info = "<html><head></head><body><p>In this congenital defect the pulmonary artery and the aorta are transposed. As a result, deoxygenated blood does not pass through the lungs and recirculates throughout the body. Transposition of the great arteries is the most frequent congenital defect in newborns and frequently causes death in patients who have not had surgery. It is only compatible with extrauterine life in case of a timely surgery or when there exists a defect of the ventricular septum (or a similar compensating defect) that allow the mixture of oxygenated and deoxygenated blood. Because of the high incoming flow caused by this defect, the right ventricle becomes hypertrophied.</p>
    </body></html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
      end Transposition_of_the_Great_Arteries;

      model Persistence_of_Ductus_Arteriosus
        extends Icons.Cardiovascular_System;
        Components.Vascular_Resistance pulmonaryVenousResistance(Conductance(displayUnit = "m3/(Pa.s)") = 5e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {112, 198}, extent = {{15, -15}, {-15, 15}}, rotation = 180)));
        Components.Vascular_Resistance pulmonaryPeripheralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 8.82e-09, useConductanceInput = false, useOxygenInput = true) annotation(
          Placement(visible = true, transformation(origin = {0, 228}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Time_Variant_Elastance leftAtrium(Compliance(displayUnit = "ml/mmHg"), ExternalPressure = -400, ZeroPressureVolume = 2.5e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start(displayUnit = "ml") = 3.46601e-06) annotation(
          Placement(visible = true, transformation(origin = {159, 165}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Heart_Valve mitralValve(_Gon(displayUnit = "m3/(Pa.s)") = 1.25e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {189, 123}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Time_Variant_Elastance leftVentricle(ExternalPressure = -400, ZeroPressureVolume = 5e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start = 4.86548e-06) annotation(
          Placement(visible = true, transformation(origin = {223, 37}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Vascular_Resistance mitralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.25e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {213, 81}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Heart_Valve aorticValve(_Gon(displayUnit = "l/(mmHg.min)") = 4.16667e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {225, -33}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Constant_Elastance intrathoracicArteries(Compliance(displayUnit = "ml/mmHg") = 5.51516e-10, ExternalPressure = -400, ZeroPressureVolume = 9.16e-06, volume_start = 1.21673e-05) annotation(
          Placement(visible = true, transformation(origin = {187, -139}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance aorticResistance(Conductance(displayUnit = "m3/(Pa.s)") = 4.17e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {209, -97}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Constant_Elastance extrathoracicArteries(Compliance(displayUnit = "ml/mmHg") = 1.29321e-09, ZeroPressureVolume = 2.42e-05, volume_start = 3.06887e-05) annotation(
          Placement(visible = true, transformation(origin = {65, -221}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance systemicPeripheralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.79e-09, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {1, -235}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Heart_Valve tricuspidValve(_Gon(displayUnit = "l/(mmHg.min)") = 1.25e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {-217, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Time_Variant_Elastance rightVentricle(ExternalPressure = -400, ZeroPressureVolume = 3.3e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start = 2.75961e-06) annotation(
          Placement(visible = true, transformation(origin = {-203, 103}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Vascular_Resistance tricuspidResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.25e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {-219, 49}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Heart_Valve pulmonaryValve(_Gon(displayUnit = "l/(mmHg.min)") = 4.1667e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {-171, 151}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Constant_Elastance pulmonaryArteries(Compliance(displayUnit = "ml/mmHg") = 6.8813e-10, ExternalPressure = -400, ZeroPressureVolume = 3.27e-06, volume_start = 4.81283e-06) annotation(
          Placement(transformation(origin = {-71, 215}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Constant_Elastance pulmonaryVeins(Compliance(displayUnit = "ml/mmHg") = 1.56263e-08, ExternalPressure = -400, ZeroPressureVolume = 2.29e-05, volume_start = 4.71283e-05) annotation(
          Placement(visible = true, transformation(origin = {54, 218}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Constant_Elastance extrathoracicVeins(Compliance(displayUnit = "ml/mmHg") = 3.00025e-08, ZeroPressureVolume = 6.54e-05, volume_start(displayUnit = "ml") = 0.000101375) annotation(
          Placement(visible = true, transformation(origin = {-69, -223}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance pulmonaryArterialResistance(Conductance(displayUnit = "m3/(Pa.s)") = 4.17e-07) annotation(
          Placement(visible = true, transformation(origin = {-124, 190}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Vascular_Resistance systemicArterialResistance(Conductance(displayUnit = "m3/(Pa.s)") = 5e-09, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {111, -207}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Vascular_Resistance extrathoracicVenousResistance(Conductance(displayUnit = "m3/(Pa.s)") = 3.57e-08) annotation(
          Placement(visible = true, transformation(origin = {-123, -199}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Constant_Elastance intrathoracicVeins(Compliance(displayUnit = "ml/mmHg") = 1.50012e-08, ExternalPressure = -400, ZeroPressureVolume = 7.78e-05, volume_start(displayUnit = "ml") = 9.97711e-05) annotation(
          Placement(visible = true, transformation(origin = {-163, -165}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance rightAtrialInletResistance(Conductance(displayUnit = "m3/(Pa.s)") = 5e-07) annotation(
          Placement(visible = true, transformation(origin = {-195, -117}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Time_Variant_Elastance rightAtrium(Compliance(displayUnit = "ml/mmHg"), ExternalPressure = -400, ZeroPressureVolume = 2.5e-07, useComplianceInput = true, useExternalPressureInput = false, volume_start(displayUnit = "ml") = 3.03061e-06) annotation(
          Placement(visible = true, transformation(origin = {-217, -65}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Blood_Inertia systemicBloodInertia(I(displayUnit = "Pa.s2/m3") = 2.40e05, volumeFlow_start = 2.16667e-05) annotation(
          Placement(visible = true, transformation(origin = {152, -180}, extent = {{15, -15}, {-15, 15}}, rotation = 0)));
        Signals.Ventricular_Elastances.Ventricular_signal_2 rightVentricularElastanceSignal(ELVMAX = 4.58629e+09, ELVMIN = 3.49305e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {-176, 102}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Signals.Ventricular_Elastances.Ventricular_signal_2 leftVentricularElastanceSignal(ELVMAX = 1.41322e+10, ELVMIN = 2.33314e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {196, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Signals.Atrial_Elastances.Atrial_signal_2 rightAtrialElastanceSignal(ELAMAX = 1.34656e+09, ELAMIN = 3.46638e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {-188, -68}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Signals.Atrial_Elastances.Atrial_signal_2 leftAtrialElastanceSignal(ELAMAX = 4.95959e+08, ELAMIN = 4.66628e+08, HR = 2.16667) annotation(
          Placement(visible = true, transformation(origin = {132, 164}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Components.Vascular_Resistance ductusArteriosusResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.5e-08) annotation(
          Placement(visible = true, transformation(origin = {8, 90}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Blood_Inertia ductusArteriosusInertia(I(displayUnit = "Pa.s2/m3") = 2.40e05, volumeFlow_start = 2.16667e-05) annotation(
          Placement(visible = true, transformation(origin = {88, -16}, extent = {{15, -15}, {-15, 15}}, rotation = 180)));
        Signals.Respirations.Pulmonary_Respiration pulmonaryRespiration(t0 = 0) annotation(
          Placement(visible = true, transformation(origin = {-56, 252}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(pulmonaryRespiration.O2_inPAB, pulmonaryPeripheralResistance.oxygen) annotation(
          Line(points = {{-46, 252}, {0, 252}, {0, 240}}, color = {0, 0, 127}));
        connect(pulmonaryArteries.O2_current, pulmonaryRespiration.O2_PA) annotation(
          Line(points = {{-84, 224}, {-84, 252}, {-66, 252}}, color = {0, 0, 127}));
        connect(pulmonaryArteries.q_in, ductusArteriosusResistance.q_in) annotation(
          Line(points = {{-71, 215}, {-72, 215}, {-72, 138}, {-38, 138}, {-38, 90}, {-10, 90}}));
        connect(ductusArteriosusResistance.q_out, ductusArteriosusInertia.q_in) annotation(
          Line(points = {{26, 90}, {26, 90}, {26, 44}, {54, 44}, {54, -16}, {74, -16}, {74, -16}}));
        connect(ductusArteriosusInertia.q_out, intrathoracicArteries.q_in) annotation(
          Line(points = {{104, -16}, {134, -16}, {134, -78}, {186, -78}, {186, -138}, {188, -138}}));
        connect(rightVentricularElastanceSignal.C, rightVentricle.compliance) annotation(
          Line(points = {{-187, 102}, {-190, 102}, {-190, 104}}, color = {0, 0, 127}));
        connect(pulmonaryValve.q_in, rightVentricle.q_in) annotation(
          Line(points = {{-170, 136}, {-186, 136}, {-186, 124}, {-198, 124}, {-198, 104}, {-202, 104}}));
        connect(leftVentricularElastanceSignal.C, leftVentricle.compliance) annotation(
          Line(points = {{207, 36}, {208, 36}, {208, 37}, {211, 37}}, color = {0, 0, 127}));
        connect(leftAtrialElastanceSignal.C, leftAtrium.compliance) annotation(
          Line(points = {{139, 164}, {146, 164}, {146, 166}, {148, 166}}, color = {0, 0, 127}));
        connect(rightAtrialElastanceSignal.C, rightAtrium.compliance) annotation(
          Line(points = {{-195, -68}, {-204, -68}, {-204, -64}}, color = {0, 0, 127}));
        connect(pulmonaryArterialResistance.q_out, pulmonaryArteries.q_in) annotation(
          Line(points = {{-106.5, 190}, {-72, 190}, {-72, 215}, {-71, 215}}));
        connect(pulmonaryArteries.q_in, pulmonaryPeripheralResistance.q_in) annotation(
          Line(points = {{-71, 215}, {-17.5, 215}, {-17.5, 230}}));
        connect(aorticValve.q_in, leftVentricle.q_in) annotation(
          Line(points = {{226, -18}, {222, -18}, {222, 37}, {223, 37}}));
        connect(mitralResistance.q_out, leftVentricle.q_in) annotation(
          Line(points = {{214, 66}, {223, 66}, {223, 37}}));
        connect(pulmonaryPeripheralResistance.q_out, pulmonaryVeins.q_in) annotation(
          Line(points = {{17.5, 228}, {48.75, 228}, {48.75, 218}, {54, 218}}));
        connect(pulmonaryVeins.q_in, pulmonaryVenousResistance.q_in) annotation(
          Line(points = {{54, 218}, {97.5, 218}, {97.5, 198}, {95, 198}}));
        connect(leftAtrium.q_in, mitralValve.q_in) annotation(
          Line(points = {{159, 165}, {190, 165}, {190, 138}}));
        connect(pulmonaryVenousResistance.q_out, leftAtrium.q_in) annotation(
          Line(points = {{128, 198}, {156, 198}, {156, 165}, {159, 165}}));
        connect(mitralValve.q_out, mitralResistance.q_in) annotation(
          Line(points = {{190, 108}, {214, 108}, {214, 96}, {214, 96}}));
        connect(aorticResistance.q_in, aorticValve.q_out) annotation(
          Line(points = {{210, -82}, {226, -82}, {226, -48}, {226, -48}}));
        connect(intrathoracicArteries.q_in, aorticResistance.q_out) annotation(
          Line(points = {{188, -138}, {208, -138}, {208, -112}, {210, -112}}));
        connect(tricuspidValve.q_out, tricuspidResistance.q_in) annotation(
          Line(points = {{-216, 14}, {-218, 14}, {-218, 34}, {-218, 34}}));
        connect(tricuspidValve.q_in, rightAtrium.q_in) annotation(
          Line(points = {{-219, -16}, {-216, -16}, {-216, -65}, {-217, -65}}));
        connect(rightAtrialInletResistance.q_out, rightAtrium.q_in) annotation(
          Line(points = {{-194, -102}, {-214, -102}, {-214, -64}, {-214, -64}}));
        connect(intrathoracicVeins.q_in, rightAtrialInletResistance.q_in) annotation(
          Line(points = {{-162, -164}, {-196, -164}, {-196, -132}, {-194, -132}}));
        connect(extrathoracicVenousResistance.q_out, intrathoracicVeins.q_in) annotation(
          Line(points = {{-138, -198}, {-164, -198}, {-164, -164}, {-162, -164}}));
        connect(extrathoracicVeins.q_in, extrathoracicVenousResistance.q_in) annotation(
          Line(points = {{-68, -222}, {-110, -222}, {-110, -198}, {-108, -198}}));
        connect(systemicPeripheralResistance.q_out, extrathoracicVeins.q_in) annotation(
          Line(points = {{-14, -234}, {-70, -234}, {-70, -222}, {-68, -222}}));
        connect(intrathoracicArteries.q_in, systemicBloodInertia.q_in) annotation(
          Line(points = {{189, -139}, {189, -176.5}, {167, -176.5}, {167, -180}}));
        connect(systemicBloodInertia.q_out, systemicArterialResistance.q_in) annotation(
          Line(points = {{139, -180}, {121, -180}, {121, -207}, {126, -207}}));
        connect(systemicArterialResistance.q_out, extrathoracicArteries.q_in) annotation(
          Line(points = {{96, -209}, {82.5, -209}, {82.5, -221}, {65, -221}}));
        connect(systemicPeripheralResistance.q_in, extrathoracicArteries.q_in) annotation(
          Line(points = {{16, -235}, {51, -235}, {51, -223}, {65, -223}}));
        connect(pulmonaryValve.q_out, pulmonaryArterialResistance.q_in) annotation(
          Line(points = {{-171, 166}, {-143.5, 166}, {-143.5, 190}}));
        connect(rightVentricle.q_in, tricuspidResistance.q_out) annotation(
          Line(points = {{-203, 103}, {-203, 84.5}, {-219, 84.5}, {-219, 64}}));
        annotation(
          Diagram(coordinateSystem(extent = {{-250, -250}, {250, 250}}, preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(origin = {15, 78}, fillColor = {255, 217, 252}, fillPattern = FillPattern.Solid, extent = {{-33, 30}, {19, -8}}), Rectangle(origin = {99, -26}, fillColor = {255, 217, 252}, fillPattern = FillPattern.Solid, extent = {{-33, 30}, {11, -8}}), Rectangle(origin = {237, 26}, fillColor = {255, 217, 252}, fillPattern = FillPattern.Solid, extent = {{-63, 30}, {11, -8}})}),
          Icon(coordinateSystem(extent = {{-250, -250}, {250, 250}}, preserveAspectRatio = false)),
          Documentation(info = "<html><head></head><body><p>The Ductus arteriosus is a large vessel that connects the pulmonary bed with the descending aorta. It usually closes after birth. Therefore, if it remains open, its persistence becomes a cardiac pathology. The PDA decreases the pulmonary vascular resistance, converting the foetal bypass from right to left in left to right derivation. This fact generates excessive pulmonary blood flow and dilatation of the left ventricle. Another important effect of PDA is that about one-half to two-thirds of the aortic blood passes through the ductus arteriosus into the pulmonary circulation.</p>
    </body></html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
      end Persistence_of_Ductus_Arteriosus;
      annotation(
        Icon(graphics = {Rectangle(lineColor = {170, 255, 255}, fillColor = {248, 248, 248}, fillPattern = FillPattern.VerticalCylinder, extent = {{-100, -100}, {100, 100}}, radius = 25), Bitmap(origin = {1, 2}, extent = {{-75, 76}, {75, -76}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/scenario_neonate.svg")}),
        Documentation(info = "<html><head></head><body><p>
    Physiological models of the Neonate. This package contains models of a healthy neonate with stenosis and four cardiac pathologies. Some heart diseases affect only the values of the components such as Stenosis. While other heart diseases not only affect the values but also the structure of the cardiovascular system. Congenital heart diseases occur due to malformations in fetal life of the heart or the vessels associated with it. These heart diseases commonly cause the greatest pediatric mortality and morbidity and are classified into 4 basic categories: left-to-right shunts, right-to-left shunts, obstructive lesions, and complex shunts. This package explores some of the most well-known heart diseases.</p><p>Articles related to the data and models presented in this package.</p><ul><li>Sepúlveda-Oviedo EH, Bermeo Clavijo LE, Méndez Córdoba LC.
    OpenModelica-based virtual simulator for the cardiovascular and respiratory physiology of a neonate. Journal of Medical Engineering &amp; Technology. 2022;46(3):179-97.</li>
    </ul></body></html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
    end Neonate;

    package Fetus

      model FetalToNeonatal_Transition
        extends Icons.Cardiovascular_System;
        Components.Vascular_Resistance pulmonaryVenousResistance(Conductance(displayUnit = "m3/(Pa.s)") = 2.08e-09, useConductanceInput = true) annotation(
          Placement(visible = true, transformation(origin = {106, 204}, extent = {{15, -15}, {-15, 15}}, rotation = 180)));
        Components.Vascular_Resistance pulmonaryPeripheralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 9.59e-10, useConductanceInput = true, useOxygenInput = true) annotation(
          Placement(visible = true, transformation(origin = {0, 228}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Time_Variant_Elastance leftAtrium(Compliance(displayUnit = "m3/Pa"), ExternalPressure = 0, ZeroPressureVolume = 0, useComplianceInput = true, useExternalPressureInput = false, volume_start(displayUnit = "ml") = 1.58967e-05) annotation(
          Placement(visible = true, transformation(origin = {159, 165}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Heart_Valve mitralValve(_Gon(displayUnit = "m3/(Pa.s)") = 1.25e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {189, 119}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Time_Variant_Elastance leftVentricle(Compliance(displayUnit = "m3/Pa"), ExternalPressure = 0, ZeroPressureVolume = 0, useComplianceInput = true, useExternalPressureInput = false, volume_start = 1.75337e-06) annotation(
          Placement(visible = true, transformation(origin = {217, 23}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Vascular_Resistance mitralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 2.08e-09, useConductanceInput = true) annotation(
          Placement(visible = true, transformation(origin = {213, 63}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Heart_Valve aorticValve(_Gon(displayUnit = "m3/(Pa.s)") = 4.17e-7, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {225, -37}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Constant_Elastance intrathoracicArteries(Compliance(displayUnit = "m3/Pa") = 9.74998e-10, ExternalPressure(displayUnit = "mmHg") = 0, metabolicConsumption(displayUnit = "mol/s"), ZeroPressureVolume = 6.86e-06, volume_start = 9.2333e-06) annotation(
          Placement(visible = true, transformation(origin = {187, -141}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance aorticResistance(Conductance(displayUnit = "m3/(Pa.s)") = 4.169999999999999e-07, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {209, -97}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Constant_Elastance extrathoracicArteries(Compliance(displayUnit = "m3/Pa") = 1.2e-09, metabolicConsumption(displayUnit = "mol/s"), SO2 = 50, ZeroPressureVolume = 1.81e-05, volume_start = 2.04096e-05) annotation(
          Placement(visible = true, transformation(origin = {65, -221}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Vascular_Resistance systemicPeripheralResistance(Conductance(displayUnit = "m3/(Pa.s)") = 3.26119e-09, useConductanceInput = true, useOxygenInput = false) annotation(
          Placement(visible = true, transformation(origin = {1, -219}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Heart_Valve tricuspidValve(_Gon(displayUnit = "m3/(Pa.s)") = 1.25e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {-217, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Time_Variant_Elastance rightVentricle(Compliance(displayUnit = "m3/Pa"), ExternalPressure(displayUnit = "mmHg") = 0, ZeroPressureVolume = 0, useComplianceInput = true, useExternalPressureInput = false, volume_start = 1.68658e-06) annotation(
          Placement(visible = true, transformation(origin = {-203, 103}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Vascular_Resistance tricuspidResistance(Conductance(displayUnit = "m3/(Pa.s)") = 3.125e-7, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {-219, 49}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Heart_Valve pulmonaryValve(_Gon(displayUnit = "m3/(Pa.s)") = 4.17e-07, useLimitationInputs = false) annotation(
          Placement(visible = true, transformation(origin = {-171, 151}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Constant_Elastance pulmonaryArteries(Compliance(displayUnit = "m3/Pa") = 1.2e-09, ExternalPressure(displayUnit = "mmHg") = 0, metabolicConsumption(displayUnit = "mol/s"), SO2 = 42, ZeroPressureVolume = 4.05e-05, volume_start = 4.31556e-05) annotation(
          Placement(visible = true, transformation(origin = {-69, 221}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Constant_Elastance pulmonaryVeins(Compliance(displayUnit = "m3/Pa") = 2.25e-09, ExternalPressure(displayUnit = "mmHg") = 0, metabolicConsumption(displayUnit = "mol/s") = 4.46428e-07, SO2 = 41.1, ZeroPressureVolume = 2.7e-05, volume_start = 4.41667e-05) annotation(
          Placement(visible = true, transformation(origin = {52, 222}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Constant_Elastance extrathoracicVeins(Compliance(displayUnit = "m3/Pa") = 3e-08, metabolicConsumption(displayUnit = "mol/s") = 9.67262e-07, ZeroPressureVolume = 4.75e-05, volume_start(displayUnit = "ml") = 9.14407e-05) annotation(
          Placement(visible = true, transformation(origin = {-69, -223}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Vascular_Resistance pulmonaryArterialResistance(Conductance(displayUnit = "m3/(Pa.s)") = 4.169999999999999e-07) annotation(
          Placement(visible = true, transformation(origin = {-124, 190}, extent = {{17.5, -17.5}, {-17.5, 17.5}}, rotation = 180)));
        Components.Vascular_Resistance extrathoracicArterialResistance(Conductance(displayUnit = "m3/(Pa.s)") = 9.139999999999999e-09, useConductanceInput = false) annotation(
          Placement(visible = true, transformation(origin = {111, -207}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Vascular_Resistance extrathoracicVenousResistance(Conductance(displayUnit = "m3/(Pa.s)") = 2.23e-08, useOxygenInput = false) annotation(
          Placement(visible = true, transformation(origin = {-123, -199}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Constant_Elastance intrathoracicVeins(Compliance(displayUnit = "m3/Pa") = 1.5e-08, ExternalPressure(displayUnit = "mmHg") = 0, metabolicConsumption(displayUnit = "mol/s"), SO2 = 50, ZeroPressureVolume = 5.65e-05, volume_start(displayUnit = "ml") = 7.7441e-05) annotation(
          Placement(visible = true, transformation(origin = {-163, -165}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Vascular_Resistance rightAtrialInletResistance(Conductance(displayUnit = "m3/(Pa.s)") = 2.08e-09) annotation(
          Placement(visible = true, transformation(origin = {-195, -117}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Time_Variant_Elastance rightAtrium(Compliance(displayUnit = "m3/Pa"), ExternalPressure(displayUnit = "mmHg") = 0, ZeroPressureVolume = 0, useComplianceInput = true, useExternalPressureInput = false, volume_start(displayUnit = "ml") = 4.62583e-06) annotation(
          Placement(visible = true, transformation(origin = {-211, -49}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
        Components.Blood_Inertia pulmonaryArterialInertia(I = 2.67e05, volumeFlow_start = 2.16667e-05) annotation(
          Placement(visible = true, transformation(origin = {152, -180}, extent = {{15, -15}, {-15, 15}}, rotation = 0)));
        Signals.Ventricular_Elastances.Ventricular_signal_2 rightVentricularElastanceSignal(ELVMAX(displayUnit = "Pa/m3") = 6.315e8, ELVMIN(displayUnit = "Pa/m3") = 6.251e6, HR = 2.46667) annotation(
          Placement(visible = true, transformation(origin = {-234, 102}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Signals.Ventricular_Elastances.Ventricular_signal_2 leftVentricularElastanceSignal(ELVMAX(displayUnit = "Pa/m3") = 6.315e8, ELVMIN(displayUnit = "Pa/m3") = 6.251e6, HR = 2.46667) annotation(
          Placement(visible = true, transformation(origin = {190, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Signals.Atrial_Elastances.Atrial_signal_2 rightAtrialElastanceSignal(ELAMAX (displayUnit = "Pa/m3")= 2.273e8, ELAMIN (displayUnit = "Pa/m3")= 7.501e7, HR = 2.46667) annotation(
          Placement(visible = true, transformation(origin = {-242, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Signals.Atrial_Elastances.Atrial_signal_2 leftAtrialElastanceSignal(ELAMAX(displayUnit = "Pa/m3") = 2.273e8, ELAMIN(displayUnit = "Pa/m3") = 7.501e7, HR = 2.46667) annotation(
          Placement(visible = true, transformation(origin = {132, 166}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Components.Vascular_Resistance umbilicalArteryResistance(Conductance(displayUnit = "m3/(Pa.s)") = 2.36001e-09, useConductanceInput = true) annotation(
          Placement(visible = true, transformation(origin = {23, -273}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Constant_Elastance Placenta(Compliance= 2.5e-9, Conc_Hb = 120, SO2 = 43.2, ZeroPressureVolume = 6e-05, volume_start = 1.58e-4) annotation(
          Placement(visible = true, transformation(origin = {-45, -275}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Vascular_Resistance ductusVenosusResistance(Conductance(displayUnit = "m3/(Pa.s)") = 1.37e-08, useConductanceInput = true, useOxygenInput = true) annotation(
          Placement(visible = true, transformation(origin = {-125, -265}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
        Components.Vascular_Resistance ductusArteriosusResistance(Conductance(displayUnit = "m3/(Pa.s)") = 6.25e-08, useConductanceInput = true) annotation(
          Placement(visible = true, transformation(origin = {-1, 85}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Components.Heart_Valve foramenOvaleValve(_Gon(displayUnit = "m3/(Pa.s)") = 3.5e-08) annotation(
          Placement(visible = true, transformation(origin = {-147, -19}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
        Components.Vascular_Resistance foramenOvaleResistance(Conductance(displayUnit = "m3/(Pa.s)") = 3.5e-08) annotation(
          Placement(visible = true, transformation(origin = {-87, 17}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Signals.Clamping.Ductus_Arteriosus_Resistance ductusArteriosusResistanceSignal(Co(displayUnit = "m3/(Pa.s)") = 6.250000000000001e-08) annotation(
          Placement(visible = true, transformation(origin = {0, 108}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Signals.Clamping.Peripheral_Vessels pulmonaryPeripheralResistanceSignal(Co(displayUnit = "m3/(Pa.s)") = 9.590000000000001e-10) annotation(
          Placement(visible = true, transformation(origin = {0, 204}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        Signals.Clamping.Left_Atrial_Resistance pulmonaryVenousResistanceSignal(Co(displayUnit = "m3/(Pa.s)") = 2.08e-09) annotation(
          Placement(visible = true, transformation(origin = {106, 182}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        Components.Blood_Inertia ductusArteriosusInertia(I = 2.40e06, volumeFlow_start = 2.16667e-05) annotation(
          Placement(visible = true, transformation(origin = {-44, 120}, extent = {{15, -15}, {-15, 15}}, rotation = 180)));
        Signals.Clamping.Systemic_Vascular systemicVascularResistanceSignal(Co(displayUnit = "m3/(Pa.s)") = 3.26119e-09) annotation(
          Placement(visible = true, transformation(origin = {0, -242}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        Signals.Clamping.Left_Atrial_Resistance mitralResistanceSignal(Co(displayUnit = "m3/(Pa.s)") = 2.08e-09) annotation(
          Placement(visible = true, transformation(origin = {236, 62}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Signals.Respirations.Placental_Respiration placentalRespiration annotation(
          Placement(visible = true, transformation(origin = {-126, -236}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Signals.Clamping.UCC_resistance umbilicalVenousClampingSignal(Co (displayUnit = "ml/(mmHg.min)")= 1.11259133750439e-11, Cf (displayUnit = "ml/(mmHg.min)")= 1.6251334143322553e-19, tc = 600, to = 1) annotation(
          Placement(transformation(origin = {-124, -294}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        Signals.Clamping.UCC_resistance umbilicalArterialClampingSignal(Cf(displayUnit = "ml/(mmHg.min)")= 1.2501026264094272e-19, Co(displayUnit = "ml/(mmHg.min)")= 1.2501026264094272e-11, tc = 600, to = 1) annotation(
          Placement(transformation(origin = {24, -300}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        Components.Altitude altitude(H = 0)  annotation(
          Placement(visible = true, transformation(origin = {-102, 260}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Signals.Respirations.PO2_altitude altitudeOxygenModel annotation(
          Placement(transformation(origin = {-50, 262}, extent = {{-10, -10}, {10, 10}})));
      equation
        connect(umbilicalArterialClampingSignal.C, umbilicalArteryResistance.cond) annotation(
          Line(points = {{24, -291}, {22, -291}, {22, -284}, {24, -284}}, color = {0, 0, 127}));
        connect(umbilicalVenousClampingSignal.C, ductusVenosusResistance.cond) annotation(
          Line(points = {{-124, -285}, {-124, -276}}, color = {0, 0, 127}));
        connect(placentalRespiration.O2_inPB, ductusVenosusResistance.oxygen) annotation(
          Line(points = {{-126, -246}, {-126, -246}, {-126, -256}, {-124, -256}}, color = {0, 0, 127}));
        connect(placentalRespiration.O2_PLAC, Placenta.O2_current) annotation(
          Line(points = {{-116, -242}, {-96, -242}, {-96, -266}, {-58, -266}, {-58, -266}}, color = {85, 255, 0}));
        connect(placentalRespiration.Q_PLAC, ductusVenosusResistance.Q_PLAC) annotation(
          Line(points = {{-136, -242}, {-142, -242}, {-142, -256}, {-142, -256}}, color = {0, 0, 127}));
        connect(mitralResistance.q_out, leftVentricle.q_in) annotation(
          Line(points = {{213, 48}, {217, 48}, {217, 23}}, color = {85, 255, 0}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(pulmonaryPeripheralResistance.q_out, pulmonaryVeins.q_in) annotation(
          Line(points = {{17.5, 228}, {48.75, 228}, {48.75, 222}, {52, 222}}, color = {85, 255, 0}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(pulmonaryVeins.q_in, pulmonaryVenousResistance.q_in) annotation(
          Line(points = {{52, 222}, {97.5, 222}, {97.5, 204}, {91, 204}}, color = {85, 255, 0}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(pulmonaryVenousResistance.q_out, leftAtrium.q_in) annotation(
          Line(points = {{121, 204}, {156, 204}, {156, 165}, {159, 165}}, color = {85, 255, 0}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(leftAtrium.q_in, mitralValve.q_in) annotation(
          Line(points = {{160, 166}, {188, 166}, {188, 134}, {190, 134}}, color = {85, 255, 0}, thickness = 0.75));
        connect(mitralValve.q_out, mitralResistance.q_in) annotation(
          Line(points = {{189, 104}, {213, 104}, {213, 78}}, color = {85, 255, 0}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(pulmonaryArteries.q_in, pulmonaryPeripheralResistance.q_in) annotation(
          Line(points = {{-69, 221}, {-17.5, 221}, {-17.5, 230}}, color = {85, 255, 0}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(ductusArteriosusInertia.q_in, pulmonaryArteries.q_in) annotation(
          Line(points = {{-59, 120}, {-72, 120}, {-72, 221}, {-69, 221}}, color = {85, 255, 0}, thickness = 0.75, arrow = {Arrow.Open, Arrow.Open}));
        connect(intrathoracicArteries.q_in, ductusArteriosusResistance.q_out) annotation(
          Line(points = {{187, -143}, {144.5, -143}, {144.5, -92}, {109, -92}, {109, -54}, {70, -54}, {70, 4}, {41, 4}, {41, 58}, {28.5, 58}, {28.5, 85}, {14, 85}}, color = {85, 255, 0}, thickness = 0.75, arrow = {Arrow.Open, Arrow.Open}));
        connect(systemicPeripheralResistance.q_in, extrathoracicArteries.q_in) annotation(
          Line(points = {{14, -219}, {51, -219}, {51, -221}, {65, -221}}, color = {85, 0, 255}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(systemicPeripheralResistance.q_out, extrathoracicVeins.q_in) annotation(
          Line(points = {{-16, -219}, {-70, -219}, {-70, -223}, {-69, -223}}, color = {85, 0, 255}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(umbilicalArteryResistance.q_in, extrathoracicArteries.q_in) annotation(
          Line(points = {{38, -275}, {55, -275}, {55, -261}, {65, -261}, {65, -221}}, color = {85, 0, 255}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(Placenta.q_in, umbilicalArteryResistance.q_out) annotation(
          Line(points = {{-45, -275}, {8, -275}}, color = {85, 0, 255}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(ductusVenosusResistance.q_out, intrathoracicVeins.q_in) annotation(
          Line(points = {{-140, -267}, {-164, -267}, {-164, -165}, {-163, -165}}, color = {85, 0, 255}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(Placenta.q_in, ductusVenosusResistance.q_in) annotation(
          Line(points = {{-45, -275}, {-110, -275}, {-110, -267}}, color = {85, 0, 255}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(intrathoracicVeins.q_in, rightAtrialInletResistance.q_in) annotation(
          Line(points = {{-162, -164}, {-196, -164}, {-196, -132}, {-194, -132}}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(extrathoracicVenousResistance.q_out, intrathoracicVeins.q_in) annotation(
          Line(points = {{-138, -198}, {-164, -198}, {-164, -164}, {-162, -164}}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(pulmonaryArterialResistance.q_out, pulmonaryArteries.q_in) annotation(
          Line(points = {{-106.5, 190}, {-72, 190}, {-72, 221}, {-69, 221}}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(ductusArteriosusResistanceSignal.C, ductusArteriosusResistance.cond) annotation(
          Line(points = {{0, 101}, {0, 94}}, color = {0, 0, 127}));
        connect(mitralResistanceSignal.C, mitralResistance.cond) annotation(
          Line(points = {{227, 62}, {222, 62}, {222, 64}}, color = {0, 0, 127}));
        connect(systemicVascularResistanceSignal.C, systemicPeripheralResistance.cond) annotation(
          Line(points = {{0, -233}, {0, -231.5}, {2, -231.5}, {2, -228}}, color = {0, 0, 127}));
        connect(extrathoracicVeins.q_in, extrathoracicVenousResistance.q_in) annotation(
          Line(points = {{-69, -223}, {-110, -223}, {-110, -198}, {-108, -198}}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(intrathoracicArteries.q_in, pulmonaryArterialInertia.q_in) annotation(
          Line(points = {{187, -143}, {187, -176.5}, {167, -176.5}, {167, -180}}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(extrathoracicArterialResistance.q_out, extrathoracicArteries.q_in) annotation(
          Line(points = {{96, -209}, {82.5, -209}, {82.5, -221}, {65, -221}}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(foramenOvaleResistance.q_in, foramenOvaleValve.q_out) annotation(
          Line(points = {{-102, 17}, {-147, 17}, {-147, -6}}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(rightAtrium.q_in, foramenOvaleValve.q_in) annotation(
          Line(points = {{-211, -49}, {-148, -49}, {-148, -36}, {-147, -36}}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(leftVentricularElastanceSignal.C, leftVentricle.compliance) annotation(
          Line(points = {{199, 24}, {210, 24}, {210, 23}, {205, 23}}, color = {0, 0, 127}));
        connect(leftVentricle.q_in, aorticValve.q_in) annotation(
          Line(points = {{217, 23}, {217, -3}, {226, -3}, {226, -22}}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(ductusArteriosusInertia.q_out, ductusArteriosusResistance.q_in) annotation(
          Line(points = {{-29, 120}, {-16, 120}, {-16, 85}}, thickness = 0.75, arrow = {Arrow.Open, Arrow.Open}));
        connect(pulmonaryPeripheralResistanceSignal.C, pulmonaryPeripheralResistance.cond) annotation(
          Line(points = {{0, 211}, {0, 218}}, color = {0, 0, 127}));
        connect(leftAtrialElastanceSignal.C, leftAtrium.compliance) annotation(
          Line(points = {{141, 164}, {165.5, 164}, {165.5, 165}, {147, 165}}, color = {0, 0, 127}));
        connect(foramenOvaleResistance.q_out, leftAtrium.q_in) annotation(
          Line(points = {{-72, 17}, {55, 17}, {55, 53}, {156, 53}, {156, 166}, {160, 166}}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(rightVentricularElastanceSignal.C, rightVentricle.compliance) annotation(
          Line(points = {{-227, 102}, {-209.5, 102}, {-209.5, 104}, {-190, 104}}, color = {0, 0, 127}));
        connect(rightAtrialElastanceSignal.C, rightAtrium.compliance) annotation(
          Line(points = {{-235, -50}, {-224.5, -50}, {-224.5, -49}, {-199, -49}}, color = {0, 0, 127}));
        connect(pulmonaryVenousResistanceSignal.C, pulmonaryVenousResistance.cond) annotation(
          Line(points = {{106, 189}, {106, 196}}, color = {0, 0, 127}));
        connect(intrathoracicArteries.q_in, aorticResistance.q_out) annotation(
          Line(points = {{187, -143}, {208, -143}, {208, -112}, {210, -112}}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(rightVentricle.q_in, tricuspidResistance.q_out) annotation(
          Line(points = {{-203, 103}, {-203, 84.5}, {-219, 84.5}, {-219, 64}}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(rightVentricle.q_in, pulmonaryValve.q_in) annotation(
          Line(points = {{-203, 103}, {-173, 103}, {-173, 136}}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(rightAtrialInletResistance.q_out, rightAtrium.q_in) annotation(
          Line(points = {{-194, -102}, {-211, -102}, {-211, -49}}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(tricuspidValve.q_in, rightAtrium.q_in) annotation(
          Line(points = {{-219, -16}, {-216, -16}, {-216, -49}, {-211, -49}}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(aorticResistance.q_in, aorticValve.q_out) annotation(
          Line(points = {{210, -82}, {225, -82}, {225, -52}}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(pulmonaryArterialInertia.q_out, extrathoracicArterialResistance.q_in) annotation(
          Line(points = {{139, -180}, {121, -180}, {121, -207}, {126, -207}}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(tricuspidValve.q_out, tricuspidResistance.q_in) annotation(
          Line(points = {{-216, 14}, {-218, 14}, {-218, 34}, {-218, 34}}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
        connect(pulmonaryValve.q_out, pulmonaryArterialResistance.q_in) annotation(
          Line(points = {{-171, 166}, {-143.5, 166}, {-143.5, 190}}, thickness = 0.75, arrow = {Arrow.None, Arrow.Open}));
      connect(altitude.P_partial_O2, altitudeOxygenModel.ambientOxygenPartialPressure) annotation(
          Line(points = {{-90, 260}, {-76, 260}, {-76, 263}, {-60, 263}, {-60, 266}}, color = {0, 85, 0}));
      connect(pulmonaryArteries.O2_current, altitudeOxygenModel.O2_PA) annotation(
          Line(points = {{-82, 234}, {-60, 234}, {-60, 258}}, color = {85, 255, 0}));
      connect(altitudeOxygenModel.O2_inPAB, pulmonaryPeripheralResistance.oxygen) annotation(
          Line(points = {{-40, 262}, {0, 262}, {0, 240}}, color = {85, 255, 0}));
        annotation(
          Diagram(coordinateSystem(extent = {{-260, -330}, {260, 290}}, preserveAspectRatio = false)),
          Icon(coordinateSystem(extent = {{-260, -330}, {260, 290}}, preserveAspectRatio = false)),
          Documentation(info = "<html><head></head><body><p>This model analyzes the effect of adequate moment of umbilical cord clamping on the adaptation of the healthy term newborn to extrauterine life.
      </p>
      </body></html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
      end FetalToNeonatal_Transition;
      annotation(
        Icon(graphics = {Rectangle(lineColor = {170, 255, 255}, fillColor = {248, 248, 248}, fillPattern = FillPattern.VerticalCylinder, extent = {{-100, -100}, {100, 100}}, radius = 25), Bitmap(origin = {1, 9}, extent = {{-83, 73}, {83, -73}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/scenario_fetus.svg")}),
        Documentation(info = "<html>
    <p>
    Physiological models of the Fetus
    </p>
    </html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
    end Fetus;
    annotation(
      Icon(graphics = {Rectangle(lineColor = {129, 61, 156}, fillColor = {248, 248, 248}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, -100}, {100, 100}}, radius = 25), Bitmap(origin = {4, -4}, extent = {{-70, 72}, {70, -72}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/package_scenarios.svg")}),
      Documentation(info = "<html>
  <p>
  This package contains all the physiological scenarios tested in the library.
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
  end Scenarios;

  package Connectors
    connector Base_connector
      Types.Pressure pressure "Blood pressure";
      flow Types.VolumeFlowRate q "Blood flow";
      stream Types.Concentration conc "Oxygen concentration";
      annotation(
        Documentation(revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>", info = "<html>
    <p>This connector enables the connection between two components. The oxygen concentration and pressure are identical in each connector that is interconnected. Furthermore, the total flow in the interconnected connectors adds up to zero.</p>
    </html>"),
        Icon(graphics = {Ellipse(fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
    end Base_connector;

    connector Input_Connector
      extends Base_connector;
      annotation(
        defaultComponentName = "Input_port",
        Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(fillColor = {0, 170, 127}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}),
        Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(origin = {12, -12}, extent = {{-112, 118}, {88, 58}}, textString = "%name"), Ellipse(fillColor = {0, 170, 127}, fillPattern = FillPattern.Solid, extent = {{-48, 48}, {48, -48}})}),
        Documentation(info = "<html>
    <p>
    Represents an input connection with a single flow signal.
    </p>
    </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));
    end Input_Connector;

    connector Output_connector
      extends Base_connector;
      annotation(
        defaultComponentName = "Output_port",
        Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(fillColor = {170, 170, 127}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}),
        Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(origin = {12, -12}, extent = {{-112, 118}, {88, 58}}, textString = "%name"), Ellipse(fillColor = {170, 170, 127}, fillPattern = FillPattern.Solid, extent = {{-48, 48}, {48, -48}})}),
        Documentation(info = "<html>
    <p>
    A connection featuring a single Real-type flow signal.
    </p>
    </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));
    end Output_connector;

    connector VolumeFlowRateInput = input Real "input VolumeFlowRate as connector" annotation(
      defaultComponentName = "volumeflowrate",
      Icon(graphics = {Polygon(lineColor = {0, 170, 255}, fillColor = {0, 170, 255}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.2)),
      Diagram(coordinateSystem(preserveAspectRatio = true, initialScale = 0.2, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {0, 170, 255}, fillColor = {0, 170, 255}, fillPattern = FillPattern.Solid, points = {{0, 50}, {100, 0}, {0, -50}, {0, 50}}), Text(textColor = {0, 0, 127}, extent = {{-10, 85}, {-10, 60}}, textString = "%name")}),
      Documentation(info = "<html>
        <p>
        Connector featuring a single input signal designated as VolumeFlowRate.
        </p>
        </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));
    connector VolumeFlowRateOutput = output Real "output VolumeFlowRate as connector" annotation(
      defaultComponentName = "volumeflowrate",
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}),
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 50}, {0, 0}, {-100, -50}, {-100, 50}}), Text(textColor = {0, 0, 127}, extent = {{30, 110}, {30, 60}}, textString = "%name")}),
      Documentation(info = "<html>
      <p>
      Connector featuring a single input signal designated as VolumeFlowRate.
      </p>
      </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));
    connector ConcentrationInput = input Real "input Concentration as connector" annotation(
      defaultComponentName = "concentration",
      Icon(graphics = {Polygon(points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}}, lineColor = {0, 0, 127}, fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid)}, coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.2)),
      Diagram(coordinateSystem(preserveAspectRatio = true, initialScale = 0.2, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(points = {{0, 50}, {100, 0}, {0, -50}, {0, 50}}, lineColor = {0, 0, 127}, fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid), Text(extent = {{-10, 85}, {-10, 60}}, lineColor = {0, 0, 127}, textString = "%name")}),
      Documentation(info = "<html>
        <p>
        Connector featuring a single input signal designated as Concentration.
        </p>
        </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));
    connector ConcentrationOutput = output Real "output Concentration as connector" annotation(
      defaultComponentName = "concentration",
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}),
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 50}, {0, 0}, {-100, -50}, {-100, 50}}), Text(textColor = {0, 0, 127}, extent = {{30, 110}, {30, 60}}, textString = "%name")}),
      Documentation(info = "<html>
      <p>
      Connector featuring a single input signal designated as Concentration.
      </p>
      </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));

    class Ports_Connector
      Input_Connector q_in  annotation(
        Placement(transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}})));
      Output_connector q_out  annotation(
        Placement(transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}})));
      Types.VolumeFlowRate volumeFlowRate ;
      Types.Pressure dp;
    equation
      q_in.q + q_out.q = 0;
      volumeFlowRate = q_in.q;
      dp = q_in.pressure - q_out.pressure;
      annotation(
        defaultComponentName = "Pair of connectors",
        Documentation(info = "<html>
    <p>
    This connector represents an input and an output connector.
    </p>
    </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));
    end Ports_Connector;

    connector PressureOutput = output Types.Pressure "output Pressure as connector" annotation(
      defaultComponentName = "pressure",
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {0, 85, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}),
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {0, 85, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 50}, {0, 0}, {-100, -50}, {-100, 50}}), Text(textColor = {0, 0, 127}, extent = {{30, 110}, {30, 60}}, textString = "%name")}),
      Documentation(info = "<html>
      <p>
      Connector featuring a single output Pressure signal.
      </p>
      </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));
    connector PressureInput = input Types.Pressure "input Pressure as connector" annotation(
      defaultComponentName = "pressure",
      Icon(graphics = {Polygon(lineColor = {0, 85, 0}, fillColor = {0, 85, 0}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.2)),
      Diagram(coordinateSystem(preserveAspectRatio = true, initialScale = 0.2, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {0, 85, 0}, fillColor = {0, 85, 0}, fillPattern = FillPattern.Solid, points = {{0, 50}, {100, 0}, {0, -50}, {0, 50}}), Text(textColor = {0, 0, 127}, extent = {{-10, 85}, {-10, 60}}, textString = "%name")}),
      Documentation(info = "<html>
      <p>
      Connector featuring a single input Pressure signal.
      </p>
      </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));
    connector OxygenFlowInput = input Types.Concentration "input Concentration as connector" annotation(
      defaultComponentName = "volumeflowrate",
      Icon(graphics = {Polygon(lineColor = {0, 255, 0}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}, coordinateSystem(initialScale = 0.2)),
      Diagram(coordinateSystem(initialScale = 0.2, grid = {1, 1}), graphics = {Polygon(lineColor = {85, 255, 0}, fillColor = {85, 255, 127}, fillPattern = FillPattern.Solid, points = {{0, 50}, {100, 0}, {0, -50}, {0, 50}}), Text(lineColor = {0, 0, 127}, extent = {{-10, 85}, {-10, 60}}, textString = "%name")}),
      Documentation(info = "<html>
      <p>
      Connector featuring a single input Oxygen signal.
      </p>
      </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));
    connector OxygenFlowOutput = output Types.Concentration "Output Concentration as connector" annotation(
      defaultComponentName = "volumeflowrate",
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {85, 255, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}),
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {85, 255, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 50}, {0, 0}, {-100, -50}, {-100, 50}}), Text(textColor = {0, 0, 127}, extent = {{30, 110}, {30, 60}}, textString = "%name")}),
      Documentation(info = "<html>
      <p>
      Connector featuring a single output Oxygen signal.
      </p>
      </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));
    connector ConductanceInput = input Types.Conductance "input Conductance as connector" annotation(
      defaultComponentName = "Conductance",
      Icon(graphics = {Polygon(lineColor = {170, 0, 255}, fillColor = {170, 0, 255}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.2)),
      Diagram(coordinateSystem(preserveAspectRatio = true, initialScale = 0.2, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {170, 0, 255}, fillColor = {170, 0, 255}, fillPattern = FillPattern.Solid, points = {{0, 50}, {100, 0}, {0, -50}, {0, 50}}), Text(textColor = {0, 0, 127}, extent = {{-10, 85}, {-10, 60}}, textString = "%name")}),
      Documentation(info = "<html>
      <p>
      Connector featuring a single Input Hydraulic signal.
      </p>
      </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));
    connector ConductanceOutput = output Types.Conductance "output Conductance as connector" annotation(
      defaultComponentName = "Conductance",
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {170, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}),
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {170, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 50}, {0, 0}, {-100, -50}, {-100, 50}}), Text(textColor = {0, 0, 127}, extent = {{30, 110}, {30, 60}}, textString = "%name")}),
      Documentation(info = "<html>
      <p>
      Connector featuring a single Output Hydraulic signal.
      </p>
      </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));
    connector VolumeInput = input Types.Volume "input Volume as connector" annotation(
      defaultComponentName = "volume",
      Icon(graphics = {Polygon(lineColor = {170, 170, 255}, fillColor = {170, 170, 255}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.2)),
      Diagram(coordinateSystem(preserveAspectRatio = true, initialScale = 0.2, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {170, 170, 255}, fillColor = {170, 170, 255}, fillPattern = FillPattern.Solid, points = {{0, 50}, {100, 0}, {0, -50}, {0, 50}}), Text(textColor = {0, 0, 127}, extent = {{-10, 85}, {-10, 60}}, textString = "%name")}),
      Documentation(info = "<html>
      <p>
      Connector featuring a single Input Volume signal.
      </p>
      </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));
    connector VolumeOutput = output Types.Volume "output Volume as connector" annotation(
      defaultComponentName = "volume",
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {170, 170, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}),
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {170, 170, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 50}, {0, 0}, {-100, -50}, {-100, 50}}), Text(textColor = {0, 0, 127}, extent = {{30, 110}, {30, 60}}, textString = "%name")}),
      Documentation(info = "<html>
      <p>
      Connector featuring a single Output Volume signal.
      </p>
      </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));
    connector ComplianceInput = input Types.Compliance "input Compliance as connector" annotation(
      defaultComponentName = "Compliance",
      Icon(graphics = {Polygon(lineColor = {0, 255, 255}, fillColor = {0, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.2)),
      Diagram(coordinateSystem(preserveAspectRatio = true, initialScale = 0.2, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {0, 255, 255}, fillColor = {0, 255, 255}, fillPattern = FillPattern.Solid, points = {{0, 50}, {100, 0}, {0, -50}, {0, 50}}), Text(textColor = {0, 0, 127}, extent = {{-10, 85}, {-10, 60}}, textString = "%name")}),
      Documentation(info = "<html>
      <p>
      Connector featuring a single Input Hydraulic signal.
      </p>
      </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));
    connector ComplianceOutput = output Types.Compliance "output Compliance as connector" annotation(
      defaultComponentName = "Compliance",
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {0, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}),
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {0, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 50}, {0, 0}, {-100, -50}, {-100, 50}}), Text(textColor = {0, 0, 127}, extent = {{30, 110}, {30, 60}}, textString = "%name")}),
      Documentation(info = "<html>
      <p>
      Connector featuring a single Output Hydraulic signal.
      </p>
      </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));
    connector FrequencyInput = input Types.Frequency "input Frequency as connector" annotation(
      defaultComponentName = "frequency",
      Icon(graphics = {Polygon(lineColor = {170, 170, 0}, fillColor = {170, 170, 0}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.2)),
      Diagram(coordinateSystem(preserveAspectRatio = true, initialScale = 0.2, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {170, 170, 0}, fillColor = {170, 170, 0}, fillPattern = FillPattern.Solid, points = {{0, 50}, {100, 0}, {0, -50}, {0, 50}}), Text(textColor = {0, 0, 127}, extent = {{-10, 85}, {-10, 60}}, textString = "%name")}),
      Documentation(info = "<html>
      <p>
      Connector featuring a single Input Frequency signal.
      </p>
      </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));
    connector FrequencyOutput = output Types.Frequency "output Frequency as connector" annotation(
      defaultComponentName = "frequency",
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {170, 170, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}),
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {170, 170, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 50}, {0, 0}, {-100, -50}, {-100, 50}}), Text(textColor = {0, 0, 127}, extent = {{30, 110}, {30, 60}}, textString = "%name")}),
      Documentation(info = "<html>
      <p>
      Connector featuring a single Output Frequency signal.
      </p>
      </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));
    connector TimeOutput = output Types.Time "output Time as connector" annotation(
      defaultComponentName = "time",
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {255, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}),
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {255, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 50}, {0, 0}, {-100, -50}, {-100, 50}}), Text(textColor = {0, 0, 127}, extent = {{30, 110}, {30, 60}}, textString = "%name")}),
      Documentation(info = "<html>
      <p>
      Connector featuring a single Output Time signal.
      </p>
      </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));
    connector TimeInput = input Types.Time "input Time as connector" annotation(
      defaultComponentName = "time",
      Icon(graphics = {Polygon(lineColor = {255, 0, 127}, fillColor = {255, 0, 127}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.2)),
      Diagram(coordinateSystem(preserveAspectRatio = true, initialScale = 0.2, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Polygon(lineColor = {255, 0, 127}, fillColor = {255, 0, 127}, fillPattern = FillPattern.Solid, points = {{0, 50}, {100, 0}, {0, -50}, {0, 50}}), Text(textColor = {0, 0, 127}, extent = {{-10, 85}, {-10, 60}}, textString = "%name")}),
      Documentation(info = "<html>
      <p>
      Connector featuring a single Input Time signal.
      </p>
      </html>", revisions = "<html>
        <table>
        <tr>
        <td>Authors:</td>
        <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
        <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
        <td> Leonardo Bermeo Clavijo (2)</td>
        </tr>
        <tr>
        <td>Copyright:</td>
        <td>In public domains</td>
        </tr>
        <tr>
        <td>By:</td>
        <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
        <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
        </tr>
        <tr>
        <td>Last revision:</td>
        <td>October 2023</td>
        </tr>
        </table>
        </html>"));
    annotation(
      Icon(graphics = {Rectangle(fillColor = {85, 255, 255}, fillPattern = FillPattern.Sphere, extent = {{-100, -100}, {100, 100}}, radius = 25), Bitmap(origin = {0, -1}, extent = {{-82, 81}, {82, -81}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/package_connectors.svg")}),
      Documentation(info = "<html>
  <p>
  This package contains all the connectors used in the physiological components.
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
  end Connectors;

  package Functions
    function H
      input Modelica.SIunits.Concentration O2_Hb;
      input Modelica.SIunits.Concentration Conc_O2;
      input Modelica.SIunits.Pressure PO2_50;
      output Real H_O2;
    algorithm
      H_O2 := PO2_50*(((Conc_O2)/(O2_Hb - Conc_O2))^(1/2.7));
      annotation(
        Icon(graphics = {Text(origin = {12, 36}, extent = {{-112, 118}, {88, 58}}, textString = "%name"), Text(origin = {-1, 3}, extent = {{-85, -83}, {85, 83}}, textString = "f"), Ellipse(fillColor = {255, 218, 8}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-1, 3}, extent = {{-85, -83}, {85, 83}}, textString = "f")}),
        Documentation(info = "<html>
    <p>
    Hill function
    </p>
    </html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
    end H;

    function H_1
      input Modelica.SIunits.Concentration O2_Hb;
      input Real HO2;
      input Modelica.SIunits.Pressure PO2_50;
      output Modelica.SIunits.Concentration O2;
    algorithm
      O2 := ((O2_Hb)*(((HO2)/(PO2_50))^2.7))/(((((HO2)/(PO2_50))^2.7)) + (1));
      annotation(
        Icon(graphics = {Text(origin = {12, 36}, extent = {{-112, 118}, {88, 58}}, textString = "%name"), Text(origin = {-1, 3}, extent = {{-85, -83}, {85, 83}}, textString = "f"), Ellipse(fillColor = {255, 218, 8}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-1, 3}, extent = {{-85, -83}, {85, 83}}, textString = "f")}),
        Documentation(info = "<html>
    <p>
    Inverse Hill function
    </p>
    </html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
    end H_1;

    function Placental_function
      extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
      input Real r "Ventilation-Perfusion Ratio";
      input Modelica.SIunits.Concentration O2_U "Uterine Concentration";
      input Real Gamma "Diffusion efficiency";
      input Modelica.SIunits.Concentration O2_PLAC   ;
      input Modelica.SIunits.Concentration O2_Hb_fetal   ;
      input Modelica.SIunits.Concentration O2_Hb_placental   ;
      input Modelica.SIunits.Pressure PO2_50   ;
    protected
      Real a, b, c, d;
    algorithm
      a := r*O2_U;
      b := (H(O2_Hb_fetal, (O2_PLAC + u), PO2_50)/Gamma);
      c := (((1 - Gamma)*(H(O2_Hb_fetal, O2_PLAC, PO2_50)))/Gamma);
      d := (r*H_1(O2_Hb_placental, (b + c), PO2_50));
      y := u - a + d;
      annotation(
        Icon(graphics = {Text(origin = {12, 36}, extent = {{-112, 118}, {88, 58}}, textString = "%name"), Text(origin = {-1, 3}, extent = {{-85, -83}, {85, 83}}, textString = "f"), Ellipse(fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-1, 3}, extent = {{-85, -83}, {85, 83}}, textString = "f")}),
        Documentation(info = "<html>
  <p>
  Placental Function
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
    end Placental_function;

    function Pulmonary_function
      extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
      input Real r "Ventilation-Perfusion Ratio";
      input Modelica.SIunits.Concentration O2_i "Uterine Concentration";
      input Real Gamma "Diffusion efficiency";
      input Modelica.SIunits.Concentration O2_PA   ;
      input Modelica.SIunits.Concentration O2_Hb_fetal   ;
      input Modelica.SIunits.Pressure PO2_50   ;
      input Real T;
      input Real K;
    protected
      Real a, b, c;
    algorithm
      a := r*O2_i;
      b := r*((H(O2_Hb_fetal, (O2_PA + u), PO2_50)/(Gamma*K*T)));
      c := r*((((1 - Gamma)*(H(O2_Hb_fetal, O2_PA, PO2_50)))/(Gamma*K*T)));
      y := u - a + b - c;
      annotation(
        Icon(graphics = {Text(origin = {12, 36}, extent = {{-112, 118}, {88, 58}}, textString = "%name"), Text(origin = {-1, 3}, extent = {{-85, -83}, {85, 83}}, textString = "f"), Ellipse(fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-1, 3}, extent = {{-85, -83}, {85, 83}}, textString = "f")}),
        Documentation(info = "<html>
  <p>
  Pulmonary Function
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
    end Pulmonary_function;

    function Pulmonary_function_2
      input Real r "Ventilation-Perfusion Ratio";
      input Modelica.SIunits.Concentration O2_i "Uterine Concentration";
      input Real H_O2_PA_PAB;
      input Real Gamma "Diffusion efficiency";
      input Real K;
      input Modelica.SIunits.Temperature T;
      input Real H_O2_PA;
      output Real O2_inPAB "Incoming oxygen";
    algorithm
      O2_inPAB := r*O2_i - r*(H_O2_PA_PAB/(Gamma*K*T)) + r*((1 - Gamma)*H_O2_PA/(Gamma*K*T));
      annotation(
        Icon(graphics = {Text(origin = {12, 36}, extent = {{-112, 118}, {88, 58}}, textString = "%name"), Text(origin = {-1, 3}, extent = {{-85, -83}, {85, 83}}, textString = "f"), Ellipse(fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-1, 3}, extent = {{-85, -83}, {85, 83}}, textString = "f")}),
        Documentation(info = "<html>
  <p>
  Pulmonary Function
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
    end Pulmonary_function_2;
    annotation(
      Icon(graphics = {Ellipse(fillColor = {255, 170, 127}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-1, 3}, extent = {{-85, -83}, {85, 83}}, textString = "f")}),
      Documentation(info = "<html>
  <p>
  This package contains all the mathematical functions used for pulmonary and placental respiration.
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
  end Functions;

  package Signals
    package Ventricular_Elastances
      model Ventricular_signal_1
        parameter Types.Elastance ELVMIN "Diastolic Elastance";
        parameter Types.Elastance ELVMAX "Systolic Elastance";
        parameter Types.Frequency HR "Heart rate";
        discrete Types.Time HP "heart period";
        discrete Types.Time t0 "time of beginning of the cardiac cycle";
        Real EN;
        Types.Time tm "relative time from the beginning of cardiac cycle";
        Connectors.ComplianceOutput C annotation(
          Placement(transformation(extent = {{-4, -102}, {16, -82}}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, -90})));
        Types.Elastance E;
      equation
        tm = (time - t0);
        EN = 1.67*(((tm*HR/0.303)^1.32)/(1 + ((tm*HR/0.303)^1.32)))*(1/(1 + ((tm*HR/0.508)^21.9)));
        E = (ELVMAX - ELVMIN)*EN + ELVMIN;
        C = 1/E;
        when {initial(), tm >= pre(HP)} then
          HP = 1/HR;
          t0 = time;
        end when;
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}, color = {0, 0, 255}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}, color = {0, 0, 255}), Text(lineColor = {0, 0, 255}, extent = {{-70, 98}, {-22, 80}}, textString = "HR"), Text(lineColor = {0, 0, 255}, extent = {{-74, -40}, {40, -80}}, textString = "Et"), Text(lineColor = {0, 0, 255}, extent = {{42, -40}, {100, -80}}, textString = "Pi"), Text(origin = {-10, 136}, lineColor = {0, 0, 255}, extent = {{-272, 16}, {276, -40}}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Ventricular Signal
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end Ventricular_signal_1;

      model Ventricular_signal_2
        parameter Types.Elastance ELVMIN "Diastolic Elastance";
        parameter Types.Elastance ELVMAX "Systolic Elastance";
        parameter Types.Frequency HR "Heart rate";
        discrete Types.Time HP "heart period";
        discrete Types.Time t0 "time of beginning of the cardiac cycle";
        discrete Types.Time tvs "duration of systole";
        discrete Types.Time DeltaT "atrioventricular delay";
        Real a;
        Real PI = Modelica.Constants.pi;
        Modelica.SIunits.Time tm "relative time from the beginning of cardiac cycle";
        Types.Elastance E;
        Connectors.ComplianceOutput C annotation(
          Placement(transformation(extent = {{-4, -102}, {16, -82}}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, -90})));
      equation
        tm = time - t0;
        if tm >= (DeltaT) and tm < (DeltaT + tvs) then
          a = sin(PI*(tm - (DeltaT))/tvs);
        else
          a = 0;
        end if;
        E = ELVMIN + (ELVMAX - ELVMIN)*(a^2);
        C = 1/E;
        when {initial(), tm >= pre(HP)} then
          HP = 1/HR;
          t0 = time;
          tvs = 0.16 + 0.3*HP;
          DeltaT = 0.02*HP;
        end when;
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}, color = {0, 0, 255}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}, color = {0, 0, 255}), Text(lineColor = {0, 0, 255}, extent = {{-70, 98}, {-22, 80}}, textString = "HR"), Text(lineColor = {0, 0, 255}, extent = {{-74, -40}, {40, -80}}, textString = "Et"), Text(lineColor = {0, 0, 255}, extent = {{42, -40}, {100, -80}}, textString = "Pi"), Text(origin = {-4, 134}, lineColor = {0, 0, 255}, extent = {{-272, 16}, {276, -40}}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Ventricular Signal
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end Ventricular_signal_2;

      model Ventricular_signal_3
        parameter Types.Elastance EMIN ;
        parameter Types.Elastance EMAX ;
        discrete Types.Time tas;
        constant Real Kn = 0.57923032735652;
        Types.Time tm "relative time from the beginning of cardiac cycle";
        discrete Types.Time HP "heart period";
        discrete Types.Time t0 "time of beginning of the cardiac cycle";
        discrete Types.Time tvs "duration of systole";
        parameter Types.Time tav(displayUnit = "s") = 0.01 "atrioventricular delay";
        Real a;
        Types.Elastance E;
        Connectors.ComplianceOutput C annotation(
          Placement(transformation(extent = {{-4, -102}, {16, -82}}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, -90})));
        Connectors.FrequencyInput HR "heart rate" annotation(
          Placement(transformation(extent = {{-106, 56}, {-66, 96}}), iconTransformation(extent = {{-106, 56}, {-66, 96}})));
      equation
        tm = time - t0;
        if tm >= (tas + tav) and tm < (tas + tav + tvs) then
          a = (tm - (tas + tav))/(tvs*Kn)*sin(Modelica.Constants.pi*(tm - (tas + tav))/tvs);
        else
          a = 0;
        end if;
        E = EMIN + (EMAX - EMIN)*a;
        C = 1/E;
        when {initial(), tm >= pre(HP)} then
          HP = 1/HR;
          t0 = time;
          tvs = 0.16 + 0.2*HP;
          tas = 0.03 + 0.09*HP "duration of atrial systole";
        end when;
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}, color = {0, 0, 255}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}, color = {0, 0, 255}), Text(extent = {{-70, 98}, {-22, 80}}, lineColor = {0, 0, 255}, textString = "HR"), Text(extent = {{-74, -40}, {40, -80}}, lineColor = {0, 0, 255}, textString = "Et"), Text(extent = {{42, -40}, {100, -80}}, lineColor = {0, 0, 255}, textString = "Pi"), Text(extent = {{-272, 16}, {276, -40}}, lineColor = {0, 0, 255}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Ventricular Signal
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end Ventricular_signal_3;
      annotation(
        Icon(graphics = {Bitmap(origin = {1, -3}, rotation = 180, extent = {{-93, 103}, {93, -103}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/signals_ventricular_elastances.svg")}),
        Documentation(info = "<html>
    <p>
    Ventricular Elastances
    </p>
    </html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
    end Ventricular_Elastances;

    package Atrial_Elastances
      model Atrial_signal_1
        parameter Types.Elastance ELAMIN "Diastolic Elastance";
        parameter Types.Elastance ELAMAX "Systolic Elastance";
        parameter Types.Frequency HR "Heart rate";
        discrete Types.Time HP "heart period";
        discrete Types.Time t0 "time of beginning of the cardiac cycle";
        Real EN;
        Types.Time tm "relative time from the beginning of cardiac cycle";
        Connectors.ComplianceOutput C annotation(
          Placement(transformation(extent = {{-4, -102}, {16, -82}}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, -90})));
        Types.Elastance E;
      equation
        tm = (time - t0);
        EN = 2.70*(((tm*HR/0.303)^1.32)/(1 + ((tm*HR/0.303)^1.32)))*(1/(1 + ((tm*HR/0.25)^21.9)));
        E = (ELAMAX - ELAMIN)*EN + ELAMIN;
        C = 1/E;
        when {initial(), tm >= pre(HP)} then
          HP = 1/HR;
          t0 = time;
        end when;
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}, color = {0, 0, 255}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}, color = {0, 0, 255}), Text(lineColor = {0, 0, 255}, extent = {{-70, 98}, {-22, 80}}, textString = "HR"), Text(lineColor = {0, 0, 255}, extent = {{-74, -40}, {40, -80}}, textString = "Et"), Text(lineColor = {0, 0, 255}, extent = {{42, -40}, {100, -80}}, textString = "Pi"), Text(origin = {-2, 138}, lineColor = {0, 0, 255}, extent = {{-272, 16}, {276, -40}}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Atrial Signal
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end Atrial_signal_1;

      model Atrial_signal_2
        parameter Types.Elastance ELAMIN "Diastolic Elastance";
        parameter Types.Elastance ELAMAX "Systolic Elastance";
        parameter Types.Frequency HR "Heart rate";
        discrete Types.Time HP "heart period";
        discrete Types.Time t0 "time of beginning of the cardiac cycle";
        discrete Types.Time tas "duration of systole";
        Real a;
        Real PI = Modelica.Constants.pi;
        Modelica.SIunits.Time tm "relative time from the beginning of cardiac cycle";
        Types.Elastance E;
        Connectors.ComplianceOutput C annotation(
          Placement(transformation(extent = {{-4, -102}, {16, -82}}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, -90})));
      equation
        tm = time - t0;
        if (0 <= tm and tm < tas) then
          a = sin(PI*((tm)/tas));
        else
          a = 0;
        end if;
        E = ELAMIN + (ELAMAX - ELAMIN)*(a^2);
        C = 1/E;
        when {initial(), tm >= pre(HP)} then
          HP = 1/HR;
          t0 = time;
          tas = 0.3*HP;
        end when;
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}, color = {0, 0, 255}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}, color = {0, 0, 255}), Text(lineColor = {0, 0, 255}, extent = {{-70, 98}, {-22, 80}}, textString = "HR"), Text(lineColor = {0, 0, 255}, extent = {{-74, -40}, {40, -80}}, textString = "Et"), Text(lineColor = {0, 0, 255}, extent = {{42, -40}, {100, -80}}, textString = "Pi"), Text(origin = {-8, 136}, lineColor = {0, 0, 255}, extent = {{-272, 16}, {276, -40}}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Atrial Signal
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end Atrial_signal_2;

      model Atrial_signal_3
        parameter Types.Elastance EMIN ;
        parameter Types.Elastance EMAX ;
        Types.Time tm "relative time from the beginning of cardiac cycle";
        discrete Types.Time HP "heart period";
        discrete Types.Time t0 "time of beginning of the cardiac cycle";
        discrete Types.Time tas "duration of systole";
        Real a;
        Connectors.ComplianceOutput C annotation(
          Placement(transformation(extent = {{-4, -102}, {16, -82}}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, -90})));
        Types.Elastance E;
        Connectors.FrequencyInput HR "heart rate" annotation(
          Placement(transformation(extent = {{-106, 56}, {-66, 96}}), iconTransformation(extent = {{-106, 56}, {-66, 96}})));
      equation
        tm = time - t0;
        if (0 <= tm and tm < tas) then
          a = sin(Modelica.Constants.pi*((tm)/tas));
        else
          a = 0;
        end if;
        E = EMIN + (EMAX - EMIN)*a;
        C = 1/E;
        when {initial(), tm >= pre(HP)} then
          HP = 1/HR;
          t0 = time;
          tas = 0.03 + 0.09*HP;
        end when;
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}, color = {0, 0, 255}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}, color = {0, 0, 255}), Text(extent = {{-70, 98}, {-22, 80}}, lineColor = {0, 0, 255}, textString = "HR"), Text(extent = {{-74, -40}, {40, -80}}, lineColor = {0, 0, 255}, textString = "Et"), Text(extent = {{42, -40}, {100, -80}}, lineColor = {0, 0, 255}, textString = "Pi"), Text(extent = {{-272, 16}, {276, -40}}, lineColor = {0, 0, 255}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Atrial Signal
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end Atrial_signal_3;
      annotation(
        Icon(graphics = {Bitmap(origin = {1, -3}, rotation = 180, extent = {{-93, 103}, {93, -103}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/signals_atrial_elastances.svg")}, coordinateSystem(extent = {{-100, 100}, {100, -120}})),
        Documentation(info = "<html>
    <p>
    Atrial Elastances
    </p>
    </html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
    end Atrial_Elastances;

    package Vascular_Resistance
      model Right_Atrial_Resistance
        Real n = -6.931;
        Real euler = Modelica.Constants.e;
        parameter Types.Conductance Co = 6.251e-06 ;
        parameter Types.Conductance Cf = 6.251e-08 ;
        Types.Time tao;
        Connectors.ConductanceOutput C annotation(
          Placement(transformation(extent = {{-4, -102}, {16, -82}}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, -90})));
        Types.Resistance R;
        Types.Resistance Ro;
        Types.Resistance Rf;
      equation
        Ro = 1/(Co/1.25013e-07);
        Rf = 1/(Cf/1.25013e-07);
        tao = 10*60;
        R = (1 + ((Rf/Ro) - 1)*euler^(-n*(time/tao)))/Rf;
        C = (1/R)*1.25013e-07;
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}, color = {0, 0, 255}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}, color = {0, 0, 255}), Text(lineColor = {0, 0, 255}, extent = {{-70, 98}, {-22, 80}}, textString = "HR"), Text(lineColor = {0, 0, 255}, extent = {{-74, -40}, {40, -80}}, textString = "Et"), Text(lineColor = {0, 0, 255}, extent = {{42, -40}, {100, -80}}, textString = "Pi"), Text(origin = {-2, 136}, lineColor = {0, 0, 255}, extent = {{-272, 16}, {276, -40}}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Right Atrial Resistance
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end Right_Atrial_Resistance;

      model Left_Atrial_Resistance
        Real n = -6.931;
        Real euler = Modelica.Constants.e;
        parameter Types.Conductance Co = 1 ;
        parameter Types.Conductance Cf = 1 ;
        Types.Time tao;
        Connectors.ConductanceOutput C annotation(
          Placement(transformation(extent = {{-4, -102}, {16, -82}}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, -90})));
        Types.Resistance R;
        Types.Resistance Ro;
        Types.Resistance Rf;
      equation
        Ro = 1/(Co/1.25013e-07);
        Rf = 1/(Cf/1.25013e-07);
        tao = 10*60;
        R = Rf/(1 + ((Rf/Ro) - 1)*euler^(n*(time/tao)));
        C = (1/R)*1.25013e-07;
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}, color = {0, 0, 255}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}, color = {0, 0, 255}), Text(lineColor = {0, 0, 255}, extent = {{-70, 98}, {-22, 80}}, textString = "HR"), Text(lineColor = {0, 0, 255}, extent = {{-74, -40}, {40, -80}}, textString = "Et"), Text(lineColor = {0, 0, 255}, extent = {{42, -40}, {100, -80}}, textString = "Pi"), Text(origin = {-8, 136}, lineColor = {0, 0, 255}, extent = {{-272, 16}, {276, -40}}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Left Atrial Resistance
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end Left_Atrial_Resistance;

      model Blood_Vessel_Resistance
        Real Diametro;
        Real k;
        parameter Types.Conductance Co = 1 ;
        parameter Types.Conductance Cf = 1 ;
        Connectors.ConductanceOutput C annotation(
          Placement(transformation(extent = {{-4, -102}, {16, -82}}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, -90})));
        Types.Resistance R;
        Types.Resistance Ro;
        Types.Resistance Rf;
        Types.Time tao;
      equation
        Ro = 1/(Co/1.25013e-07);
        Rf = 1/(Cf/1.25013e-07);
        tao = 10*60;
        Diametro = (time)*Ro^(1/4) + (tao - time)*Rf^(1/4);
        k = Ro*Rf*tao^4;
        R = k/(Diametro^4);
        C = (1/R)*1.25013e-07;
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}, color = {0, 0, 255}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}, color = {0, 0, 255}), Text(lineColor = {0, 0, 255}, extent = {{-70, 98}, {-22, 80}}, textString = "HR"), Text(lineColor = {0, 0, 255}, extent = {{-74, -40}, {40, -80}}, textString = "Et"), Text(lineColor = {0, 0, 255}, extent = {{42, -40}, {100, -80}}, textString = "Pi"), Text(origin = {-8, 136}, lineColor = {0, 0, 255}, extent = {{-272, 16}, {276, -40}}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Blood Vessel Resistance
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end Blood_Vessel_Resistance;

      model Left_Atrial_Resistance_2
        Types.Time tm "relative time from the beginning of cardiac cycle";
        Real RLAINo = 3.60;
        Real euler = Modelica.Constants.e;
        Connectors.ConductanceOutput C annotation(
          Placement(transformation(extent = {{-4, -102}, {16, -82}}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, -90})));
        Types.Resistance R;
      equation
        tm = (time)/3600;
        if 0 <= tm and tm <= 2 then
          R = RLAINo*(1 - 0.74*(1 - euler^(-6*tm)));
        elseif 2 < tm and tm <= 24 then
          R = RLAINo*(0.26 - 9.5e-04*(tm - 2));
        else
          R = RLAINo;
        end if;
        C = (1/R)*7.5e-09;
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}, color = {0, 0, 255}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}, color = {0, 0, 255}), Text(extent = {{-70, 98}, {-22, 80}}, lineColor = {0, 0, 255}, textString = "HR"), Text(extent = {{-74, -40}, {40, -80}}, lineColor = {0, 0, 255}, textString = "Et"), Text(extent = {{42, -40}, {100, -80}}, lineColor = {0, 0, 255}, textString = "Pi"), Text(extent = {{-272, 16}, {276, -40}}, lineColor = {0, 0, 255}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Left Atrial Resistance
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end Left_Atrial_Resistance_2;

      model Ductus_Arteriosus_Resistance
        Types.Time tm "relative time from the beginning of cardiac cycle";
        Real Diametro;
        Real euler = Modelica.Constants.e;
        constant Real k = 0.0145;
        Connectors.ConductanceOutput C annotation(
          Placement(transformation(extent = {{-4, -102}, {16, -82}}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, -90})));
        Types.Resistance R;
      equation
        tm = (time)/3600;
        Diametro = (0.29*euler^(-0.43*tm)) + (0.3*euler^(-0.054*tm));
        R = k/(Diametro^4);
        C = (1/R)*(7.5e-09);
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}, color = {0, 0, 255}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}, color = {0, 0, 255}), Text(extent = {{-70, 98}, {-22, 80}}, lineColor = {0, 0, 255}, textString = "HR"), Text(extent = {{-74, -40}, {40, -80}}, lineColor = {0, 0, 255}, textString = "Et"), Text(extent = {{42, -40}, {100, -80}}, lineColor = {0, 0, 255}, textString = "Pi"), Text(extent = {{-272, 16}, {276, -40}}, lineColor = {0, 0, 255}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Ductus Arteriosus Resistance
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end Ductus_Arteriosus_Resistance;

      model Vascular_System_Resistance
        Types.Time tm "relative time from the beginning of cardiac cycle";
        parameter Connectors.TimeInput clampingTime "Clamping";
        Connectors.ConductanceOutput C annotation(
          Placement(transformation(extent = {{-4, -102}, {16, -82}}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, -90})));
        Types.Resistance R;
      equation
        tm = (time)/3600;
        if (clampingTime/3600) <= tm and tm <= 12 then
          R = 0.0846*tm + 3.45;
        elseif 12 < tm and tm <= 24 then
          R = 0.00420*tm + 4.42;
        else
          R = 2.30;
        end if;
        C = (1/R)*7.5e-9;
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}, color = {0, 0, 255}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}, color = {0, 0, 255}), Text(extent = {{-70, 98}, {-22, 80}}, lineColor = {0, 0, 255}, textString = "HR"), Text(extent = {{-74, -40}, {40, -80}}, lineColor = {0, 0, 255}, textString = "Et"), Text(extent = {{42, -40}, {100, -80}}, lineColor = {0, 0, 255}, textString = "Pi"), Text(extent = {{-272, 16}, {276, -40}}, lineColor = {0, 0, 255}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Vascular System Resistance
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end Vascular_System_Resistance;

      model Peripheral_Vessel_Resistance
        Types.Time tm "relative time from the beginning of cardiac cycle";
        Real RPPo = 7.82;
        Real euler = Modelica.Constants.e;
        Connectors.ConductanceOutput C annotation(
          Placement(transformation(extent = {{-4, -102}, {16, -82}}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, -90})));
        Types.Resistance R;
      equation
        tm = (time)/3600;
        if 0 <= tm and tm <= 2 then
          R = RPPo*(1 - 0.74*(1 - euler^(-6*tm)));
        elseif 2 < tm and tm <= 24 then
          R = RPPo*(0.26 - 9.5e-04*(tm - 2));
        else
          R = RPPo;
        end if;
        C = (1/R)*7.5e-09;
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}, color = {0, 0, 255}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}, color = {0, 0, 255}), Text(extent = {{-70, 98}, {-22, 80}}, lineColor = {0, 0, 255}, textString = "HR"), Text(extent = {{-74, -40}, {40, -80}}, lineColor = {0, 0, 255}, textString = "Et"), Text(extent = {{42, -40}, {100, -80}}, lineColor = {0, 0, 255}, textString = "Pi"), Text(extent = {{-272, 16}, {276, -40}}, lineColor = {0, 0, 255}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Peripheral Vessel Resistance
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end Peripheral_Vessel_Resistance;

      model Pulmonary_Vascular_Transition
        Types.Time tao;
        Real n = -6.931;
        Real euler = Modelica.Constants.e;
        Real delaySlope;
        parameter Types.Conductance Co = 6.251e-09 "Co";
        parameter Types.Conductance Cf = 3.251e-06 "Cf";
        parameter Types.Height altitudeAboveSeaLevel = 2400 "msnm";
        Types.Height maximumAltitude "Maximum height";
        Types.Time delay "Delay_Height";
        Types.Time maximumDelay "Delay_Height_Maximo";
        Connectors.ConductanceOutput C annotation(
          Placement(transformation(extent = {{-4, -102}, {16, -82}}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, -90})));
        Types.Resistance R;
        Types.Resistance Ro;
        Types.Resistance Rf;
      equation
        Ro = 1/(Co/1.25013e-07);
        Rf = 1/(Cf/1.25013e-07);
        tao = 10*60;
        maximumDelay = 1.0e-20;
        maximumAltitude = 4000;//Tibet
        delaySlope = (maximumDelay)/(maximumAltitude);
        delay = delaySlope*altitudeAboveSeaLevel;
        R = (Rf/(1 + (Rf/Ro - 1)*euler^(n*((time - delay)/tao))));
        C = 1/R*1.25013e-07;
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}, color = {0, 0, 255}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}, color = {0, 0, 255}), Text(extent = {{-70, 98}, {-22, 80}}, lineColor = {0, 0, 255}, textString = "HR"), Text(extent = {{-74, -40}, {40, -80}}, lineColor = {0, 0, 255}, textString = "Et"), Text(extent = {{42, -40}, {100, -80}}, lineColor = {0, 0, 255}, textString = "Pi"), Text(extent = {{-272, 16}, {276, -40}}, lineColor = {0, 0, 255}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Pulmonar
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end Pulmonary_Vascular_Transition;
      annotation(
        Icon(graphics = {Bitmap(origin = {1, -1}, extent = {{-95, 67}, {95, -67}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/signals_vascular_resistance.svg")}, coordinateSystem(extent = {{-100, 80}, {100, -80}})),
        Documentation(info = "<html>
    <p>
    Vascular Resistances
    </p>
    </html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
    end Vascular_Resistance;

    package Respirations
      model Pulmonary_Respiration
        //---------------------------------
        //---Constants--------------------
        //---------------------------------
        parameter Modelica.SIunits.Temperature T = 298.15 "Body temperature";
        final constant Real K(final unit = "J/(mol.K)") = 8.3144598 "Molar gas constant";
        Real tolerance = 100*Modelica.Constants.eps;
        //---------------------------------
        //---Concentrations---------------
        //---------------------------------
        parameter Modelica.SIunits.MassConcentration Conc_Hb_fetal = 175 "Hemoglobin mass concentration (SI kg/m3; numerically equal to g/L)";
        Modelica.SIunits.Concentration O2_Hb_fetal "Concentration carried by hemoglobin";
        Modelica.SIunits.Concentration O2_i "Uterine oxygen concentration";
        parameter Real Tau_s = 24 "Pulmonary establishment time, typically 24 hours";
        //---------------------------------
        //---Auxiliary variables----------
        //---------------------------------
        Real r, a, b;
        parameter Real Gamma = 1 "Diffusion efficiency";
        //---------------------------------
        //---Pressures---------------------
        //---------------------------------
        parameter Types.Pressure ambientOxygenPartialPressure = 19998.3 "Incoming oxygen pressure";
        parameter Types.Pressure PO2_50 = 2666.44 "Partial pressure of O2 at 50% saturation";
        Connectors.OxygenFlowInput O2_PA annotation(
          Placement(visible = true, transformation(origin = {-120, 32}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-102, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Connectors.OxygenFlowOutput O2_inPAB annotation(
          Placement(visible = true, transformation(origin = {-120, -32}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {102, 4}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        //---------------------------------
        //---Birth time-------------
        //---------------------------------
        parameter Modelica.SIunits.Time t0 = 0 "time of birth";

      equation
//---------------------------------
//---Ventilation-Perfusion Ratio---
//---------------------------------
// t in hours
        if time <= 3600*Tau_s then
          r = 0.7*time/(3600*Tau_s);
        else
          r = 0.7;
        end if;
//---------------------------------
//---Maximum concentration---------
//---------------------------------
        O2_Hb_fetal = Conc_Hb_fetal*1340*(1/(1000*22.4));
//-----------------------------------------
//---Inspired concentration [O2]_{i}-------
//-----------------------------------------
        O2_i = ambientOxygenPartialPressure/(K*T);
//---------------------------------
//---Hill Function-----------------
//---------------------------------
        a = 0;
        b = (O2_Hb_fetal - O2_PA)*0.99;
//is that it is the oxygen concentration in blood that is
//allowed to equilibrate directly with the inspired air,without
//the intervention of the lungs
//---------------------------------
//----O2 concentration intake------
//----of the blood passing the-----
//----pulmonary arterial bed-------
//---------------------------------
        O2_inPAB = Modelica.Math.Nonlinear.solveOneNonlinearEquation(function Functions.Pulmonary_function(r = r, O2_i = O2_i, Gamma = Gamma, O2_PA = O2_PA, O2_Hb_fetal = O2_Hb_fetal, PO2_50 = PO2_50, T = T, K = K), a, b, tolerance);
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}), Text(lineColor = {0, 0, 255}, extent = {{-70, 98}, {-22, 80}}, textString = "HR"), Text(lineColor = {0, 0, 255}, extent = {{-74, -40}, {40, -80}}, textString = "Et"), Text(lineColor = {0, 0, 255}, extent = {{42, -40}, {100, -80}}, textString = "Pi"), Text(origin = {-10, 166}, lineColor = {0, 0, 255}, extent = {{-272, 16}, {276, -40}}, textString = "%name")}),
          Documentation(info = "<html>
      <p>
      Pulmonary Respiration
      </p>
      </html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
      end Pulmonary_Respiration;

      model Placental_Respiration
        //----Constants----
        parameter Modelica.SIunits.Temperature T = 298.15 "Body temperature";
        final constant Real K(final unit = "J/(mol.K)") = 8.3144598 "Molar gas constant";
        Real tolerance = 100*Modelica.Constants.eps;
        //----Concentrations--------
        parameter Modelica.SIunits.MassConcentration Conc_Hb_fetal = 175 "Hemoglobin mass concentration (SI kg/m3; numerically equal to g/L)";
        parameter Modelica.SIunits.MassConcentration Conc_Hb_placental = 120 "Hemoglobin mass concentration (SI kg/m3; numerically equal to g/L)";
        Modelica.SIunits.Concentration O2_Hb_fetal "Concentration carried by hemoglobin";
        Modelica.SIunits.Concentration O2_Hb_placental "Concentration carried by hemoglobin";
        Modelica.SIunits.Concentration O2_U "Uterine oxygen concentration";
        // maternal blood assumed at 85% saturation with 12gr/dl
        Modelica.SIunits.Concentration b;
        Modelica.SIunits.Concentration a;
        //---Auxiliary variables---
        Real r;
        parameter Real Gamma = 0.45 "Diffusion efficiency";
        //---Pressures---
        parameter Types.Pressure ambientOxygenPartialPressure = 13332.2 "Incoming oxygen pressure";
        parameter Types.Pressure PO2_50 = 3546.36 "Partial pressure of O2 at 50% saturation";
        Connectors.OxygenFlowInput O2_PLAC annotation(
          Placement(visible = true, transformation(origin = {-32, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {96, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        Connectors.OxygenFlowOutput O2_inPB annotation(
          Placement(visible = true, transformation(origin = {46, -126}, extent = {{-36, -22}, {-16, -2}}, rotation = -90), iconTransformation(origin = {8, -94}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Connectors.VolumeFlowRateInput Q_PLAC annotation(
          Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180), iconTransformation(origin = {-96, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
//---------------------------------
//------Maximum concentration------
//---------------------------------
                O2_Hb_fetal = Conc_Hb_fetal*1340*(1/(1000*22.4));
                O2_Hb_placental = Conc_Hb_placental*1340*(1/(1000*22.4));
//---------------------------------
//-----Uterine O2 concentration----
//---------------------------------
                O2_U = Functions.H_1(O2_Hb_placental, ambientOxygenPartialPressure, PO2_50);
//---------------------------------
//---Ventilation-Perfusion Ratio---
//---------------------------------
                r = 1e-5/Q_PLAC;
//---------------------------------
//----Integration method limits----
//---------------------------------
//lower limit of the bisection method
                a = 0;
//upper limit of the bisection method
                b = (O2_Hb_fetal - O2_PLAC)*0.99;
//---------------------------------
//------Oxygen that enters---------
//----------the system-------------
//---------------------------------
        O2_inPB = Modelica.Math.Nonlinear.solveOneNonlinearEquation(function Functions.Placental_function(r = r, O2_U = O2_U, Gamma = Gamma, O2_PLAC = O2_PLAC, O2_Hb_fetal = O2_Hb_fetal, O2_Hb_placental = O2_Hb_placental, PO2_50 = PO2_50), a, b, tolerance);
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}), Text(origin = {-44, -164}, lineColor = {0, 0, 255}, extent = {{-70, 98}, {-22, 80}}, textString = "HR"), Text(lineColor = {0, 0, 255}, extent = {{-74, -40}, {40, -80}}, textString = "Et"), Text(lineColor = {0, 0, 255}, extent = {{42, -40}, {100, -80}}, textString = "Pi"), Text(origin = {-6, 122}, lineColor = {0, 0, 255}, extent = {{-272, 16}, {276, -40}}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Placental Respiration
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end Placental_Respiration;

      model Pulmonary_Respiration_2
        parameter Real Gamma_PAB "Diffusion efficiency";
        parameter Types.Pressure PO2_50 "Partial pressure of O2 at 50% ";
        parameter Types.Pressure ambientOxygenPartialPressure "pressure of O2 concentration";
        parameter Types.Mass Conc_Hb "Concentration of Hb in blood in [g Hb/dl]";
        parameter Types.Temperature T "Temperature";
        parameter Modelica.SIunits.Time tm "relative time from the beginning of cardiac cycle";
        parameter Types.Frequency HR "Heart rate";
        discrete Types.Time HP "heart period";
        discrete Types.Time t0 "time of beginning of the cardiac cycle";
        Connectors.ConcentrationOutput O2_inPAB annotation(
          Placement(visible = true, transformation(origin = {52, -124}, extent = {{-36, -22}, {-16, -2}}, rotation = -90), iconTransformation(origin = {-70, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
        Connectors.ConcentrationInput O2_PA annotation(
          Placement(visible = true, transformation(origin = {-40, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {70, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Types.Concentration O2_i "Temperature";
        Real r, K, Tao, a, b, H_PAB, H_PA;
      equation
//---------------------------------
//----Inspired O2 concentration----
//---------------------------------
                O2_i = (ambientOxygenPartialPressure)/(K*T);
//---------------------------------
//---Ventilation-Perfusion Ratio---
//---------------------------------
        tm = time - t0;
        Tao = 1;
        if 0 < tm and tm <= t0 then
          r = 0;
        elseif t0 < tm and tm <= t0 + Tao then
          r = 0.7*((tm - t0)/Tao);
        else
          r = 0.7;
        end if;
//---------------------------------
//----------Hill Function----------
//---------------------------------
        H_PAB = Functions.H(Conc_Hb, O2_inPAB, PO2_50);
        H_PA = Functions.H(Conc_Hb, O2_PA, PO2_50);

        K = 62.3656;
        a = ((H_PAB + H_PA)/(Gamma_PAB*K*T));
        b = ((1 - Gamma_PAB)*H_PAB/(Gamma_PAB*K*T));
        O2_inPAB = (r*O2_i) - (r*a) + (r*b);
        when {initial(), tm >= pre(HP)} then
          HP = 1/HR;
          t0 = time;
        end when;
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}), Text(lineColor = {0, 0, 255}, extent = {{-70, 98}, {-22, 80}}, textString = "HR"), Text(lineColor = {0, 0, 255}, extent = {{-74, -40}, {40, -80}}, textString = "Et"), Text(lineColor = {0, 0, 255}, extent = {{42, -40}, {100, -80}}, textString = "Pi"), Text(lineColor = {0, 0, 255}, extent = {{-272, 16}, {276, -40}}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Pulmonary Respiration
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end Pulmonary_Respiration_2;

      model Placental_Respiration_2
        parameter Real Gamma_PAB(start = 1) "Diffusion efficiency";
        // Diffusion efficiency of respiratory membrane
        parameter Types.Pressure PO2_50(start = 1e-12) "Partial pressure of O2 at 50% ";
        parameter Types.Pressure ambientOxygenPartialPressure(start = 1e-12) "pressure of O2 concentration";
        parameter Types.Mass Conc_Hb(start = 1e-13) "Concentration of Hb in blood in [g Hb/dl]";
        parameter Types.Temperature T(start = 30) "Temperature";

        Connectors.ConcentrationInput O2_PLAC(start = 1e-12) annotation(
          Placement(visible = true, transformation(origin = {-40, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {-54, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Connectors.VolumeFlowRateInput Q_PLAC(start = 1e-12) annotation(
          Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180), iconTransformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Connectors.ConcentrationOutput O2_inPB annotation(
          Placement(visible = true, transformation(origin = {52, -124}, extent = {{-36, -22}, {-16, -2}}, rotation = -90), iconTransformation(origin = {46, -94}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
        Types.Concentration O2_u "Uterine Concentration";
        Real r, Tao, a, b, H_PB_PLAC, H_PLAC, H_M;
        constant Real K = 0.082;
      equation
//---------------------------------
//----Inspired O2 concentration----
//---------------------------------
        O2_u = (ambientOxygenPartialPressure)*(1/H_M);
//---------------------------------
//---Ventilation-Perfusion Ratio---
//---------------------------------
        Tao = 600;
        r = 600/Q_PLAC;
//---------------------------------
//----------Hill Function----------
//---------------------------------
        H_PB_PLAC = H(Conc_Hb, (O2_inPB + O2_PLAC), PO2_50);
        H_PLAC = H(Conc_Hb, O2_PLAC, PO2_50);
        H_M = H(Conc_Hb, O2_u, PO2_50);

        a = (H_PB_PLAC/(Gamma_PAB*K*T));
        b = ((1 - Gamma_PAB)*H_PLAC/(Gamma_PAB*K*T));
        O2_inPB = (r*O2_u) - (r*(1/H_M)*(a + b));
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}), Text(lineColor = {0, 0, 255}, extent = {{-70, 98}, {-22, 80}}, textString = "HR"), Text(lineColor = {0, 0, 255}, extent = {{-74, -40}, {40, -80}}, textString = "Et"), Text(lineColor = {0, 0, 255}, extent = {{42, -40}, {100, -80}}, textString = "Pi"), Text(lineColor = {0, 0, 255}, extent = {{-272, 16}, {276, -40}}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Placental Respiration
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end Placental_Respiration_2;

      model Pulmonary_Respiration_3
        Types.Concentration O2_i "Inspired O2 concentration";
        parameter Real Gamma_PAB = 1 "Diffusion efficiency";
        parameter Types.Pressure ambientOxygenPartialPressure = 150 "pressure of O2 concentration";
        Real K = 1.381e-23;
        //Ideal gases constant
        parameter Types.Temperature T = 310.15 "Temperature";
        //Body temperature
        Real Tao;
        // Transition time
        Real r;
        //Ventilation-Perfusion Ratio
        parameter Types.Time t0 = 30 "time of beginning of the transition";
        Types.Concentration O_AB "Oxygen concentration after inspiring";
        //Oxygen concentration after inspiring
        Connectors.ConcentrationInput O2_PA annotation(
          Placement(visible = true, transformation(origin = {-40, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {70, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Connectors.ConcentrationOutput O2_inPAB annotation(
          Placement(visible = true, transformation(origin = {52, -124}, extent = {{-36, -22}, {-16, -2}}, rotation = -90), iconTransformation(origin = {-70, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
        parameter Types.Mass Conc_Hb = 17.5 "Concentration of Hb in blood in [g Hb/dl]";
        parameter Types.Pressure PO2_50 = 20 "Partial pressure of O2 at 50% ";
        Real H_PAB, H_PA;
        //Variables for Hill function
      equation
//---------------------------------
//----Inspired O2 concentration----
//---------------------------------
        O2_i = (ambientOxygenPartialPressure)/(K*T);
//---------------------------------
//---Ventilation-Perfusion Ratio---
//---------------------------------
        Tao = 10*60;
// 10 minutes
        if time <= t0 then
          r = 0;
        elseif t0 < time and time <= t0 + Tao then
          r = 0.7*((time - t0)/Tao);
        else
          r = 0.7;
        end if;
//---------------------------------
//----------Hill Function----------
//---------------------------------
        O_AB = O2_PA + O2_inPAB;
//Oxygen concentration after inspiring
        H_PAB = H(Conc_Hb, O_AB, PO2_50);
        H_PA = H(Conc_Hb, O2_PA, PO2_50);
//---------------------------------
//------Oxygen that enters---------
//----------the system-------------
//---------------------------------
        O2_inPAB = (r*O2_i) - (r*(H_PAB/(Gamma_PAB*K*T))) + r*(((1 - Gamma_PAB)*H_PA)/(Gamma_PAB*K*T));
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}), Text(lineColor = {0, 0, 255}, extent = {{-70, 98}, {-22, 80}}, textString = "HR"), Text(lineColor = {0, 0, 255}, extent = {{-74, -40}, {40, -80}}, textString = "Et"), Text(lineColor = {0, 0, 255}, extent = {{42, -40}, {100, -80}}, textString = "Pi"), Text(lineColor = {0, 0, 255}, extent = {{-272, 16}, {276, -40}}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Pulmonary Respiration
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end Pulmonary_Respiration_3;

      model Placental_Respiration_3
        Types.Concentration O2_u "Inspired O2 concentration";
        parameter Real Gamma_PAB = 0.45 "Diffusion efficiency";
        parameter Types.Pressure ambientOxygenPartialPressure = 100 "pressure of O2 concentration";
        Real r;
        //Ventilation-Perfusion Ratio
        Types.Concentration O_PB_PLAC "Oxygen concentration after inspiring";
        //Oxygen concentration after inspiring
        Connectors.ConcentrationInput O2_PLAC annotation(
          Placement(visible = true, transformation(origin = {-40, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {70, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Connectors.ConcentrationOutput O2_inPB annotation(
          Placement(visible = true, transformation(origin = {52, -124}, extent = {{-36, -22}, {-16, -2}}, rotation = -90), iconTransformation(origin = {-70, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
        parameter Types.Mass Conc_Hb = 12 "Concentration of Hb in blood in [g Hb/dl]";
        parameter Types.Pressure PO2_50 = 26.6 "Partial pressure of O2 at 50% ";
        Real H_PB_PLAC, H_PLAC, H_M;
        //Variables for Hill function
        Connectors.VolumeFlowRateInput Q_PLAC(start = 1e-12) annotation(
          Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180), iconTransformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
//---------------------------------
//----Inspired O2 concentration----
//---------------------------------
        O2_u = (ambientOxygenPartialPressure)*(1/H_M);
//---------------------------------
//---Ventilation-Perfusion Ratio---
//---------------------------------
        r = 600/Q_PLAC;
//---------------------------------
//----------Hill Function----------
//---------------------------------
        O_PB_PLAC = O2_inPB + O2_PLAC;
//Oxygen concentration after inspiring
        H_PB_PLAC = H(Conc_Hb, O_PB_PLAC, PO2_50);
        H_PLAC = H(Conc_Hb, O2_PLAC, PO2_50);
        H_M = H(Conc_Hb, O2_u, PO2_50);
//---------------------------------
//------Oxygen that enters---------
//----------the system-------------
//---------------------------------
        O2_inPB = (r*O2_u) - (r*(1/H_M)*((H_PB_PLAC/(Gamma_PAB)) + ((1 - Gamma_PAB)*H_PLAC/(Gamma_PAB))));
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}), Text(lineColor = {0, 0, 255}, extent = {{-70, 98}, {-22, 80}}, textString = "HR"), Text(lineColor = {0, 0, 255}, extent = {{-74, -40}, {40, -80}}, textString = "Et"), Text(lineColor = {0, 0, 255}, extent = {{42, -40}, {100, -80}}, textString = "Pi"), Text(lineColor = {0, 0, 255}, extent = {{-272, 16}, {276, -40}}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Placental Respiration
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end Placental_Respiration_3;

      model Pulmonary_Respiration_4
        //----Constants----
        parameter Real T(final unit = "K") = 298.15 "Body temperature";
        parameter Real K = 62.36367 "Gas constant [mmHg.L/(mol.K)]";
        //----Concentrations--------
        Real O2_inPAB2 "Inspired O2 concentration [mmol O2/L]";
        Real O2_Hb "Concentration carried by hemoglobin [mmol O2/L]";
        Real O2_combi "Combined oxygen concentration [mmol O2/L]";
        Real O2_i(start = 5) "Uterine oxygen concentration [mmol O2/L]";
        parameter Real Conc_Hb = 17.5 "Hemoglobin concentration [g Hb/dL]";
        // 7.45 mmol/l --- 12g/dl --- 7.45 mol/m3;
        //---Auxiliary variables---
        Real r, Tao, a, b, c;
        parameter Real Gamma = 0.45 "Diffusion efficiency";
        //---Pressures---
        parameter Real ambientOxygenPartialPressure(final unit = "mmHg") = 150 "Presion oxigeno entrante";
        parameter Real PO2_50(final unit = "mmHg") = 20 "Partial pressure of O2 at 50% saturation";
        Real PO2_PA(final unit = "mmHg");
        Real PO2_PAB(final unit = "mmHg");
        //---Hill function---
        Real H_O2_PA, H_O2_PA_PAB;
        //Variables for Hill function
        //----Birth time--------
        parameter Types.Time t0 = 5 "time of birth";
        Connectors.OxygenFlowOutput O2_inPAB annotation(
          Placement(visible = true, transformation(origin = {-120, -32}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {40, -102}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
        Connectors.OxygenFlowInput O2_PA annotation(
          Placement(visible = true, transformation(origin = {-120, 32}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-40, -102}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
      equation
//---------------------------------
//---Ventilation-Perfusion Ratio---
//---------------------------------
        Tao = 10*60;
        if 0 < time and time <= t0 then
          r = 0;
        elseif t0 < time and time <= t0 + Tao then
          r = 0.7*((time - t0)/Tao);
        else
          r = 0.7;
        end if;
////---------------------------------------
////----Inspired concentration [O2]_{i}----
////---------------------------------------
        O2_i = ambientOxygenPartialPressure/(K*T);
////---------------------------------
////----------Hill Function----------
        O2_Hb = (Conc_Hb*1.34)/(22.4*0.1);
        O2_combi = O2_PA + O2_inPAB;
        H_O2_PA_PAB = PO2_50*((O2_combi)/((O2_Hb) - (O2_combi)))^(1/2.7);
        H_O2_PA = PO2_50*((O2_PA)/((O2_Hb) - (O2_PA)))^(1/2.7);
//---------------------------------
//----------Ideal gas law----------
//---------------------------------
        PO2_PAB = (O2_inPAB*K*T);
        PO2_PA = (O2_PA*K*T);
////---------------------------------
////----O2 concentration intake------
////----of the blood passing the-----
////----pulmonary arterial bed-------
////---------------------------------
        a = O2_i;
        b = ((H_O2_PA_PAB)/(Gamma*K*T));
        c = ((1 - Gamma)*H_O2_PA)/(Gamma*K*T);
        O2_inPAB2 = r*(a - b + c);
        O2_inPAB = r*(a - b + c);
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}), Text(lineColor = {0, 0, 255}, extent = {{-70, 98}, {-22, 80}}, textString = "HR"), Text(lineColor = {0, 0, 255}, extent = {{-74, -40}, {40, -80}}, textString = "Et"), Text(lineColor = {0, 0, 255}, extent = {{42, -40}, {100, -80}}, textString = "Pi"), Text(lineColor = {0, 0, 255}, extent = {{-272, 16}, {276, -40}}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Pulmonary Respiration
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end Pulmonary_Respiration_4;

      model Placental_Respiration_4
        Types.Concentration O2_u "Inspired O2 concentration";
        parameter Real Gamma_PAB = 0.45 "Diffusion efficiency";
        parameter Types.Pressure ambientOxygenPartialPressure = 100 "pressure of O2 concentration";
        Real r;
        //Ventilation-Perfusion Ratio
        Types.Concentration O_PB_PLAC "Oxygen concentration after inspiring";
        //Oxygen concentration after inspiring
        Connectors.ConcentrationInput O2_PLAC annotation(
          Placement(visible = true, transformation(origin = {-40, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {70, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Connectors.ConcentrationOutput O2_inPB annotation(
          Placement(visible = true, transformation(origin = {52, -124}, extent = {{-36, -22}, {-16, -2}}, rotation = -90), iconTransformation(origin = {-70, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
        parameter Types.Mass Conc_Hb = 12 "Concentration of Hb in blood in [g Hb/dl]";
        parameter Types.Pressure PO2_50 = 26.6 "Partial pressure of O2 at 50% ";
        Real H_PB_PLAC, H_PLAC, H_M;
        //Variables for Hill function
        Connectors.VolumeFlowRateInput Q_PLAC(start = 1e-12) annotation(
          Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180), iconTransformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
//---------------------------------
//----Inspired O2 concentration----
//---------------------------------
        O2_u = (ambientOxygenPartialPressure)*(1/H_M);
//---------------------------------
//---Ventilation-Perfusion Ratio---
//---------------------------------
        r = 600/Q_PLAC;
//---------------------------------
//----------Hill Function----------
//---------------------------------
        O_PB_PLAC = O2_inPB + O2_PLAC;
//Oxygen concentration after inspiring
        H_PB_PLAC = Functions.H(Conc_Hb, O_PB_PLAC, PO2_50);
        H_PLAC = Functions.H(Conc_Hb, O2_PLAC, PO2_50);
        H_M = Functions.H(Conc_Hb, O2_u, PO2_50);
//---------------------------------
//------Oxygen that enters---------
//----------the system-------------
//---------------------------------
        O2_inPB = (r*O2_u) - (r*(1/H_M)*((H_PB_PLAC/(Gamma_PAB)) + ((1 - Gamma_PAB)*H_PLAC/(Gamma_PAB))));
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}), Text(lineColor = {0, 0, 255}, extent = {{-70, 98}, {-22, 80}}, textString = "HR"), Text(lineColor = {0, 0, 255}, extent = {{-74, -40}, {40, -80}}, textString = "Et"), Text(lineColor = {0, 0, 255}, extent = {{42, -40}, {100, -80}}, textString = "Pi"), Text(lineColor = {0, 0, 255}, extent = {{-272, 16}, {276, -40}}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Placental Respiration
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end Placental_Respiration_4;

      model PO2_altitude
        //---------------------------------
        //---Constants--------------------
        //---------------------------------
        parameter Modelica.SIunits.Temperature T = 298.15 "Body temperature";
        final constant Real K(final unit = "J/(mol.K)") = 8.3144598 "Molar gas constant";
        Real tolerance = 100*Modelica.Constants.eps;
        parameter Real Tau_s = 24 "Pulmonary establishment time, typically 24 hours";
        //---------------------------------
        //---Concentrations---------------
        //---------------------------------
        parameter Modelica.SIunits.MassConcentration Conc_Hb_fetal = 175 "Hemoglobin mass concentration (SI kg/m3; numerically equal to g/L)";
        Modelica.SIunits.Concentration O2_Hb_fetal "Concentration carried by hemoglobin";
        Modelica.SIunits.Concentration O2_i "Uterine oxygen concentration";
        //---------------------------------
        //---Auxiliary variables----------
        //---------------------------------
        Real r, a, b;
        parameter Real Gamma = 1 "Diffusion efficiency";
        //---------------------------------
        //---Pressures---------------------
        //---------------------------------
        Connectors.PressureInput ambientOxygenPartialPressure annotation(
          Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-102, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        parameter Types.Pressure PO2_50 = 2666.44 "Partial pressure of O2 at 50% saturation";
        Connectors.OxygenFlowInput O2_PA annotation(
          Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-102, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        Connectors.OxygenFlowOutput O2_inPAB annotation(
          Placement(visible = true, transformation(origin = {100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {102, 4}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        //---------------------------------
        //---Birth time-------------
        //---------------------------------
        parameter Modelica.SIunits.Time t0 = 0 "time of birth";

      equation
//---------------------------------
//---Ventilation-Perfusion Ratio---
//---------------------------------
// time in hours
        if time <= 3600*Tau_s then
          r = 0.7*time/(3600*Tau_s);
        else
          r = 0.7;
        end if;
//---------------------------------
//---Maximum concentration---------
//---------------------------------
        O2_Hb_fetal = Conc_Hb_fetal*1340*(1/(1000*22.4));
//-----------------------------------------
//---Inspired concentration [O2]_{i}-------
//-----------------------------------------
        O2_i = ambientOxygenPartialPressure/(K*T);
//---------------------------------
//---Hill Function-----------------
//---------------------------------
        a = 0;
        b = (O2_Hb_fetal - O2_PA)*0.99;
//is that it is the oxygen concentration in blood that is
//allowed to equilibrate directly with the inspired air,without
//the intervention of the lungs
//---------------------------------
//----O2 concentration intake------
//----of the blood passing the-----
//----pulmonary arterial bed-------
//---------------------------------
        O2_inPAB = Modelica.Math.Nonlinear.solveOneNonlinearEquation(function Functions.Pulmonary_function(r = r, O2_i = O2_i, Gamma = Gamma, O2_PA = O2_PA, O2_Hb_fetal = O2_Hb_fetal, PO2_50 = PO2_50, T = T, K = K), a, b, tolerance);
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}), Text(lineColor = {0, 0, 255}, extent = {{-70, 98}, {-22, 80}}, textString = "HR"), Text(lineColor = {0, 0, 255}, extent = {{-74, -40}, {40, -80}}, textString = "Et"), Text(lineColor = {0, 0, 255}, extent = {{42, -40}, {100, -80}}, textString = "Pi"), Text(origin = {-8, 166}, lineColor = {0, 0, 255}, extent = {{-272, 16}, {276, -40}}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  PO2 altitude
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end PO2_altitude;
      annotation(
        Icon(graphics = {Bitmap(origin = {1, 3}, extent = {{75, 55}, {-75, -55}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/signals_respirations.svg")}, coordinateSystem(extent = {{-80, 60}, {80, -60}})),
        Documentation(info = "<html>
    <p>
    Respirations
    </p>
    </html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
    end Respirations;

    package Clamping
model Systemic_Vascular

  parameter Modelica.SIunits.Time tc = 86400 "Time of umbilical cord clamping";
  parameter Modelica.SIunits.Time phase_one = 43200 "First stage";
  parameter Modelica.SIunits.Time phase_two = 86400 "Second stage";

  parameter Types.Conductance Co = 3.26119e-09 "Initial vascular conductance";
  Connectors.ConductanceOutput C annotation(
    Placement(transformation(extent = {{-4, -102}, {16, -82}}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, -90})));

  Types.Resistance R;
  Types.Resistance Ro "Initial vascular resistance";

equation

  Ro = (1/Co)*7.5e-09;

  if time <= phase_one then
    R = 0.0846*(time/3600) + 3.45;
  elseif time > phase_one and time <= phase_two then
    R = 0.00420*(time/3600) + 4.42;
  else
    R = 0.00420*(phase_two/3600) + 4.42;
  end if;

  C = (1/R)*7.5e-9;

  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}, color = {0, 0, 255}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}, color = {0, 0, 255}), Text(lineColor = {0, 0, 255}, extent = {{-70, 98}, {-22, 80}}, textString = "HR"), Text(lineColor = {0, 0, 255}, extent = {{-74, -40}, {40, -80}}, textString = "Et"), Text(lineColor = {0, 0, 255}, extent = {{42, -40}, {100, -80}}, textString = "Pi"), Text(lineColor = {0, 0, 255}, extent = {{-272, 16}, {276, -40}}, textString = "%name")}),
    Documentation(info = "<html>
<p>
Systemic Vascular
</p>
</html>", revisions = "<html>
<table>
<tr>
<td>Authors:</td>
<td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
<td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
<td> Leonardo Bermeo Clavijo (2)</td>
</tr>
<tr>
<td>Copyright:</td>
<td>In public domains</td>
</tr>
<tr>
<td>By:</td>
<td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
<td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
</tr>
<tr>
<td>Last revision:</td>
<td>October 2023</td>
</tr>
</table>
</html>"));
end Systemic_Vascular;

      model Peripheral_Vessels

        parameter Modelica.SIunits.Time phase_one = 7200 "First stage";
        parameter Modelica.SIunits.Time phase_two = 86400 "Second stage";

        parameter Types.Conductance Co = 4.795875e-10 "Initial vascular conductance";

        Real euler = Modelica.Constants.e;

        Connectors.ConductanceOutput C annotation(
          Placement(transformation(extent = {{-4, -102}, {16, -82}}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, -90})));

        Types.Resistance R;
        Types.Resistance RPPo "Initial vascular resistance";

      equation

        RPPo = (1/Co)*7.5e-09;

        if time <= phase_one then
          R = RPPo*(1 - 0.74*(1 - euler^(-6*((time/3600)))));
        elseif time > phase_one and time <= phase_two then
          R = RPPo*(0.26 - 9.5e-04*(((time/3600)) - 2));
         else
         R = RPPo*(0.26 - 9.5e-04*(((phase_two/3600)) - 2));
        end if;

        C = (1/R)*7.5e-09;



        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}, color = {0, 0, 255}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}, color = {0, 0, 255}), Text(lineColor = {0, 0, 255}, extent = {{-70, 98}, {-22, 80}}, textString = "HR"), Text(lineColor = {0, 0, 255}, extent = {{-74, -40}, {40, -80}}, textString = "Et"), Text(lineColor = {0, 0, 255}, extent = {{42, -40}, {100, -80}}, textString = "Pi"), Text(lineColor = {0, 0, 255}, extent = {{-272, 16}, {276, -40}}, textString = "%name")}),
          Documentation(info = "<html>
      <p>
      Peripheral Vessels
      </p>
      </html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
      end Peripheral_Vessels;

      model Systemic_Vascular_2
        parameter Modelica.SIunits.Time tc = 60 "Time of umbilical cord clamping";
        parameter Modelica.SIunits.Time tao = 600 "Transition time";
        parameter Modelica.SIunits.Time tb = 10 "Time of birth";
        parameter Types.Conductance Co = 2.36001e-09 "Initial vascular conductance";
        parameter Types.Conductance Cf = 1.25013e-17 "Final vascular conductance";
        Modelica.SIunits.Time t0 "Time from birth";
        Modelica.SIunits.Time tm "Time until the clamping of the umbilical cord";
        Connectors.ConductanceOutput C annotation(
          Placement(transformation(extent = {{-4, -102}, {16, -82}}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, -90})));
        Types.Resistance R;
        Types.Resistance Ro "Initial vascular resistance";
        Types.Resistance Rf "Final vascular resistance";
      equation
        t0 = tb + tc;
        tm = time - t0;
        Ro = (1/Co)*7.5e-09;
        Rf = (1/Cf)*7.5e-09;
        if 0 <= time and time <= t0 then
          R = Ro;
        elseif t0 < time and time <= t0 + tao then
          R = (Ro*Rf*tao^4)/(((tm)*Ro^(1/4) + (tao - tm)*Rf^(1/4))^4);
        else
          R = Rf;
        end if;
        C = (1/R)*7.5e-09;
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}, color = {0, 0, 255}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}, color = {0, 0, 255}), Text(textColor = {0, 0, 255}, extent = {{-70, 98}, {-22, 80}}, textString = "HR"), Text(textColor = {0, 0, 255}, extent = {{-74, -40}, {40, -80}}, textString = "Et"), Text(textColor = {0, 0, 255}, extent = {{42, -40}, {100, -80}}, textString = "Pi"), Text(origin = {-8, 136}, textColor = {0, 0, 255}, extent = {{-272, 16}, {276, -40}}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Systemic Vascular
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end Systemic_Vascular_2;

      model UCC_resistance
        parameter Types.Conductance Co = 3.931140334557942e-11 "Initial vascular conductance";
        parameter Types.Conductance Cf = 4.579130495913344e-17 "Final vascular conductance";
        parameter Modelica.SIunits.Time tc = 180 "Time of umbilical cord clamping";
        parameter Modelica.SIunits.Time to = 100 "It represents the time it takes for complete occlusion of both umbilical arteries and the umbilical vein after clamping";

        Real euler = Modelica.Constants.e;

        Types.Resistance R;

        Types.Resistance Ro "Initial vascular resistance";
        Types.Resistance Rf "Final vascular resistance";

        Connectors.ConductanceOutput C annotation(
          Placement(transformation(extent = {{-4, -102}, {16, -82}}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, -90})));

      equation
        Ro = 1/Co*7.5e-09;
        Rf = 1/Cf*7.5e-09;

        if time <= tc then
          R = Ro;
        elseif tc < time and time <= to + tc then
          R = Ro*(euler^(((log(Rf/Ro))/to)*(time - tc)));
        else
          R = Rf;
        end if;

        C = 1/R*7.5e-09;
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}, color = {0, 0, 255}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}, color = {0, 0, 255}), Text(lineColor = {0, 0, 255}, extent = {{-70, 98}, {-22, 80}}, textString = "HR"), Text(lineColor = {0, 0, 255}, extent = {{-74, -40}, {40, -80}}, textString = "Et"), Text(lineColor = {0, 0, 255}, extent = {{42, -40}, {100, -80}}, textString = "Pi"), Text(lineColor = {0, 0, 255}, extent = {{-272, 16}, {276, -40}}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Umbilical Cord Clamping resistance
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end UCC_resistance;

      model Ductus_Arteriosus_Resistance

        parameter Types.Conductance Co = 3.26119e-09 "Initial vascular conductance";

        Real euler = Modelica.Constants.e;
        constant Real k = 0.0145;

        Connectors.ConductanceOutput C annotation(
          Placement(transformation(extent = {{-4, -102}, {16, -82}}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, -90})));

        Types.Resistance R;
        Types.Resistance RDA "Initial vascular resistance";

      equation

        RDA = (1/Co)*7.5e-09;

        R = k/(((0.29*euler^(-0.43*((time/3600)))) + (0.3*euler^(-0.054*((time/3600)))))^4);

        C = (1/R)*(7.5e-09);

        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}, color = {0, 0, 255}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}, color = {0, 0, 255}), Text(lineColor = {0, 0, 255}, extent = {{-70, 98}, {-22, 80}}, textString = "HR"), Text(lineColor = {0, 0, 255}, extent = {{-74, -40}, {40, -80}}, textString = "Et"), Text(lineColor = {0, 0, 255}, extent = {{42, -40}, {100, -80}}, textString = "Pi"), Text(lineColor = {0, 0, 255}, extent = {{-272, 16}, {276, -40}}, textString = "%name")}),
          Documentation(info = "<html>
  <p>
  Ductus Arteriosus Resistance
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
      end Ductus_Arteriosus_Resistance;

      model Left_Atrial_Resistance

        parameter Modelica.SIunits.Time phase_one = 7200 "First stage";
        parameter Modelica.SIunits.Time phase_two = 86400 "Second stage";

        parameter Types.Conductance Co = 9.59175e-10 "Initial vascular conductance";

        Real euler = Modelica.Constants.e;


        Connectors.ConductanceOutput C annotation(
          Placement(transformation(extent = {{-4, -102}, {16, -82}}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, -90})));

        Types.Resistance R;
        Types.Resistance RLAINo "Initial vascular resistance";

      equation

        RLAINo = (1/Co)*7.5e-09;

        if time <= phase_one then
          R = RLAINo*(1 - 0.74*(1 - euler^(-6*((time/3600)))));
        elseif time > phase_one and time <= phase_two then
          R = RLAINo*(0.26 - 9.5e-04*((time/3600) - 2));
        else
          R = RLAINo*(0.26 - 9.5e-04*((phase_two/3600) - 2));
        end if;
          C = (1/R)*7.5e-09;


        annotation(
          Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}), Line(points = {{-78, 0}, {-68, 18}, {-54, 52}, {-44, 64}, {-30, 60}, {-26, 46}}, color = {0, 0, 255}), Line(points = {{-26, 46}, {-26, 32}, {-20, 10}, {-8, 2}, {36, 2}, {80, 2}}, color = {0, 0, 255}), Text(lineColor = {0, 0, 255}, extent = {{-70, 98}, {-22, 80}}, textString = "HR"), Text(lineColor = {0, 0, 255}, extent = {{-74, -40}, {40, -80}}, textString = "Et"), Text(lineColor = {0, 0, 255}, extent = {{42, -40}, {100, -80}}, textString = "Pi"), Text(lineColor = {0, 0, 255}, extent = {{-272, 16}, {276, -40}}, textString = "%name")}),
          Documentation(info = "<html>
      <p>
      Ductus Arteriosus Resistance
      </p>
      </html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
      end Left_Atrial_Resistance;
      annotation(
        Icon(graphics = {Bitmap(origin = {-1, -2}, extent = {{-79, 76}, {79, -76}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/signals_clamping.svg")}),
        Documentation(info = "<html>
    <p>
    Umbilical Cord Clamping Signals
    </p>
    </html>", revisions = "<html>
      <table>
      <tr>
      <td>Authors:</td>
      <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
      <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
      <td> Leonardo Bermeo Clavijo (2)</td>
      </tr>
      <tr>
      <td>Copyright:</td>
      <td>In public domains</td>
      </tr>
      <tr>
      <td>By:</td>
      <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
      <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
      </tr>
      <tr>
      <td>Last revision:</td>
      <td>October 2023</td>
      </tr>
      </table>
      </html>"));
    end Clamping;
    annotation(
      Icon(graphics = {Rectangle(lineColor = {200, 200, 200}, fillColor = {248, 248, 248}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, -100}, {100, 100}}, radius = 25), Bitmap(origin = {-1, 1}, extent = {{-111, 75}, {111, -75}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/package_signals.svg")}),
      Documentation(info = "<html>
  <p>
  This package contains all the time-varying signals that will modify the vascular resistance of the physiological components. It also contains signals associated with respirations and the Umbilical Cord Clamping.
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    </html>"));
  end Signals;

  package UsersGuide
    class Contact "Contact"
      annotation(
        Documentation(info = "<html>
  <p>Edgar Hernando Sep&uacute;lveda-Oviedo</p>
    <ul>
  <li>Email: edgar-hernando.sepulveda-oviedo@univ-perp.fr</li>
  <li>ResearchGate: https://www.researchgate.net/profile/Edgar-Sepulveda-Oviedo</li>
  <li>Current affiliation 1: PROMES-CNRS (UPR 8521), Rambla de la thermodynamique, Tecnosud, Perpignan, 66100, France</li>
  <li>Current affiliation 2: Universit&eacute; de Perpignan Via Domitia, 52 Avenue Paul Alduy, Perpignan, 66860, France</li>
    </ul>
    <td></td>
    <td></td>
    <p>Luis Carlos M&eacute;ndez-C&oacute;rdoba</p>
    <ul>
    <li>Email: lcmendezc@unal.edu.co</li>
    <li>Afiliation: Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia</li>
    </ul>
    <td></td>
    <td></td>
    <p>Leonardo Bermeo Clavijo</p>
    <ul>
    <li>Email: lbermeoc@unal.edu.co</li>
    <li>Afiliation: Universidad Nacional de Colombia, ,Facultad de Ingenier&iacute;a, Departamento de ingenier&iacute;a el&eacute;ctrica y electr&oacute;nica, Bogot&aacute;, Colombia</li>
    </ul>
  </html>"),
        Icon(graphics = {Rectangle(origin = {0, 1}, lineColor = {246, 97, 81}, fillColor = {0, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, -79}, {100, 79}}, radius = 25), Bitmap(origin = {0, -2}, extent = {{-94, 68}, {94, -68}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/usersguide_contact.svg")}));
    end Contact;

    model Related_Articles "Related Articles"
      annotation(
        Documentation(info = "<html>
    <p>Articles related to the data and models presented in this library are listed below. </p>
    <ol>
    <li>Sep&uacute;lveda-Oviedo EH, Bermeo Clavijo LE, M&eacute;ndez C&oacute;rdoba LC.
    Effect of timing of umbilical cord clamping and birth on fetal to neonatal transition: OpenModelica-based virtual simulator-based approach. Biocybernetics and Biomedical Engineering. 2024;44(3):716-730. DOI: 10.1016/j.bbe.2024.08.008.</li>
    <li>Sep&uacute;lveda-Oviedo EH, Bermeo Clavijo LE, M&eacute;ndez C&oacute;rdoba LC.
    OpenModelica-based virtual simulator for the cardiovascular and respiratory physiology of a neonate. Journal of Medical Engineering & Technology. 2022;46(3):179-97.</li>
    <li>Sepulveda-Oviedo, EH., Bermeo, L., y M&eacute;ndez, L. (2018). Desarrollo de una herramienta de simulaci&oacute;n cardiovascular neonatal para la enseñanza y la investigaci&oacute;n. XLVI Congresso Brasileiro de Educação em Engenharia (COBENGE) e no 1º Simp&oacute;sio Internacional de Educação em Engenharia da ABENGE, Salvador bahia, Brasil.</li>
    <li>Sep&uacute;lveda-Oviedo EH. Estudio de la pr&aacute;ctica del pinzamiento del cord&oacute;n umbilical usando an&aacute;lisis computacional de la informaci&oacute;n bibliogr&aacute;fica, modelos de eventos discretos y modelos din&aacute;micos [diploma thesis]. Universidad Nacional de Colombia; 2019.</li>

    <li>Yigit MB, Kowalski WJ, Hutchon DJR, Pekkana K. Transition from fetal to neonatal circulation: Modeling the effect of umbilical cord clamping. Journal of Biomechanics. 2015;48(9):1662-70.</li>

    <li>Hoppensteadt, F. y Peskin, C. (2002). Modeling and Simulation in Medicine and the Life Sciences (2nd Edition). Springer, NewYork.</li>

    <li>Goodwin, J., van Meurs, W., S&aacute;-Couto, C., Beneken, J., y Graves, S. (2004). A model for educational simulation of infant cardiovascular physiology. Anesth Analg,99(6):1655-1664. </li>
    <li>S&aacute;-Couto, P., Van-Meurs, W., Bernardes, J., Marques de S&aacute;, J., y Goodwin, J. (2002). Mathematical model for educational simulation of the oxygen delivery to the fetus. 10(1):59-66.</li>
    <li>S&aacute;-Couto, C. D., van Meurs, W. L., Goodwin, J. A., y Andriessen, P. (2006). A model for educational simulation of neonatal cardiovascular pathophysiology. 1(Inaugural):4-9.</li>

    <li>Serov, A., Salafia, C., Filoche, M., y Grebenkov, D. (2015). Analytical theory of oxygen transport in the human placenta. J Theor Biol., 368:133-144.</li>

    <li>Matej&aacute;k, M. y Kofr&aacute;nek, J. (2015). Physiomodel - an integrative physiology in modelica. En Conf Proc IEEE Eng Med Biol Soc., pp. 1464-7.</li>

    <li>Huikeshoven, F., Coleman, T., y Jongsma, H. (1980). Mathematical model of the fetal cardiovascular system: the uncontrolled case. Am J Physiol., 239(3):R317-25.</li>

    <li>Koch, G. (1968). Alveolar ventilation, diffusing capacity and the a-a po2, difference in the newborn infant. Respiration Physiology, 4(2):168 - 192.</li>

    <li>Guyton, A. (1991). Textbook of medical physiology (8th Edition). W.B. Saunders Company, Philadelphia.</li>

    <li>Graham, T. y Jarmakani, M. (1971). Evaluation of ventricular function in infants and children. Pediatric Clinics of North America, 18(4):1109 - 1132.</li>

    <li>Paul, A. y Das, S. (2017). Valvular heart disease and anaesthesia. Indian J Anaesth, 61(9):721–727.</li>

    <li>Avery, G., Fletcher, M., y MacDonald, M. (1999). Neonatology: Pathophysiology and management of the newborn (5th Edition). Lippincott Williams and Wilkins, Philadelphia.</li>
    </ol>
    </html>"),
        Icon(graphics = {Bitmap(origin = {4, 0}, extent = {{-98, 94}, {98, -94}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/usersguide_related_articles.svg")}));
    end Related_Articles;

    model Acknowledgments
      annotation(
        Documentation(info = "<html><head></head><body><p>This study mainly thanks researcher Marek Matejak from Charles University in Prague for the development of his Physiolibrary library which was the basis for the development of some components contained in this library.</p>
    <p>This study also especially thanks the Instituto Materno Infantil -- Hospital La Victoria in Bogotá Colombia, for allowing us a series of validations with a group of health professionals over several years.</p></body></html>"),
        Icon(graphics = {Rectangle(lineColor = {246, 97, 81}, fillColor = {149, 255, 10}, fillPattern = FillPattern.Solid, extent = {{-80, -80}, {80, 80}}, radius = 25), Bitmap(origin = {0, 6}, extent = {{-80, 62}, {80, -62}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/usersguide_acknowledgments.svg")}));
    end Acknowledgments;
    annotation(
      Icon(graphics = {Ellipse(lineColor = {75, 138, 73}, fillColor = {75, 138, 73}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}), Polygon(origin = {-4.167, -15}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-15.833, 20}, {-15.833, 30}, {14.167, 40}, {24.167, 20}, {4.167, -30}, {14.167, -30}, {24.167, -30}, {24.167, -40}, {-5.833, -50}, {-15.833, -30}, {4.167, 20}, {-5.833, 20}, {-15.833, 20}}, smooth = Smooth.Bezier), Ellipse(origin = {7.5, 56.5}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-12.5, -12.5}, {12.5, 12.5}})}),
      Documentation(info = "<html>
  <p>
  This packet contains contact information, the scientific articles used as a basis for the project, and acknowledgments to people whose contributions made a significant contribution to this research.
  </p>
  </html>", revisions = "<html>
    <table>
    <tr>
    <td>Authors:</td>
    <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
    <td> Luis Carlos M&eacute;ndez-C&oacute;rdoba (2) </td>
    <td> Leonardo Bermeo Clavijo (2)</td>
    </tr>
    <tr>
    <td>Copyright:</td>
    <td>In public domains</td>
    </tr>
    <tr>
    <td>By:</td>
    <td>(1) Laboratory for Analysis and Architecture of Systems, Toulouse, France</td>
    <td>(2) Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia </td>
    </tr>
    <tr>
    <td>Last revision:</td>
    <td>October 2023</td>
    </tr>
    </table>
    <p>THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS &QUOT;AS IS&QUOT; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.</p>
    </html>"));
  end UsersGuide;
  annotation(
    Icon(graphics = {Rectangle(origin = {0, 12}, lineColor = {85, 255, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, lineThickness = 0.75, extent = {{-98, 68}, {98, -68}}), Bitmap(origin = {2, 8}, extent = {{-96, 82}, {96, -82}}, fileName = "modelica://PatientEvoPhysio/Resources/Images/icon/package_root.svg")}),
    version = "2.1.0",
    versionDate = "2026-10-24",
    dateModified = "2026-10-23",
    uses(Modelica(version = "3.2.3"), Physiolibrary(version = "2.3.1")),
    Documentation(info = "<html><head></head><body><p>
PatientEvoPhysio is an open-source Modelica library for cardiovascular and respiratory computational physiology across fetal, neonatal, child and adult scenarios. The project originated from research performed with collaborators at the National University of Colombia and LAAS-CNRS and is currently maintained by Edgar Hernando Sep&uacute;lveda-Oviedo at PROMES-CNRS (UPR 8521) and Universit&eacute; de Perpignan Via Domitia, Perpignan, France.
</p><p>The library supports research and education in physiological situations where direct experimental investigation may be ethically or practically constrained. Code in this library has been adapted and/or adopted from Physiolibrary 2.3.1.</p>
</body></html>", revisions = "<html>
  <table>
  <tr>
  <td>Authors:</td>
  <td>Edgar Hernando Sep&uacute;lveda-Oviedo (1,2)</td>
  <td>Luis Carlos M&eacute;ndez-C&oacute;rdoba</td>
  <td>Leonardo Enrique Bermeo Clavijo</td>
  </tr>
  <tr>
  <td>Copyright:</td>
  <td>In public domains</td>
  </tr>
  <tr>
  <td>Current maintainer affiliations:</td>
  <td>(1) PROMES-CNRS (UPR 8521), Rambla de la thermodynamique, Tecnosud, Perpignan, 66100, France</td>
  <td>(2) Universit&eacute; de Perpignan Via Domitia, 52 Avenue Paul Alduy, Perpignan, 66860, France</td>
  </tr>
  <tr>
  <td>Last revision:</td>
  <td>October 2026</td>
  </tr>
  </table>

  <p>THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS &QUOT;AS IS&QUOT; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.</p>
  </html>"));
end PatientEvoPhysio;
