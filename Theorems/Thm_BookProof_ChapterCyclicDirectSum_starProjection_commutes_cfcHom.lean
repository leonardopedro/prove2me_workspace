-- Generated from ChapterCyclicDirectSum.lean — theorem BookProof.ChapterCyclicDirectSum.starProjection_commutes_cfcHom
import Mathlib
import Definitions.Def_ChapterCyclicDirectSum
import Definitions.Def_ChapterA4
open BookProof.ChapterCyclicDirectSum

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)


noncomputable section

open MeasureTheory Complex


open BookProof.ChapterCyclicDecomposition


theorem BookProof.ChapterCyclicDirectSum.starProjection_commutes_cfcHom {M : Submodule ℂ H} [M.HasOrthogonalProjection]
    (hM : Invariant T hT M) (g : C(spectrum ℂ T, ℂ)) (v : H) :
    M.starProjection (cfcHom hT g v) = cfcHom hT g (M.starProjection v) := by sorry
