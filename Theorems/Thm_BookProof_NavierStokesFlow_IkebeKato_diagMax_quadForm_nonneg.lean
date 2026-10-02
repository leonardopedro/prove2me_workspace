-- Generated from ChapterNavierStokesIkebeKato.lean — theorem BookProof.NavierStokesFlow.IkebeKato.diagMax_quadForm_nonneg
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato

variable {ι : Type*}


open scoped ENNReal



open LpNat BookProof.FarisLavine


theorem BookProof.NavierStokesFlow.IkebeKato.diagMax_quadForm_nonneg (c : ι → ℝ) (hc : ∀ k, 0 ≤ c k) (x : maxDom c) :
    0 ≤ quadForm (diagMax c) x := by sorry
