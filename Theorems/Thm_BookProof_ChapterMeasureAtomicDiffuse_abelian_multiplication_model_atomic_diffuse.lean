-- Generated from ChapterMeasureAtomicDiffuse.lean — theorem BookProof.ChapterMeasureAtomicDiffuse.abelian_multiplication_model_atomic_diffuse
import Mathlib
import Definitions.Def_ChapterMeasureAtomicDiffuse
import Definitions.Def_ChapterA4
open BookProof.ChapterMeasureAtomicDiffuse

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α] (mu : Measure α)
variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


noncomputable section

open MeasureTheory Complex




theorem BookProof.ChapterMeasureAtomicDiffuse.abelian_multiplication_model_atomic_diffuse
    (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H)) :
    ∃ (S : Set H) (mu : S → Measure X) (V : ∀ x : S, Lp ℂ 2 (mu x) →ₗᵢ[ℂ] H),
      (∀ x : S, IsProbabilityMeasure (mu x)) ∧
      IsHilbertSum ℂ (fun x : S => Lp ℂ 2 (mu x)) V ∧
      (∀ (x : S) (g : C(X, ℂ)) (u : Lp ℂ 2 (mu x)),
        V x (mulRep (mu x) g u) = pi g (V x u)) ∧
      (∀ x : S, ∃ (A : Set X) (mua mud : Measure X), A.Countable ∧ MeasurableSet A ∧
        mu x = mua + mud ∧
        mua = Measure.sum (fun y : A => (mu x) {(y : X)} • Measure.dirac (y : X)) ∧
        mua Aᶜ = 0 ∧ NullSingletonClass mud) := by sorry
