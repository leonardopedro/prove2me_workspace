-- Generated from ChapterLorentzRealRep.lean — solution of BookProof.ChapterLorentzRealRep.b10R_linearIndependent
import Mathlib
import Definitions.Def_ChapterLorentzRealRep
import Theorems.Thm_BookProof_ChapterLorentzRealRep_gram_10R
import Theorems.Thm_BookProof_ChapterLorentzRealRep_linIndep_of_gram
open BookProof.ChapterLorentzRealRep



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega

set_option maxHeartbeats 1000000 in
theorem solution : LinearIndependent ℝ b10R := linIndep_of_gram b10R gram_10R
