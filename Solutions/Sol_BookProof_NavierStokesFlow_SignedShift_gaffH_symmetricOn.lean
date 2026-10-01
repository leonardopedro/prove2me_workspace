-- Generated from ChapterNavierStokesSignedShift.lean — solution of BookProof.NavierStokesFlow.SignedShift.gaffH_symmetricOn
import Mathlib
import Definitions.Def_ChapterNavierStokesSignedShift
import Theorems.Thm_BookProof_NavierStokesFlow_SignedShift_listH_symmetricOn
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignedShift



open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian AffineFiber

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution : SymmetricOn (maxDom (gsym kap cst)) (gaffH kap cst) := listH_symmetricOn _
