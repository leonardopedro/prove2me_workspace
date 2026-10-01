-- Generated from ChapterNavierStokesIkebeKato.lean — theorem BookProof.NavierStokesFlow.IkebeKato.memLpTwo_of_le
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato

variable {ι : Type*}


open scoped ENNReal



open LpNat FarisLavine

variable {ι : Type*}

g h.summable

theorem BookProof.NavierStokesFlow.IkebeKato.memLpTwo_of_le (f : L2I ι) {g : ι → ℂ} (h : ∀ k, ‖g k‖ ≤ ‖(f : ι → ℂ) k‖) : := by sorry
