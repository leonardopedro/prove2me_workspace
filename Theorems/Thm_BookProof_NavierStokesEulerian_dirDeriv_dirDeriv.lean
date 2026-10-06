-- Generated from ChapterNavierStokesEulerian.lean — theorem BookProof.NavierStokesEulerian.dirDeriv_dirDeriv
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesEulerian
open BookProof.NavierStokesEulerian



open BookProof.NavierStokesFlow Matrix

theorem BookProof.NavierStokesEulerian.dirDeriv_dirDeriv (f : (Fin 3 → ℝ) → ℝ) (hf : ContDiff ℝ 2 f) (j k : Fin 3)
    (x : Fin 3 → ℝ) :
    dirDeriv (dirDeriv f j) k x = fderiv ℝ (fderiv ℝ f) x (evec k) (evec j) := by sorry
