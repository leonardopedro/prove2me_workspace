-- Generated from ChapterNavierStokesIkebeKato.lean — theorem BookProof.NavierStokesFlow.IkebeKato.summable_normSq
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato


open scoped ENNReal



open LpNat BookProof.FarisLavine

variable {ι : Type*}


theorem BookProof.NavierStokesFlow.IkebeKato.summable_normSq (f : L2I ι) : Summable fun k => ‖(f : ι → ℂ) k‖ ^ 2 := by sorry
