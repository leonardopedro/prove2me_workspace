-- Generated from ChapterNavierStokesIkebeKato.lean — theorem BookProof.NavierStokesFlow.IkebeKato.sum_single_mem_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato

variable {ι : Type*}


open scoped ENNReal



open LpNat FarisLavine

variable {ι : Type*}

.mem_insert]

theorem BookProof.NavierStokesFlow.IkebeKato.sum_single_mem_finiteModes [DecidableEq ι] (S : Finset ι) (u : ι → ℂ) :
    (∑ i ∈ S, lp.single 2 i (u i) : L2I ι) ∈ lpF := by sorry
