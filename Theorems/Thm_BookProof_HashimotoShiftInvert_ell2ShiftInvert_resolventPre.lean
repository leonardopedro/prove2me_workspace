-- Generated from ChapterHashimotoComplexShifts.lean — theorem BookProof.HashimotoShiftInvert.ell2ShiftInvert_resolventPre
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Mathlib
import Definitions.Def_ChapterHashimotoComplexShifts
import Definitions.Def_ChapterHashimotoShiftInvert
import Definitions.Def_ChapterComplexShiftCore
open scoped lp
open BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

on.2.1

theorem BookProof.HashimotoShiftInvert.ell2ShiftInvert_resolventPre {γ : ℂ} (hγ : γ.im ≠ 0) (u : ℓ²(ℕ, ℂ)) :
    ell2ShiftInvert (ell2ResolventPre hγ u) = ell2Resolven := by sorry
