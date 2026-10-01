-- Generated from ChapterNavierStokesSignedShift.lean — theorem BookProof.NavierStokesFlow.SignedShift.SignedHop.hopH_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesSignedShift
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignedShift.SignedHop

variable {ι : Type*}
variable {sym : ι → ℝ} (S : SignedHop ι sym)
variable {sym : ι → ℝ}
variable (kap cst : ℝ)


open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian AffineFiber

variable {ι : Type*}

theorem BookProof.NavierStokesFlow.SignedShift.SignedHop.hopH_coe (x : maxDom sym) (β : ι) :
    ((hopH S x : L2I ι) : ι → ℂ) β = S.hFun ((x : L2I ι) : ι → ℂ) β := by sorry
