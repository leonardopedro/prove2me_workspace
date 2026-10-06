-- Generated from ChapterLorentzRealRep.lean — solution of BookProof.ChapterLorentzRealRep.bPsR_linearIndependent
import Mathlib
import Definitions.Def_ChapterLorentzRealRep
import Theorems.Thm_BookProof_ChapterLorentzRealRep_gram_psR
import Theorems.Thm_BookProof_ChapterLorentzRealRep_linIndep_of_gram
open BookProof.ChapterLorentzRealRep



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega

set_option maxHeartbeats 1000000 in
theorem solution : LinearIndependent ℝ bPsR := linIndep_of_gram bPsR gram_psR
