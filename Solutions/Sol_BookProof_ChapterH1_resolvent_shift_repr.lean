-- Generated from ChapterH1.lean — solution of BookProof.ChapterH1.resolvent_shift_repr
import Mathlib
import Definitions.Def_ChapterH1
import Theorems.Thm_BookProof_ChapterH1_resolvent_shift_mul
open BookProof.ChapterH1







open scoped BigOperators
open intervalIntegral


noncomputable section














variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]








variable {A : Type*} [Ring A] [Algebra ℂ A]

set_option maxHeartbeats 1000000 in
theorem solution (a : A) (N h : ℂ) (j m : ℂ) (Xj Xm : A)
    (hjl : (algebraMap ℂ A (N - h * j) - a) * Xj = 1)
    (hjr : Xj * (algebraMap ℂ A (N - h * j) - a) = 1)
    (hml : (algebraMap ℂ A (N - h * m) - a) * Xm = 1)
    (hmr : Xm * (algebraMap ℂ A (N - h * m) - a) = 1)
    [Invertible (1 + (h * (m - j)) • Xm)] :
    Xj = ⅟(1 + (h * (m - j)) • Xm) * Xm := by

  -- By definition of $u$, we know that $u * Xm = Xm * u$.
  have hu_comm : (1 + (h * (m - j)) • Xm) * Xm = Xm * (1 + (h * (m - j)) • Xm) := by
    simp [ mul_add, add_mul ];
  have hu_inv_comm : Xm * ⅟(1 + (h * (m - j)) • Xm) = ⅟(1 + (h * (m - j)) • Xm) * Xm := by
    apply_fun (fun x => x * ⅟(1 + (h * (m - j)) • Xm)) at hu_comm;
    simp_all only [map_sub, map_mul, mul_assoc, mul_invOf_self', mul_one];
    apply_fun (fun x => ⅟(1 + (h * (m - j)) • Xm) * x) at hu_comm; simp_all ;
  convert congr_arg ( fun x => x * ⅟ ( 1 + ( h * ( m - j ) ) • Xm ) ) ( resolvent_shift_mul a N h j
      m Xj Xm hjl hjr hml hmr ) using 1;
  · simp [ mul_assoc ];
  · exact hu_inv_comm.symm
