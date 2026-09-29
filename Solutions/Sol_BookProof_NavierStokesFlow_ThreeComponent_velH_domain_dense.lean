-- Generated from ChapterNavierStokesThreeComponent.lean — solution of BookProof.NavierStokesFlow.ThreeComponent.velH_domain_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesThreeComponent
import Theorems.Thm_BookProof_NavierStokesFlow_lpFiniteModes_dense
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ThreeComponent



open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution :
    Dense ((lpFiniteModes Vel : Submodule ℂ (L2I Vel)) : Set (L2I Vel)) := lpFiniteModes_dense
