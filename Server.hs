{-# LANGUAGE LambdaCase, RecordWildCards #-}

module Server where

import           Control.Applicative
import           Control.Concurrent.Async (race_)
import           Control.Concurrent.STM
import           Control.Exception        (finally, mask)
import           Control.Monad
import           Data.Map                 (Map)
import qualified Data.Map                 as M
import qualified Data.Set                 as S
import           System.IO
import           Text.Printf              (hPrintf, printf)


import Client
import Dataypes

data Server = Server
    { serverChannels :: TVar (Map ChannelName Channel)
    , serverClients  :: TVar (Map ClientName Client)
    }

defaultChannelName :: ChannelName
defaultChannelName = "General"

welcomeMsg :: String
welcomeMsg = unlines
    [ "Welcome to the server! Available commands:"
    , "/whisper name msg - whisper 'msg' to 'name'"
    , "/join    name     - join channel 'name'"
    , "/users            - list the users in the current channel"
    , "/whoami           - list your name and channel"
    , "/kick    name     - kick 'name'"
    , "/quit             - quit the server"
    , "/nick    newName  - TO change your name "
    , "/ignore  name     - To stop getting messages from a particular user"
    , "/revive           - To restart getting messages from all the users"
    , "/chat             - To chat personally with a user"
    , "/listall          - list all the users from all the channels"
    , "/listmine         - list all the users in your active channel"
    , "/help             - see available help options "
    ]


