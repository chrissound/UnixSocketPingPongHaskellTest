{-# Language OverloadedStrings #-}
module Main where

import Network.Socket hiding (send)
import Network.Socket.ByteString as NBS
import Control.Concurrent
import Control.Monad

main :: IO ()
main = do
  putStrLn "Hello, Haskell!2"
  withSocketsDo $ do
    soc <- socket AF_UNIX Stream 0
    connect (soc) (SockAddrUnix "/tmp2/test2.soc")
    forever $ do
      send soc ("ping")
      threadDelay $ 1 * 10^6
      print "sent ping....."
      threadDelay $ 1 * 10^6
      msg <- NBS.recv soc 400000
      print msg
      print "got reply to ping...."
    close soc

