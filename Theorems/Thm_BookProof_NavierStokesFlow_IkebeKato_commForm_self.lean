-- Generated from ChapterNavierStokesIkebeKato.lean — theorem BookProof.NavierStokesFlow.IkebeKato.commForm_self
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato


open scoped ENNReal



open LpNat BookProof.FarisLavine

variable {ι : Type*}


theorem BookProof.NavierStokesFlow.IkebeKato.commForm_self (c : ι → ℝ) (x : maxDom c) : commForm (diagMax c) (diagMax c) x = 0 := by sorry
