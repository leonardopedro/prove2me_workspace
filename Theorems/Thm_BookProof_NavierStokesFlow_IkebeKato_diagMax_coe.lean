-- Generated from ChapterNavierStokesIkebeKato.lean — theorem BookProof.NavierStokesFlow.IkebeKato.diagMax_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato

variable {ι : Type*}


open scoped ENNReal



open LpNat FarisLavine

variable {ι : Type*}

ul]
    ring

theorem BookProof.NavierStokesFlow.IkebeKato.diagMax_coe (c : ι → ℝ) (f : maxDom c) (k : ι) :
    ((diagMax c f : L2I ι) : ι → ℂ) k = (c k : ℂ) * ((f : L2I ι) : := by sorry
