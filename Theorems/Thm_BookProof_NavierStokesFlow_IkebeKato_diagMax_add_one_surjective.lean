-- Generated from ChapterNavierStokesIkebeKato.lean — theorem BookProof.NavierStokesFlow.IkebeKato.diagMax_add_one_surjective
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato

variable {ι : Type*}


open scoped ENNReal



open LpNat FarisLavine

variable {ι : Type*}

f `N + 1` -/

theorem BookProof.NavierStokesFlow.IkebeKato.diagMax_add_one_surjective (c : ι → ℝ) (hc : ∀ k, 0 ≤ c k) (f : L2I ι) :
    ∃ x : maxDom c, (diagMax c x : L2I ι) + (x := by sorry
