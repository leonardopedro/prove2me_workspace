-- Generated from ChapterNavierStokesGaugeY.lean — theorem BookProof.NavierStokesGaugeY.uFieldOp_apply_of_y_zero
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY

variable {E : Type*} [AddCommGroup E] [Module ℂ E]



open MvPolynomial BookProof.NavierStokesFlow

theorem BookProof.NavierStokesGaugeY.uFieldOp_apply_of_y_zero (u : Fin 3 → E →ₗ[ℂ] E) (uD : Fin 3 → Fin 3 → E →ₗ[ℂ] E)
    (Y : Fin 3 → E →ₗ[ℂ] E) (v : E) (hv : ∀ j, Y j v = 0) (i : Fin 3) :
    uFieldOp u uD Y i v = u i v := by sorry
