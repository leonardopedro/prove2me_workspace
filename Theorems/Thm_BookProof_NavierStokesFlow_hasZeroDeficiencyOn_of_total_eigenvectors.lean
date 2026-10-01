-- Generated from ChapterNavierStokesEsa.lean — theorem BookProof.NavierStokesFlow.hasZeroDeficiencyOn_of_total_eigenvectors
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.NavierStokesFlow

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*}
variable {n : ℕ} (d : NSTruncation n)


open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

    (by norm_num) w fun v => ?_
    simpa using hw v

theorem BookProof.NavierStokesFlow.hasZeroDeficiencyOn_of_total_eigenvectors {I : Type*} (D : Submodule ℂ F) (H : D →ₗ[ℂ] D)
    (e : I → D) (lam : I → ℝ) (heig : ∀ i, H (e i) = ((lam i : ℂ)) • e i)
    (htotal : ∀ w : F, (∀ i, (inner ℂ ((e i : F)) w := by sorry
