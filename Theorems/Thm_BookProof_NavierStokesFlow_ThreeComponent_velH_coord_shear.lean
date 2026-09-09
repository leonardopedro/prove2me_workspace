-- Generated from ChapterNavierStokesThreeComponent.lean — theorem BookProof.NavierStokesFlow.ThreeComponent.velH_coord_shear
import Mathlib
import Definitions.Def_ChapterNavierStokesThreeComponent
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ThreeComponent















open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian SignedShift





































variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
-- the twenty-four members of the family are expanded and evaluated one by one
theorem BookProof.NavierStokesFlow.ThreeComponent.velH_coord_shear :
    ((velH A c (velState A c ![0, 0, 0]) : L2I Vel) : Vel → ℂ) ![1, 0, 0]
      = Complex.I * ((c 0 / Real.sqrt 2 : ℝ) : ℂ) := by sorry
