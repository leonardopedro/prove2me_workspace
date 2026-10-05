-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.liftFst_otimes
import Mathlib
import Definitions.Def_ChapterGradedFock
import Theorems.Thm_BookProof_GradedFock_otimes_add_left
import Theorems.Thm_BookProof_GradedFock_otimes_add_right
import Theorems.Thm_BookProof_GradedFock_otimes_smul_left
import Theorems.Thm_BookProof_GradedFock_otimes_smul_right
import Theorems.Thm_BookProof_GradedFock_otimes_single
import Theorems.Thm_BookProof_GradedFock_liftFst_single
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (T : (α →₀ ℂ) →ₗ[ℂ] (α →₀ ℂ)) (v : α →₀ ℂ) (w : β →₀ ℂ) :
    liftFst T (otimes v w) = otimes (T v) w := by

  classical
  induction v using Finsupp.induction_linear with
  | zero => simp
  | add f g hf hg => rw [otimes_add_left, map_add, hf, hg, map_add, otimes_add_left]
  | single a x =>
    induction w using Finsupp.induction_linear with
    | zero => simp
    | add f g hf hg => rw [otimes_add_right, map_add, hf, hg, otimes_add_right]
    | single b y =>
      have hx : (Finsupp.single a x : α →₀ ℂ) = x • Finsupp.single a 1 := by
        rw [Finsupp.smul_single, smul_eq_mul, mul_one]
      have hy : (Finsupp.single b y : β →₀ ℂ) = y • Finsupp.single b 1 := by
        rw [Finsupp.smul_single, smul_eq_mul, mul_one]
      rw [otimes_single, liftFst_single, hx, hy, map_smul, otimes_smul_left,
        otimes_smul_right, smul_smul]
