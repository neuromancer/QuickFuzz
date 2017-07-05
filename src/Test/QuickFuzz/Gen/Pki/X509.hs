{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE IncoherentInstances #-}
{-# LANGUAGE DeriveGeneric #-}

module Test.QuickFuzz.Gen.Pki.X509 where

import Data.Default

import Data.X509
import Data.ASN1.Types
import Data.ASN1.Encoding
import Data.ASN1.BitArray
import Data.ASN1.BinaryEncoding
import Crypto.PubKey.ECC.Types

import Time.Types

import Test.QuickCheck
import Control.Monad
import Control.DeepSeq
import Control.Monad.Trans
import Control.Monad.Trans.State
import Data.List
import Data.Monoid 

import Test.QuickFuzz.Derive.Arbitrary
import Test.QuickFuzz.Derive.NFData
import Test.QuickFuzz.Derive.Show
import Test.QuickFuzz.Gen.FormatInfo
import Test.QuickFuzz.Gen.Base.ByteString
import Test.QuickFuzz.Gen.Base.String

import qualified Data.ByteString.Lazy as L

devArbitrary ''Certificate
devNFData ''Certificate

x509Info :: FormatInfo Certificate NoActions
x509Info = def 
    { encode = L.fromStrict . (\x -> encodeASN1' DER (toASN1 x []))
    , random = arbitrary
    , value = show
    , ext = "x509" 
    } 
