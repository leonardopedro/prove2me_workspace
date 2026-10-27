-- Generated from ChapterPauliFundamental.lean — solution of BookProof.ChapterPauliFundamental.gp_push
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Theorems.Thm_BookProof_ChapterPauliFundamental_cliff_anticomm
open BookProof.ChapterPauliFundamental



open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

variable {A : Fin 4 → M4}

set_option maxHeartbeats 1000000 in
theorem solution (hA : IsCliffordC A) (μ : Fin 4) :
    ∀ l : List (Fin 4), (∀ ν ∈ l, ν ≠ μ) →
      A μ * gp A l = ((-1 : ℂ) ^ l.length) • (gp A l * A μ) := by

  intro l
  induction l with
  | nil => intro _; simp [gp]
  | cons a t ih =>
      intro h
      have ha : a ≠ μ := h a (by simp)
      have ht : ∀ ν ∈ t, ν ≠ μ := fun ν hν => h ν (by simp [hν])
      have h1 : A μ * A a = -(A a * A μ) := cliff_anticomm hA (Ne.symm ha)
      simp only [gp, List.length_cons, ← mul_assoc, h1]
      rw [neg_mul, mul_assoc, ih ht]
      simp [pow_succ, mul_assoc]
