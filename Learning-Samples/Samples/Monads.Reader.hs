 -- {-# LANGUAGE FlexibleContexts #-}
module Samples.Monads.Reader where
import Control.Monad.Reader


-- Environment that keeps global values
newtype Environment = Environment { getLogLevel::String }  deriving Show


-- Create a default environment
getDefaultEnv :: Environment
getDefaultEnv = Environment "DEBUG"


-- Function that logs but adding a levelq
logger:: String -> String-> IO ()
logger level mesg =  print $ level ++": "++mesg


--bussinesLogic::  (MonadReader Environment m, MonadIO m)  => m ()
-- Bussines logic that will be runned by runReaderT, and do IO opperations
bussinesLogic = do 
                    env <- asks getLogLevel
                    liftIO (logger env "Starting Application")     -- liftIO for using IO inside a reader
                    local (\env -> Environment "INFO")$ do                          -- Change a local environment
                                                            env <- asks getLogLevel
                                                            liftIO (logger env "Running in info <<---")
                    liftIO $ logger env "Getting back on previous environment"
                    return ()


main:: IO()
main = do 
            let env = getDefaultEnv
            runReaderT bussinesLogic  env
            return ()
    