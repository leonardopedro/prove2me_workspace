-- Generated from ChapterQgCouplingDGammaSum.lean — solution of BookProof.QgCouplingDGammaSum.creA_annA_apply
import Mathlib
import Definitions.Def_ChapterQgCouplingDGammaSum
import Theorems.Thm_BookProof_FockSecondQuantization_annA_apply
import Theorems.Thm_BookProof_FockSecondQuantization_creA_apply
import Theorems.Thm_BookProof_FockSecondQuantization_dn_self
import Theorems.Thm_BookProof_FockSecondQuantization_up_dn
open BookProof.QgCouplingDGammaSum




open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs

noncomputable section

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (u : FockAlg) (α : Conf) :
    creA k (annA k u) α = ((α k : ℝ) : ℂ) * u α := by

  rw [creA_apply, annA_apply]
  rcases Nat.eq_zero_or_pos (α k) with h0 | hpos
  · rw [h0]
    simp
  · have hk : 1 ≤ α k := hpos
    have hdn : ((dn k α) k : ℝ) + 1 = (α k : ℝ) := by
      rw [dn_self, Nat.cast_sub (R := ℝ) hk]
      ring
    rw [hdn, up_dn k hk, ← mul_assoc, ← Complex.ofReal_mul,
      Real.mul_self_sqrt (Nat.cast_nonneg _)]
