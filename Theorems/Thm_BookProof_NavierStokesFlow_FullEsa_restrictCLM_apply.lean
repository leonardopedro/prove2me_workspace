-- Generated from ChapterNavierStokesFullEsa.lean — theorem BookProof.NavierStokesFlow.FullEsa.restrictCLM_apply
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}


open scoped ENNReal

theorem BookProof.NavierStokesFlow.FullEsa.restrictCLM_apply (A : F →L[ℂ] F) (D : Submodule ℂ F)
    (h : ∀ v : D, A (v : F) ∈ D) (x : D) : ((restrictCLM A D h x : D) : F) = A (x : F) := by sorry
