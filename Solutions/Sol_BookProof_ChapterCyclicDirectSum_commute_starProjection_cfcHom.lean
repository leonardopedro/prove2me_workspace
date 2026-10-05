-- Generated from ChapterCyclicDirectSum.lean — solution of BookProof.ChapterCyclicDirectSum.commute_starProjection_cfcHom
import Mathlib
import Definitions.Def_ChapterCyclicDirectSum
import Theorems.Thm_BookProof_ChapterCyclicDirectSum_starProjection_commutes_cfcHom
open BookProof.ChapterCyclicDirectSum



noncomputable section

open MeasureTheory Complex


open BookProof.ChapterCyclicDecomposition

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)

set_option maxHeartbeats 1000000 in
theorem solution {M : Submodule ℂ H} [M.HasOrthogonalProjection]
    (hM : Invariant T hT M) (g : C(spectrum ℂ T, ℂ)) :
    Commute M.starProjection (cfcHom hT g) := by

  ext v
  simpa [ContinuousLinearMap.mul_apply] using starProjection_commutes_cfcHom T hT hM g v
