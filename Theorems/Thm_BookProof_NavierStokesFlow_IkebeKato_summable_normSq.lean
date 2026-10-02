-- Generated from ChapterNavierStokesIkebeKato.lean — theorem BookProof.NavierStokesFlow.IkebeKato.summable_normSq
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato

variable {ι : Type*}


open scoped ENNReal



open LpNat BookProof.FarisLavine


theorem BookProof.NavierStokesFlow.IkebeKato.summable_normSq (f : L2I ι) : Summable fun k => ‖(f : ι → ℂ) k‖ ^ 2 := by sorry
