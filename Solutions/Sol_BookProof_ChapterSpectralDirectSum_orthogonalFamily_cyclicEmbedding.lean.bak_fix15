-- Generated from ChapterSpectralDirectSum.lean — solution of BookProof.ChapterSpectralDirectSum.orthogonalFamily_cyclicEmbedding
import Mathlib
import Definitions.Def_ChapterSpectralDirectSum
import Theorems.Thm_BookProof_ChapterSpectralDirectSum_mem_cyclicSubspace_cyclicEmbedding
import Theorems.Thm_BookProof_ChapterSpectralDirectSum_inner_eq_zero_of_le_orthogonal
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
theorem solution {S : Set H} (hS : OrthogonalCyclicFamily T hT S) :
    OrthogonalFamily ℂ (fun x : S => Lp ℂ 2 (spectralMeasure T hT (x : H)))
      (fun x : S => cyclicEmbedding T hT (x : H)) := by

  intro x y hxy u v
  have hle := hS.2 (x : H) x.2 (y : H) y.2 (Subtype.coe_injective.ne hxy)
  exact inner_eq_zero_of_le_orthogonal hle
    (mem_cyclicSubspace_cyclicEmbedding T hT (x : H) u)
    (mem_cyclicSubspace_cyclicEmbedding T hT (y : H) v)
