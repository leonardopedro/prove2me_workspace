-- Generated from ChapterCyclicDecomposition.lean — theorem BookProof.ChapterCyclicDecomposition.invariant_iSup_cyclicSubspace
import Definitions.Def_ChapterSpectralMultiplication
import Mathlib
import Definitions.Def_ChapterCyclicDecomposition
open BookProof.ChapterCyclicDecomposition

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)


noncomputable section

open MeasureTheory Complex


open BookProof.ChapterSpectralMultiplication


theorem BookProof.ChapterCyclicDecomposition.invariant_iSup_cyclicSubspace (S : Set H) :
    Invariant T hT (⨆ x ∈ S, cyclicSubspace T hT x).topologicalClosure := by sorry
