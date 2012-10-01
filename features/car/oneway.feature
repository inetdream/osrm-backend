@routing @car @oneway
Feature: Car - Oneway streets
Handle oneways streets, as defined at http://wiki.openstreetmap.org/wiki/OSM_tags_for_routing

	Background:
		Given the speedprofile "car"
	
	Scenario: Car - Simple oneway
		Then routability should be
		 | highway | oneway | forw | backw |
		 | primary | yes    | x    |       |

	Scenario: Car - Simple reverse oneway
		Then routability should be
		 | highway | oneway | forw | backw |
		 | primary | -1     |      | x     |

	Scenario: Car - Around the Block
		Given the node map
		 | a | b |
		 | d | c |		
	
		And the ways
		 | nodes | oneway |
		 | ab    | yes    |
		 | bc    |        |
		 | cd    |        |
		 | da    |        |
    
		When I route I should get
		 | from | to | route    |
		 | a    | b  | ab       |
		 | b    | a  | bc,cd,da |
	
	Scenario: Car - Cars should not be affected by bicycle tags
		Then routability should be
		 | highway | junction   | oneway | oneway:bicycle | forw | backw |
		 | primary |            | yes    | yes            | x    |       |
		 | primary |            | yes    | no             | x    |       |
		 | primary |            | yes    | -1             | x    |       |
		 | primary |            | no     | yes            | x    | x     |
		 | primary |            | no     | no             | x    | x     |
		 | primary |            | no     | -1             | x    | x     |
		 | primary |            | -1     | yes            |      | x     |
		 | primary |            | -1     | no             |      | x     |
		 | primary |            | -1     | -1             |      | x     |
		 | primary | roundabout |        | yes            | x    |       |
		 | primary | roundabout |        | no             | x    |       |
		 | primary | roundabout |        | -1             | x    |       |