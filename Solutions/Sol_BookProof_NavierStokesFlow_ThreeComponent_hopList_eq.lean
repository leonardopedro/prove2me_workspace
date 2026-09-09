-- Generated from ChapterNavierStokesThreeComponent.lean — solution of BookProof.NavierStokesFlow.ThreeComponent.hopList_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesThreeComponent
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ThreeComponent
















open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian SignedShift





































variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution : hopList A c =
    [diagHop A c 0, shearHop A c 0,
      pairHop A c 0 0, rotHop A c 0 0, pairHop A c 0 1, rotHop A c 0 1,
      pairHop A c 0 2, rotHop A c 0 2,
     diagHop A c 1, shearHop A c 1,
      pairHop A c 1 0, rotHop A c 1 0, pairHop A c 1 1, rotHop A c 1 1,
      pairHop A c 1 2, rotHop A c 1 2,
     diagHop A c 2, shearHop A c 2,
      pairHop A c 2 0, rotHop A c 2 0, pairHop A c 2 1, rotHop A c 2 1,
      pairHop A c 2 2, rotHop A c 2 2] := rfl
