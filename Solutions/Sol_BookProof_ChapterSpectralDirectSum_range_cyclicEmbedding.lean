-- Generated from ChapterSpectralDirectSum.lean — solution of BookProof.ChapterSpectralDirectSum.range_cyclicEmbedding
import Mathlib
import Definitions.Def_ChapterSpectralDirectSum
import Theorems.Thm_BookProof_ChapterSpectralDirectSum_mem_cyclicSubspace_cyclicEmbedding
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
    LinearMap.range (cyclicEmbedding T hT xi).toLinearMap = cyclicSubspace T hT xi := by

  apply le_antisymm
  · rintro _ ⟨u, rfl⟩
    exact mem_cyclicSubspace_cyclicEmbedding T hT xi u
  · intro v hv
    refine ⟨(cyclicUnitary T hT xi).symm ⟨v, hv⟩, ?_⟩
    change (cyclicUnitary T hT xi ((cyclicUnitary T hT xi).symm ⟨v, hv⟩) : H) = v
    rw [LinearIsometryEquiv.apply_symm_apply]
