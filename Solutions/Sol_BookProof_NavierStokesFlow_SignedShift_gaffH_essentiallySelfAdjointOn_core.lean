-- Generated from ChapterNavierStokesSignedShift.lean — solution of BookProof.NavierStokesFlow.SignedShift.gaffH_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterNavierStokesSignedShift
import Theorems.Thm_BookProof_NavierStokesFlow_SignedShift_listH_essentiallySelfAdjointOn_core
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignedShift



open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian AffineFiber

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution :
    EssentiallySelfAdjointOn (lpFiniteModes ℕ)
      ((gaffH kap cst).comp (Submodule.inclusion (finiteModes_le_maxDom (gsym kap cst)))) := listH_essentiallySelfAdjointOn_core _ (gsym_ge_one kap cst)
