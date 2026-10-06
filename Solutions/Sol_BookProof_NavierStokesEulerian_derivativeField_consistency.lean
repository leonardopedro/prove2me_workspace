-- Generated from ChapterNavierStokesEulerian.lean — solution of BookProof.NavierStokesEulerian.derivativeField_consistency
import Mathlib
import Definitions.Def_ChapterNavierStokesEulerian
import Theorems.Thm_BookProof_NavierStokesEulerian_dirDeriv_dirDeriv
open BookProof.NavierStokesEulerian




open BookProof.NavierStokesFlow Matrix

set_option maxHeartbeats 1000000 in
theorem solution (u : (Fin 3 → ℝ) → Fin 3 → ℝ)
    (hu : ∀ i, ContDiff ℝ 2 (fun y => u y i)) (i j k : Fin 3) (x : Fin 3 → ℝ) :
    dirDeriv (dirDeriv (fun y => u y i) j) k x
      = dirDeriv (dirDeriv (fun y => u y i) k) j x := by

  rw [dirDeriv_dirDeriv _ (hu i), dirDeriv_dirDeriv _ (hu i)]
  exact ((hu i).contDiffAt.isSymmSndFDerivAt (by simp)) _ _
