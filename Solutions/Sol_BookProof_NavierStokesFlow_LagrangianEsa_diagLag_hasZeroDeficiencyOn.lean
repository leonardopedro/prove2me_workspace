-- Generated from ChapterNavierStokesLagrangianEsa.lean — solution of BookProof.NavierStokesFlow.LagrangianEsa.diagLag_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianEsa
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianEsa_diagLagData_hFull
import Theorems.Thm_BookProof_NavierStokesFlow_DiagonalEsa_diagOp_hasZeroDeficiencyOn
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagOp_sum
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagOp_real_smul
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagOp_add
import Definitions.Def_ChapterAbelianDiagonalCountable
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianEsa





open FullEsa
open BookProof.ChapterAbelianDiagonalCountable
open BookProof.NavierStokesFlow.DiagonalEsa
open BookProof.NavierStokesFlow.JacobiDeficiency
open BookProof.NavierStokesFlow.LpNat

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]

set_option maxHeartbeats 1000000 in

theorem solution :
    diagLagUnbounded.hFull = diagOp (fun n => (1 / 2) * (n : ℝ) ^ 2) := by
  -- The published `diagLagData_hFull` node carries the deficiency statement rather than the
  -- componentwise identity `hFull = diagOp (diagLagSymbol …)`, so we inline the identity.
  have hEq : ∀ (p q dr : Fin 3 → ℕ → ℝ) (c : ℕ → ℝ) (fr : Fin 3 → ℝ) {nu : ℝ}
      (_hnu : 0 ≤ nu),
      (diagLagData p q dr c fr _hnu).hFull = diagOp (diagLagSymbol p q dr c fr nu) := by
    intro p q dr c fr nu hnu
    simp only [LagrangianFullData.hFull, LagrangianFullData.kinetic, LagrangianFullData.viscous,
      LagrangianFullData.drift, diagLagData, diagOp_comp, FullEsa.diagOp_sum,
      FullEsa.diagOp_real_smul, FullEsa.diagOp_add]
    show ((((1 / 2 : ℝ) : ℂ) • (∑ i, diagOp fun n ↦ p i n * p i n))
        + (((nu : ℝ) : ℂ) • (∑ i, diagOp fun n ↦ q i n * q i n)))
        + (∑ i, ((fr i : ℝ) : ℂ) • diagOp (dr i)) + diagOp c
        = diagOp (diagLagSymbol p q dr c fr nu)
    simp only [FullEsa.diagOp_sum, FullEsa.diagOp_real_smul, FullEsa.diagOp_add]
    refine congrArg DiagonalEsa.diagOp ?_
    funext n
    simp only [diagLagSymbol]
  unfold diagLagUnbounded
  rw [hEq]
  congr 1
  funext n
  simp only [diagLagSymbol, Fin.sum_univ_three]
  norm_num [Fin.ext_iff]
  ring
