@routing @bicycle @cycleway
Feature: Bike - Cycle tracks/lanes
# Reference: http://wiki.openstreetmap.org/wiki/Key:cycleway

    Background:
        Given the profile "bicycle"

    Scenario: Bike - Cycle tracks/lanes should enable biking
        Then routability should be
            | highway     | cycleway     | forw | backw |
            | motorway    |              |      |       |
            | motorway    | track        | x    |       |
            | motorway    | lane         | x    |       |
            | motorway    | shared       | x    |       |
            | motorway    | share_busway | x    |       |
            | motorway    | sharrow      | x    |       |
            | some_tag    | track        | x    | x     |
            | some_tag    | lane         | x    | x     |
            | some_tag    | shared       | x    | x     |
            | some_tag    | share_busway | x    | x     |
            | some_tag    | sharrow      | x    | x     |
            | residential | track        | x    | x     |
            | residential | lane         | x    | x     |
            | residential | shared       | x    | x     |
            | residential | share_busway | x    | x     |
            | residential | sharrow      | x    | x     |

    Scenario: Bike - Left/right side cycleways on implied bidirectionals
        Then routability should be
            | highway | cycleway | cycleway:left | cycleway:right | forw | backw |
            | primary |          |               |                | x    | x     |
            | primary | track    |               |                | x    | x     |
            | primary | opposite |               |                | x    | x     |
            | primary |          | track         |                | x    | x     |
            | primary |          | opposite      |                | x    | x     |
            | primary |          |               | track          | x    | x     |
            | primary |          |               | opposite       | x    | x     |
            | primary |          | track         | track          | x    | x     |
            | primary |          | opposite      | opposite       | x    | x     |
            | primary |          | track         | opposite       | x    | x     |
            | primary |          | opposite      | track          | x    | x     |

    Scenario: Bike - Left/right side cycleways on implied oneways
        Then routability should be
            | highway  | cycleway | cycleway:left | cycleway:right | forw | backw |
            | primary  |          |               |                | x    | x     |
            | motorway |          |               |                |      |       |
            | motorway | track    |               |                | x    |       |
            | motorway | opposite |               |                | x    | x     |
            | motorway |          | track         |                | x    |       |
            | motorway |          | opposite      |                | x    | x     |
            | motorway |          |               | track          | x    |       |
            | motorway |          |               | opposite       | x    | x     |
            # motorways are implicit oneways and cycleway tracks next to oneways always
            # follow the oneway direction (unless tagged as opposite)
            | motorway |          | track         | track          | x    |       |
            | motorway |          | opposite      | opposite       | x    | x     |
            | motorway |          | track         | opposite       | x    | x     |
            | motorway |          | opposite      | track          | x    | x     |

    Scenario: Bike - Invalid cycleway tags
        Then routability should be
            | highway  | cycleway   | bothw |
            | primary  |            | x     |
            | primary  | yes        | x     |
            | primary  | no         | x     |
            | primary  | some_track | x     |
            | motorway |            |       |
            | motorway | yes        |       |
            | motorway | no         |       |
            | motorway | some_track |       |

    Scenario: Bike - Access tags should overwrite cycleway access
        Then routability should be
            | highway     | cycleway | access | forw | backw |
            | motorway    | track    | no     |      |       |
            | residential | track    | no     |      |       |
            | footway     | track    | no     |      |       |
            | cycleway    | track    | no     |      |       |
            | motorway    | lane     | yes    | x    |       |
            | residential | lane     | yes    | x    | x     |
            | footway     | lane     | yes    | x    | x     |
            | cycleway    | lane     | yes    | x    | x     |

    Scenario: Bike - Cycleway on oneways, modes
        Then routability should be
            | highway     | cycleway | oneway | forw    | backw        |
            | motorway    | track    | yes    | cycling |              |
            | residential | track    | yes    | cycling | pushing bike |
            | cycleway    | track    | yes    | cycling | pushing bike |
            | footway     | track    | yes    | cycling | pushing bike |

    Scenario: Bike - Cycleway on oneways, speeds
        Then routability should be
            | highway     | cycleway | oneway | forw    | backw      |
            | motorway    | track    | yes    | 15 km/h |            |
            | residential | track    | yes    | 15 km/h | 4 km/h +-1 |
            | cycleway    | track    | yes    | 15 km/h | 4 km/h +-1 |
            | footway     | track    | yes    | 15 km/h | 4 km/h +-1 |
