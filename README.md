# universal tree template
Tricktresor Tree Template in the context of #devtoberfest 2020

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
