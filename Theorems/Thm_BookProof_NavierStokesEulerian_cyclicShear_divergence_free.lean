-- Generated from ChapterNavierStokesEulerian.lean — theorem BookProof.NavierStokesEulerian.cyclicShear_divergence_free
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesEulerian
open BookProof.NavierStokesEulerian



open BookProof.NavierStokesFlow Matrix

theorem BookProof.NavierStokesEulerian.cyclicShear_divergence_free (x : Fin 3 → ℝ) :
    ∑ j : Fin 3, dirDeriv (fun y => cyclicShear y j) j x = 0 := by sorry
