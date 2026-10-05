-- Generated from ChapterUnboundedSpectralModel.lean — solution of BookProof.UnboundedSpectralModel.model_ae_real_multiplier
import Mathlib
import Definitions.Def_ChapterUnboundedSpectralModel
import Theorems.Thm_BookProof_UnboundedSpectralModel_cayley_real_multiplier
import Theorems.Thm_BookProof_UnboundedSpectralModel_model_ae_circle
import Theorems.Thm_BookProof_UnboundedSpectralModel_model_ae_ne_zero
open BookProof.UnboundedSpectralModel



noncomputable section

open MeasureTheory Complex
open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication
open BookProof.ChapterSpectralDirectSum

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H) {mu : Measure (spectrum ℂ (resOp T))}
  (V : Lp ℂ 2 mu →ₗᵢ[ℂ] H)
  (hV : ∀ u : Lp ℂ 2 mu, V (mulRep mu (coordFn (resOp T)) u) = resOp T (V u))

set_option maxHeartbeats 1000000 in
theorem solution [IsFiniteMeasure mu] :
    ∀ᵐ z ∂mu, 1 + Complex.I * z.1 = ((z.1.re / ‖z.1‖ ^ 2 : ℝ) : ℂ) * z.1 := by

  filter_upwards [model_ae_circle T V hV, model_ae_ne_zero T V hV] with z hcirc hne
  exact cayley_real_multiplier hcirc hne
