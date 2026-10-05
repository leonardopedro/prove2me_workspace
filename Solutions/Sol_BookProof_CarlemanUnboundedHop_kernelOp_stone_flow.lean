-- Generated from ChapterCarlemanUnboundedHop.lean — solution of BookProof.CarlemanUnboundedHop.kernelOp_stone_flow
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
import Theorems.Thm_BookProof_CarlemanUnboundedHop_kernelOp_symmetric
import Theorems.Thm_BookProof_CarlemanUnboundedHop_kernelOp_essentiallySelfAdjoint
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
open BookProof.CarlemanUnboundedHop




open Finset

noncomputable section

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {a : ℕ → ℕ → ℂ} {A θ Θ : ℕ → ℝ} (hk : IsL2Kernel a)
    (hθ0 : ∀ r, 0 ≤ θ r) (hΘ : ∀ j, HasSum (fun i => θ (i + j + 1)) (Θ j))
    (hΘsum : Summable Θ) (hApos : ∀ n, 0 < A n) (hAmono : Monotone A)
    (hbd : ∀ n k, n < k → ‖a n k‖ ≤ A n * θ (k - n))
    (hcar : ¬ Summable fun n => (A n)⁻¹) :
    ∃ (T : ChapterStoneResolvent.UnboundedSelfAdjoint L2N) (U : ℝ → (L2N →L[ℂ] L2N)),
      EsaClosure.IsSelfAdjointExtension (kernelOp hk) T.op ∧ StoneBridge.IsStoneFlow T U :=
  StoneBridge.exists_stone_flow_of_esa _ lpFiniteModes_dense (kernelOp_symmetric hk)
      (kernelOp_essentiallySelfAdjoint hk hθ0 hΘ hΘsum hApos hAmono hbd hcar)
