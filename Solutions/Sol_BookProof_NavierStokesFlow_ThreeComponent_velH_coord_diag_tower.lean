-- Generated from ChapterNavierStokesThreeComponent.lean — solution of BookProof.NavierStokesFlow.ThreeComponent.velH_coord_diag_tower
import Mathlib
import Definitions.Def_ChapterNavierStokesThreeComponent
import Theorems.Thm_BookProof_NavierStokesFlow_ThreeComponent_velH_coe_single
import Theorems.Thm_BookProof_NavierStokesFlow_ThreeComponent_hopList_eq
import Theorems.Thm_BookProof_NavierStokesFlow_ThreeComponent_vel_eq_iff
import Theorems.Thm_BookProof_NavierStokesFlow_ThreeComponent_raise_apply
import Theorems.Thm_BookProof_NavierStokesFlow_ThreeComponent_shDiag_apply
import Theorems.Thm_BookProof_NavierStokesFlow_ThreeComponent_shPair_apply
import Theorems.Thm_BookProof_NavierStokesFlow_ThreeComponent_shShear_apply
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ThreeComponent
















open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian SignedShift





































variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
set_option maxHeartbeats 1000000 in
-- the twenty-four members of the family are expanded and evaluated one by one
theorem solution (n : ℕ) :
    ((velH A c (velState A c ![n + 1, 0, 0]) : L2I Vel) : Vel → ℂ) ![n + 3, 0, 0]
      = Complex.I * ((A 0 0 / 2 * Real.sqrt (((n : ℝ) + 1 + 1) * ((n : ℝ) + 1 + 2)) : ℝ) : ℂ) := by

  have hne : ¬ (n + 3 + 1 = n) := by omega
  rw [velH_coe_single, hopList_eq]
  simp [vel_eq_iff, shDiag_apply, shPair_apply, shShear_apply, shRot, swapVel, lower,
    raise_apply, Equiv.swap_apply_def, hne, ampDiag, ampPair, coefPair]
