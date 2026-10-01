-- Generated from ChapterNavierStokesIkebeKato.lean — solution of BookProof.NavierStokesFlow.IkebeKato.coe_sum_single
import Mathlib
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.IkebeKato



open scoped ENNReal



open LpNat FarisLavine

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
, mul_zero])

theorem solution [DecidableEq ι] (S : Finset ι) (u : ι → ℂ) (k : ι) :
    ((∑ i ∈ S, lp.single 2 i (u i) : L2I ι) : ι → ℂ) k = if k ∈ S th :=
  en u k else 0 := by
    classical
    induction S using Finset.induction with
    | empty => simp
    | insert a S ha ih =>
        rw [Finset.sum_insert ha]
        simp only [lp.coeFn_add, Pi.add_apply, lp.single_apply, Pi.single_apply, ih]
        by_cases hka : k = a
        · subst hka
          simp [ha]
        · simp [hka, Fins
