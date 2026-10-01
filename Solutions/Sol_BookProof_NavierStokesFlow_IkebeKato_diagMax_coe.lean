-- Generated from ChapterNavierStokesIkebeKato.lean — solution of BookProof.NavierStokesFlow.IkebeKato.diagMax_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato



open scoped ENNReal



open LpNat FarisLavine

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
ul]
    ring

theorem solution (c : ι → ℝ) (f : maxDom c) (k : ι) :
    ((diagMax c f : L2I ι) : ι → ℂ) k = (c k : ℂ) * ((f : L2I ι) : := ι →
