-- Generated from ChapterSpectralDirectSum.lean — theorem BookProof.ChapterSpectralDirectSum.orthogonalFamily_cyclicEmbedding
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterSpectralMultiplication
import Definitions.Def_ChapterCyclicDecomposition
import Definitions.Def_ChapterCyclicDirectSum
import Mathlib
import Definitions.Def_ChapterSpectralDirectSum
open BookProof.ChapterSpectralDirectSum

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)


noncomputable section

open MeasureTheory Complex


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication
open BookProof.ChapterCyclicDecomposition BookProof.ChapterCyclicDirectSum


theorem BookProof.ChapterSpectralDirectSum.orthogonalFamily_cyclicEmbedding {S : Set H} (hS : OrthogonalCyclicFamily T hT S) :
    OrthogonalFamily ℂ (fun x : S => Lp ℂ 2 (spectralMeasure T hT (x : H)))
      (fun x : S => cyclicEmbedding T hT (x : H)) := by sorry
