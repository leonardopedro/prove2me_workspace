-- Generated from ChapterNavierStokesSignedShift.lean — solution of BookProof.NavierStokesFlow.SignedShift.SignedHop.hopH_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesSignedShift
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignedShift.SignedHop



open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian AffineFiber

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (x : maxDom sym) (β : ι) :
    ((hopH S x : L2I ι) : ι → ℂ) β = S.hFun ((x : L2I ι) : ι → ℂ) β := rfl
