#!/bin/bash
# initial install script
# this will run every other script that is in the same folder
# 	excluding itself
install_scripts=$(dirname $0)
for script in $(ls ${install_scripts} | grep -v 00_install.bash); do
	${install_scripts}/${script}
done

