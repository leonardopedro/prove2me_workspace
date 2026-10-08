-- Generated from ChapterNavierStokesFullEsa.lean — theorem BookProof.NavierStokesFlow.FullEsa.hasZeroDeficiencyOn_congr
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa


open scoped ENNReal

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

theorem BookProof.NavierStokesFlow.FullEsa.hasZeroDeficiencyOn_congr {D : Submodule ℂ F} {H₁ H₂ : D →ₗ[ℂ] D}
    (h : ∀ x : D, (H₁ x : F) = (H₂ x : F)) (h₁ : HasZeroDeficiencyOn D H₁) :
    HasZeroDeficiencyOn D H₂ := by sorry
