-- Generated from ChapterH1.lean — solution of BookProof.ChapterH1.resolvent_shift_mul
import Mathlib
import Definitions.Def_ChapterH1
open BookProof.ChapterH1







open scoped BigOperators
open intervalIntegral


noncomputable section














variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]








variable {A : Type*} [Ring A] [Algebra ℂ A]

set_option maxHeartbeats 1000000 in
theorem solution (a : A) (N h : ℂ) (j m : ℂ)
    (Xj Xm : A)
    (_hjl : (algebraMap ℂ A (N - h * j) - a) * Xj = 1)
    (hjr : Xj * (algebraMap ℂ A (N - h * j) - a) = 1)
    (hml : (algebraMap ℂ A (N - h * m) - a) * Xm = 1)
    (_hmr : Xm * (algebraMap ℂ A (N - h * m) - a) = 1) :
    Xj * (1 + (h * (m - j)) • Xm) = Xm := by

  simp_all only [map_sub, map_mul, sub_mul, mul_sub, Algebra.smul_def, mul_add, mul_one];
  apply_fun ( · * Xm ) at hjr ; simp_all [ mul_assoc, sub_mul ];
  simp_all [ sub_eq_iff_eq_add ];
  simp_all [ mul_add ];
  grind
