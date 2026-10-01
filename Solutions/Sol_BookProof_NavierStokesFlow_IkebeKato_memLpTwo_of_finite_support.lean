-- Generated from ChapterNavierStokesIkebeKato.lean — solution of BookProof.NavierStokesFlow.IkebeKato.memLpTwo_of_finite_support
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato



open scoped ENNReal



open LpNat FarisLavine

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
e_normSq f))

theorem solution {g : ι → ℂ} (h : (Function.support g).Finite) : :=
    Memℓp g 2 := by
    classical
    refine memLpTwo_of_summable_normSq (summable_of_ne_finset_zero (s := h.toFinset) ?_)
    intro k hk
    have : g k = 0 := by
      by_contra hne
      exact hk (h.mem_toFinset.mpr hne)
