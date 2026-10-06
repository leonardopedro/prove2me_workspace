-- Generated from ChapterNavierStokesEulerian.lean — theorem BookProof.NavierStokesEulerian.dirDeriv_coord
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesEulerian
open BookProof.NavierStokesEulerian



open BookProof.NavierStokesFlow Matrix

theorem BookProof.NavierStokesEulerian.dirDeriv_coord (k j : Fin 3) (x : Fin 3 → ℝ) :
    dirDeriv (fun y => y k) j x = if k = j then 1 else 0 := by sorry
