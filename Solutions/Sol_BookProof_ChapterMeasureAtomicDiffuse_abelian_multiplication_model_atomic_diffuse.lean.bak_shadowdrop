-- Generated from ChapterMeasureAtomicDiffuse.lean — solution of BookProof.ChapterMeasureAtomicDiffuse.abelian_multiplication_model_atomic_diffuse
import Mathlib
import Definitions.Def_ChapterMeasureAtomicDiffuse
import Theorems.Thm_BookProof_ChapterMeasureAtomicDiffuse_exists_atomic_diffuse_decomposition
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_abelian_multiplication_model_general
open BookProof.ChapterMeasureAtomicDiffuse



noncomputable section

open MeasureTheory Complex



variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α] (mu : Measure α)

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α] (mu : Measure α)
variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution
    (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H)) :
    ∃ (S : Set H) (mu : S → Measure X) (V : ∀ x : S, Lp ℂ 2 (mu x) →ₗᵢ[ℂ] H),
      (∀ x : S, IsProbabilityMeasure (mu x)) ∧
      IsHilbertSum ℂ (fun x : S => Lp ℂ 2 (mu x)) V ∧
      (∀ (x : S) (g : C(X, ℂ)) (u : Lp ℂ 2 (mu x)),
        V x (mulRep (mu x) g u) = pi g (V x u)) ∧
      (∀ x : S, ∃ (A : Set X) (mua mud : Measure X), A.Countable ∧ MeasurableSet A ∧
        mu x = mua + mud ∧
        mua = Measure.sum (fun y : A => (mu x) {(y : X)} • Measure.dirac (y : X)) ∧
        mua Aᶜ = 0 ∧ NullSingletonClass mud) := by

  obtain ⟨S, mu, V, hprob, hsum, hint⟩ := abelian_multiplication_model_general pi
  refine ⟨S, mu, V, hprob, hsum, hint, fun x => ?_⟩
  haveI : IsProbabilityMeasure (mu x) := hprob x
  exact exists_atomic_diffuse_decomposition (mu x)
