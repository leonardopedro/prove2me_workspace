-- Generated from ChapterNavierStokesEulerian.lean — solution of BookProof.NavierStokesEulerian.derivativeField_second
import Mathlib
import Definitions.Def_ChapterNavierStokesEulerian
import Theorems.Thm_BookProof_NavierStokesEulerian_dirDeriv_eq
open BookProof.NavierStokesEulerian




open BookProof.NavierStokesFlow Matrix

set_option maxHeartbeats 1000000 in
theorem solution (uD : Fin 3 → Fin 3 → (Fin 3 → ℝ) → ℝ)
    (uDD : Fin 3 → Fin 3 → Fin 3 → (Fin 3 → ℝ) → ℝ)
    (M : Fin 3 → Fin 3 → (Fin 3 → ℝ) → ((Fin 3 → ℝ) →L[ℝ] ℝ))
    (huD : ∀ i j x, HasFDerivAt (uD i j) (M i j x) x)
    (huDD : ∀ i j k x, uDD i j k x = M i j x (evec k)) (i j k : Fin 3) (x : Fin 3 → ℝ) :
    uDD i j k x = dirDeriv (uD i j) k x := by

  rw [huDD, dirDeriv_eq (huD i j x)]
