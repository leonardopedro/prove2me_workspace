-- Generated from ChapterNavierStokesAffineFiberEsa.lean — solution of BookProof.NavierStokesFlow.AffineFiber.support_hFun
import Mathlib
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Theorems.Thm_BookProof_NavierStokesFlow_AffineFiber_hFun_eq_zero
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineFiber



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian

variable {ι : Type*}

variable {ι : Type*}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (S : ShiftData ι) (X : ι → ℂ) :
    Function.support (S.hFun X)
      ⊆ S.shift '' Function.support X ∪ S.shift ⁻¹' Function.support X := by

  intro β hβ
  rw [Set.mem_union]
  by_contra hcon
  push_neg at hcon
  obtain ⟨h1, h2⟩ := hcon
  have hX : X (S.shift β) = 0 := by
    by_contra h
    exact h2 h
  refine hβ (hFun_eq_zero S (fun α hα => ?_) hX)
  by_contra hXα
  exact h1 ⟨α, hXα, hα⟩
