-- Generated from ChapterCyclicDirectSum.lean — solution of BookProof.ChapterCyclicDirectSum.starProjection_commutes_cfcHom
import Mathlib
import Definitions.Def_ChapterCyclicDirectSum
import Theorems.Thm_BookProof_ChapterCyclicDecomposition_invariant_orthogonal
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
    (hM : Invariant T hT M) (g : C(spectrum ℂ T, ℂ)) (v : H) :
    M.starProjection (cfcHom hT g v) = cfcHom hT g (M.starProjection v) := by

  refine Submodule.eq_starProjection_of_mem_orthogonal'
    (hM g _ (M.starProjection_apply_mem v))
    (invariant_orthogonal T hT hM g _ (M.sub_starProjection_mem_orthogonal v)) ?_
  rw [← map_add]
  congr 1
  abel
