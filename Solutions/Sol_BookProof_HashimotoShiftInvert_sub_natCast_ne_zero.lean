-- Generated from ChapterHashimotoComplexShifts.lean — solution of BookProof.HashimotoShiftInvert.sub_natCast_ne_zero
import Mathlib
import Definitions.Def_ChapterHashimotoComplexShifts
open BookProof.HashimotoShiftInvert



















open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}


















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}




















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]







variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]








open scoped InnerProductSpace ENNReal

set_option maxHeartbeats 1000000 in
theorem solution {γ : ℂ} (hγ : γ.im ≠ 0) (n : ℕ) : γ - (n : ℂ) ≠ 0 := by

  intro h
  have := norm_sub_natCast_ge γ n
  rw [h, norm_zero] at this
  exact hγ (abs_eq_zero.mp (le_antisymm this (abs_nonneg _)))
