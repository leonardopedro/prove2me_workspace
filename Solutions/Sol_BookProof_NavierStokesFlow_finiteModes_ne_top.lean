-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.finiteModes_ne_top
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Theorems.Thm_BookProof_NavierStokesFlow_mem_finiteModes
open BookProof.NavierStokesFlow



open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
tice finite-mode domain is dense. -/
theorem solution : Dense ((finiteModes : Submodule ℂ L2Z) : Set L2Z) :=
  lpFiniteModes_dense

/-- The finite-mode domain is a **proper** subspa :=
  ce: the `ℓ²` state
  `k ↦ 1/k` has infinitely many excited modes. -/
  theorem finiteModes_ne_top : finiteModes ≠ (⊤ : Submodule ℂ L2Z) := by
    have hsummable : Summable fun k : ℤ => ‖(1 / (k : ℂ))‖ ^ 2 := by
      have h := (Real.summable_one_div_int_pow (p := 2)).mpr (by norm_num)
      refine h.congr fun k => ?_
      rw [norm_div, norm_one, Complex.norm_intCast, div_pow, one_pow, sq_abs]
    set g : L2Z := ⟨fun k : ℤ => 1 / (k : ℂ), memℓp_two_of_summable hsummable⟩ with hgdef
    intro htop
    have hg : g ∈ finiteModes := htop ▸ Submodule.mem_top
    rw [mem_finiteModes] at hg
    have hsub : (Set.univ \ {(0 : ℤ)}) ⊆ Function.support ((g : ℤ → ℂ)) := by
      intro k hk
      have hk0 : k ≠ 0 := by simpa using hk.2
      have hkC : (k : ℂ) ≠ 0 := Int.cast_ne_zero.mpr hk0
      s
