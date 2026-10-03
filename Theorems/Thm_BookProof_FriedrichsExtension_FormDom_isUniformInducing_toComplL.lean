-- Generated from ChapterFriedrichsExtension.lean — theorem BookProof.FriedrichsExtension.FormDom.isUniformInducing_toComplL
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin
open scoped InnerProductSpace ENNReal lp


iformSpace.Completion.denseRange_coe (α := FormDom P)

theorem BookProof.FriedrichsExtension.FormDom.isUniformInducing_toComplL (P : PosSymOp F) :
    IsUniformInducing (UniformSpace.Completion.toComplL (𝕜 := by sorry
