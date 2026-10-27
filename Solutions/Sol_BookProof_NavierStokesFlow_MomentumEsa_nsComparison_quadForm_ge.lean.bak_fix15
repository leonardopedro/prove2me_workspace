-- Generated from ChapterNavierStokesMomentumEsa.lean — solution of BookProof.NavierStokesFlow.MomentumEsa.nsComparison_quadForm_ge
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumEsa
import Theorems.Thm_BookProof_NavierStokesFlow_MomentumEsa_nsSymbol_ge_one
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_diagMax_quadForm_ge_norm_sq
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumEsa





open LpNat BookProof.FarisLavine IkebeKato FarisLavineLift DiagonalEsa

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (d : ℕ) (p q : Fin d → ℕ → ℝ)
    (x : maxDom (nsSymbol d p q)) :
    ‖(x : L2I ℕ)‖ ^ 2 ≤ quadForm (diagMax (nsSymbol d p q)) x := diagMax_quadForm_ge_norm_sq _ (nsSymbol_ge_one d p q) x
