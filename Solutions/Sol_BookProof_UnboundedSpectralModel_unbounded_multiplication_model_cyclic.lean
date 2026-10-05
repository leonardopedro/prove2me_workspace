-- Generated from ChapterUnboundedSpectralModel.lean — solution of BookProof.UnboundedSpectralModel.unbounded_multiplication_model_cyclic
import Mathlib
import Definitions.Def_ChapterUnboundedSpectralModel
import Theorems.Thm_BookProof_UnboundedSpectralModel_exists_resOp_eq
import Theorems.Thm_BookProof_UnboundedSpectralModel_isStarNormal_resOp
import Theorems.Thm_BookProof_UnboundedSpectralModel_model_mem
import Theorems.Thm_BookProof_UnboundedSpectralModel_model_apply
import Theorems.Thm_BookProof_UnboundedSpectralModel_model_ae_circle
import Theorems.Thm_BookProof_UnboundedSpectralModel_model_ae_ne_zero
import Theorems.Thm_BookProof_ChapterSpectralMultiplication_spectral_multiplication_model
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
theorem solution (T : UnboundedSelfAdjoint H) (xi : H)
    (hxi : ‖xi‖ = 1)
    (hcyc : DenseRange (cfcVec (resOp T) (isStarNormal_resOp T) xi)) :
    ∃ (mu : Measure (spectrum ℂ (resOp T))) (_ : IsProbabilityMeasure mu)
      (U : Lp ℂ 2 mu ≃ₗᵢ[ℂ] H),
      (∀ᵐ z ∂mu, z.1 ≠ 0 ∧ ‖z.1‖ ^ 2 = z.1.im) ∧
      (∀ u : Lp ℂ 2 mu, ∃ h : U (mulRep mu (coordFn (resOp T)) u) ∈ T.domain,
        T.op ⟨U (mulRep mu (coordFn (resOp T)) u), h⟩
          = U (u + Complex.I • mulRep mu (coordFn (resOp T)) u)) ∧
      (∀ x ∈ T.domain, ∃ u : Lp ℂ 2 mu, x = U (mulRep mu (coordFn (resOp T)) u)) := by

  obtain ⟨mu, hmu, U, h1, _h2⟩ :=
    spectral_multiplication_model (resOp T) (isStarNormal_resOp T) xi hcyc hxi
  have hV : ∀ u : Lp ℂ 2 mu,
      U.toLinearIsometry (mulRep mu (coordFn (resOp T)) u) = resOp T (U.toLinearIsometry u) :=
    h1
  refine ⟨mu, hmu, U, ?_, ?_, ?_⟩
  · exact (model_ae_ne_zero T U.toLinearIsometry hV).and
      (model_ae_circle T U.toLinearIsometry hV)
  · intro u
    exact ⟨model_mem T U.toLinearIsometry hV u, model_apply T U.toLinearIsometry hV u⟩
  · intro x hx
    obtain ⟨y, hy⟩ := exists_resOp_eq T hx
    refine ⟨U.symm y, ?_⟩
    have := hV (U.symm y)
    simp only [LinearIsometryEquiv.coe_toLinearIsometry, LinearIsometryEquiv.apply_symm_apply]
      at this
    rw [this, hy]
