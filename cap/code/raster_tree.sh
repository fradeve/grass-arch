#!/bin/bash
#before it was /bin/sh
#check this path if this script returns "Let: not found" or "bad substitution"
#
#############################################################################
#
# raster_tree.sh
#
# SCRIPT:   	import all the raster files in a directory tree using r.in.gdal
# AUTHOR(S):	Francesco Massa - 03/01/2008; Paolo Zatelli - 2007/04/28
# PURPOSE:  	import all the raster files found in the currente directory
#		and in its subdirectories. Maps' names are assigned from
#		raster files' base names (i.e. without extension). If a raster
#		map with the same name already exists in the current mapset
#		the import is skipped and a warning is issued on the stdout.
#   	    	 
# COPYRIGHT:	2008 Francesco Massa - 2007 Paolo Zatelli
# LICENSE:	GPL 2.0 or (at your option) any later version
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
#
#############################################################################
# IMPORTANT: the script must be run from the GRASS shell in the base
# directory of the tree containing the raster files.

# raster files extension - case sensitive
raster=asc
# raster files path and its subdirectories containing raster files - RECURSIVE!
path="."    # . or other source path
#############################################################################
# nothing to modify below this line
num=0
START_DATE=`date`

eval `g.gisenv`
: ${GISDBASE?} ${LOCATION_NAME?} ${MAPSET?}
LOCATION="$GISDBASE/$LOCATION_NAME/$MAPSET"

# default region
g.region -d

# import all the raster files found in the currente directory and in its
# subdirectories
inlist=`find $path -iname "*$raster" -print` 

for namein in $inlist
do

# strips the file name from the complete path+filename string
nameout=`basename $namein .$raster`
lungh1=`expr length "$namein"`
lungh2=`expr length "$nameout"`
lungh3=`expr length "$raster"`
let "lungh=$lungh1-$lungh2-$lungh3-1" #1 for the "." char
inputdir=${namein:0:$lungh}
#echo $nameout $inputdir $namein 

echo importing $raster $namein to $nameout
if  g.list vect|grep $nameout >/dev/null
 then
       echo "Warning: map $nameout already exists, file $namein NOT imported."
 else
       r.in.gdal -o -e input=$namein output=$nameout

let "num=$num+1"

fi
done
echo "$num $raster file(s) imported"
STOP_DATE=`date`
echo "Start: "$START_DATE
echo "Stop: "$STOP_DATE
