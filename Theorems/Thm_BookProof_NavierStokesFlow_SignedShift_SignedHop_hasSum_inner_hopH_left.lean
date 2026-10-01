-- Generated from ChapterNavierStokesSignedShift.lean — theorem BookProof.NavierStokesFlow.SignedShift.SignedHop.hasSum_inner_hopH_left
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

theorem BookProof.NavierStokesFlow.SignedShift.SignedHop.hasSum_inner_hopH_left (x : maxDom sym) (y : L2I ι) :
    HasSum (fun β => -Complex.I * S.crossA ((x : L2I ι) : ι → ℂ) ((y : ι → ℂ)) β
        + Complex.I * S.crossB ((x : L2I ι) : ι → ℂ) ((y : ι → ℂ)) β)
      (inner ℂ (hopH S x : L2I ι) y) := by sorry
