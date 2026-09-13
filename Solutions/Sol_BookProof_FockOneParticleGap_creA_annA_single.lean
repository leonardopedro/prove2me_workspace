-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.creA_annA_single
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterNavierStokesFockCanonical
import Theorems.Thm_BookProof_FockSecondQuantization_annA_single
import Theorems.Thm_BookProof_FockSecondQuantization_creA_single
import Theorems.Thm_BookProof_FockSecondQuantization_dn_self
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFarisLavine
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (β : Conf) (c : ℂ) :
    creA k (annA k (Finsupp.single β c)) = ((β k : ℝ) : ℂ) • Finsupp.single β c := by

  rw [annA_single]
  by_cases hk : β k = 0
  · simp [hk]
  · have h1 : 1 ≤ β k := Nat.one_le_iff_ne_zero.mpr hk
    rw [map_smul, creA_single, up_dn k h1]
    have hcast : ((dn k β) k : ℝ) + 1 = (β k : ℝ) := by
      rw [dn_self, Nat.cast_sub (R := ℝ) h1]; ring
    rw [hcast, smul_smul, Finsupp.smul_single, Finsupp.smul_single]
    congr 1
    have h2 : (Real.sqrt (β k) : ℂ) * (Real.sqrt (β k) : ℂ) = ((β k : ℝ) : ℂ) := by
      rw [← Complex.ofReal_mul, Real.mul_self_sqrt (by positivity)]
    simp only [smul_eq_mul]
    calc c * (Real.sqrt (β k) : ℂ) * (Real.sqrt (β k) : ℂ)
        = c * ((Real.sqrt (β k) : ℂ) * (Real.sqrt (β k) : ℂ)) := by ring
      _ = ((β k : ℝ) : ℂ) * c := by rw [h2]; ring
