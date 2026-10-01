-- Generated from ChapterNavierStokesIkebeKato.lean — solution of BookProof.NavierStokesFlow.IkebeKato.finiteModes_le_maxDom
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_memLpTwo_of_finite_support
import Theorems.Thm_BookProof_NavierStokesFlow_mem_lpFiniteModes
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato



open scoped ENNReal



open LpNat FarisLavine

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
mode core -/

theorem solution (c : ι → ℝ) : lpFiniteModes ι :=
   ≤ maxDom c := by
    intro f hf
    refine memLpTwo_of_finite_support (Set.Finite.subset (mem_lpFiniteModes.mp hf) ?_)
    intro k hk
    simp only [Function.mem_support] at hk ⊢
    intro h0
    exact hk (by rw [
