-- Generated from ChapterNavierStokesLagrangianKatoRellich.lean — solution of BookProof.NavierStokesFlow.LagrangianKatoRellich.diagKR_hFull_essentiallySelfAdjointOn
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_hFull_essentiallySelfAdjointOn_of_drive_eq_P
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
variable (L : LagrangianFullData F)








open LpNat DiagonalEsa

set_option maxHeartbeats 1000000 in
theorem solution :
    EssentiallySelfAdjointOn diagKR.D (lagrangianCore diagKR) :=
  hFull_essentiallySelfAdjointOn_of_drive_eq_P diagKR diagKR_drive le_rfl
      diagKR_constraint_bound
      ((essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn diagKR.D (secondOrder diagKR)).mpr
        diagKR_secondOrder_hasZeroDeficiencyOn)
