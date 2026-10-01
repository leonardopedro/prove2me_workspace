-- Generated from ChapterComplexShiftCore.lean — theorem BookProof.HashimotoShiftInvert.cshiftMap_injective
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFarisLavineCore
open BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}



open BookProof.FarisLavine
open Filter Topology

theorem BookProof.HashimotoShiftInvert.cshiftMap_injective {A : Dom →ₗ[ℂ] F} (hsym : SymmetricOn Dom A)
    {γ : ℂ} (hγ : γ.im ≠ 0) : Function.Injective (cshiftMap A γ) := by sorry
