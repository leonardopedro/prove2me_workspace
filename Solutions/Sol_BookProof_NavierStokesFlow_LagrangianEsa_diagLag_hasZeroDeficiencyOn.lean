-- Generated from ChapterNavierStokesLagrangianEsa.lean — solution of BookProof.NavierStokesFlow.LagrangianEsa.diagLag_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianEsa
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianEsa_diagLagData_hFull
import Theorems.Thm_BookProof_NavierStokesFlow_DiagonalEsa_diagOp_hasZeroDeficiencyOn
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
  unfold diagLagUnbounded
  rw [diagLagData_hFull]
  congr 1
  funext n
  simp only [diagLagSymbol, Fin.sum_univ_three]
  norm_num [Fin.ext_iff]
  ring
