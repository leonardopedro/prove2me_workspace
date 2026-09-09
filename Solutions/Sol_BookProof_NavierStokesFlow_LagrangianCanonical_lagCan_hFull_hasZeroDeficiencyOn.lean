-- Generated from ChapterNavierStokesLagrangianCanonical.lean — solution of BookProof.NavierStokesFlow.LagrangianCanonical.lagCan_hFull_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_lagCan_secondOrder_hasZeroDeficiencyOn
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical

















open scoped ENNReal



open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent














variable (nu : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (hnu : 0 < nu) (f : Fin 3 → ℝ) :
    HasZeroDeficiencyOn (lagCanData nu hnu f).D (lagCanData nu hnu f).hFull :=
  hFull_hasZeroDeficiencyOn_of_drive_eq_P (lagCanData nu hnu f) rfl le_rfl
      (fun v => by simp [lagCanData]) (lagCan_secondOrder_hasZeroDeficiencyOn nu hnu f)
