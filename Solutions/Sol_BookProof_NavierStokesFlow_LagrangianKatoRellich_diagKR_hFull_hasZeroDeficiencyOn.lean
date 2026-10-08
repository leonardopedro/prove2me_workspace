-- Generated from ChapterNavierStokesLagrangianKatoRellich.lean — solution of BookProof.NavierStokesFlow.LagrangianKatoRellich.diagKR_hFull_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_hFull_hasZeroDeficiencyOn_of_drive_eq_P
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_diagKR_drive
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_diagKR_constraint_bound
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_diagKR_secondOrder_hasZeroDeficiencyOn
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianKatoRellich



open Filter Topology



open FullEsa LagrangianEsa BookProof.FarisLavine BookProof.KatoRellich
open BookProof.EsaClosure BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
noncomputable def l2NatBasis : HilbertBasis ℕ ℂ L2N :=
  DeficiencyOn)
  
  theorem diagKR_hFull_hasZeroDeficiencyOn :
