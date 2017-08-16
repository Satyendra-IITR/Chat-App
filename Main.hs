module Main where

import Control.Concurrent (forkFinally)
import Control.Monad      (forever)
import Network            (PortID(..), accept, listenOn, withSocketsDo)
import System.IO          (hClose)
import Text.Printf        (printf)

import Server             (handleClient, newServer)

main :: IO ()
main = withSocketsDo $ do
    server <- newServer
    sock <- listenOn (PortNumber (fromIntegral port))
    _ <- printf "Server Created on Port :  %d\n" port

    forever $ do
        (handle, host, port') <- accept sock
        _ <- printf "Accepted connection from %s: %s\n" host (show port')
        forkFinally (handleClient handle server) (\_ -> hClose handle)


--make connection via ffi to admin.c and get port number and default channelname  



port :: Int
port = 1234
