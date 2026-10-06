-- Generated from ChapterNavierStokesLagrangianCanonical.lean — solution of BookProof.NavierStokesFlow.LagrangianCanonical.lagT_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_lagT_coreState
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_coreState_total
import Theorems.Thm_BookProof_NavierStokesFlow_hasZeroDeficiencyOn_of_total_eigenvectors
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent

variable (nu : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution : HasZeroDeficiencyOn (lpFiniteModes Vel) (lagT nu) :=
  ingle 2 β 1 from rfl,
      lp.inner_single_left] at h
    simpa using h
  
  /-- **The Lagrangian second-order part is
