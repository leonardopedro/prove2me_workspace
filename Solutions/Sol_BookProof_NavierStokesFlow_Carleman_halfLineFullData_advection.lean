-- Generated from ChapterNavierStokesCarleman.lean — solution of BookProof.NavierStokesFlow.Carleman.halfLineFullData_advection
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagOp_real_smul
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagOp_sub
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagOp_sum
open BookProof.NavierStokesFlow



open scoped ENNReal



open LpNat DiagonalEsa FullEsa

set_option maxHeartbeats 1000000 in
theorem solution (c : Fin 15 → ℕ → ℝ) (nu : ℝ) (i : Fin 3) :
    (halfLineFullData c nu).advection i = diagOp (halfLineAlpha c nu i) := by

  simp only [NSFullData.advection, NSFullData.velocity, NSFullData.gradVelocity,
    NSFullData.lapVelocity, halfLineFullData, diagOp_comp, diagOp_sum, diagOp_real_smul,
    diagOp_sub]
  show (∑ j, diagOp fun n ↦ c (nsVelIdx j) n * c (nsGradIdx i j) n)
      - ((nu : ℝ) : ℂ) • diagOp (c (nsLapIdx i)) = diagOp (halfLineAlpha c nu i)
  simp only [diagOp_sum, diagOp_real_smul, diagOp_sub]
  rfl
