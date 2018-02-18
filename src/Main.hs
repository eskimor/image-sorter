{-# LANGUAGE OverloadedStrings #-}
module Main where

import qualified Data.ByteString.UTF8 as BS
import           Data.Foldable
import           Data.UnixTime
import           System.Directory
import           System.Environment
import           System.FilePath
import           System.Posix.Files

type DateFolder = String


getFolder :: FilePath -> IO DateFolder
getFolder fp = do
  fStatus <- getFileStatus fp
  let modTimeStamp = modificationTime fStatus
  let unixTime = fromEpochTime modTimeStamp
  BS.toString <$> formatUnixTime "%Y/%m/%d" unixTime


main :: IO ()
main = do
  [inputDir, outputDir] <- getArgs
  inFiles <- map (inputDir </>) <$> listDirectory inputDir

  relativeFolders <- traverse getFolder inFiles
  let absFolders = map (outputDir </>) relativeFolders
  traverse (createDirectoryIfMissing True) absFolders

  let targets = zipWith (</>) absFolders (map takeFileName inFiles)
  let ops = zip inFiles targets
  traverse_ (uncurry copyFileWithMetadata) ops

