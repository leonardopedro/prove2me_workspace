-- Generated from ChapterCyclicDirectSum.lean — solution of BookProof.ChapterCyclicDirectSum.starProjection_cyclicSubspace_commutes
import Mathlib
import Definitions.Def_ChapterCyclicDirectSum
import Theorems.Thm_BookProof_ChapterCyclicDirectSum_commute_starProjection_cfcHom
import Theorems.Thm_BookProof_ChapterCyclicDecomposition_invariant_cyclicSubspace
open BookProof.ChapterCyclicDirectSum



noncomputable section

open MeasureTheory Complex


open BookProof.ChapterCyclicDecomposition

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)

set_option maxHeartbeats 1000000 in
theorem solution (xi : H) (g : C(spectrum ℂ T, ℂ)) :
    Commute (cyclicSubspace T hT xi).starProjection (cfcHom hT g) := commute_starProjection_cfcHom T hT (invariant_cyclicSubspace T hT xi) g
