-- Generated from ChapterNavierStokesEulerian.lean — solution of BookProof.NavierStokesEulerian.cyclicShear_divergence_free
import Mathlib
import Definitions.Def_ChapterNavierStokesEulerian
import Theorems.Thm_BookProof_NavierStokesEulerian_dirDeriv_coord
open BookProof.NavierStokesEulerian




open BookProof.NavierStokesFlow Matrix

set_option maxHeartbeats 1000000 in
theorem solution (x : Fin 3 → ℝ) :
    ∑ j : Fin 3, dirDeriv (fun y => cyclicShear y j) j x = 0 := by

  have h : ∀ j : Fin 3, dirDeriv (fun y => cyclicShear y j) j x = 0 := by
    intro j
    have hj : j + 1 ≠ j := by revert j; decide
    rw [show (fun y => cyclicShear y j) = (fun y : Fin 3 → ℝ => y (j + 1)) from rfl,
      dirDeriv_coord, if_neg hj]
  simp [h]
