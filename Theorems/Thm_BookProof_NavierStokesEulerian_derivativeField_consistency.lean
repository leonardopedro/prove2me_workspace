-- Generated from ChapterNavierStokesEulerian.lean — theorem BookProof.NavierStokesEulerian.derivativeField_consistency
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterNavierStokesEulerian
open BookProof.NavierStokesEulerian



open BookProof.NavierStokesFlow Matrix

theorem BookProof.NavierStokesEulerian.derivativeField_consistency (u : (Fin 3 → ℝ) → Fin 3 → ℝ)
    (hu : ∀ i, ContDiff ℝ 2 (fun y => u y i)) (i j k : Fin 3) (x : Fin 3 → ℝ) :
    dirDeriv (dirDeriv (fun y => u y i) j) k x
      = dirDeriv (dirDeriv (fun y => u y i) k) j x := by sorry
