-- Generated from ChapterNavierStokesIkebeKato.lean — theorem BookProof.NavierStokesFlow.IkebeKato.diagMax_quadForm_ge_norm_sq
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato

variable {ι : Type*}


open scoped ENNReal



open LpNat FarisLavine

variable {ι : Type*}

sq_nonneg _)

theorem BookProof.NavierStokesFlow.IkebeKato.diagMax_quadForm_ge_norm_sq (c : ι → ℝ) (hc : ∀ k, 1 ≤ c k) (x : maxDom c) :
    ‖(x : L2I ι)‖ ^ 2 ≤ quadForm := by sorry
