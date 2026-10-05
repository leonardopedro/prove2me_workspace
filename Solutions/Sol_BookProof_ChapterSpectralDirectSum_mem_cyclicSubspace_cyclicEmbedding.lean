-- Generated from ChapterSpectralDirectSum.lean — solution of BookProof.ChapterSpectralDirectSum.mem_cyclicSubspace_cyclicEmbedding
import Mathlib
import Definitions.Def_ChapterSpectralDirectSum
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
theorem solution (u : Lp ℂ 2 (spectralMeasure T hT xi)) :
    cyclicEmbedding T hT xi u ∈ cyclicSubspace T hT xi := (cyclicUnitary T hT xi u).2
