-- Generated from ChapterCyclicDecomposition.lean — theorem BookProof.ChapterCyclicDecomposition.exists_cyclic_decomposition
import Definitions.Def_ChapterSpectralMultiplication
import Mathlib
import Definitions.Def_ChapterCyclicDecomposition
open BookProof.ChapterCyclicDecomposition


noncomputable section

open MeasureTheory Complex


open BookProof.ChapterSpectralMultiplication

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)


theorem BookProof.ChapterCyclicDecomposition.exists_cyclic_decomposition :
    ∃ S : Set H, OrthogonalCyclicFamily T hT S ∧
      (⨆ x ∈ S, cyclicSubspace T hT x).topologicalClosure = ⊤ := by sorry
