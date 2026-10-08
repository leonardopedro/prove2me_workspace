-- Generated from ChapterNavierStokesFullEsa.lean — theorem BookProof.NavierStokesFlow.FullEsa.hasZeroDeficiencyOn_of_boundedRealization
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa


open scoped ENNReal

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

theorem BookProof.NavierStokesFlow.FullEsa.hasZeroDeficiencyOn_of_boundedRealization {D : Submodule ℂ F} (H : D →ₗ[ℂ] D)
    (A : F →L[ℂ] F) (hsym : (A : F →ₗ[ℂ] F).IsSymmetric) (hdense : Dense (D : Set F))
    (hHA : ∀ x : D, (H x : F) = A (x : F)) : HasZeroDeficiencyOn D H := by sorry
