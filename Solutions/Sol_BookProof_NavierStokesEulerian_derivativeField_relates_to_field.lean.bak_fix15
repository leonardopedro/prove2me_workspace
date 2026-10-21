-- Generated from ChapterNavierStokesEulerian.lean — solution of BookProof.NavierStokesEulerian.derivativeField_relates_to_field
import Mathlib
import Definitions.Def_ChapterNavierStokesEulerian
import Theorems.Thm_BookProof_NavierStokesEulerian_dirDeriv_eq
open BookProof.NavierStokesEulerian




open BookProof.NavierStokesFlow Matrix

set_option maxHeartbeats 1000000 in
theorem solution (u : (Fin 3 → ℝ) → Fin 3 → ℝ)
    (uD : Fin 3 → Fin 3 → (Fin 3 → ℝ) → ℝ) (L : Fin 3 → (Fin 3 → ℝ) → ((Fin 3 → ℝ) →L[ℝ] ℝ))
    (hu : ∀ i x, HasFDerivAt (fun y => u y i) (L i x) x)
    (huD : ∀ i j x, uD i j x = L i x (evec j)) (i j : Fin 3) (x : Fin 3 → ℝ) :
    uD i j x = dirDeriv (fun y => u y i) j x := by

  rw [huD, dirDeriv_eq (hu i x)]
