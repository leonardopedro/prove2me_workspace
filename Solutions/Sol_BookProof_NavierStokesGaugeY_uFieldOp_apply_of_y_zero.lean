-- Generated from ChapterNavierStokesGaugeY.lean — solution of BookProof.NavierStokesGaugeY.uFieldOp_apply_of_y_zero
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
import Theorems.Thm_BookProof_NavierStokesFlow_field_evaluates_to_value
open BookProof.NavierStokesGaugeY




open MvPolynomial BookProof.NavierStokesFlow

variable {E : Type*} [AddCommGroup E] [Module ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution (u : Fin 3 → E →ₗ[ℂ] E) (uD : Fin 3 → Fin 3 → E →ₗ[ℂ] E)
    (Y : Fin 3 → E →ₗ[ℂ] E) (v : E) (hv : ∀ j, Y j v = 0) (i : Fin 3) :
    uFieldOp u uD Y i v = u i v := field_evaluates_to_value (u i) (uD i) Y 0 v (by simpa using hv)
