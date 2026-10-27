-- Generated from ChapterUnboundedSpectralModel.lean — solution of BookProof.UnboundedSpectralModel.model_ae_circle
import Mathlib
import Definitions.Def_ChapterUnboundedSpectralModel
import Theorems.Thm_BookProof_UnboundedSpectralModel_mulRep_cayleyFn_eq_zero
import Theorems.Thm_BookProof_ChapterLinftyMultiplication_multOp_eq_zero_iff
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
theorem solution [IsFiniteMeasure mu] : ∀ᵐ z ∂mu, ‖z.1‖ ^ 2 = z.1.im := by

  have h0 : mulRep mu (cayleyFn T) = 0 := mulRep_cayleyFn_eq_zero T V hV
  have hae : (fun z => (cayleyFn T z : ℂ)) =ᵐ[mu] 0 :=
    (BookProof.ChapterLinftyMultiplication.multOp_eq_zero_iff (μ := mu)
      (fun z => (cayleyFn T z : ℂ)) (contMemLpTop mu (cayleyFn T))).mp h0
  filter_upwards [hae] with z hz
  have : ((z.1.im - ‖z.1‖ ^ 2 : ℝ) : ℂ) = 0 := hz
  have hr : (z.1.im - ‖z.1‖ ^ 2 : ℝ) = 0 := by exact_mod_cast this
  linarith
