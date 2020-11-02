# universal tree template
Tricktresor Tree Template in the context of #devtoberfest 2020

![logo](https://github.com/tricktresor/tree_template/blob/master/img/tree-template-small-01.png)

![screenshot](https://github.com/tricktresor/tree_template/blob/master/img/SNAG-00721.png)

# purpose
providing a tree framework to use common tree features and easily build a tree with class CL_LIST_TREE_MODEL.
design a tree with independent nodes of different behaviour.
Each node type will be a separate class with general behaviour (define node icon, define items, actions etc.)

# example
## sales orders

 - sales order
   - item 1
     - schedule 1
     - schedule 2
   - item 2
     - schedule 1
     - schedule 2
     - schedule 3
     - item 3 (BOM)
       - schedule 1
       - schedule 2
  - partner
    - partner 1
    - partner 2
  - Equipments
    - equi 1
    - equi 2

# possible actions
 - delete node (order, item, partner, ...)
 - cancel
 - check

# additional
 node and items update on changes
 - also on subsequent nodes...!
 nodes should know nothing about the structure
 node actions should be processed by controller not by the icon itself
 actions may depend on status of parent node(s)

 different types of nodes might be mixed together (sales order, delivery, invoices, ... )
 (a) show sales order and all subsequent deliveries
 (b) show deliveries and all preceding sales orders
 (c) show invoices and related sales orders + deliveries


 actions may come from
 (a) node itself (context menu)
 (b) tree for marked nodes

 # QUESTIONS
 what does the controller know?
 MVC aspect?
 - make controller + data independent from used tree
 display two or more views to compare sales orders
 actions like "expand all", "collapse all", "find" should be processed on all displayed trees
 mass processing:
 - how to integrate a log?
 - which actions succeeded, which failed?
 how to integrate drag'n'Drop?!?!
 - dragging items into "dust bin" to cancel
 - assign serial numbers from order a to order b
 - build BOM structures

# Examples

## demo 02 - example application "Marvel Universe"

![screenshot demo02](https://github.com/tricktresor/tree_template/blob/master/img/SNAG-00729.png)

## demo 03 - example application "transactions and report menu"

specific nodes with discrete attributes 
* transaction
* report

![screenshot demo03](https://github.com/tricktresor/tree_template/blob/master/img/SNAG-00776.png)

## demo 04 - example application "simple selection for sub screen"

tried to use simple selection (event SELECTION_CHANGED) for changing the current sub screen on dynpro

![screenshot demo04](https://github.com/tricktresor/tree_template/blob/master/img/SNAG-00777.png)

todo:
* change icon on activation or mark selected entry with different color
* select item via application to display desired subscreen
* set different icon for different status
  * entered data correct: green led
  * warnings on screen: yellow led
  * uncompleted or failure on screen: red led
  * data to be maintained: grey led
  
thoughts:
* using separate interface for kind of control
  * get different control for each node (demo 02 - marvel universe)
  * get data after selection changed or link click (demo 04 - subscreen)
    
