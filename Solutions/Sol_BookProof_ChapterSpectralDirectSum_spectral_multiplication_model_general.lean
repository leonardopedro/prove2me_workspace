-- Generated from ChapterSpectralDirectSum.lean — solution of BookProof.ChapterSpectralDirectSum.spectral_multiplication_model_general
import Mathlib
import Definitions.Def_ChapterSpectralDirectSum
import Theorems.Thm_BookProof_ChapterSpectralDirectSum_range_cyclicEmbedding
import Theorems.Thm_BookProof_ChapterSpectralDirectSum_cyclicEmbedding_intertwines
import Theorems.Thm_BookProof_ChapterSpectralDirectSum_orthogonalFamily_cyclicEmbedding
import Theorems.Thm_BookProof_ChapterCyclicDecomposition_exists_cyclic_decomposition
import Theorems.Thm_BookProof_ChapterSpectralMultiplication_isProbabilityMeasure_spectralMeasure
open BookProof.ChapterSpectralDirectSum



noncomputable section

open MeasureTheory Complex


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication
open BookProof.ChapterCyclicDecomposition BookProof.ChapterCyclicDirectSum

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ (S : Set H) (mu : S → Measure (spectrum ℂ T))
      (V : ∀ x : S, Lp ℂ 2 (mu x) →ₗᵢ[ℂ] H),
      (∀ x : S, IsProbabilityMeasure (mu x)) ∧
      IsHilbertSum ℂ (fun x : S => Lp ℂ 2 (mu x)) V ∧
      (∀ (x : S) (u : Lp ℂ 2 (mu x)),
        V x (mulRep (mu x) (coordFn T) u) = T (V x u)) := by

  obtain ⟨S, hS, htop⟩ := exists_cyclic_decomposition T hT
  refine ⟨S, fun x => spectralMeasure T hT (x : H), fun x => cyclicEmbedding T hT (x : H),
    fun x => isProbabilityMeasure_spectralMeasure T hT (x : H) (hS.1 (x : H) x.2), ?_,
    fun x u => cyclicEmbedding_intertwines T hT (x : H) u⟩
  refine IsHilbertSum.mk (orthogonalFamily_cyclicEmbedding T hT hS) ?_
  have hrange : (⨆ x : S, LinearMap.range (cyclicEmbedding T hT (x : H)).toLinearMap)
      = ⨆ x ∈ S, cyclicSubspace T hT x := by
    rw [iSup_subtype]
    exact iSup_congr fun x => iSup_congr fun _ => range_cyclicEmbedding T hT x
  rw [hrange, htop]
