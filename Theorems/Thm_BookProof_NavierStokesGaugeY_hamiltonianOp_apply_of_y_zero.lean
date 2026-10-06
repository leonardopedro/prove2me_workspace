-- Generated from ChapterNavierStokesGaugeY.lean — theorem BookProof.NavierStokesGaugeY.hamiltonianOp_apply_of_y_zero
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY

variable {E : Type*} [AddCommGroup E] [Module ℂ E]



open MvPolynomial BookProof.NavierStokesFlow

theorem BookProof.NavierStokesGaugeY.hamiltonianOp_apply_of_y_zero (nu : ℂ) (mom : Fin 3 → E →ₗ[ℂ] E)
    (u : Fin 3 → E →ₗ[ℂ] E) (uD : Fin 3 → Fin 3 → E →ₗ[ℂ] E) (uL : Fin 3 → E →ₗ[ℂ] E)
    (Y : Fin 3 → E →ₗ[ℂ] E) (hcomm : ∀ i j k, Y k ∘ₗ uD i j = uD i j ∘ₗ Y k)
    (hmom : ∀ i k, Y k ∘ₗ mom i = mom i ∘ₗ Y k) (v : E) (hv : ∀ j, Y j v = 0) :
    hamiltonianOp nu mom u uD uL Y v = hamiltonianPoint nu mom u uD uL v := by sorry
