-- Generated from ChapterSeparableL2Model.lean — solution of BookProof.ChapterSeparableL2Model.abelian_multiplication_model_classified_separable_hilbert
import Mathlib
import Definitions.Def_ChapterSeparableL2Model
import Theorems.Thm_BookProof_ChapterSeparableL2Model_separable_Lp_realizes_standard_type
import Theorems.Thm_BookProof_ChapterSeparableL2Model_separableSpace_of_linearIsometry
import Theorems.Thm_BookProof_ChapterAbelianCyclicModel_isProbabilityMeasure_repMeasure
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_countable_orthogonalRepCyclicFamily
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_exists_rep_cyclic_decomposition
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_orthogonalFamily_repEmbedding
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_range_repEmbedding
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_repEmbedding_intertwines
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

set_option maxHeartbeats 1000000 in
theorem solution [SeparableSpace H]
    (pi : C(Y, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H)) :
    ∃ (S : Set H) (mu : S → Measure Y) (V : ∀ x : S, Lp ℂ 2 (mu x) →ₗᵢ[ℂ] H),
      S.Countable ∧
      (∀ x : S, IsProbabilityMeasure (mu x)) ∧
      IsHilbertSum ℂ (fun x : S => Lp ℂ 2 (mu x)) V ∧
      (∀ (x : S) (g : C(Y, ℂ)) (u : Lp ℂ 2 (mu x)),
        V x (mulRep (mu x) g u) = pi g (V x u)) ∧
      (∀ x : S, ∃ (Z : Type u) (_ : MeasurableSpace Z) (_ : StandardBorelSpace Z)
        (_ : MeasurableSingletonClass Z) (Phi : Y → Z) (hPhi : Measurable Phi),
        ∃ _ : IsProbabilityMeasure (Measure.map Phi (mu x)),
          RealizesStandardType (Measure.map Phi (mu x)) ∧
          ∃ U : Lp ℂ 2 (Measure.map Phi (mu x)) ≃ₗᵢ[ℂ] Lp ℂ 2 (mu x),
            ∀ (g : Z → ℂ) (hg : MemLp g ⊤ (Measure.map Phi (mu x)))
              (v : Lp ℂ 2 (Measure.map Phi (mu x))),
              U (multOp g hg v)
                = multOp (fun y => g (Phi y)) (hg.comp_measurePreserving ⟨hPhi, rfl⟩) (U v)) := by

  obtain ⟨S, hS, htop⟩ := exists_rep_cyclic_decomposition pi
  refine ⟨S, fun x => repMeasure pi (x : H), fun x => repEmbedding pi (x : H),
    countable_orthogonalRepCyclicFamily hS,
    fun x => isProbabilityMeasure_repMeasure pi (x : H) (hS.1 (x : H) x.2), ?_,
    fun x g u => repEmbedding_intertwines pi (x : H) g u, ?_⟩
  · refine IsHilbertSum.mk (orthogonalFamily_repEmbedding hS) ?_
    have hrange : (⨆ x : S, LinearMap.range (repEmbedding pi (x : H)).toLinearMap)
        = ⨆ x ∈ S, repCyclicSubspace pi x := by
      rw [iSup_subtype]
      exact iSup_congr fun x => iSup_congr fun _ => range_repEmbedding pi x
    rw [hrange, htop]
  · intro x
    haveI := isProbabilityMeasure_repMeasure pi (x : H) (hS.1 (x : H) x.2)
    haveI : SeparableSpace (Lp ℂ 2 (repMeasure pi (x : H))) :=
      separableSpace_of_linearIsometry (repEmbedding pi (x : H))
    exact separable_Lp_realizes_standard_type (repMeasure pi (x : H))
