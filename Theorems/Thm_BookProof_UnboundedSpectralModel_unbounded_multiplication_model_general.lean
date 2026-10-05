-- Generated from ChapterUnboundedSpectralModel.lean — theorem BookProof.UnboundedSpectralModel.unbounded_multiplication_model_general
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterSpectralMultiplication
import Definitions.Def_ChapterSpectralDirectSum
import Mathlib
import Definitions.Def_ChapterUnboundedSpectralModel
import Definitions.Def_ChapterStoneResolvent
open BookProof.UnboundedSpectralModel

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H) {mu : Measure (spectrum ℂ (resOp T))}
  (V : Lp ℂ 2 mu →ₗᵢ[ℂ] H)
  (hV : ∀ u : Lp ℂ 2 mu, V (mulRep mu (coordFn (resOp T)) u) = resOp T (V u))


noncomputable section

open MeasureTheory Complex
open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication
open BookProof.ChapterSpectralDirectSum


theorem BookProof.UnboundedSpectralModel.unbounded_multiplication_model_general (T : UnboundedSelfAdjoint H) :
    ∃ (S : Set H) (mu : S → Measure (spectrum ℂ (resOp T)))
      (V : ∀ x : S, Lp ℂ 2 (mu x) →ₗᵢ[ℂ] H),
      (∀ x : S, IsProbabilityMeasure (mu x)) ∧
      IsHilbertSum ℂ (fun x : S => Lp ℂ 2 (mu x)) V ∧
      (∀ x : S, ∀ᵐ z ∂(mu x), z.1 ≠ 0 ∧ ‖z.1‖ ^ 2 = z.1.im) ∧
      (∀ (x : S) (u : Lp ℂ 2 (mu x)),
        ∃ h : V x (mulRep (mu x) (coordFn (resOp T)) u) ∈ T.domain,
          T.op ⟨V x (mulRep (mu x) (coordFn (resOp T)) u), h⟩
            = V x (u + Complex.I • mulRep (mu x) (coordFn (resOp T)) u)) := by sorry
