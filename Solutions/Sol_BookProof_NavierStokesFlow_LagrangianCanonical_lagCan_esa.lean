-- Generated from ChapterNavierStokesLagrangianCanonical.lean — solution of BookProof.NavierStokesFlow.LagrangianCanonical.lagCan_esa
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
import Theorems.Thm_BookProof_FarisLavine_essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_lagCan_secondOrder_hasZeroDeficiencyOn
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_hFull_essentiallySelfAdjointOn_of_drive_eq_P
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical



open scoped ENNReal



open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent

set_option maxHeartbeats 1000000 in
s Vel) (lagT nu) :=
  hasZeroDeficiencyOn_of_total_eigenvectors _ _ coreState (lagLam nu)
    (lagT_coreState nu) coreState_total

theorem solution (hnu : 0 < nu) (f : Fin 3 → ℝ) :
    HasZeroDeficiencyOn (lagCanData nu hnu f).D (secondOrder (lagCanData nu hnu f)) := by
  rw [lagCan_secondOrder_eq nu hnu f]
  exact lagT_hasZeroDeficiencyOn nu

/-- **The full trans :=
  formed (Lagrangian) Navier–Stokes Hamiltonian is essentially
  self-adjoint on the trajectory-space Hermite core**, by the Kato–Rellich
  relative bound: the drift `∑ fᵢ Pᵢ` is controlled by the positive second-order
  part. -/
  theorem lagCan_esa (hnu : 0 < nu) (f : Fin 3 → ℝ) :
      Ess
