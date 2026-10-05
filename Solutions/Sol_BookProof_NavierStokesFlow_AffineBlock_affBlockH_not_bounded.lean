-- Generated from ChapterNavierStokesAffineBlockEsa.lean — solution of BookProof.NavierStokesFlow.AffineBlock.affBlockH_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesAffineBlockEsa
import Theorems.Thm_BookProof_NavierStokesFlow_AffineFiber_hFun_eq_zero
import Theorems.Thm_BookProof_NavierStokesFlow_AffineFiber_hFun_shift_of_single
import Theorems.Thm_BookProof_NavierStokesFlow_AffineFiber_le_amp
open BookProof.NavierStokesFlow



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber BilinearEsa

variable {J : Type*}

variable {J : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (hc : ∀ j, 0 ≤ c j)
    (hunb : ∀ C : ℝ, ∃ j, C < κ j) (C : ℝ) :
    ∃ x : lpFiniteModes (ℕ × J),
      ‖((x : lpFiniteModes (ℕ × J)) : L2I (ℕ × J))‖ = 1
        ∧ C < ‖affBlockH κ c hκ hc x‖ := by

  classical
  obtain ⟨j, hj⟩ := hunb (2 * |C| + 2)
  refine ⟨⟨lp.single 2 ((0 : ℕ), j) (1 : ℂ), lpSingle_mem_lpFiniteModes _ _⟩, by simp, ?_⟩
  set x : lpFiniteModes (ℕ × J) :=
    ⟨lp.single 2 ((0 : ℕ), j) (1 : ℂ), lpSingle_mem_lpFiniteModes _ _⟩ with hxdef
  have hX : ∀ m : ℕ, ((x : L2I (ℕ × J)) : ℕ × J → ℂ) (m, j) = if m = 0 then 1 else 0 := by
    intro m
    simp [hxdef, lp.single_apply, Pi.single_apply, Prod.ext_iff]
  have hsnd : (affData (hκ j) (hc j)).snd.hFun
      (fun m => ((x : L2I (ℕ × J)) : ℕ × J → ℂ) (m, j)) 2 = 0 := by
    refine hFun_eq_zero _ (fun α hα => ?_) ?_
    · simp only [affData_shift₂] at hα
      rw [hX]
      have hne : α ≠ 0 := by omega
      simp [hne]
    · simp only [PairShift.snd_shift, affData_shift₂, hX]
      norm_num
  have hfst : (affData (hκ j) (hc j)).fst.hFun
      (fun m => ((x : L2I (ℕ × J)) : ℕ × J → ℂ) (m, j)) 2
        = Complex.I * ((amp (κ j) 0 : ℝ) : ℂ) := by
    have h := hFun_shift_of_single (affData (hκ j) (hc j)).fst
      (X := fun m => ((x : L2I (ℕ × J)) : ℕ × J → ℂ) (m, j)) (o := 0)
      (by simp [hX]) (by simp [hX])
    simpa using h
  have hcoord : ((affBlockH κ c hκ hc x : L2I (ℕ × J)) : ℕ × J → ℂ) (2, j)
      = Complex.I * ((amp (κ j) 0 : ℝ) : ℂ) := by
    change affFun κ c hκ hc _ (2, j) = _
    simp only [affFun]
    rw [hfst, hsnd, add_zero]
  have hb : ‖((affBlockH κ c hκ hc x : L2I (ℕ × J)) : ℕ × J → ℂ) (2, j)‖
      ≤ ‖(affBlockH κ c hκ hc x : L2I (ℕ × J))‖ :=
    lp.norm_apply_le_norm (by norm_num) _ _
  rw [hcoord] at hb
  have hnv : ‖Complex.I * ((amp (κ j) 0 : ℝ) : ℂ)‖ = amp (κ j) 0 := by
    rw [norm_mul, Complex.norm_I, one_mul, Complex.norm_real, Real.norm_eq_abs,
      abs_of_nonneg (amp_nonneg (hκ j) 0)]
  rw [hnv] at hb
  have hlow := le_amp (hκ j) 0
  have hC : C ≤ |C| := le_abs_self C
  norm_num at hlow
  linarith
