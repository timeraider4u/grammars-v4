function die() {
	echo "${1}"
	exit 1
}

#FILE="./examples/empty.h"
#FILE="./examples/code.h"
#FILE="./examples/includes.h"
#FILE="./examples/simpleDef.c"
#FILE="./examples/reuseDef.c"
FILE="./examples/error.h"
#GRAMMAR="Cmacros"
GRAMMAR="CPreprocess"
CP="./libs/antlr-4.5.1-complete.jar:."
java -cp ${CP} org.antlr.v4.Tool ${GRAMMAR}.g4 || die
javac -cp ${CP} *.java || die
echo ""
echo ""
echo ""
echo ""
cat ${FILE} | java -cp ${CP} org.antlr.v4.runtime.misc.TestRig ${GRAMMAR} compilationUnit -gui

find . -name "*.java" -not -name "Scope.java" -not -name "Main.java" -exec rm {} \;
rm *.class || die
rm *.tokens || die
echo "Done!"
