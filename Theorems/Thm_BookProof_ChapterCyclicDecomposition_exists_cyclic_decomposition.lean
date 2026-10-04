-- Generated from ChapterCyclicDecomposition.lean — theorem BookProof.ChapterCyclicDecomposition.exists_cyclic_decomposition
import Mathlib
import Definitions.Def_ChapterCyclicDecomposition
import Definitions.Def_ChapterA4
open BookProof.ChapterCyclicDecomposition

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)


noncomputable section

open MeasureTheory Complex


open BookProof.ChapterSpectralMultiplication


theorem BookProof.ChapterCyclicDecomposition.exists_cyclic_decomposition :
    ∃ S : Set H, OrthogonalCyclicFamily T hT S ∧
      (⨆ x ∈ S, cyclicSubspace T hT x).topologicalClosure = ⊤ := by sorry
