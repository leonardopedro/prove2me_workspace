-- Generated from ChapterFriedrichsExtension.lean — theorem BookProof.FriedrichsExtension.FormDom.friedrichsResolvent_injective
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterLeafGaps
open BookProof.QgOuterFockFL
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin
open scoped InnerProductSpace ENNReal lp

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable [CompleteSpace F]

-- The statement is already carried by the published `Def_ChapterQgOuterFockFarisLavine`
-- bundle (which inlines `friedrichsResolvent_injective`), so this stub keeps only the
-- imports: re-declaring it here makes the offline statement-module build fail with
-- "has already been declared" for every sol that imports it.
example (P : PosSymOp F) (hdense : Dense (P.dom : Set F)) :
    Function.Injective (friedrichsResolvent P) := by sorry
