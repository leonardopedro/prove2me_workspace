-- Generated from ChapterNavierStokesSignedShift.lean — theorem BookProof.NavierStokesFlow.SignedShift.SignedHop.hopH_relative_bound
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

theorem BookProof.NavierStokesFlow.SignedShift.SignedHop.hopH_relative_bound (x : maxDom sym) :
    ‖(hopH S x : L2I ι)‖ ^ 2
      ≤ (1 / 2) * ‖(diagMax sym x : L2I ι)‖ ^ 2 + (8 * S.K ^ 2) * ‖(x : L2I ι)‖ ^ 2 := by sorry
