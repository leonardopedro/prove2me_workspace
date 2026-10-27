-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.farisLavine_without_symmetry_forces_trivial
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]
variable {n : ℕ} (L : LagrangianNS n)
variable {n : ℕ} (d : NSTruncation n)
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution
    (crit : ∀ (H' N' : F →ₗ[ℂ] F) (a b : ℝ),
      (∀ v : F, ‖H' v‖ ≤ a * ‖N' v‖) →
      (∀ v : F, ‖(inner ℂ v (H' (N' v) - N' (H' v)) : ℂ)‖ ≤ b * ‖(inner ℂ v (N' v) : ℂ)‖) →
      HasZeroDeficiency H') (v : F) : v = 0 :=
  (crit (Complex.I • LinearMap.id) LinearMap.id 1 1 (fun v => by simp [norm_smul])
      (fun v => by simp)).1 v (by simp)
