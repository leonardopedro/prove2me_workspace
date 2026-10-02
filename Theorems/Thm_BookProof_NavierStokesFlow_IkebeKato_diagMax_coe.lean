-- Generated from ChapterNavierStokesIkebeKato.lean — theorem BookProof.NavierStokesFlow.IkebeKato.diagMax_coe
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato

variable {ι : Type*}


open scoped ENNReal



open LpNat BookProof.FarisLavine


theorem BookProof.NavierStokesFlow.IkebeKato.diagMax_coe (c : ι → ℝ) (f : maxDom c) (k : ι) :
    ((diagMax c f : L2I ι) : ι → ℂ) k = (c k : ℂ) * ((f : L2I ι) : ι → ℂ) k := by sorry
