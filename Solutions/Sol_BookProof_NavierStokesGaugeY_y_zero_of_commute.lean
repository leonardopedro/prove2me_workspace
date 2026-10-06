-- Generated from ChapterNavierStokesGaugeY.lean — solution of BookProof.NavierStokesGaugeY.y_zero_of_commute
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY




open MvPolynomial BookProof.NavierStokesFlow

variable {E : Type*} [AddCommGroup E] [Module ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution (Y : Fin 3 → E →ₗ[ℂ] E) (T : E →ₗ[ℂ] E)
    (hT : ∀ j, Y j ∘ₗ T = T ∘ₗ Y j) (v : E) (hv : ∀ j, Y j v = 0) (j : Fin 3) :
    Y j (T v) = 0 := by

  have := congrArg (fun L : E →ₗ[ℂ] E => L v) (hT j)
  simpa [hv j] using this
