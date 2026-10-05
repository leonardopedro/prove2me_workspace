-- Generated from ChapterFriedrichsCanonical.lean — theorem BookProof.FriedrichsCanonical.eq_zero_of_inner_coe_eq_zero
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterFriedrichsCanonical
import Definitions.Def_ChapterFriedrichsExtension
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension
open BookProof.FriedrichsCanonical

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension

noncomputable section


theorem BookProof.FriedrichsCanonical.eq_zero_of_inner_coe_eq_zero (P : PosSymOp F) (k : FormSpace P)
    (h : ∀ v : FormDom P, (inner ℂ (v : FormSpace P) k : ℂ) = 0) : k = 0 := by sorry
