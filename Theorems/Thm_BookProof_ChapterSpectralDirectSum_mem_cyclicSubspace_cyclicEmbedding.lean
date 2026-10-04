-- Generated from ChapterSpectralDirectSum.lean — theorem BookProof.ChapterSpectralDirectSum.mem_cyclicSubspace_cyclicEmbedding
import Mathlib
import Definitions.Def_ChapterSpectralDirectSum
import Definitions.Def_ChapterA4
open BookProof.ChapterSpectralDirectSum

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)


noncomputable section

open MeasureTheory Complex


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication
open BookProof.ChapterCyclicDecomposition BookProof.ChapterCyclicDirectSum


theorem BookProof.ChapterSpectralDirectSum.mem_cyclicSubspace_cyclicEmbedding (u : Lp ℂ 2 (spectralMeasure T hT xi)) :
    cyclicEmbedding T hT xi u ∈ cyclicSubspace T hT xi := by sorry
