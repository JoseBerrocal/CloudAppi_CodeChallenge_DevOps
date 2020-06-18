#!/bin/bash

echo "Se hara prueba de stress con 50 ingresos"
echo "****************************************"
cd stress_testing_50
jmeter -n -t jmeter_testplan.jmx  -l jmeter_testplan_result.csv -e -o HTML_report_50/
cd ../stress_testing_70

echo "Se hara prueba de stress con 70 ingresos"
echo "****************************************"
jmeter -n -t jmeter_testplan.jmx  -l jmeter_testplan_result.csv -e -o HTML_report_70/
cd ../stress_testing_90

echo "Se hara prueba de stress con 90 ingresos"
echo "****************************************"
jmeter -n -t jmeter_testplan.jmx  -l jmeter_testplan_result.csv -e -o HTML_report_90/
cd ..

echo "Se pasan los reportes a la carpeta Reportes_HTML"
echo "************************************************"
cp -pr stress_testing_50/HTML_report_50/ Reportes_HTML/
cp -pr stress_testing_70/HTML_report_70/ Reportes_HTML/
cp -pr stress_testing_90/HTML_report_90/ Reportes_HTML/
echo "Los reportes estan disponibles"
