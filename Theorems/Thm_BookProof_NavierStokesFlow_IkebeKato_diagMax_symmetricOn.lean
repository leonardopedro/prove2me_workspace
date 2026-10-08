-- Generated from ChapterNavierStokesIkebeKato.lean — theorem BookProof.NavierStokesFlow.IkebeKato.diagMax_symmetricOn
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato


open scoped ENNReal



open LpNat BookProof.FarisLavine

variable {ι : Type*}


theorem BookProof.NavierStokesFlow.IkebeKato.diagMax_symmetricOn (c : ι → ℝ) : SymmetricOn (maxDom c) (diagMax c) := by sorry
