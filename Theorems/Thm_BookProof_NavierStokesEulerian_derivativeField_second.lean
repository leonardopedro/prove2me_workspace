-- Generated from ChapterNavierStokesEulerian.lean — theorem BookProof.NavierStokesEulerian.derivativeField_second
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesEulerian
open BookProof.NavierStokesEulerian



open BookProof.NavierStokesFlow Matrix

theorem BookProof.NavierStokesEulerian.derivativeField_second (uD : Fin 3 → Fin 3 → (Fin 3 → ℝ) → ℝ)
    (uDD : Fin 3 → Fin 3 → Fin 3 → (Fin 3 → ℝ) → ℝ)
    (M : Fin 3 → Fin 3 → (Fin 3 → ℝ) → ((Fin 3 → ℝ) →L[ℝ] ℝ))
    (huD : ∀ i j x, HasFDerivAt (uD i j) (M i j x) x)
    (huDD : ∀ i j k x, uDD i j k x = M i j x (evec k)) (i j k : Fin 3) (x : Fin 3 → ℝ) :
    uDD i j k x = dirDeriv (uD i j) k x := by sorry
