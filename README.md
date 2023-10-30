# PatientEvoPhysio
Free open source Model Library designed to evaluate human physiological evolution in adulthood, childhood, neonatal and fetal life in the face of the occurrence of cardiovascular and respiratory anomalies or different clinical practices.

![image](https://github.com/ehsepulvedao/PatientEvoPhysio/assets/7245709/967f427d-3f07-4a28-b29f-1e0a24ae1af4)

## Library description

The internal structure of the library is as follows:

![image](https://github.com/ehsepulvedao/PatientEvoPhysio/assets/7245709/b984a87f-c5c8-4d01-8544-f79505e25cea)

As can be seen in the Figure, the library is made up of 8 packages. The content of each package is explained below:

<html>
<ol>
<li>Icons: This package contains the icons of all the components that make up the physiological models of the library.</li>
<li>Components: This package contains all the components that are used to assemble the different physiological scenarios for evaluating the evolution of patients.</li>
<li>Types: Contains particular data types. All of this data is modifications of Modelica's primitive data.</li>
<li>Scenarios: They contain multiple models divided into 4 large categories: Adults, children, neonates and fetuses.</li>
<li>Connectors: This package contains different connectors that allow interaction between the internal variables of the components.
<li>Function: This package contains mathematical functions such as the Hill function, the inverse Hill function, pulmonary or placental respiratory functions that determine changes in time-varying oxygen saturation.</li>
<li>Signals: This package contains the components that determine the time-varying behavior of aspects such as the variable elastance of certain vascular components, pulmonary respiration, placental respiration, the foramen ovale, among others.</li>
<li>UsersGuide: Contains contact information, acknowledgments of scientific articles related to the development of this library.</li>
</ol>
</html>


## Installation

To run this library it is necessary to have the following prerequisites installed:

<html>
<ul>
<li>Download the PatientEvoPhysio.mo file.</li>
<li>Install Modelica. Version 3.2.3.</li>
<li>Install Physiolibrary. Version 2.3.1.</li>
<li>Download and install the simulation and modeling environment that supports Modelica 3.2.3, such as: 
  <a href="https://www.3ds.com/fr/produits-et-services/catia/produits/dymola/">Dymola</a>,
  <a href="https://openmodelica.org/">OpenModelica</a>,
  <a href="https://jmodelica.org/">JModelica</a>
</li>
</ul>
</html>

## Future work

This library will soon be available as part of the VirtualLabUN project of the National University of Colombia. Learn more about the project in the following link.

https://unvlab.unal.edu.co/unvl.php?&_1node=2147488259

## Development and contribution
<html>
<p>Release manager: <a href="https://www.researchgate.net/profile/Edgar-Sepulveda-Oviedo">Edgar Hernando Sep&uacute;lveda-Oviedo</a></p>
<ul>
Contributors:
<li><a href="https://www.researchgate.net/profile/Edgar-Sepulveda-Oviedo">Edgar Hernando Sep&uacute;lveda-Oviedo</a></li>
  <p>Laboratory for Analysis and Architecture of Systems, Toulouse, France.</p>
<li><a href="https://www.researchgate.net/profile/Leonardo-Bermeo">Leonardo Bermeo Clavijo</a></li>
  <p>Universidad Nacional de Colombia, ,Facultad de Ingenier&iacute;a, Departamento de ingenier&iacute;a el&eacute;ctrica y electr&oacute;nica, Bogot&aacute;, Colombia.</p>
<li><a href="https://www.researchgate.net/profile/Luis-Mendez-Cordoba">Luis Carlos M&eacute;ndez-C&oacute;rdoba</a></li>
  <p>Universidad Nacional de Colombia, ,Instituto Materno Infantil -- Hospital La Victoria Sede, Bogot&aacute;, Colombia.</p>
</ul>

## Issues
You may report any issues to the email ehsepulved@laas.fr or lbermeoc@unal.edu.co

## Related scientific articles
<html>
<p>Articles related to the data and models presented in this library are listed below. </p>
<ol>
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
</html>


