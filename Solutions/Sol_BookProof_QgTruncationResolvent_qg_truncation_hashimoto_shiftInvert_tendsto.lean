-- Generated from ChapterQgTruncationResolvent.lean — solution of BookProof.QgTruncationResolvent.qg_truncation_hashimoto_shiftInvert_tendsto
import Mathlib
import Definitions.Def_ChapterQgTruncationResolvent
import Theorems.Thm_BookProof_QgTruncationResolvent_qgOuterFock_truncation_flow_convergence
import Theorems.Thm_BookProof_QgTruncationResolvent_isShiftInvertC_neg_resCLM
open BookProof.QgTruncationResolvent




open Filter Topology
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.QgOuterFockCoreFL BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.ScalaronEsa BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {ι : Type*}
variable (W : WallPot) (Q : QgModeData ι)

set_option maxHeartbeats 1000000 in
theorem solution (Λ : ℕ → Set ι)
    (hexh : ∀ F : Finset ι, ∀ᶠ n in atTop, ∀ a ∈ F, a ∈ Λ n) :
    ∃ (T : UnboundedSelfAdjoint (Sec ι)) (S : ℕ → UnboundedSelfAdjoint (Sec ι)),
      IsSelfAdjointExtension (secHam W Q) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam W (truncModes Q (Λ n))) (S n).op) ∧
        IsShiftInvertC T.op Complex.I (-(T.resCLM 1)) ∧
        (∀ n, IsShiftInvertC (S n).op Complex.I (-((S n).resCLM 1))) ∧
        ∀ u : Sec ι, Tendsto (fun n => -((S n).resCLM 1 u)) atTop (𝓝 (-(T.resCLM 1 u))) := by

  obtain ⟨T, S, hT, hS, hres, -⟩ := qgOuterFock_truncation_flow_convergence W Q Λ hexh
  exact ⟨T, S, hT, hS, isShiftInvertC_neg_resCLM T, fun n => isShiftInvertC_neg_resCLM (S n),
    fun u => (hres u).neg⟩
