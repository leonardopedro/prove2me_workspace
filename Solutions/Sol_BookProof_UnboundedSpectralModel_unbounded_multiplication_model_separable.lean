-- Generated from ChapterUnboundedSpectralModel.lean — solution of BookProof.UnboundedSpectralModel.unbounded_multiplication_model_separable
import Mathlib
import Definitions.Def_ChapterUnboundedSpectralModel
import Theorems.Thm_BookProof_UnboundedSpectralModel_isStarNormal_resOp
import Theorems.Thm_BookProof_UnboundedSpectralModel_model_mem
import Theorems.Thm_BookProof_UnboundedSpectralModel_model_apply
import Theorems.Thm_BookProof_UnboundedSpectralModel_model_ae_circle
import Theorems.Thm_BookProof_UnboundedSpectralModel_model_ae_ne_zero
import Theorems.Thm_BookProof_ChapterSpectralDirectSum_spectral_multiplication_model_separable
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
theorem solution [TopologicalSpace.SeparableSpace H]
    (T : UnboundedSelfAdjoint H) :
    ∃ (S : Set H) (mu : S → Measure (spectrum ℂ (resOp T)))
      (V : ∀ x : S, Lp ℂ 2 (mu x) →ₗᵢ[ℂ] H),
      S.Countable ∧
      (∀ x : S, IsProbabilityMeasure (mu x)) ∧
      IsHilbertSum ℂ (fun x : S => Lp ℂ 2 (mu x)) V ∧
      (∀ x : S, ∀ᵐ z ∂(mu x), z.1 ≠ 0 ∧ ‖z.1‖ ^ 2 = z.1.im) ∧
      (∀ (x : S) (u : Lp ℂ 2 (mu x)),
        ∃ h : V x (mulRep (mu x) (coordFn (resOp T)) u) ∈ T.domain,
          T.op ⟨V x (mulRep (mu x) (coordFn (resOp T)) u), h⟩
            = V x (u + Complex.I • mulRep (mu x) (coordFn (resOp T)) u)) := by

  obtain ⟨S, mu, V, hcount, hprob, hsum, hint⟩ :=
    spectral_multiplication_model_separable (resOp T) (isStarNormal_resOp T)
  refine ⟨S, mu, V, hcount, hprob, hsum, ?_, ?_⟩
  · intro x
    have := hprob x
    exact (model_ae_ne_zero T (V x) (hint x)).and (model_ae_circle T (V x) (hint x))
  · intro x u
    exact ⟨model_mem T (V x) (hint x) u, model_apply T (V x) (hint x) u⟩
