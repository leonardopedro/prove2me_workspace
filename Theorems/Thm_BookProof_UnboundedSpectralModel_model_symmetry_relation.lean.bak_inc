-- Generated from ChapterUnboundedSpectralModel.lean — theorem BookProof.UnboundedSpectralModel.model_symmetry_relation
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterSpectralMultiplication
import Definitions.Def_ChapterSpectralDirectSum
import Mathlib
import Definitions.Def_ChapterUnboundedSpectralModel
import Definitions.Def_ChapterStoneConverse
import Definitions.Def_ChapterStoneResolvent
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup
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

theorem BookProof.UnboundedSpectralModel.model_symmetry_relation (u : Lp ℂ 2 mu) :
    (inner ℂ u (mulRep mu (coordFn (resOp T)) u) : ℂ)
        - inner ℂ (mulRep mu (coordFn (resOp T)) u) u
      = (2 * Complex.I)
          * inner ℂ (mulRep mu (coordFn (resOp T)) u) (mulRep mu (coordFn (resOp T)) u) := by sorry
