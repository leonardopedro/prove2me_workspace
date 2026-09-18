-- Generated from ChapterFriedrichsExtension.lean — theorem BookProof.FriedrichsExtension.FormDom.dense_range_formExt
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_BookProof.ChapterClosureUniqueness

open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.FriedrichsExtension.FormDom.dense_range_formExt (P : PosSymOp F) (hdense : Dense (P.dom : Set F)) :
    Dense (Set.range (formExt P)) := by sorry
