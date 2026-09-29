-- Generated from ChapterNavierStokesThreeComponent.lean — solution of BookProof.NavierStokesFlow.ThreeComponent.velH_symmetricOn
import Mathlib
import Definitions.Def_ChapterNavierStokesThreeComponent
import Theorems.Thm_BookProof_NavierStokesFlow_SignedShift_listH_symmetricOn
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ThreeComponent



open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution : SymmetricOn (maxDom (velSym (velMu A c))) (velH A c) := SignedShift.listH_symmetricOn _
