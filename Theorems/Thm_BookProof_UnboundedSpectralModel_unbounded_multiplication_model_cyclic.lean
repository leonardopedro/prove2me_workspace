-- Generated from ChapterUnboundedSpectralModel.lean — theorem BookProof.UnboundedSpectralModel.unbounded_multiplication_model_cyclic
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterSpectralMultiplication
import Definitions.Def_ChapterSpectralDirectSum
import Mathlib
import Definitions.Def_ChapterUnboundedSpectralModel
import Definitions.Def_ChapterStoneResolvent
open BookProof.UnboundedSpectralModel


noncomputable section

open MeasureTheory Complex
open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication
open BookProof.ChapterSpectralDirectSum

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable (T : UnboundedSelfAdjoint H) {mu : Measure (spectrum ℂ (resOp T))}
  (V : Lp ℂ 2 mu →ₗᵢ[ℂ] H)
  (hV : ∀ u : Lp ℂ 2 mu, V (mulRep mu (coordFn (resOp T)) u) = resOp T (V u))

theorem BookProof.UnboundedSpectralModel.unbounded_multiplication_model_cyclic (T : UnboundedSelfAdjoint H) (xi : H)
    (hxi : ‖xi‖ = 1)
    (hcyc : DenseRange (cfcVec (resOp T) (isStarNormal_resOp T) xi)) :
    ∃ (mu : Measure (spectrum ℂ (resOp T))) (_ : IsProbabilityMeasure mu)
      (U : Lp ℂ 2 mu ≃ₗᵢ[ℂ] H),
      (∀ᵐ z ∂mu, z.1 ≠ 0 ∧ ‖z.1‖ ^ 2 = z.1.im) ∧
      (∀ u : Lp ℂ 2 mu, ∃ h : U (mulRep mu (coordFn (resOp T)) u) ∈ T.domain,
        T.op ⟨U (mulRep mu (coordFn (resOp T)) u), h⟩
          = U (u + Complex.I • mulRep mu (coordFn (resOp T)) u)) ∧
      (∀ x ∈ T.domain, ∃ u : Lp ℂ 2 mu, x = U (mulRep mu (coordFn (resOp T)) u)) := by sorry
