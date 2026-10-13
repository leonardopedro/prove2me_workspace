-- Generated from ChapterNavierStokesLagrangianEsa.lean — solution of BookProof.NavierStokesFlow.LagrangianEsa.diagLagData_hFull
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagOp_add
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagOp_real_smul
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagOp_sum
import Definitions.Def_ChapterAbelianDiagonalCountable
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesFullEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianEsa





open FullEsa
open BookProof.ChapterAbelianDiagonalCountable
open BookProof.BRSTNilpotent
open BookProof.ChapterF7
open BookProof.NavierStokesFlow.DiagonalEsa
open BookProof.NavierStokesFlow.JacobiDeficiency
open BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.FullEsa.NSFullData

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]

set_option maxHeartbeats 1000000 in
theorem solution (p q dr : Fin 3 → ℕ → ℝ) (c : ℕ → ℝ) (fr : Fin 3 → ℝ)
    {nu : ℝ} (hnu : 0 ≤ nu) :
    HasZeroDeficiencyOn (diagLagData p q dr c fr hnu).D (diagLagData p q dr c fr hnu).hFull :=
  Data.kinetic, LagrangianFullData.viscous,
      LagrangianFullData.dr
