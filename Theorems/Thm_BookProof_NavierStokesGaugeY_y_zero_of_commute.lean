-- Generated from ChapterNavierStokesGaugeY.lean — theorem BookProof.NavierStokesGaugeY.y_zero_of_commute
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY

variable {E : Type*} [AddCommGroup E] [Module ℂ E]



open MvPolynomial BookProof.NavierStokesFlow

theorem BookProof.NavierStokesGaugeY.y_zero_of_commute (Y : Fin 3 → E →ₗ[ℂ] E) (T : E →ₗ[ℂ] E)
    (hT : ∀ j, Y j ∘ₗ T = T ∘ₗ Y j) (v : E) (hv : ∀ j, Y j v = 0) (j : Fin 3) :
    Y j (T v) = 0 := by sorry
