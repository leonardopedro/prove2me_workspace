-- Generated from ChapterSpectralDirectSum.lean — solution of BookProof.ChapterSpectralDirectSum.inner_eq_zero_of_orthogonalCyclicFamily
import Mathlib
import Definitions.Def_ChapterSpectralDirectSum
import Theorems.Thm_BookProof_ChapterSpectralDirectSum_inner_eq_zero_of_le_orthogonal
import Theorems.Thm_BookProof_ChapterCyclicDecomposition_self_mem_cyclicSubspace
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
theorem solution {S : Set H} (hS : OrthogonalCyclicFamily T hT S)
    {x y : H} (hx : x ∈ S) (hy : y ∈ S) (hxy : x ≠ y) : inner ℂ x y = (0 : ℂ) :=
  inner_eq_zero_of_le_orthogonal (hS.2 x hx y hy hxy) (self_mem_cyclicSubspace T hT x)
      (self_mem_cyclicSubspace T hT y)
