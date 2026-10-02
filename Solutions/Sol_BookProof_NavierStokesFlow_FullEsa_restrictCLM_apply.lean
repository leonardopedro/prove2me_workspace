-- Generated from ChapterNavierStokesFullEsa.lean — solution of BookProof.NavierStokesFlow.FullEsa.restrictCLM_apply
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa



open scoped ENNReal

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (A : F →L[ℂ] F) (D : Submodule ℂ F)
    (h : ∀ v : D, A (v : F) ∈ D) (x : D) : ((restrictCLM A D h x : D) : F) = A (x : F) := rfl
