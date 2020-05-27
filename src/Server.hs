{-# Language OverloadedStrings #-}
module Server where

import Network.Socket hiding (send)
import Network.Socket.ByteString as NBS
import Control.Concurrent
import Control.Monad

serv :: IO ()
serv = do
  print "begin"
  print "Running daemon"
  soc <- socket AF_UNIX Stream 0
  bind soc . SockAddrUnix $ "/tmp2/test2.soc"
  listen soc maxListenQueue
  accept soc >>= (\(x,y)-> do
    print "begin2"
    print x
    print y
    forever $ do
      msg <- NBS.recv x 400000
      print "Got message:"
      print msg
      print "Sending pong...."
      NBS.sendAll soc "ppong"
      print "alll done"

      threadDelay $ 3 * 10^6
      )
