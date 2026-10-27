-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.eGram_diag_ne_zero
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
import Theorems.Thm_BookProof_QgFullEliminated_elimCoef_torsion_ne_zero
open BookProof.QgFullEliminated




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa BookProof.ScalaronEsa
open BookProof.QgVielbeinScalaronGaugeFL BookProof.QgFourierElim

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (k : Mom) (hk : k 0 ≠ 0) :
    eGram ((k, (1, 0)) : EGMode) (k, (1, 0)) ≠ 0 := by

  have hsum : eGram ((k, (1, 0)) : EGMode) (k, (1, 0))
      = ((∑ F : FormIdx, ‖elimCoef k F ((1, 0) : EComp)‖ ^ 2 : ℝ) : ℂ) := by
    simp only [eGram, if_true, Complex.ofReal_sum]
    exact Finset.sum_congr rfl fun F _ => conj_mul_self_ofReal _
  intro h0
  rw [hsum] at h0
  have hzero : (∑ F : FormIdx, ‖elimCoef k F ((1, 0) : EComp)‖ ^ 2) = 0 := by exact_mod_cast h0
  have hterm : ‖elimCoef k (torsionF 0 1 0) ((1, 0) : EComp)‖ ^ 2 = 0 :=
    (Finset.sum_eq_zero_iff_of_nonneg (fun F _ => by positivity)).mp hzero _
      (Finset.mem_univ _)
  refine elimCoef_torsion_ne_zero k hk (norm_eq_zero.mp ?_)
  nlinarith [norm_nonneg (elimCoef k (torsionF 0 1 0) ((1, 0) : EComp))]
