module  Datatypes where

type clientname = String
type channelname = String

data Message = Notice String
               | Tell clientname String
               | Broadcast channelname clientname String
               | Command String
