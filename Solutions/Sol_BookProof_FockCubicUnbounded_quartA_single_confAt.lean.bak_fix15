-- Generated from ChapterFockCubicUnbounded.lean — solution of BookProof.FockCubicUnbounded.quartA_single_confAt
import Mathlib
import Definitions.Def_ChapterFockCubicUnbounded
import Theorems.Thm_BookProof_FockCubicUnbounded_confAt_self
import Theorems.Thm_BookProof_FockCubicUnbounded_up_confAt
import Theorems.Thm_BookProof_FockCubicUnbounded_dn_confAt
import Theorems.Thm_BookProof_FockSecondQuantization_annA_single
import Theorems.Thm_BookProof_FockSecondQuantization_creA_single
open BookProof.FockCubicUnbounded



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation

set_option maxHeartbeats 1000000 in
theorem solution (k m : ℕ) (z : ℂ) :
    quartA k (Finsupp.single (confAt k m) z)
      = Finsupp.single (confAt k m) ((((m : ℝ) * ((m : ℝ) - 1) : ℝ) : ℂ) * z) := by

  match m with
  | 0 => simp [quartA, confAt_self, dn_confAt]
  | 1 => simp [quartA, confAt_self, dn_confAt]
  | (m + 2) =>
      have e1 : m + 2 - 1 = m + 1 := by omega
      have e2 : m + 1 - 1 = m := by omega
      simp only [quartA, LinearMap.comp_apply, annA_single, creA_single,
        confAt_self, dn_confAt, up_confAt, e1, e2, Finsupp.smul_single,
        smul_eq_mul]
      congr 1
      have hs1 : Real.sqrt ((m : ℝ) + 1) * Real.sqrt ((m : ℝ) + 1) = (m : ℝ) + 1 :=
        Real.mul_self_sqrt (by positivity)
      have hs2 : Real.sqrt ((m : ℝ) + 2) * Real.sqrt ((m : ℝ) + 2) = (m : ℝ) + 2 :=
        Real.mul_self_sqrt (by positivity)
      have e3 : ((m + 1 : ℕ) : ℝ) = (m : ℝ) + 1 := by push_cast; ring
      have e4 : ((m + 2 : ℕ) : ℝ) = (m : ℝ) + 2 := by push_cast; ring
      have hA : Real.sqrt ((m + 2 : ℕ) : ℝ) * Real.sqrt ((m + 1 : ℕ) : ℝ)
            * Real.sqrt ((m : ℝ) + 1) * Real.sqrt (((m + 1 : ℕ) : ℝ) + 1)
          = ((m + 2 : ℕ) : ℝ) * (((m + 2 : ℕ) : ℝ) - 1) := by
        rw [e3, e4, show (m : ℝ) + 1 + 1 = (m : ℝ) + 2 from by ring]
        linear_combination (Real.sqrt ((m : ℝ) + 1) * Real.sqrt ((m : ℝ) + 1)) * hs2
          + ((m : ℝ) + 2) * hs1
      have hAc := congrArg (fun r : ℝ => (r : ℂ)) hA
      push_cast at hAc ⊢
      linear_combination z * hAc
