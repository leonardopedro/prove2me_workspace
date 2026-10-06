-- Generated from ChapterNavierStokesEulerian.lean — theorem BookProof.NavierStokesEulerian.dirDeriv_eq
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesEulerian
open BookProof.NavierStokesEulerian



open BookProof.NavierStokesFlow Matrix

theorem BookProof.NavierStokesEulerian.dirDeriv_eq {f : (Fin 3 → ℝ) → ℝ} {L : (Fin 3 → ℝ) →L[ℝ] ℝ} {x : Fin 3 → ℝ}
    (hf : HasFDerivAt f L x) (j : Fin 3) : dirDeriv f j x = L (evec j) := by sorry
