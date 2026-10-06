-- Generated from ChapterLorentzRealRepSum.lean — solution of BookProof.ChapterLorentzRealRepSum.bAllR_linearIndependent
import Mathlib
import Definitions.Def_ChapterLorentzRealRepSum
import Theorems.Thm_BookProof_ChapterLorentzRealRepSum_gram_allR
import Theorems.Thm_BookProof_ChapterLorentzRealRep_linIndep_of_gram
open BookProof.ChapterLorentzRealRepSum



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open Module

set_option maxHeartbeats 1000000 in
theorem solution : LinearIndependent ℝ bAllR := linIndep_of_gram bAllR gram_allR
