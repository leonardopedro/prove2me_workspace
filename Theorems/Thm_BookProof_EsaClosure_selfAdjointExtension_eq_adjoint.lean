-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.selfAdjointExtension_eq_adjoint
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFarisLavineCore
open BookProof.HashimotoShiftInvert
open BookProof.EsaClosure


open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable [CompleteSpace F]

theorem BookProof.EsaClosure.selfAdjointExtension_eq_adjoint {Dom : Submodule ℂ F} {T : D →ₗ[ℂ] F} {A : Dom →ₗ[ℂ] F}
    (hesa : EssentiallySelfAdjointOn D T) (hA : IsSelfAdjointExtension T A) (w u : F) :
    ((∀ v : D, (inner ℂ (T v) w : ℂ) = inner ℂ (v : F) u) ↔
      ∃ h : w ∈ Dom, A ⟨w, h⟩ = u) := by sorry
