-- # LANGUAGE RecordWildCards
module Module.AppTypes where

import           System.Posix

-- Configuration from command line
data AppConfig =
  AppConfig
    -- | Path to start computing information
    { basePath       :: FilePath
    -- | Maximum depth of recursive search
    , maxDepth       :: Int
    -- | Is there extension to match
    , extension      :: Maybe String
    -- | Should we follows links
    , followSymlinks :: Bool
    }

-- Appenv is the application state
data AppEnv =
  AppEnv
    -- | Configuration from cli
    { cfg        :: AppConfig
    -- | Current path
    , path       :: FilePath
    -- | Current depth
    , depth      :: Int
    -- | FileStatus
    , fileStatus :: FilePath -> IO FileStatus
    }

-- generates initial status based on the configuration
initialEnv ::
     AppConfig -- ^ Application configuration
  -> AppEnv
initialEnv config =
  AppEnv
    { cfg = config
    , path = basePath config
    , depth = 0
    , fileStatus =
        if followSymlinks config
          then getFileStatus
          else getSymbolicLinkStatus
    }
