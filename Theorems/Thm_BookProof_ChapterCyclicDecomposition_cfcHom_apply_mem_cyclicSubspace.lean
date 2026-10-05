-- Generated from ChapterCyclicDecomposition.lean — theorem BookProof.ChapterCyclicDecomposition.cfcHom_apply_mem_cyclicSubspace
import Definitions.Def_ChapterSpectralMultiplication
import Mathlib
import Definitions.Def_ChapterCyclicDecomposition
open BookProof.ChapterCyclicDecomposition

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)


noncomputable section

open MeasureTheory Complex


open BookProof.ChapterSpectralMultiplication


theorem BookProof.ChapterCyclicDecomposition.cfcHom_apply_mem_cyclicSubspace (xi : H) (g : C(spectrum ℂ T, ℂ)) :
    cfcHom hT g xi ∈ cyclicSubspace T hT xi := by sorry
