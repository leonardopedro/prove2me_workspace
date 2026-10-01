-- Generated from ChapterNavierStokesEsa.lean — theorem BookProof.NavierStokesFlow.hasZeroDeficiencyOn_of_bounded_symmetric
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


open scoped Matrix




ve himag := congrArg Complex.im hi
    simp at himag

theorem BookProof.NavierStokesFlow.hasZeroDeficiencyOn_of_bounded_symmetric (A : F →L[ℂ] F)
    (hsym : (A : F →ₗ[ℂ] F).IsSymmetric) (D : Submodule ℂ F) (hdense : Dense (D : Set F))
    (hinv : ∀ v : D, A (v : F) ∈ D) :
    HasZeroDeficiencyOn D
      (LinearMap.codRestrict D (( := by sorry
