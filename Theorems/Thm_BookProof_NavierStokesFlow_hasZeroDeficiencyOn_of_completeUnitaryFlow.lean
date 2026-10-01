-- Generated from ChapterNavierStokesEsa.lean — theorem BookProof.NavierStokesFlow.hasZeroDeficiencyOn_of_completeUnitaryFlow
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
open BookProof.NavierStokesFlow

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*}
variable {n : ℕ} (d : NSTruncation n)


open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

l_of_bounded g s (‖w‖ * ‖(v : F)‖) hs hgd hb

theorem BookProof.NavierStokesFlow.hasZeroDeficiencyOn_of_completeUnitaryFlow (D : Submodule ℂ F) (H : D →ₗ[ℂ] D)
    (U : ℝ → F → F) (hdense : Dense (D : Set F)) (hnorm : ∀ (t : ℝ) (v : F), ‖U t v‖ = ‖v‖)
    (hU0 : ∀ v : F, U 0 v = v) (hUD : ∀ (t : ℝ) (v : D), U t (v : F) ∈ D)
    (hderiv : ∀ (v : D) (t : ℝ),
      HasDerivAt (fun s => U s (v : F)) (Complex.I • (H ⟨U t (v : := by sorry
