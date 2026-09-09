-- Generated from ChapterNavierStokesThreeComponent.lean — solution of BookProof.NavierStokesFlow.ThreeComponent.velH_coord_diag
import Mathlib
import Definitions.Def_ChapterNavierStokesThreeComponent
import Theorems.Thm_BookProof_NavierStokesFlow_ThreeComponent_velH_coe_single
import Theorems.Thm_BookProof_NavierStokesFlow_ThreeComponent_hopList_eq
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ThreeComponent
















open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian SignedShift





































variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
set_option maxHeartbeats 1000000 in
-- the twenty-four members of the family are expanded and evaluated one by one
theorem solution :
    ((velH A c (velState A c ![0, 0, 0]) : L2I Vel) : Vel → ℂ) ![2, 0, 0]
      = Complex.I * ((A 0 0 * Real.sqrt 2 / 2 : ℝ) : ℂ) := by

  rw [velH_coe_single, hopList_eq]
  simp +decide [ampDiag, ampPair, coefPair]
  ring
