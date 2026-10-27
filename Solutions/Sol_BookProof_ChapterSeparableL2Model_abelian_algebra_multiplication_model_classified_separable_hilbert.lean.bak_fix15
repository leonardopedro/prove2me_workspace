-- Generated from ChapterSeparableL2Model.lean — solution of BookProof.ChapterSeparableL2Model.abelian_algebra_multiplication_model_classified_separable_hilbert
import Mathlib
import Definitions.Def_ChapterSeparableL2Model
import Theorems.Thm_BookProof_ChapterSeparableL2Model_abelian_multiplication_model_classified_separable_hilbert
open BookProof.ChapterSeparableL2Model



noncomputable section

open MeasureTheory TopologicalSpace


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel
open BookProof.ChapterAbelianDirectSum BookProof.ChapterLinftyMultiplication
open BookProof.ChapterStandardBorelClassification

variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y] [MeasurableSpace Y]
  [BorelSpace Y] (mu : Measure Y) [IsFiniteMeasure mu] [mu.WeaklyRegular]
variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [MeasurableSpace Y]
  [BorelSpace Y] (D : Set C(Y, ℂ)) [Countable D]
variable {Y : Type u} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y] [MeasurableSpace Y]
  [BorelSpace Y] (mu : Measure Y) [IsProbabilityMeasure mu] [mu.WeaklyRegular]
variable {Y : Type u} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y] [MeasurableSpace Y]
  [BorelSpace Y]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable {A : Type v} [CommCStarAlgebra A]

set_option maxHeartbeats 1000000 in
theorem solution
    [TopologicalSpace.SeparableSpace H] (rho : A →⋆ₐ[ℂ] (H →L[ℂ] H)) :
    ∃ (S : Set H) (mu : S → Measure (characterSpace ℂ A))
      (V : ∀ x : S, Lp ℂ 2 (mu x) →ₗᵢ[ℂ] H),
      S.Countable ∧
      (∀ x : S, IsProbabilityMeasure (mu x)) ∧
      IsHilbertSum ℂ (fun x : S => Lp ℂ 2 (mu x)) V ∧
      (∀ (x : S) (a : A) (u : Lp ℂ 2 (mu x)),
        V x (mulRep (mu x) (gelfandModel A a) u) = rho a (V x u)) ∧
      (∀ x : S, ∃ (Z : Type v) (_ : MeasurableSpace Z) (_ : StandardBorelSpace Z)
        (_ : MeasurableSingletonClass Z) (Phi : characterSpace ℂ A → Z)
        (hPhi : Measurable Phi),
        ∃ _ : IsProbabilityMeasure (Measure.map Phi (mu x)),
          RealizesStandardType (Measure.map Phi (mu x)) ∧
          ∃ U : Lp ℂ 2 (Measure.map Phi (mu x)) ≃ₗᵢ[ℂ] Lp ℂ 2 (mu x),
            ∀ (g : Z → ℂ) (hg : MemLp g ⊤ (Measure.map Phi (mu x)))
              (v : Lp ℂ 2 (Measure.map Phi (mu x))),
              U (multOp g hg v)
                = multOp (fun y => g (Phi y)) (hg.comp_measurePreserving ⟨hPhi, rfl⟩) (U v)) := by

  obtain ⟨S, mu, V, hcount, hprob, hsum, hint, hclass⟩ :=
    abelian_multiplication_model_classified_separable_hilbert (gelfandRep rho)
  refine ⟨S, mu, V, hcount, hprob, hsum, fun x a u => ?_, hclass⟩
  rw [hint x (gelfandModel A a) u, gelfandRep_gelfandModel]
