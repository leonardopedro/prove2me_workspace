-- Generated from ChapterFockPairPerturbation.lean — solution of BookProof.FockPairPerturbation.pairVec_unbounded
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
import Theorems.Thm_BookProof_FockPairPerturbation_pairVec_apply
import Theorems.Thm_BookProof_FockPairPerturbation_creVec_single_one
import Theorems.Thm_BookProof_FockPairPerturbation_annVec_single_one
import Theorems.Thm_BookProof_FockOneParticleGap_norm_toLp_sq
import Theorems.Thm_BookProof_FockSecondQuantization_annA_apply
import Theorems.Thm_BookProof_FockSecondQuantization_creA_apply
import Theorems.Thm_BookProof_FockSecondQuantization_dn_up
import Theorems.Thm_BookProof_FockSecondQuantization_up_self
open BookProof.FockPairPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockFieldPerturbation

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (C : ℝ) :
    ∃ u : FockAlg, ‖toLp u‖ = 1 ∧
      C ≤ ‖toLp (pairVec (Finsupp.single k 1) (Finsupp.single k 1) u)‖ := by

  classical
  obtain ⟨n, hn⟩ := exists_nat_gt (C ^ 2)
  set al : Conf := Finsupp.single k n with hal
  set u : FockAlg := Finsupp.single al 1 with hu
  have halk : al k = n := by simp [hal]
  have husupp : u.support = {al} := Finsupp.support_single_ne_zero al one_ne_zero
  have hval : u al = 1 := by simp [hu]
  have hu1 : ‖toLp u‖ = 1 := by
    have h : ‖toLp u‖ ^ 2 = 1 := by
      rw [norm_toLp_sq, husupp, Finset.sum_singleton, hval]
      simp
    have hx : (0 : ℝ) ≤ ‖toLp u‖ := norm_nonneg _
    nlinarith
  refine ⟨u, hu1, ?_⟩
  set v : FockAlg := pairVec (Finsupp.single k (1 : ℂ)) (Finsupp.single k (1 : ℂ)) u with hv
  have hvsplit : v = creA k (creA k u) + annA k (annA k u) := by
    rw [hv, pairVec_apply, creVec_single_one, creVec_single_one, annVec_single_one,
      annVec_single_one]
  set be : Conf := up k (up k al) with hbe
  have hbek : be k = n + 2 := by rw [hbe, up_self, up_self, halk]
  have hupalk : (up k al) k = n + 1 := by rw [up_self, halk]
  have hann : annA k (annA k u) be = 0 := by
    rw [annA_apply, annA_apply]
    have hzero : u (up k (up k be)) = 0 := by
      have hne : up k (up k be) ≠ al := by
        intro hcontra
        have := congrArg (fun β : Conf => β k) hcontra
        simp only [up_self, hbek, halk] at this
        omega
      simp [hu, Ne.symm hne]
    rw [hzero]
    ring
  have hcre : creA k (creA k u) be
      = ((Real.sqrt ((n : ℝ) + 2) : ℝ) : ℂ) * ((Real.sqrt ((n : ℝ) + 1) : ℝ) : ℂ) := by
    rw [creA_apply, creA_apply, dn_up, hbek, hupalk, dn_up, hval, mul_one]
    push_cast
    ring_nf
  have hcoord : v be
      = ((Real.sqrt ((n : ℝ) + 2) : ℝ) : ℂ) * ((Real.sqrt ((n : ℝ) + 1) : ℝ) : ℂ) := by
    rw [hvsplit, Finsupp.add_apply, hann, hcre, add_zero]
  have hnormcoord : ‖v be‖ ^ 2 = ((n : ℝ) + 2) * ((n : ℝ) + 1) := by
    rw [hcoord, norm_mul, Complex.norm_real, Complex.norm_real, Real.norm_eq_abs,
      Real.norm_eq_abs, abs_of_nonneg (Real.sqrt_nonneg _), abs_of_nonneg (Real.sqrt_nonneg _),
      mul_pow, Real.sq_sqrt (by positivity), Real.sq_sqrt (by positivity)]
  have hcoordne : v be ≠ 0 := by
    intro hzero
    rw [hzero] at hnormcoord
    simp only [norm_zero] at hnormcoord
    nlinarith [Nat.cast_nonneg (α := ℝ) n]
  have hmem : be ∈ v.support := Finsupp.mem_support_iff.mpr hcoordne
  have hge : ((n : ℝ) + 2) * ((n : ℝ) + 1) ≤ ‖toLp v‖ ^ 2 := by
    rw [norm_toLp_sq]
    calc ((n : ℝ) + 2) * ((n : ℝ) + 1) = ‖v be‖ ^ 2 := hnormcoord.symm
      _ ≤ ∑ β ∈ v.support, ‖v β‖ ^ 2 :=
          Finset.single_le_sum (f := fun β => ‖v β‖ ^ 2) (fun _ _ => sq_nonneg _) hmem
  have hvn : (0 : ℝ) ≤ ‖toLp v‖ := norm_nonneg _
  nlinarith [sq_nonneg C, Nat.cast_nonneg (α := ℝ) n]
