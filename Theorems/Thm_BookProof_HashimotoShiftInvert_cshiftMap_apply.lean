-- Generated from ChapterComplexShiftCore.lean — theorem BookProof.HashimotoShiftInvert.cshiftMap_apply
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterComplexShiftCore
open BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}



open BookProof.FarisLavine
open Filter Topology

theorem BookProof.HashimotoShiftInvert.cshiftMap_apply (A : Dom →ₗ[ℂ] F) (γ : ℂ) (x : Dom) :
    cshiftMap A γ x = γ • (x : F) - A x := by sorry
