-- Generated from ChapterCyclicDirectSum.lean — theorem BookProof.ChapterCyclicDirectSum.starProjection_cyclicSubspace_commutes
import Definitions.Def_ChapterCyclicDecomposition
import Mathlib
import Definitions.Def_ChapterCyclicDirectSum
open BookProof.ChapterCyclicDirectSum

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)


noncomputable section

open MeasureTheory Complex


open BookProof.ChapterCyclicDecomposition


theorem BookProof.ChapterCyclicDirectSum.starProjection_cyclicSubspace_commutes (xi : H) (g : C(spectrum ℂ T, ℂ)) :
    Commute (cyclicSubspace T hT xi).starProjection (cfcHom hT g) := by sorry
