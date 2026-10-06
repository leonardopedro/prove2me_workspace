-- Generated from ChapterNavierStokesEulerian.lean — theorem BookProof.NavierStokesEulerian.derivativeField_relates_to_field
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesEulerian
open BookProof.NavierStokesEulerian



open BookProof.NavierStokesFlow Matrix

theorem BookProof.NavierStokesEulerian.derivativeField_relates_to_field (u : (Fin 3 → ℝ) → Fin 3 → ℝ)
    (uD : Fin 3 → Fin 3 → (Fin 3 → ℝ) → ℝ) (L : Fin 3 → (Fin 3 → ℝ) → ((Fin 3 → ℝ) →L[ℝ] ℝ))
    (hu : ∀ i x, HasFDerivAt (fun y => u y i) (L i x) x)
    (huD : ∀ i j x, uD i j x = L i x (evec j)) (i j : Fin 3) (x : Fin 3 → ℝ) :
    uD i j x = dirDeriv (fun y => u y i) j x := by sorry
