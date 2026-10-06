-- Generated from ChapterEulerStochastic.lean — solution of BookProof.ChapterEulerStochastic.uniform_to_vertex_singular
import Mathlib
import Definitions.Def_ChapterEulerStochastic
open BookProof.ChapterEulerStochastic



open scoped Matrix BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (M : Matrix (Fin 2) (Fin 2) ℝ)
    (hM : PreservesProb M) (hcollapse : M *ᵥ ![1 / 2, 1 / 2] = ![1, 0]) :
    M.det = 0 := by

      rw [ Matrix.det_fin_two ];
      simp_all [ funext_iff, Fin.forall_fin_two, Matrix.mulVec ];
      have := hM ![1, 0] ; have := hM ![0, 1] ; norm_num [ IsProbVec ] at *;
      norm_num [ Matrix.vecHead, Matrix.vecTail, Matrix.mulVec ] at * ; nlinarith!
