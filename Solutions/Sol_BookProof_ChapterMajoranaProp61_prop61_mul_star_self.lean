-- Generated from ChapterMajoranaProp61.lean — solution of BookProof.ChapterMajoranaProp61.prop61_mul_star_self
import Mathlib
import Definitions.Def_ChapterMajoranaProp61
open BookProof.ChapterMajoranaProp61




variable {𝒜 : Type*} [Ring 𝒜] [StarRing 𝒜] [Algebra ℝ 𝒜] [StarModule ℝ 𝒜]

set_option maxHeartbeats 1000000 in
set_option maxHeartbeats 2000000 in
-- the proof below is a large finite computation; the default heartbeat budget
-- is not enough to elaborate it
omit [StarModule ℝ 𝒜] hNE hNA in
theorem solution :
    Uprime U H g E Ni * star (Uprime U H g E Ni) = 1 := by

  -- Using the hypothesis `hNi₂ : Ni * N = 1`, we can simplify the expression.
  have h_comm : Ni * (E + Aop U H g) * (E + star (Aop U H g)) * Ni = Ni * N * N * Ni := by
    have h_comm : (E + Aop U H g) * (E + star (Aop U H g)) = 2 • (E * E) + (2 * m) • E := by
      simp only [mul_add, add_mul, hE2, two_smul]
      simp_all only [← mul_assoc, Aop, star_mul, star_star]
      simp_all only [← eq_sub_iff_add_eq', mul_assoc, mul_one]
      simp_all only [sub_mul, Algebra.smul_mul_assoc, one_mul, mul_assoc, mul_sub,
        Algebra.mul_smul_comm, mul_one]
      abel1
    simp only [mul_assoc, h_comm]
    simp only [nsmul_eq_mul, Nat.cast_ofNat, ← mul_assoc]
    simp only [two_mul, add_mul, mul_add, Algebra.mul_smul_comm, mul_assoc, Algebra.smul_mul_assoc,
        hN2, add_left_inj]
    rw [ two_smul ]
  unfold Uprime; simp_all only [mul_assoc, one_mul, star_mul, star_add]
  have h_star_Ni : star Ni * N = 1 := by
    rw [ ← star_inj ] ; simp [ * ]
  apply_fun ( · * Ni ) at h_star_Ni; simp_all [ mul_assoc ]
