-- Generated from ChapterFriedrichsCanonical.lean — solution of BookProof.FriedrichsCanonical.friedrichsOp_symmetricOn
import Mathlib
import Definitions.Def_ChapterFriedrichsCanonical
import Theorems.Thm_BookProof_FriedrichsCanonical_friedrichsOp_isPositiveSelfAdjointExtension
open BookProof.FriedrichsCanonical




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension.FormDom

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (P : PosSymOp F) (hdense : Dense (P.dom : Set F)) :
    SymmetricOn (friedrichsDomain P) (friedrichsOp P hdense) := (friedrichsOp_isPositiveSelfAdjointExtension P hdense).2.1
