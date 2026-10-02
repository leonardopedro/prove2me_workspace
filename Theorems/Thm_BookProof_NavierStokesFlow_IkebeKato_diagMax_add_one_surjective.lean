-- Generated from ChapterNavierStokesIkebeKato.lean — theorem BookProof.NavierStokesFlow.IkebeKato.diagMax_add_one_surjective
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato

variable {ι : Type*}


open scoped ENNReal



open LpNat BookProof.FarisLavine


theorem BookProof.NavierStokesFlow.IkebeKato.diagMax_add_one_surjective (c : ι → ℝ) (hc : ∀ k, 0 ≤ c k) (f : L2I ι) :
    ∃ x : maxDom c, (diagMax c x : L2I ι) + (x : L2I ι) = f := by sorry
