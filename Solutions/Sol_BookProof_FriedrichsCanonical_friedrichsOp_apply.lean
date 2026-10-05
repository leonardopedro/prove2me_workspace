-- Generated from ChapterFriedrichsCanonical.lean — solution of BookProof.FriedrichsCanonical.friedrichsOp_apply
import Mathlib
import Definitions.Def_ChapterFriedrichsCanonical
open BookProof.FriedrichsCanonical




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension.FormDom

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (P : PosSymOp F) (hdense : Dense (P.dom : Set F))
    (y : friedrichsDomain P) :
    friedrichsOp P hdense y
      = preim (friedrichsResolvent P) y - ((1 : ℝ) : ℂ) • (y : F) := rfl
