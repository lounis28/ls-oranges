# ls-oranges
Oranges farm script for QBCore

Add these to qb-core/shared/items.lua
['oranges'] 					 	 = {['name'] = 'oranges', 			    	    ['label'] = 'Orange', 					['weight'] = 300, 		['type'] = 'item', 		['image'] = 'orange.png', 	    	    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,   ['description'] = 'Tasty Orange'},

['orange_juice'] 				         = {['name'] = 'orange_juice', 			  	    ['label'] = 'Orange Juice', 			        ['weight'] = 450, 		['type'] = 'item', 		['image'] = 'orange_juice.png', 	    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,   ['description'] = 'Tasty Orange Juice'},

*Step 2
Go to resources qb-inventory/html/images and add orange.png & orange_juice.png to images.
# Dependicies
- qb-target - https://github.com/qbcore-framework/qb-target
- qb-core - https://github.com/qbcore-framework/qb-core
