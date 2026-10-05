-- Generated from ChapterCyclicDirectSum.lean — theorem BookProof.ChapterCyclicDirectSum.commute_starProjection_cfcHom
import Definitions.Def_ChapterCyclicDecomposition
import Mathlib
import Definitions.Def_ChapterCyclicDirectSum
open BookProof.ChapterCyclicDirectSum

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)


noncomputable section

open MeasureTheory Complex


open BookProof.ChapterCyclicDecomposition


theorem BookProof.ChapterCyclicDirectSum.commute_starProjection_cfcHom {M : Submodule ℂ H} [M.HasOrthogonalProjection]
    (hM : Invariant T hT M) (g : C(spectrum ℂ T, ℂ)) :
    Commute M.starProjection (cfcHom hT g) := by sorry
